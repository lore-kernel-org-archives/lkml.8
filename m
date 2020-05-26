Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DF2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4AB20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519944;
	bh=Lgi7w1xxCl7mtt8YFNnBDnOTXM6T1vM2qt5Wvl8ZwjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0a72u+P71ENjVb5KcQt+WXI4az9Fc7hhxioMihvOZ+52sR64+s5K5bg/qHVU/YrNk
	 UP5zDZSGhSPP5vI5FwQb629lBzPz65aG4NdIo+dmo68qtxk0yhXhVMja/4kPMAoyh9
	 XMKSDwVefSVZiTIRIW//sz6KCkPRqrWv+1spyhWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391527AbgEZTFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391036AbgEZTFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989A9208A7;
        Tue, 26 May 2020 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519936;
        bh=Lgi7w1xxCl7mtt8YFNnBDnOTXM6T1vM2qt5Wvl8ZwjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/VdL1xRM0jYR9TRS93baEeA7v4uq3gdQFq9jkE1hDZf6+Ys8GgyBuJm8R5Z76e47
         cMvFxBYevX+I6BCBvAHEKg4n4EasJzz1g0C7EX9hH4lGjyjtjui8QfoTYG1Hn5sNow
         sNHhsTqgFrBbt4+BQ2bRYDUvxnhk3e8O9cMsudcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 75/81] iio: adc: stm32-adc: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 26 May 2020 20:53:50 +0200
Message-Id: <20200526183935.381021331@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 735404b846dffcb320264f62b76e6f70012214dd ]

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stm32-adc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 24d5d049567a..d85caedda02e 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1688,9 +1688,21 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
 	struct dma_slave_config config;
 	int ret;
 
-	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
-	if (!adc->dma_chan)
+	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
+	if (IS_ERR(adc->dma_chan)) {
+		ret = PTR_ERR(adc->dma_chan);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(&indio_dev->dev,
+					"DMA channel request failed with %d\n",
+					ret);
+			return ret;
+		}
+
+		/* DMA is optional: fall back to IRQ mode */
+		adc->dma_chan = NULL;
 		return 0;
+	}
 
 	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
 					 STM32_DMA_BUFFER_SIZE,
-- 
2.25.1



