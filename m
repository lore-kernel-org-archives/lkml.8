Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E265DC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A1024954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340492;
	bh=yfmgup1j+g7a8gzNFBbIPglvFt+5H4EnjEA4sFgEpmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ivf9oNCE7eeFtCk6Y8X2fJLDKT/yuK4XHTMrNSL1glumxhQAC1tsMDQmSyAe4rdJa
	 PWSeUkqTyyzwoybEk7gLPZSxyjUdEGg915Mn6adCjky9pW5rKCg6ly4Kfr87pckMv6
	 lsx3BTXOVCWWK3CqEVDj+13RkBJl1HxXAjUSRmwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgEANlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbgEANlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:41:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4FF205C9;
        Fri,  1 May 2020 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340484;
        bh=yfmgup1j+g7a8gzNFBbIPglvFt+5H4EnjEA4sFgEpmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGYg56QqVP2t29buloEZkDu5uDy97cCPpgx07Izeq7UP4VOR+T5eMN8fN0z1CsrPu
         YhGeyPog6TnIr74GvaJWWNLHSZgogrL6NRII5d2u4PZDUzY0IL3/c9zBWJ9SgOT1Ux
         XuL0PEFSnGQIG5/DyLNT9W8DwgOAzcnb0U3oCZII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.6 013/106] iio: imu: st_lsm6dsx: specify slave odr in slv_odr
Date:   Fri,  1 May 2020 15:22:46 +0200
Message-Id: <20200501131545.969987449@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit 76551a3c3df151750a842b003c6899e9c62e0fd2 upstream.

Introduce slv_odr in ext_info data structure in order to distinguish
between sensor hub trigger (accel sensor) odr and i2c slave odr and
properly compute samples in FIFO pattern

Fixes: e485e2a2cfd6 ("iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |    1 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |   29 ++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -357,6 +357,7 @@ struct st_lsm6dsx_sensor {
 
 	struct {
 		const struct st_lsm6dsx_ext_dev_settings *settings;
+		u32 slv_odr;
 		u8 addr;
 	} ext_info;
 };
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -421,7 +421,8 @@ int st_lsm6dsx_shub_set_enable(struct st
 
 	settings = sensor->ext_info.settings;
 	if (enable) {
-		err = st_lsm6dsx_shub_set_odr(sensor, sensor->odr);
+		err = st_lsm6dsx_shub_set_odr(sensor,
+					      sensor->ext_info.slv_odr);
 		if (err < 0)
 			return err;
 	} else {
@@ -459,7 +460,7 @@ st_lsm6dsx_shub_read_oneshot(struct st_l
 	if (err < 0)
 		return err;
 
-	delay = 1000000000 / sensor->odr;
+	delay = 1000000000 / sensor->ext_info.slv_odr;
 	usleep_range(delay, 2 * delay);
 
 	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
@@ -500,8 +501,8 @@ st_lsm6dsx_shub_read_raw(struct iio_dev
 		iio_device_release_direct_mode(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = sensor->odr / 1000;
-		*val2 = (sensor->odr % 1000) * 1000;
+		*val = sensor->ext_info.slv_odr / 1000;
+		*val2 = (sensor->ext_info.slv_odr % 1000) * 1000;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -535,8 +536,20 @@ st_lsm6dsx_shub_write_raw(struct iio_dev
 
 		val = val * 1000 + val2 / 1000;
 		err = st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
-		if (!err)
-			sensor->odr = val;
+		if (!err) {
+			struct st_lsm6dsx_hw *hw = sensor->hw;
+			struct st_lsm6dsx_sensor *ref_sensor;
+			u8 odr_val;
+			int odr;
+
+			ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+			odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
+			if (odr < 0)
+				return odr;
+
+			sensor->ext_info.slv_odr = val;
+			sensor->odr = odr;
+		}
 		break;
 	}
 	default:
@@ -613,6 +626,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_l
 			     const struct st_lsm6dsx_ext_dev_settings *info,
 			     u8 i2c_addr, const char *name)
 {
+	enum st_lsm6dsx_sensor_id ref_id = ST_LSM6DSX_ID_ACC;
 	struct iio_chan_spec *ext_channels;
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
@@ -628,7 +642,8 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_l
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = info->odr_table.odr_avl[0].milli_hz;
+	sensor->odr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
+	sensor->ext_info.slv_odr = info->odr_table.odr_avl[0].milli_hz;
 	sensor->gain = info->fs_table.fs_avl[0].gain;
 	sensor->ext_info.settings = info;
 	sensor->ext_info.addr = i2c_addr;


