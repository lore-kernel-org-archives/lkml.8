Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE41C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1A0206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261308;
	bh=gBJjacVL2m/4ejgMgslD8NKdAbwGMCJFnQvE0Zo+e6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZC7KPCpvVZBG5gu+wn3V+L5Deb6M5Ub/zKiZx1A7ehMV2N0WkJjt8oRFuv6vDb5pa
	 NLAxX6FwILeh4GKJxbeTFI5w/EbQj55tj6OkJNA7fISUWbn+ocXeFHwXjYgavBW/La
	 eNa9AVAuyJME3Xufk4f+QhmbzL9deJzKmKhMsqC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgGTQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733254AbgGTQIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEF62065E;
        Mon, 20 Jul 2020 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261301;
        bh=gBJjacVL2m/4ejgMgslD8NKdAbwGMCJFnQvE0Zo+e6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKha4bXsF9oGr4yaofeiqrVywksEOxX4/l9NA+gmO2ez4w3RZOn3I6iKFlLZnhWuh
         RwqFsnISKu0phKfVafxS2Mw0B7+I3cLNIcUuyD541MRMxjaEp68E7WLRpVCbi/X9F2
         lDw/pJa3i9YfkIma9AiroIpd+2C2u7ocVQZBazkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stable@vger.kernel.org
Subject: [PATCH 5.7 066/244] iio:humidity:hts221 Fix alignment and data leak issues
Date:   Mon, 20 Jul 2020 17:35:37 +0200
Message-Id: <20200720152828.997519701@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 5c49056ad9f3c786f7716da2dd47e4488fc6bd25 upstream.

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data.
This data is allocated with kzalloc so no data can leak
apart from previous readings.

Explicit alignment of ts needed to ensure consistent padding
on all architectures (particularly x86_32 with it's 4 byte alignment
of s64)

Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo device")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/humidity/hts221.h        |    7 +++++--
 drivers/iio/humidity/hts221_buffer.c |    9 +++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -14,8 +14,6 @@
 
 #include <linux/iio/iio.h>
 
-#define HTS221_DATA_SIZE	2
-
 enum hts221_sensor_type {
 	HTS221_SENSOR_H,
 	HTS221_SENSOR_T,
@@ -39,6 +37,11 @@ struct hts221_hw {
 
 	bool enabled;
 	u8 odr;
+	/* Ensure natural alignment of timestamp */
+	struct {
+		__le16 channels[2];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 extern const struct dev_pm_ops hts221_pm_ops;
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -162,7 +162,6 @@ static const struct iio_buffer_setup_ops
 
 static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 {
-	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
 	struct iio_poll_func *pf = p;
 	struct iio_dev *iio_dev = pf->indio_dev;
 	struct hts221_hw *hw = iio_priv(iio_dev);
@@ -172,18 +171,20 @@ static irqreturn_t hts221_buffer_handler
 	/* humidity data */
 	ch = &iio_dev->channels[HTS221_SENSOR_H];
 	err = regmap_bulk_read(hw->regmap, ch->address,
-			       buffer, HTS221_DATA_SIZE);
+			       &hw->scan.channels[0],
+			       sizeof(hw->scan.channels[0]));
 	if (err < 0)
 		goto out;
 
 	/* temperature data */
 	ch = &iio_dev->channels[HTS221_SENSOR_T];
 	err = regmap_bulk_read(hw->regmap, ch->address,
-			       buffer + HTS221_DATA_SIZE, HTS221_DATA_SIZE);
+			       &hw->scan.channels[1],
+			       sizeof(hw->scan.channels[1]));
 	if (err < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
 					   iio_get_time_ns(iio_dev));
 
 out:


