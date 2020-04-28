Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC77C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E11206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100257;
	bh=HVlooMNtiKSy3RQDjckeLqwmZgxF92lbXT5tCZ8rwnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYd2o6vEH9FjrIXZvHLLkO5jGly88lD1dqPPcZr3Idvh7OKivY4IvX9WPlRlc53cS
	 O8i+ToqWsqGyWlcQLW6ERThTqM2NMO7fAf7xCbMMRtsLoQ8DEZdOWPie1ZzlCsXUdi
	 TWrChsJgrZl/EBYrjcTnjSmKVz2JzQszBhdVl7w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgD1SaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbgD1SaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:30:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC566214D8;
        Tue, 28 Apr 2020 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098612;
        bh=HVlooMNtiKSy3RQDjckeLqwmZgxF92lbXT5tCZ8rwnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNPFfisyyngj3GPdSpAdkBm7OeSRAn6t7B0AxNnVo1e8+bb0yIEa6iGloNe8hzPOw
         +XdqPu4SgUohbH+RK5FP0c9kzWjoOPGS5U0Am3mXV8J2pUoaQQ3e86JB/Ixsg5v6E3
         zIOuRVc1H0Xm793BJlauXsitpl4ssBUY8sYm+bKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.6 085/167] iio: adc: ti-ads8344: properly byte swap value
Date:   Tue, 28 Apr 2020 20:24:21 +0200
Message-Id: <20200428182235.744145699@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit dd7de4c0023e7564cabe39d64b2822a522890792 upstream.

The first received byte is the MSB, followed by the LSB so the value needs
to be byte swapped.

Also, the ADC actually has a delay of one clock on the SPI bus. Read three
bytes to get the last bit.

Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ti-ads8344.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -29,7 +29,7 @@ struct ads8344 {
 	struct mutex lock;
 
 	u8 tx_buf ____cacheline_aligned;
-	u16 rx_buf;
+	u8 rx_buf[3];
 };
 
 #define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
@@ -89,11 +89,11 @@ static int ads8344_adc_conversion(struct
 
 	udelay(9);
 
-	ret = spi_read(spi, &adc->rx_buf, 2);
+	ret = spi_read(spi, adc->rx_buf, sizeof(adc->rx_buf));
 	if (ret)
 		return ret;
 
-	return adc->rx_buf;
+	return adc->rx_buf[0] << 9 | adc->rx_buf[1] << 1 | adc->rx_buf[2] >> 7;
 }
 
 static int ads8344_read_raw(struct iio_dev *iio,


