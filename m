Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE7C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBAB206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZSmL+PjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgD0Tt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:49:57 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.219]:28733 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgD0Tt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:49:57 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D89302189
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:49:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T9lLjfVjUAGTXT9lLjyLUz; Mon, 27 Apr 2020 14:49:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d0MbhRJ5eD5Y7+MhsOSEX8wmNhxsr/DO77LwRTLGH3A=; b=ZSmL+PjA81Nrs3oA6zFvWX8UD
        szqbmabAC2zJN0+NbVZIJZS9fl4YVzBjZN9U9oeVNwK17BJwciwyrNoUS/WMLt9JVWAhPE/u9VV7N
        W9Tlz2agUZaTpuFHYuQzJnbMiIg7E36Uykv2YGBSH4BoMNERDWPKMXhL7ArqZmOP+c7o0hDOlYo3y
        U3nGorclYR1qwzuAzQ6EG6bubV3EN4J+b0Dwc4Ewxa2VrGSv9hEZv7LIseCy1l3ck/uuqgO/+8HWQ
        VCX8gak32LTN7skd94nuBR8xceCcvA6Td7/QEkWXrA8edxzXY42nfzmFchibgzOEgZa1F6eiVokCd
        OayKG4aIw==;
Received: from [201.162.241.110] (port=6103 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT9lL-000zx6-BA; Mon, 27 Apr 2020 14:49:55 -0500
Date:   Mon, 27 Apr 2020 14:54:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 2/3] mtd: lpddr: Replace printk with pr_notice
Message-ID: <ff48ce07ef208ba65b858f09279a3b36031d64d2.1588016644.git.gustavo@embeddedor.com>
References: <cover.1588016644.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588016644.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.110
X-Source-L: No
X-Exim-ID: 1jT9lL-000zx6-BA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:6103
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_notice is preferred over printk.

Also, coalesce formats as coalescing is part of coding-style:
"never break user-visible strings such as printk messages"

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Coalesce formats and update changelog text, accordingly.

 include/linux/mtd/pfow.h | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
index c65d7a3be3c6..cd21c6768065 100644
--- a/include/linux/mtd/pfow.h
+++ b/include/linux/mtd/pfow.h
@@ -127,31 +127,26 @@ static inline void print_drs_error(unsigned dsr)
 	int prog_status = (dsr & DSR_RPS) >> 8;
 
 	if (!(dsr & DSR_AVAILABLE))
-		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
+		pr_notice("DSR.15: (0) Device not Available\n");
 	if ((prog_status & 0x03) == 0x03)
-		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
-						"half with 41h command\n");
+		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
 	else if (prog_status & 0x02)
-		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
-					"in region with Control Mode data\n");
+		pr_notice("DSR.9,8: (10) Object Mode Program attempt in region with Control Mode data\n");
 	else if (prog_status &  0x01)
-		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
-						"with Object Mode data\n");
+		pr_notice("DSR.9,8: (01) Program attempt in region with Object Mode data\n");
 	if (!(dsr & DSR_READY_STATUS))
-		printk(KERN_NOTICE"DSR.7: (0) Device is Busy\n");
+		pr_notice("DSR.7: (0) Device is Busy\n");
 	if (dsr & DSR_ESS)
-		printk(KERN_NOTICE"DSR.6: (1) Erase Suspended\n");
+		pr_notice("DSR.6: (1) Erase Suspended\n");
 	if (dsr & DSR_ERASE_STATUS)
-		printk(KERN_NOTICE"DSR.5: (1) Erase/Blank check error\n");
+		pr_notice("DSR.5: (1) Erase/Blank check error\n");
 	if (dsr & DSR_PROGRAM_STATUS)
-		printk(KERN_NOTICE"DSR.4: (1) Program Error\n");
+		pr_notice("DSR.4: (1) Program Error\n");
 	if (dsr & DSR_VPPS)
-		printk(KERN_NOTICE"DSR.3: (1) Vpp low detect, operation "
-					"aborted\n");
+		pr_notice("DSR.3: (1) Vpp low detect, operation aborted\n");
 	if (dsr & DSR_PSS)
-		printk(KERN_NOTICE"DSR.2: (1) Program suspended\n");
+		pr_notice("DSR.2: (1) Program suspended\n");
 	if (dsr & DSR_DPS)
-		printk(KERN_NOTICE"DSR.1: (1) Aborted Erase/Program attempt "
-					"on locked block\n");
+		pr_notice("DSR.1: (1) Aborted Erase/Program attempt on locked block\n");
 }
 #endif /* __LINUX_MTD_PFOW_H */
-- 
2.26.0

