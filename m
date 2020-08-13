Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621C4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F45208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHMLrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:47:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35643 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHMLoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:44:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k6Be4-0007ty-85; Thu, 13 Aug 2020 11:43:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] of/address: check for invalid range.cpu_addr
Date:   Thu, 13 Aug 2020 12:43:44 +0100
Message-Id: <20200813114344.67730-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently invalid CPU addresses are not being sanity checked resulting in
SATA setup failure on a SynQuacer SC2A11 development machine. The original
check was removed by and earlier commit, so add a sanity check back in
to avoid this regression.

Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/of/address.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 590493e04b01..6ffbf7b99e92 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -985,6 +985,10 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 			/* Don't error out as we'd break some existing DTs */
 			continue;
 		}
+		if (range.cpu_addr == OF_BAD_ADDR) {
+			pr_err("Translation of CPU address failed on node (%pOF)\n", node);
+			continue;
+		}
 		dma_offset = range.cpu_addr - range.bus_addr;
 
 		/* Take lower and upper limits */
-- 

V2: print message using pr_err and don't print range.cpu_addr as it's always
    going to be OF_BAD_ADDR so the information is pointless.
--
2.27.0

