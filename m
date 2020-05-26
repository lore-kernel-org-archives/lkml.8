Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2275CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0360420873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519952;
	bh=5xa30C6N17AVRqDi2Jmf/sGexGZQiLSNFqM0N6ArWXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dru/amB5PpI4Eo9gzVVO0KC3pLH08rWXcOO6cTsJorKzKfESuRFuV58Ylpgt05mHn
	 jspzAFVi6cve1ERUIDC0M5qSrbfwG1EyS4yqGi5jwZQXiM7uYSwh0w6rQi5jWjej+b
	 jUtsC1b4DAjdNjztzlH+PkyN2BUsg4AAGW55JnjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgEZTFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391530AbgEZTFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502EB208A7;
        Tue, 26 May 2020 19:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519943;
        bh=5xa30C6N17AVRqDi2Jmf/sGexGZQiLSNFqM0N6ArWXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cJlRC56ADKig+fBHR3zYhXwyE7R1GY3Xoh80woI34XI7wmh4QyH4NjaGZjUmnmMJ
         GiE8v5fZel4n9PfP/UUfj/wrpF7EMW66TVjaciWyWA/Mpuj6+9+lkbFu7c0mNd//Yp
         pmKT90dIRDQZN0Oh+gRe4DXfokzVJ76jyQrvZneU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 78/81] iio: adc: stm32-dfsdm: fix device used to request dma
Date:   Tue, 26 May 2020 20:53:53 +0200
Message-Id: <20200526183935.711435313@linuxfoundation.org>
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

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit b455d06e6fb3c035711e8aab1ca18082ccb15d87 ]

DMA channel request should use device struct from platform device struct.
Currently it's using iio device struct. But at this stage when probing,
device struct isn't yet registered (e.g. device_register is done in
iio_device_register). Since commit 71723a96b8b1 ("dmaengine: Create
symlinks between DMA channels and slaves"), a warning message is printed
as the links in sysfs can't be created, due to device isn't yet registered:
- Cannot create DMA slave symlink
- Cannot create DMA dma:rx symlink

Fix this by using device struct from platform device to request dma chan.

Fixes: eca949800d2d ("IIO: ADC: add stm32 DFSDM support for PDM microphone")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 516d7d22d9f4..1c492a7f4587 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -45,7 +45,7 @@ enum sd_converter_type {
 
 struct stm32_dfsdm_dev_data {
 	int type;
-	int (*init)(struct iio_dev *indio_dev);
+	int (*init)(struct device *dev, struct iio_dev *indio_dev);
 	unsigned int num_channels;
 	const struct regmap_config *regmap_cfg;
 };
@@ -923,7 +923,8 @@ static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
 	}
 }
 
-static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
+static int stm32_dfsdm_dma_request(struct device *dev,
+				   struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct dma_slave_config config = {
@@ -933,7 +934,7 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
 	};
 	int ret;
 
-	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
+	adc->dma_chan = dma_request_chan(dev, "rx");
 	if (IS_ERR(adc->dma_chan)) {
 		int ret = PTR_ERR(adc->dma_chan);
 
@@ -997,7 +998,7 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					  &adc->dfsdm->ch_list[ch->channel]);
 }
 
-static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
+static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
@@ -1027,10 +1028,10 @@ static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
 	indio_dev->num_channels = 1;
 	indio_dev->channels = ch;
 
-	return stm32_dfsdm_dma_request(indio_dev);
+	return stm32_dfsdm_dma_request(dev, indio_dev);
 }
 
-static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
+static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
@@ -1174,7 +1175,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 		adc->dfsdm->fl_list[adc->fl_id].sync_mode = val;
 
 	adc->dev_data = dev_data;
-	ret = dev_data->init(iio);
+	ret = dev_data->init(dev, iio);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1



