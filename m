Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24032C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0995620829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgGaKDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:03:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732371AbgGaKC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:02:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05C85B035;
        Fri, 31 Jul 2020 10:03:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: address: Fix parser address/size cells initialization
Date:   Fri, 31 Jul 2020 12:02:48 +0200
Message-Id: <20200731100248.26982-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus->count_cells() parses cells starting from the node's parent. This is
not good enough for parser_init() which is generally parsing a bus node.

Revert to previous behavior using of_bus_n_*_cells().

Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/address.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 275d764efc77..89822e191956 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -701,11 +701,11 @@ static int parser_init(struct of_pci_range_parser *parser,
 
 	parser->node = node;
 	parser->pna = of_n_addr_cells(node);
+	parser->na = of_bus_n_addr_cells(node);
+	parser->ns = of_bus_n_size_cells(node);
 	parser->dma = !strcmp(name, "dma-ranges");
 	parser->bus = of_match_bus(node);
 
-	parser->bus->count_cells(parser->node, &parser->na, &parser->ns);
-
 	parser->range = of_get_property(node, name, &rlen);
 	if (parser->range == NULL)
 		return -ENOENT;
-- 
2.27.0

