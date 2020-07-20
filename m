Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F350BC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FA020734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263020;
	bh=aaTkkjTThiK4kO48WcJTrCLmtM7O9Qdc/8N21SoD+Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZkBlOnPUP9/tr/SC/JSQe7zvvsQmEGt02ERvS2pXatvJxj6NIs4QlvWlurG8T2iK
	 GusKi55ZBjBuG9LTkn+n61rTAfUPU6okMsRH478e91NvLJotcOmN6av2lwDWn1KB0k
	 /kfBKB+BEDMXyEoaPXr0MhS5QzaiuxHFNAtm+8SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388903AbgGTQg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731316AbgGTPwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E8042064B;
        Mon, 20 Jul 2020 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260324;
        bh=aaTkkjTThiK4kO48WcJTrCLmtM7O9Qdc/8N21SoD+Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1Z3fRe4mlAyQ7nd5hLQZbNcQ8lcLQ6CQM44tp3A+BYtHG1IshtgFm+3eJwzsqmlA
         7DMDy9orKXjiki51MYk6/csOdp8dctTydYbgyxTNj2xtCCFanOnveNl8nn2UFMB1Dy
         dYxqe75x9p0LS0cXJiVWDyc4sbJYonHiYmXLV1MM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stable@vger.kernel.org
Subject: [PATCH 4.19 034/133] iio:humidity:hts221 Fix alignment and data leak issues
Date:   Mon, 20 Jul 2020 17:36:21 +0200
Message-Id: <20200720152805.365344523@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
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
@@ -15,8 +15,6 @@
 
 #include <linux/iio/iio.h>
 
-#define HTS221_DATA_SIZE	2
-
 enum hts221_sensor_type {
 	HTS221_SENSOR_H,
 	HTS221_SENSOR_T,
@@ -40,6 +38,11 @@ struct hts221_hw {
 
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
@@ -163,7 +163,6 @@ static const struct iio_buffer_setup_ops
 
 static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 {
-	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
 	struct iio_poll_func *pf = p;
 	struct iio_dev *iio_dev = pf->indio_dev;
 	struct hts221_hw *hw = iio_priv(iio_dev);
@@ -173,18 +172,20 @@ static irqreturn_t hts221_buffer_handler
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


