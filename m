Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC64C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F6B2081E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581720227;
	bh=Rj8PSB+UwBprmaQ2JyKnvemogSiYDpPi3Vm6V0cZl4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NZs4tVt/oxglfHeEoEUAC9Zgvvo/Cl57T7o54eM7sbHlIWqcnboxoQ3q2pDxom6GB
	 zrJNhS24JMPIFEpyqOnIcyKIlAwwOkGF1a2ix9BRzN3b53nF9kHSeY2CrZJ+oxZoE5
	 DY9fSOj+syPzDisFqB6a2kJzrrMT8uqbXegggYoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBNWnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42955 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBNWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so10674736otd.9;
        Fri, 14 Feb 2020 14:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxqrTmSWehNrZNpQ90LT3R+yI3An6tFPJHq9Cs6TvSY=;
        b=O2oIHRQOgC/RyyoVqyUHnBlXqNO8XeUKzLO5VBx7Lqo0Bjb4bTdWhu7yRLxHglZ2k7
         uDcAiVpHAD5+TXcZn+FVX4C2k4Ef2JGqso9GKoWmIyFqYl0yxJcU50cQt5fwXMGatFxf
         rD70SVy6fwgggMXWW1ro3WaT1KbRQpsPdIApn66Yj+dPR/LJ8RDeJMdYXKQZjTANtuaa
         /i3i1aW234SVTWXsJA4kbn8SzOGR8NNIKEkLStvlkU+AQupzWhDSj1lmEditDz02BgXY
         KjyXcjm+am6cZsdcF2o0FV1X6disavHLyr/tUVxT+KfOnrNaETN1v6TuG+5XMG/EO8dm
         Qszg==
X-Gm-Message-State: APjAAAW8m46zMAYpL6I079eKaQY5MPDldy9Xjs5HRH/Nw0b++WaFEEoi
        y7l6EavD3zQV+okX8+uWqOsARAQ=
X-Google-Smtp-Source: APXvYqzRyruX6jzkcJBQ4Ol9aSCzNcGPj4+4pT7mi4zsBVbfgiMtU6G60aL26K2rvdNgbEenPv9cKg==
X-Received: by 2002:a05:6830:1049:: with SMTP id b9mr4276236otp.100.1581720211206;
        Fri, 14 Feb 2020 14:43:31 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/7] of/address: use range parser for of_dma_get_range
Date:   Fri, 14 Feb 2020 16:43:21 -0600
Message-Id: <20200214224322.20030-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_dma_get_range() does the same ranges parsing as
of_pci_range_parser_one(), so let's refactor of_dma_get_range() to use
it instead.

This commit is no functional change. Subsequent commits will parse more
than the 1st dma-ranges entry.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 6d33f849f114..a2c45812a50e 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -939,10 +939,11 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 {
 	struct device_node *node = of_node_get(np);
 	const __be32 *ranges = NULL;
-	int len, naddr, nsize, pna;
+	int len;
 	int ret = 0;
 	bool found_dma_ranges = false;
-	u64 dmaaddr;
+	struct of_range_parser parser;
+	struct of_range range;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -967,33 +968,20 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		goto out;
 	}
 
-	naddr = of_bus_n_addr_cells(node);
-	nsize = of_bus_n_size_cells(node);
-	pna = of_n_addr_cells(node);
-	if ((len / sizeof(__be32)) % (pna + naddr + nsize)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	of_dma_range_parser_init(&parser, node);
+
+	for_each_of_range(&parser, &range) {
+		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+			 range.bus_addr, range.cpu_addr, range.size);
+
+		*dma_addr = range.bus_addr;
+		*paddr = range.cpu_addr;
+		*size = range.size;
 
-	/* dma-ranges format:
-	 * DMA addr	: naddr cells
-	 * CPU addr	: pna cells
-	 * size		: nsize cells
-	 */
-	dmaaddr = of_read_number(ranges, naddr);
-	*paddr = of_translate_dma_address(node, ranges + naddr);
-	if (*paddr == OF_BAD_ADDR) {
-		pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
-		       dmaaddr, np);
-		ret = -EINVAL;
 		goto out;
 	}
-	*dma_addr = dmaaddr;
-
-	*size = of_read_number(ranges + naddr + pna, nsize);
 
-	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
-		 *dma_addr, *paddr, *size);
+	pr_err("translation of DMA ranges failed on node(%pOF)\n", np);
 
 out:
 	of_node_put(node);
-- 
2.20.1

