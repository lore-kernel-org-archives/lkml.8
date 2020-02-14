Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808D222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581720219;
	bh=Zf38wgIMWVasPLHlNZcrweBYlJ2q1EslnsGRn2rC8ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PF/V/7/ah+Pwk3197eiQ1wHYw8ELbOG7Iu2cvXGNzSTBmwm8jwhWJD8nrmhD1/Vm3
	 8zaMEFahtpVqrg35CEwVkZnve3443INxjklUk8il2uBCR29YCynEV9GxBgo0E5ADDN
	 fZWVDI1a7EmxNEcbkrm8vxNp/+Kg/OqGOdwRXY/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBNWnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39725 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgBNWnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so10686041oty.6;
        Fri, 14 Feb 2020 14:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/fB8IpN2HvJy1SWgbzx0N4XyHZ1oSMpdaP9MXF/We8=;
        b=RK1TyN3fB6GW1cLpYPRBi93AfJMcq8xrUS9hZyv6EKleeGDt8Q/GvWQ+YDjdy1TA80
         bsTKHoVRF0XIMY1mJYa+BNTJy9dOMVXd2svStB/iBbYWdQwUimh7vpvHu93ayxMRQoce
         8OwgaTHkPZCwiXwHbtJKP8s0L/I8+7vaVox+4QtmJhRSrl4uwrE5cFebwk2tUkT7wAkx
         xK8o7HQacoIhrcazmX0CQpvbPj+1eM3yGPEkCiZfICsdXQ2/RKXx8uZV/yYHS70a+Opn
         FVORabNMtT0mLHkQCgdxe2YjM1VqM2pIO+nLSKFM3iahvlIVDXn2Zg/GbHSAi1I+UR7L
         Bmkg==
X-Gm-Message-State: APjAAAWSfiPVKVM17xdfrvCDWDJbEeWDzb87gAeGtVQnAdlalXK2iOb1
        v37AFluJcvD73l3o4d5aKjcDn+o=
X-Google-Smtp-Source: APXvYqxPb7eZ0ET0dBpwWANxrcTfk4nicz/9JegOP1idWSuzHFEIGRzPBmcfQgcoYGCJ+bNZJYwQnw==
X-Received: by 2002:a9d:649a:: with SMTP id g26mr3937088otl.15.1581720210006;
        Fri, 14 Feb 2020 14:43:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:29 -0800 (PST)
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
Subject: [PATCH 5/7] of/address: Rework of_pci_range parsing for non-PCI buses
Date:   Fri, 14 Feb 2020 16:43:20 -0600
Message-Id: <20200214224322.20030-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only PCI specific part of of_pci_range_parser_one() is the handling
of the 3rd address cell. Rework it to work on regular 1 and 2 cell
addresses.

Use defines and a union to avoid a treewide renaming of the parsing
helpers and struct.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 33 +++++++++++++++++++++------------
 include/linux/of_address.h | 12 +++++++++---
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5d608d7c10d6..6d33f849f114 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -694,12 +694,12 @@ EXPORT_SYMBOL(of_get_address);
 static int parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node, const char *name)
 {
-	const int na = 3, ns = 2;
 	int rlen;
 
 	parser->node = node;
 	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
+	parser->na = of_bus_n_addr_cells(node);
+	parser->ns = of_bus_n_size_cells(node);
 	parser->dma = !strcmp(name, "dma-ranges");
 
 	parser->range = of_get_property(node, name, &rlen);
@@ -724,20 +724,28 @@ int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 	return parser_init(parser, node, "dma-ranges");
 }
 EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
+#define of_dma_range_parser_init of_pci_dma_range_parser_init
 
 struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 						struct of_pci_range *range)
 {
-	const int na = 3, ns = 2;
+	int na = parser->na;
+	int ns = parser->ns;
+	int np = parser->pna + na + ns;
 
 	if (!range)
 		return NULL;
 
-	if (!parser->range || parser->range + parser->np > parser->end)
+	if (!parser->range || parser->range + np > parser->end)
 		return NULL;
 
-	range->flags = of_bus_pci_get_flags(parser->range);
-	range->pci_addr = of_read_number(parser->range + 1, ns);
+	if (parser->na == 3)
+		range->flags = of_bus_pci_get_flags(parser->range);
+	else
+		range->flags = 0;
+
+	range->pci_addr = of_read_number(parser->range, na);
+
 	if (parser->dma)
 		range->cpu_addr = of_translate_dma_address(parser->node,
 				parser->range + na);
@@ -746,15 +754,16 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 				parser->range + na);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
-	parser->range += parser->np;
+	parser->range += np;
 
 	/* Now consume following elements while they are contiguous */
-	while (parser->range + parser->np <= parser->end) {
-		u32 flags;
+	while (parser->range + np <= parser->end) {
+		u32 flags = 0;
 		u64 pci_addr, cpu_addr, size;
 
-		flags = of_bus_pci_get_flags(parser->range);
-		pci_addr = of_read_number(parser->range + 1, ns);
+		if (parser->na == 3)
+			flags = of_bus_pci_get_flags(parser->range);
+		pci_addr = of_read_number(parser->range, na);
 		if (parser->dma)
 			cpu_addr = of_translate_dma_address(parser->node,
 					parser->range + na);
@@ -770,7 +779,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 			break;
 
 		range->size += size;
-		parser->range += parser->np;
+		parser->range += np;
 	}
 
 	return range;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 8d12bf18e80b..763022ed3456 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -10,20 +10,27 @@ struct of_pci_range_parser {
 	struct device_node *node;
 	const __be32 *range;
 	const __be32 *end;
-	int np;
+	int na;
+	int ns;
 	int pna;
 	bool dma;
 };
+#define of_range_parser of_pci_range_parser
 
 struct of_pci_range {
-	u64 pci_addr;
+	union {
+		u64 pci_addr;
+		u64 bus_addr;
+	};
 	u64 cpu_addr;
 	u64 size;
 	u32 flags;
 };
+#define of_range of_pci_range
 
 #define for_each_of_pci_range(parser, range) \
 	for (; of_pci_range_parser_one(parser, range);)
+#define for_each_of_range for_each_of_pci_range
 
 /* Translate a DMA address from device space to CPU space */
 extern u64 of_translate_dma_address(struct device_node *dev,
@@ -142,4 +149,3 @@ static inline int of_pci_range_to_resource(struct of_pci_range *range,
 #endif /* CONFIG_OF_ADDRESS && CONFIG_PCI */
 
 #endif /* __OF_ADDRESS_H */
-
-- 
2.20.1

