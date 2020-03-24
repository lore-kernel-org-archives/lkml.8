Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA43208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056249;
	bh=vCM1J3zbZVmk3rlk6aXkfslrUBDU31Q1M4zSPn7U1XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hSXxd+W20TGRPJbICG7949IpCIMpEqd642YKDZExthnahQNI3aFqlQOPbvbaluOVE
	 gxj/A7nGojZs6egeo5irB4R3/4apeBGvfIBtr1TcNru5XUG5wXwEdLou3Cqcxxaxvt
	 LvIRlIy0NVG6DktXp9566ynsZsnyG4KpvAeEON7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgCXNYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbgCXNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:24:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236CF208C3;
        Tue, 24 Mar 2020 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056242;
        bh=vCM1J3zbZVmk3rlk6aXkfslrUBDU31Q1M4zSPn7U1XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmTGVw7Ds6tTT9SMX+L04D6t09ZJ2oshg79TF1T07IGYtsHrUYTYCWqv4csqVmdEN
         fbRgipYrVLHmnAiZwa1Tnrx7dSKk8i+O+v6x3Xe5Mi39q9xd4TfUa76aJXfwODKDob
         FjF8mOsHCmtCFodxj1JqZAcznuuPKMVnccKzEuX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Moysan <olivier.moysan@st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.5 067/119] iio: adc: stm32-dfsdm: fix sleep in atomic context
Date:   Tue, 24 Mar 2020 14:10:52 +0100
Message-Id: <20200324130814.888546007@linuxfoundation.org>
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

From: Olivier Moysan <olivier.moysan@st.com>

commit e19ac9d9a978f8238a85a28ed624094a497d5ae6 upstream.

This commit fixes the error message:
"BUG: sleeping function called from invalid context at kernel/irq/chip.c"
Suppress the trigger irq handler. Make the buffer transfers directly
in DMA callback, instead.
Push buffers without timestamps, as timestamps are not supported
in DFSDM driver.

Fixes: 11646e81d775 ("iio: adc: stm32-dfsdm: add support for buffer modes")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-dfsdm-adc.c |   43 ++++++++------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -842,31 +842,6 @@ static inline void stm32_dfsdm_process_d
 	}
 }
 
-static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	int available = stm32_dfsdm_adc_dma_residue(adc);
-
-	while (available >= indio_dev->scan_bytes) {
-		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
-
-		stm32_dfsdm_process_data(adc, buffer);
-
-		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-						   pf->timestamp);
-		available -= indio_dev->scan_bytes;
-		adc->bufi += indio_dev->scan_bytes;
-		if (adc->bufi >= adc->buf_sz)
-			adc->bufi = 0;
-	}
-
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
 static void stm32_dfsdm_dma_buffer_done(void *data)
 {
 	struct iio_dev *indio_dev = data;
@@ -874,11 +849,6 @@ static void stm32_dfsdm_dma_buffer_done(
 	int available = stm32_dfsdm_adc_dma_residue(adc);
 	size_t old_pos;
 
-	if (indio_dev->currentmode & INDIO_BUFFER_TRIGGERED) {
-		iio_trigger_poll_chained(indio_dev->trig);
-		return;
-	}
-
 	/*
 	 * FIXME: In Kernel interface does not support cyclic DMA buffer,and
 	 * offers only an interface to push data samples per samples.
@@ -906,7 +876,15 @@ static void stm32_dfsdm_dma_buffer_done(
 			adc->bufi = 0;
 			old_pos = 0;
 		}
-		/* regular iio buffer without trigger */
+		/*
+		 * In DMA mode the trigger services of IIO are not used
+		 * (e.g. no call to iio_trigger_poll).
+		 * Calling irq handler associated to the hardware trigger is not
+		 * relevant as the conversions have already been done. Data
+		 * transfers are performed directly in DMA callback instead.
+		 * This implementation avoids to call trigger irq handler that
+		 * may sleep, in an atomic context (DMA irq handler context).
+		 */
 		if (adc->dev_data->type == DFSDM_IIO)
 			iio_push_to_buffers(indio_dev, buffer);
 	}
@@ -1517,8 +1495,7 @@ static int stm32_dfsdm_adc_init(struct i
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev,
-					 &iio_pollfunc_store_time,
-					 &stm32_dfsdm_adc_trigger_handler,
+					 &iio_pollfunc_store_time, NULL,
 					 &stm32_dfsdm_buffer_setup_ops);
 	if (ret) {
 		stm32_dfsdm_dma_release(indio_dev);


