Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD62C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3B920748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217050;
	bh=R+bh719d9Q5QgI+sWO+6UqYdpo93I4kzyTiicq2nTvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zxyy7GQ1fOd7wTPQsf1YAKq+aBy1xqbY7lvM+iIxCrnRkG+hFHhMUO3lPVDyB8QMi
	 duQUJp5k2mLumDvVyRFGVGtY4H5IOE19in0rlamWPr5BnVof8r+yJHJaWsWwyc+fYm
	 Kjx9yNs82MHh5bX9DrlDf3rEjm04uDHY+yx3YS1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgAPXYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgAPXYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:24:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959A72075B;
        Thu, 16 Jan 2020 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217045;
        bh=R+bh719d9Q5QgI+sWO+6UqYdpo93I4kzyTiicq2nTvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYerBByNzbQ7wmc5JiVfgatCjMb3pylkShw9pj4qNft/YkFRhlJM9yMpAJYrCdEht
         yn6yGhdQjR3eB0NjLmiNP/I1OpkDdGvi9mOZeBlhh/txM4Lx69la+6xfRaggF/190G
         yOZcTVYPOe9g3dGvd6drZ1odIy0zmA1dDtaoF8MM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 109/203] iio: imu: st_lsm6dsx: fix gyro gain definitions for LSM9DS1
Date:   Fri, 17 Jan 2020 00:17:06 +0100
Message-Id: <20200116231755.033009357@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit 1b3751017e09f0857bc38f9b1be08dce38f3d92c upstream.

Fix typos in gyro gain definitions for LSM9DS1 sensor

Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -152,9 +152,10 @@ static const struct st_lsm6dsx_settings
 					.addr = 0x10,
 					.mask = GENMASK(4, 3),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
-				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
+
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 				.fs_len = 3,
 			},
 		},


