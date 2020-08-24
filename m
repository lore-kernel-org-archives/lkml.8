Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556EDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340442067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="clz/C0FZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHXRjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHXRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:39:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FAAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:39:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s20so4254241wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=clz/C0FZ1UbxXtnPwybhuWgiHNBL5Brwo6D97RcHtz/jpSGZzUyPdyThZfVpsuUPhy
         BLLt2igu/mDIt1K0CqFa2yQD9w2oVsQK/9Iqi7QetOpl9d/mWUlr8Mn3/cu3Vf9m/QWa
         mOtxZs3N/KmsPcr/EpW5ESCgbWZkeB6WRu4AKdJ1gZtRX/JdmE/Q30YbfWKEIb7mLWKZ
         2R00AVRzPMCqeANspr2UiyCqGTLKTmTfU2iRv0AXULWhbniUFAtjwt6XAQI8wBfuf+MA
         opHnb1m8Um2FEht+6vz1mkxnLQA4+m9qen3QuxTtiWVoJ7SSP1XU8QfKb1FULd7s0z/L
         juGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=SQUPevjjF9qXpelAE/l2V375jSw9fL5WEhugpcy+Q6xRfcnl8WJRmnxZmGNRp0mbZc
         IT74UMpjCGa2Ti+ljpFPh7Zoec/FkfaKyEyXFonIzkz2NYqhJl4SLwkM1g+VUSg6V92M
         XsSQu3lyn1Koc3SfPdJSsaZ8KJjkjWfNvlnKYbQVAadqy7cOffd91savcnujB4L70cRQ
         LOYopDnKgp3cC2cuMlj+2inRwIONCI1CTS5gtcfj8hTqzfkXnG5KG/or0SDvOmMkWR3L
         sqEf9ka6F8MYZQ5KUylKZ617rkqJWBDDAkljl/WDBU0Ho6O0G6FZToU8Kek51nu3Jwos
         wfnQ==
X-Gm-Message-State: AOAM533CWeHSEWxvMoRNi55YXUZFPRIZSbefPGZnll83HNXI87o6/BKq
        KDjqwu9cEeO1nuPbMuhWdCQaMA==
X-Google-Smtp-Source: ABdhPJyON3K1mqtMD/inQXwsjxZaY9mFHqzEoTnd6F5b28j0NPRKH/zMGFn1ARwYjsrjlG6pFSUHow==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr390305wmm.100.1598290747126;
        Mon, 24 Aug 2020 10:39:07 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Mon, 24 Aug 2020 19:38:59 +0200
Message-Id: <20200824173859.4910-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200824173859.4910-1-brgl@bgdev.pl>
References: <20200824173859.4910-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed variant of krealloc() and shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d0b7ef296afb..f93c34fe5873 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1092,6 +1092,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
+	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
 	struct iio_chan_spec *channels, *chan;
 	struct device_node *chan_node, *child;
@@ -1136,7 +1137,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
+	channels = devm_kmemdup(dev, xadc_channels,
+				sizeof(xadc_channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
@@ -1172,8 +1174,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	of_node_put(chan_node);
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = krealloc(channels, sizeof(*channels) *
-					num_channels, GFP_KERNEL);
+	indio_dev->channels = devm_krealloc(dev, channels,
+					    sizeof(*channels) * num_channels,
+					    GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
@@ -1225,14 +1228,14 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
 	if (ret)
-		goto err_device_free;
+		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
 		ret = iio_triggered_buffer_setup(indio_dev,
 			&iio_pollfunc_store_time, &xadc_trigger_handler,
 			&xadc_buffer_ops);
 		if (ret)
-			goto err_device_free;
+			return ret;
 
 		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
 		if (IS_ERR(xadc->convst_trigger)) {
@@ -1350,8 +1353,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_triggered_buffer_cleanup:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_triggered_buffer_cleanup(indio_dev);
-err_device_free:
-	kfree(indio_dev->channels);
 
 	return ret;
 }
@@ -1371,7 +1372,6 @@ static int xadc_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
 	kfree(xadc->data);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
2.26.1

