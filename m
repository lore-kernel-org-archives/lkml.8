Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056AEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04F7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846519;
	bh=X7tG5Nb9FdI0XtMkJSgMz6obTbzw75umNhrHk6RRrbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i27MW+5ZSBkV9b/DspHsWZ6LafkE2yGJe+UIlg/E/LlAjzPV0qgeZcwehhYIM+cWT
	 DuudfOtRXjVfSAmIZbM/Dj1f/cOrTRH9ewPVA5J4xQgM10EL7wXRWld28j6Kd9AD0r
	 GYZIDMxDIWTFrimm59lKbrBmRbyLPm/kAmWzpPn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgCJNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730320AbgCJNB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E29208E4;
        Tue, 10 Mar 2020 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845317;
        bh=X7tG5Nb9FdI0XtMkJSgMz6obTbzw75umNhrHk6RRrbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCEwFOdDiFF6Hg3HFiPfZuegk4F7jXpma4T+zC7KZfP77aG61CkURfF8qA5WSJMW1
         Co7Hzg9qKLrE6YG8dLOmUDwfA0+cKm1eLn+dLVVt9YQVZdHrMaHWpjB+PHeWj84Olw
         cbv3tmxBn34iOCNPwTFt2KSicjly112HcB4C9OJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 140/189] spi: atmel-quadspi: fix possible MMIO window size overrun
Date:   Tue, 10 Mar 2020 13:39:37 +0100
Message-Id: <20200310123653.981003009@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

commit 8e093ea4d3593379be46b845b9e823179558047e upstream.

The QSPI controller memory space is limited to 128MB:
0x9000_00000-0x9800_00000/0XD000_0000--0XD800_0000.

There are nor flashes that are bigger in size than the memory size
supported by the controller: Micron MT25QL02G (256 MB).

Check if the address exceeds the MMIO window size. An improvement
would be to add support for regular SPI mode and fall back to it
when the flash memories overrun the controller's memory space.

Fixes: 0e6aae08e9ae ("spi: Add QuadSPI driver for Atmel SAMA5D2")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20200228155437.1558219-1-tudor.ambarus@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/atmel-quadspi.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -149,6 +149,7 @@ struct atmel_qspi {
 	struct clk		*qspick;
 	struct platform_device	*pdev;
 	const struct atmel_qspi_caps *caps;
+	resource_size_t		mmap_size;
 	u32			pending;
 	u32			mr;
 	u32			scr;
@@ -329,6 +330,14 @@ static int atmel_qspi_exec_op(struct spi
 	u32 sr, offset;
 	int err;
 
+	/*
+	 * Check if the address exceeds the MMIO window size. An improvement
+	 * would be to add support for regular SPI mode and fall back to it
+	 * when the flash memories overrun the controller's memory space.
+	 */
+	if (op->addr.val + op->data.nbytes > aq->mmap_size)
+		return -ENOTSUPP;
+
 	err = atmel_qspi_set_cfg(aq, op, &offset);
 	if (err)
 		return err;
@@ -480,6 +489,8 @@ static int atmel_qspi_probe(struct platf
 		goto exit;
 	}
 
+	aq->mmap_size = resource_size(res);
+
 	/* Get the peripheral clock */
 	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(aq->pclk))


