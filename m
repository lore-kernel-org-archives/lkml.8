Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE714C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E6A24125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699219;
	bh=I+VLj7wPA/ByWO/czUC3hP/jbE0YMB6KcBdEWKzI7BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOuzlUfLcYt7ZjL1ccOXukRmYLgvWriVsQnnyMIS28/6EGtdDlKR9A+bhlJnaYDSH
	 Pq4KwKSBbt/gmz84B3m5x1LUc6E47fVtSLvaFaSqbfgXUj8pC5zCn4TlVK+a86E6jQ
	 VsUtd3JGrZ2pGsLWR0kodNgmTO/57giYwmWVukSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgAVNUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgAVNUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:20:14 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A9C2467E;
        Wed, 22 Jan 2020 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699214;
        bh=I+VLj7wPA/ByWO/czUC3hP/jbE0YMB6KcBdEWKzI7BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2B1RZighAJQ7LRfj2C7mS2x68X4o2fjx0pGhuZZLwQR1lSVwv5xdTcECBRNSgEy6D
         +keH0oGO95yMo3uoQO2Z6izMcO/hhbct17VrHq/g3glp14XtXujKPDFkTKwP42pSEB
         grkus9GIMo41O9iQ9SjTnYZ/gl3JcfSAQvcd5FZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 039/222] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Date:   Wed, 22 Jan 2020 10:27:05 +0100
Message-Id: <20200122092836.329332842@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit fb4fbc8904e786537e29329d791147389e1465a2 upstream.

At the moment, attempting to probe a device with ST_LSM6DS3_ID
(e.g. using the st,lsm6ds3 compatible) fails with:

    st_lsm6dsx_i2c 1-006b: unsupported whoami [69]

... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.

This happens because st_lsm6dsx_check_whoami() also attempts
to match unspecified (zero-initialized) entries in the "id" array.
ST_LSM6DS3_ID = 0 will therefore match any entry in
st_lsm6dsx_sensor_settings (here: the first), because none of them
actually have all 12 entries listed in the "id" array.

Avoid this by additionally checking if "name" is set,
which is only set for valid entries in the "id" array.

Note: Although the problem was introduced earlier it did not surface until
commit 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
because ST_LSM6DS3_ID was the first entry in st_lsm6dsx_sensor_settings.

Fixes: d068e4a0f921 ("iio: imu: st_lsm6dsx: add support to multiple devices with the same settings")
Cc: <stable@vger.kernel.org> # 5.4
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -911,7 +911,8 @@ static int st_lsm6dsx_check_whoami(struc
 
 	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
 		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
-			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
+			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
+			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
 				break;
 		}
 		if (j < ST_LSM6DSX_MAX_ID)


