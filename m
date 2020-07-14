Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1442C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2EA21D93
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kr3lngVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGNGfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNGfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:35:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE18DC061755;
        Mon, 13 Jul 2020 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=894nJfbdHHUH/ylIpUbkkJ24k6/ppZVJBHTRyT/kui4=; b=kr3lngVSlsG3f4Lw6SDU3Y81LY
        aV/H6hj1kW2Bsrp8p7+L9EzPewSaD2+fJmHeg9kFe4AuCFyVIsZpylNVdYHHkAdZ08+1k67hzx3bq
        itseW3uxwfUa3uPAFPsiBv7NzPD7H69F2GAB0mbuefd279ut3e3PgiOybaElIUAl7O7n+KY2a4Bt4
        U3mhqvS2nTORQal+hdH9bGnmxrZzTOcInsv2rGyDBCZGfW6gXdNRynrVAIDh5O9uj82oha/x+LD7g
        AE5BliNO1p2/T5R6VZq4DEQfRxbxw96QEC6JwkeBRBFs2ElpXT9yJSfABYGiOMm7/3YOC8IevL3xf
        xmlP5BQA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvEXX-00064C-Ct; Tue, 14 Jul 2020 06:35:43 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] dmaengine: idxd: fix PCI_MSI build errors
Message-ID: <9dee3f46-70d9-ea75-10cb-5527ab297d1d@infradead.org>
Date:   Mon, 13 Jul 2020 23:35:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_PCI_MSI is not enabled by making the
driver depend on PCI_MSI:

ld: drivers/dma/idxd/device.o: in function `idxd_mask_msix_vector':
device.c:(.text+0x26f): undefined reference to `pci_msi_mask_irq'
ld: drivers/dma/idxd/device.o: in function `idxd_unmask_msix_vector':
device.c:(.text+0x2af): undefined reference to `pci_msi_unmask_irq'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2020-0713-1949.orig/drivers/dma/Kconfig
+++ mmotm-2020-0713-1949/drivers/dma/Kconfig
@@ -285,6 +285,7 @@ config INTEL_IDMA64
 config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
 	depends on PCI && X86_64
+	depends on PCI_MSI
 	depends on SBITMAP
 	select DMA_ENGINE
 	help


