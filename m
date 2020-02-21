Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDE5C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF49824673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271166;
	bh=2a+zUaID5zALeOpO/fqjSjJWxrxS49+DTJaNZxvO+2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BgEgZiEHuuiQB2q7Wh/NvBhd1ObMdNKtbx+ZZ/gzVPZiJjOHGl1Gzlo5nZjeiz44t
	 CaOwfNBtM3DIA4nIjM2pUfyx/g+D8iJuBjjjPjoj9vF/c98dRnjUla8XlOeV3uEW4A
	 I0uksH4nqVsLXDpDeKCT5UHQfmVqKmRyhwTIb3pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgBUHqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbgBUHqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:46:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8FC20801;
        Fri, 21 Feb 2020 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271162;
        bh=2a+zUaID5zALeOpO/fqjSjJWxrxS49+DTJaNZxvO+2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ov5Z6JAcFvX+/MpHxBCIm+17o5Tow9XFA0DQPksrUvkpQm3A2d3ih5mobeOijnv28
         On9AQtPOk4YtaL4sMIVhmaQp7kyeRZIS5ZyPSOqAMfsSFWzlJuaUgmxYWPCoANIroR
         V2gJPr2C3/+VSCGDkYBPnH+nqCkqRtTUi4zH3QwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 061/399] iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable
Date:   Fri, 21 Feb 2020 08:36:26 +0100
Message-Id: <20200221072408.298365940@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit a2dd9bd9334efb8dc0bdc0109abff3a7b57effb1 ]

Add missing return value check in st_lsm6dsx_read_oneshot disabling the
sensor. The issue is reported by coverity with the following error:

Unchecked return value:
If the function returns an error value, the error value may be mistaken
for a normal value.

Addresses-Coverity-ID: 1446733 ("Unchecked return value")
Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b921dd9e108fa..e45123d8d2812 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1506,8 +1506,11 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	if (!hw->enable_event)
-		st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (!hw->enable_event) {
+		err = st_lsm6dsx_sensor_set_enable(sensor, false);
+		if (err < 0)
+			return err;
+	}
 
 	*val = (s16)le16_to_cpu(data);
 
-- 
2.20.1



