Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB7C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FF62078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="suFuGCVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD0TWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:22:54 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.219]:45646 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgD0TWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:22:53 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E3A5A874D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:58:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T8xyjG5jJXVkQT8xyjQ3YG; Mon, 27 Apr 2020 13:58:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FOyZfRjZPBxCQvfUPqDeaCbaMtJlKN1+CtCYhi/tOSY=; b=suFuGCVs7RyNqaM33tnxUFAe1
        E9/FZswXv79NEBrCUMlg+x8b5aiKCsRMAPlskamQJ0gt8W1BVzPU0DpeCqpM4x+VczB5fFSj9GJID
        QfBIrvRhuF2NRXDviV22fgJ9PfwNC2GrMhTUzLdJbQa8EH0YepiP3AIGZ5NCF6TGv58uqFSq4zvGO
        Rp+53roCuI0kwbwx5db+RZqYJx65HNkdzyMu/PIvyhC8qMcxDstLThQ2huGoni0XNoY3/6gcGwsFn
        zQoogUs07/TtLRq893oytfDNK9/t4cSg2fG4dDzoqFZh0YhORdF6Oh7Qr+HBQGbhqwvFlvE2kW8Tv
        BR+OQ6FDw==;
Received: from [201.162.241.110] (port=5852 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT8xy-000a5x-D5; Mon, 27 Apr 2020 13:58:54 -0500
Date:   Mon, 27 Apr 2020 14:03:12 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/3] mtd: lpddr: Replace printk with pr_notice
Message-ID: <c9684a22b661fdeff9efcd5b18be01653911fc89.1588013366.git.gustavo@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588013366.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.110
X-Source-L: No
X-Exim-ID: 1jT8xy-000a5x-D5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:5852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_notice is preferred over printk.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/mtd/pfow.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
index c65d7a3be3c6..b1fe2bbfdb04 100644
--- a/include/linux/mtd/pfow.h
+++ b/include/linux/mtd/pfow.h
@@ -127,31 +127,31 @@ static inline void print_drs_error(unsigned dsr)
 	int prog_status = (dsr & DSR_RPS) >> 8;
 
 	if (!(dsr & DSR_AVAILABLE))
-		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
+		pr_notice("DSR.15: (0) Device not Available\n");
 	if ((prog_status & 0x03) == 0x03)
-		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
+		pr_notice("DSR.9,8: (11) Attempt to program invalid "
 						"half with 41h command\n");
 	else if (prog_status & 0x02)
-		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
+		pr_notice("DSR.9,8: (10) Object Mode Program attempt "
 					"in region with Control Mode data\n");
 	else if (prog_status &  0x01)
-		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
+		pr_notice("DSR.9,8: (01) Program attempt in region "
 						"with Object Mode data\n");
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
+		pr_notice("DSR.3: (1) Vpp low detect, operation "
 					"aborted\n");
 	if (dsr & DSR_PSS)
-		printk(KERN_NOTICE"DSR.2: (1) Program suspended\n");
+		pr_notice("DSR.2: (1) Program suspended\n");
 	if (dsr & DSR_DPS)
-		printk(KERN_NOTICE"DSR.1: (1) Aborted Erase/Program attempt "
+		pr_notice("DSR.1: (1) Aborted Erase/Program attempt "
 					"on locked block\n");
 }
 #endif /* __LINUX_MTD_PFOW_H */
-- 
2.26.0

