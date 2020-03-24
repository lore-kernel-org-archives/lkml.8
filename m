Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F194EC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E52208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056543;
	bh=p+doGnRzaKO0ei7HENSP5rHdtLQfvDeepgfpWPTJ9Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDE1vbZFxdvhT1JQuukVIE5sqSOUnIZLg8X+PlbdrjJ4MwLDG4WUIWqrHUvg7fg7r
	 W//I2D9JUd9pyJw8X9nbwzKDWnwnFTLUGPbBecd+sPfDW49WCdqzE6gkr89u8zBrfV
	 jOFgggKvRnxfz/3HEG4w/pVUrlcBE276Z3Huis/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgCXN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgCXNYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:24:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972A8208CA;
        Tue, 24 Mar 2020 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056248;
        bh=p+doGnRzaKO0ei7HENSP5rHdtLQfvDeepgfpWPTJ9Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSXyph+WQvLtFVfMkAfm7Abn7bmiErbBNiQVvrvkJqXWjw6rsnN7qVZZF5kqQmpxV
         nYgcmQSIjiJf8idaitFNw0LOG5Ge1HdS7dXF3rLwh9XRWMqt97r9T/9uEV7tG3f7Z0
         DH3as4Yh5gXRkx9oJogBgy6bHA+4v7hW/xwq1sko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.5 068/119] iio: adc: at91-sama5d2_adc: fix differential channels in triggered mode
Date:   Tue, 24 Mar 2020 14:10:53 +0100
Message-Id: <20200324130815.011096322@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit a500f3bd787f8224341e44b238f318c407b10897 upstream.

The differential channels require writing the channel offset register (COR).
Otherwise they do not work in differential mode.
The configuration of COR is missing in triggered mode.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/at91-sama5d2_adc.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -723,6 +723,7 @@ static int at91_adc_configure_trigger(st
 
 	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
 		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
+		u32 cor;
 
 		if (!chan)
 			continue;
@@ -732,6 +733,20 @@ static int at91_adc_configure_trigger(st
 			continue;
 
 		if (state) {
+			cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
+
+			if (chan->differential)
+				cor |= (BIT(chan->channel) |
+					BIT(chan->channel2)) <<
+					AT91_SAMA5D2_COR_DIFF_OFFSET;
+			else
+				cor &= ~(BIT(chan->channel) <<
+				       AT91_SAMA5D2_COR_DIFF_OFFSET);
+
+			at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
+		}
+
+		if (state) {
 			at91_adc_writel(st, AT91_SAMA5D2_CHER,
 					BIT(chan->channel));
 			/* enable irq only if not using DMA */


