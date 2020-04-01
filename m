Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE43C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9884212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759315;
	bh=Qv7p7skIwClAgWc94R84u6lXFzPtN2mlav+yyCBP6S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l86Gkeg9mhD2FMi0dWdHdP9mYJqSnqRVTr08AomftGnzto6OeVcCAkexQIj+vkerj
	 39ZYeC7tEgHhKAEqOwL0FnqtPCO6iYwYEGJgqHRDRbQ9JoeybGUAoBMdW81w1ZQmOQ
	 qoULnJhzA3q+FBLH2SwXMQauJvY3eAnlA1+dpxFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbgDAQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389162AbgDAQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:41:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C062420658;
        Wed,  1 Apr 2020 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759311;
        bh=Qv7p7skIwClAgWc94R84u6lXFzPtN2mlav+yyCBP6S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C97YkYsttPnp+UemRo9gWCLI9JIJzJKI+ExrjjNkNKtepdkAkvF9bkiRtghTTI/CD
         qx78FeHSDC4ZL2cNq/KuihiKqGSBjFh75pxf8IlbRw2KAvh1jpr3eqwRxFAiLrqSCd
         dKh6xc7p7skrys9WcCV8glxM8+Z87RTH5A7EcvHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 042/148] iio: adc: at91-sama5d2_adc: fix channel configuration for differential channels
Date:   Wed,  1 Apr 2020 18:17:14 +0200
Message-Id: <20200401161556.877865168@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit f0c8d1f6dc8eac5a1fbf441c8e080721a7b6c0ff ]

When iterating through the channels, the index in the array is not the
scan index. Added an xlate function to translate to the proper index.
The result of the bug is that the channel array is indexed with a wrong index,
thus instead of the proper channel, we access invalid memory, which may
lead to invalid results and/or corruption.
This will be used also for devicetree channel xlate.

Fixes: 5e1a1da0f ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Fixes: 073c66201 ("iio: adc: at91-sama5d2_adc: add support for DMA")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a70ef7fec95f0..0898f40c2b892 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -300,6 +300,27 @@ static const struct iio_chan_spec at91_adc_channels[] = {
 				+ AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
 };
 
+static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].scan_index == chan)
+			return i;
+	}
+	return -EINVAL;
+}
+
+static inline struct iio_chan_spec const *
+at91_adc_chan_get(struct iio_dev *indio_dev, int chan)
+{
+	int index = at91_adc_chan_xlate(indio_dev, chan);
+
+	if (index < 0)
+		return NULL;
+	return indio_dev->channels + index;
+}
+
 static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
@@ -317,8 +338,10 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
 
 	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
-		struct iio_chan_spec const *chan = indio->channels + bit;
+		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
 
+		if (!chan)
+			continue;
 		if (state) {
 			at91_adc_writel(st, AT91_SAMA5D2_CHER,
 					BIT(chan->channel));
@@ -398,8 +421,11 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	u8 bit;
 
 	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
-		struct iio_chan_spec const *chan = indio->channels + bit;
+		struct iio_chan_spec const *chan =
+					at91_adc_chan_get(indio, bit);
 
+		if (!chan)
+			continue;
 		st->buffer[i] = at91_adc_readl(st, chan->address);
 		i++;
 	}
-- 
2.20.1



