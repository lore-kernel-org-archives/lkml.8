Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46241C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B52217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581720211;
	bh=7wtrM8uT2nSDc0z2nrQdISXH6Z3Clu998+UmSaZBCe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJ46hiHQZ6GJF2lUU+AYVHG2TVaMpXxJFrJNFyDeFrasyH85QpoyPEg3emgRfw7Fb
	 vjJK+QfCTqn/FSnjBuX0KushGgvXzakuThFqIiA743lpqChQoCwST8kvL4zxyKtZrr
	 UGRzcth/61gDduLl9a0trEza2jumY1IzLeQLpXUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBNWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46671 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgBNWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so10656592otb.13;
        Fri, 14 Feb 2020 14:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEnB5+kU+FjhvIdO5SQl7ydF6Vj7dX77BsiIjtiVufU=;
        b=A80G/xETcsCrQoRQvPMZLRZod47UrkhUS/d7J8fmEfoyGhoFd9JNbF7yHPhvpICNG2
         IdQV9TelRim7MPYRCLy/2dOmPf5CYXjcfIeU4iPrsJQk4qZOcLx1CJ4LSCoS70jzGQfb
         iLjyb72HZbsGQWh57Wu5njvmMtCkBH9r3H7IbrcypVS2ynRecQ1xSlgmz0v/onVQRcYJ
         7ojYwtF5HOJp75Sz4ZmpXbCJ0UHRTenGFgCD/92WOmTCSV7/KOcAjE+0tUmMBulHvTYv
         86FpEnSD+Wjw/wrxV0X/MsKg5bLh9mi529yjII5+KgLSrlA++9QFKOULECCRijAwggCM
         dK6g==
X-Gm-Message-State: APjAAAUozaBDodr0HSQSkzaZhc0aW35qXLx3Vc/DQDEb9Cp8ndHHKtwJ
        cbYAbMX/EVRN/MFWJ/h7zXTZFBE=
X-Google-Smtp-Source: APXvYqy5SwntOtr1CzPuatwaYlGx9mBbjcZbXp6MOXwEDNH/Uw68ZFD5Up2zlZRyFWflVldIKSAeEA==
X-Received: by 2002:a9d:3b09:: with SMTP id z9mr4087034otb.195.1581720205444;
        Fri, 14 Feb 2020 14:43:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:24 -0800 (PST)
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
Subject: [PATCH 1/7] of/address: Move range parser code out of CONFIG_PCI
Date:   Fri, 14 Feb 2020 16:43:16 -0600
Message-Id: <20200214224322.20030-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to make the range parsing code work for non-PCI buses,
move the parsing functions out from the CONFIG_PCI #ifdef.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 215 ++++++++++++++++++++++---------------------
 1 file changed, 109 insertions(+), 106 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e8a39c3ec4d4..846045a48395 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -100,6 +100,28 @@ static unsigned int of_bus_default_get_flags(const __be32 *addr)
 	return IORESOURCE_MEM;
 }
 
+static unsigned int of_bus_pci_get_flags(const __be32 *addr)
+{
+	unsigned int flags = 0;
+	u32 w = be32_to_cpup(addr);
+
+	if (!IS_ENABLED(CONFIG_PCI))
+		return 0;
+
+	switch((w >> 24) & 0x03) {
+	case 0x01:
+		flags |= IORESOURCE_IO;
+		break;
+	case 0x02: /* 32 bits */
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM;
+		break;
+	}
+	if (w & 0x40000000)
+		flags |= IORESOURCE_PREFETCH;
+	return flags;
+}
+
 #ifdef CONFIG_PCI
 /*
  * PCI bus specific translator
@@ -125,25 +147,6 @@ static void of_bus_pci_count_cells(struct device_node *np,
 		*sizec = 2;
 }
 
-static unsigned int of_bus_pci_get_flags(const __be32 *addr)
-{
-	unsigned int flags = 0;
-	u32 w = be32_to_cpup(addr);
-
-	switch((w >> 24) & 0x03) {
-	case 0x01:
-		flags |= IORESOURCE_IO;
-		break;
-	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
-		flags |= IORESOURCE_MEM;
-		break;
-	}
-	if (w & 0x40000000)
-		flags |= IORESOURCE_PREFETCH;
-	return flags;
-}
-
 static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 		int pna)
 {
@@ -234,93 +237,6 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
-static int parser_init(struct of_pci_range_parser *parser,
-			struct device_node *node, const char *name)
-{
-	const int na = 3, ns = 2;
-	int rlen;
-
-	parser->node = node;
-	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
-	parser->dma = !strcmp(name, "dma-ranges");
-
-	parser->range = of_get_property(node, name, &rlen);
-	if (parser->range == NULL)
-		return -ENOENT;
-
-	parser->end = parser->range + rlen / sizeof(__be32);
-
-	return 0;
-}
-
-int of_pci_range_parser_init(struct of_pci_range_parser *parser,
-				struct device_node *node)
-{
-	return parser_init(parser, node, "ranges");
-}
-EXPORT_SYMBOL_GPL(of_pci_range_parser_init);
-
-int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-				struct device_node *node)
-{
-	return parser_init(parser, node, "dma-ranges");
-}
-EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
-
-struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
-						struct of_pci_range *range)
-{
-	const int na = 3, ns = 2;
-
-	if (!range)
-		return NULL;
-
-	if (!parser->range || parser->range + parser->np > parser->end)
-		return NULL;
-
-	range->pci_space = be32_to_cpup(parser->range);
-	range->flags = of_bus_pci_get_flags(parser->range);
-	range->pci_addr = of_read_number(parser->range + 1, ns);
-	if (parser->dma)
-		range->cpu_addr = of_translate_dma_address(parser->node,
-				parser->range + na);
-	else
-		range->cpu_addr = of_translate_address(parser->node,
-				parser->range + na);
-	range->size = of_read_number(parser->range + parser->pna + na, ns);
-
-	parser->range += parser->np;
-
-	/* Now consume following elements while they are contiguous */
-	while (parser->range + parser->np <= parser->end) {
-		u32 flags;
-		u64 pci_addr, cpu_addr, size;
-
-		flags = of_bus_pci_get_flags(parser->range);
-		pci_addr = of_read_number(parser->range + 1, ns);
-		if (parser->dma)
-			cpu_addr = of_translate_dma_address(parser->node,
-					parser->range + na);
-		else
-			cpu_addr = of_translate_address(parser->node,
-					parser->range + na);
-		size = of_read_number(parser->range + parser->pna + na, ns);
-
-		if (flags != range->flags)
-			break;
-		if (pci_addr != range->pci_addr + range->size ||
-		    cpu_addr != range->cpu_addr + range->size)
-			break;
-
-		range->size += size;
-		parser->range += parser->np;
-	}
-
-	return range;
-}
-EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
-
 /*
  * of_pci_range_to_resource - Create a resource from an of_pci_range
  * @range:	the PCI range that describes the resource
@@ -775,6 +691,93 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
 }
 EXPORT_SYMBOL(of_get_address);
 
+static int parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node, const char *name)
+{
+	const int na = 3, ns = 2;
+	int rlen;
+
+	parser->node = node;
+	parser->pna = of_n_addr_cells(node);
+	parser->np = parser->pna + na + ns;
+	parser->dma = !strcmp(name, "dma-ranges");
+
+	parser->range = of_get_property(node, name, &rlen);
+	if (parser->range == NULL)
+		return -ENOENT;
+
+	parser->end = parser->range + rlen / sizeof(__be32);
+
+	return 0;
+}
+
+int of_pci_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	return parser_init(parser, node, "ranges");
+}
+EXPORT_SYMBOL_GPL(of_pci_range_parser_init);
+
+int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	return parser_init(parser, node, "dma-ranges");
+}
+EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
+
+struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
+						struct of_pci_range *range)
+{
+	const int na = 3, ns = 2;
+
+	if (!range)
+		return NULL;
+
+	if (!parser->range || parser->range + parser->np > parser->end)
+		return NULL;
+
+	range->pci_space = be32_to_cpup(parser->range);
+	range->flags = of_bus_pci_get_flags(parser->range);
+	range->pci_addr = of_read_number(parser->range + 1, ns);
+	if (parser->dma)
+		range->cpu_addr = of_translate_dma_address(parser->node,
+				parser->range + na);
+	else
+		range->cpu_addr = of_translate_address(parser->node,
+				parser->range + na);
+	range->size = of_read_number(parser->range + parser->pna + na, ns);
+
+	parser->range += parser->np;
+
+	/* Now consume following elements while they are contiguous */
+	while (parser->range + parser->np <= parser->end) {
+		u32 flags;
+		u64 pci_addr, cpu_addr, size;
+
+		flags = of_bus_pci_get_flags(parser->range);
+		pci_addr = of_read_number(parser->range + 1, ns);
+		if (parser->dma)
+			cpu_addr = of_translate_dma_address(parser->node,
+					parser->range + na);
+		else
+			cpu_addr = of_translate_address(parser->node,
+					parser->range + na);
+		size = of_read_number(parser->range + parser->pna + na, ns);
+
+		if (flags != range->flags)
+			break;
+		if (pci_addr != range->pci_addr + range->size ||
+		    cpu_addr != range->cpu_addr + range->size)
+			break;
+
+		range->size += size;
+		parser->range += parser->np;
+	}
+
+	return range;
+}
+EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
+
 static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
 			u64 size)
 {
-- 
2.20.1

