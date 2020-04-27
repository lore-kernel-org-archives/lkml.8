Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B4C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78932078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JfNK8pjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgD0TUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:20:42 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:24932 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgD0TUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:20:39 -0400
X-Greylist: delayed 1472 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 15:20:38 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 49C0C3E3F5D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:00:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T8zAjA9qXEfyqT8zAj09wt; Mon, 27 Apr 2020 14:00:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LDbKFNJfmPWOJIgfBqIvSGHMQbRoOTKIi2anasyc6tw=; b=JfNK8pjbssL3lNb0vv9UdYv9v
        hiX8dXffE8UhzXW2S2HU7Qs41TIDKP2ZdViBxYZ73yauclJZaFfSLtefSRGsOLK1zTZkDGzzYMcJ8
        m6liiH5yHzmCEoA+jqd4ZbT3cV5ZN0qJ3oa/I43/3g+OOzpNgMRr2muwA+IfXup5tZVQDm4jvRLnQ
        /5yrvszHQx2BtTq5HjjVUIVwEoPvXU/22jA9pts+v+bW1QgsqTurKzV28Vr21keQAGrhfjzptG5e6
        yqLH0UEk2TVb3FdOy4BAnVQ/Gi/+g86JLJfLWnZL+k19qvfE8mS0/2wtCywL1ZezOQcEjWzD8Vsjg
        KsdzFk7BQ==;
Received: from [201.162.241.110] (port=3231 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT8z9-000anI-Lu; Mon, 27 Apr 2020 14:00:07 -0500
Date:   Mon, 27 Apr 2020 14:04:25 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 3/3] mtd: lpddr: Move function print_drs_error to lpddr_cmds.c
Message-ID: <5cc0d2e83e971693d974235608c8d96fe94c849d.1588013366.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1jT8z9-000anI-Lu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:3231
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function print_drs_error is only used in drivers/mtd/lpddr/lpddr_cmds.c
so, better to move it there.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/lpddr/lpddr_cmds.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/mtd/pfow.h       | 32 --------------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index fb1cbc9a2870..2675032984f9 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -94,6 +94,39 @@ struct mtd_info *lpddr_cmdset(struct map_info *map)
 }
 EXPORT_SYMBOL(lpddr_cmdset);
 
+static inline void print_drs_error(unsigned int dsr)
+{
+	int prog_status = (dsr & DSR_RPS) >> 8;
+
+	if (!(dsr & DSR_AVAILABLE))
+		pr_notice("DSR.15: (0) Device not Available\n");
+	if ((prog_status & 0x03) == 0x03)
+		pr_notice("DSR.9,8: (11) Attempt to program invalid "
+						"half with 41h command\n");
+	else if (prog_status & 0x02)
+		pr_notice("DSR.9,8: (10) Object Mode Program attempt "
+					"in region with Control Mode data\n");
+	else if (prog_status &  0x01)
+		pr_notice("DSR.9,8: (01) Program attempt in region "
+						"with Object Mode data\n");
+	if (!(dsr & DSR_READY_STATUS))
+		pr_notice("DSR.7: (0) Device is Busy\n");
+	if (dsr & DSR_ESS)
+		pr_notice("DSR.6: (1) Erase Suspended\n");
+	if (dsr & DSR_ERASE_STATUS)
+		pr_notice("DSR.5: (1) Erase/Blank check error\n");
+	if (dsr & DSR_PROGRAM_STATUS)
+		pr_notice("DSR.4: (1) Program Error\n");
+	if (dsr & DSR_VPPS)
+		pr_notice("DSR.3: (1) Vpp low detect, operation "
+					"aborted\n");
+	if (dsr & DSR_PSS)
+		pr_notice("DSR.2: (1) Program suspended\n");
+	if (dsr & DSR_DPS)
+		pr_notice("DSR.1: (1) Aborted Erase/Program attempt "
+					"on locked block\n");
+}
+
 static int wait_for_ready(struct map_info *map, struct flchip *chip,
 		unsigned int chip_op_time)
 {
diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
index b1fe2bbfdb04..7b57c36878cc 100644
--- a/include/linux/mtd/pfow.h
+++ b/include/linux/mtd/pfow.h
@@ -122,36 +122,4 @@ static inline void send_pfow_command(struct map_info *map,
 			map->pfow_base + PFOW_COMMAND_EXECUTE);
 }
 
-static inline void print_drs_error(unsigned dsr)
-{
-	int prog_status = (dsr & DSR_RPS) >> 8;
-
-	if (!(dsr & DSR_AVAILABLE))
-		pr_notice("DSR.15: (0) Device not Available\n");
-	if ((prog_status & 0x03) == 0x03)
-		pr_notice("DSR.9,8: (11) Attempt to program invalid "
-						"half with 41h command\n");
-	else if (prog_status & 0x02)
-		pr_notice("DSR.9,8: (10) Object Mode Program attempt "
-					"in region with Control Mode data\n");
-	else if (prog_status &  0x01)
-		pr_notice("DSR.9,8: (01) Program attempt in region "
-						"with Object Mode data\n");
-	if (!(dsr & DSR_READY_STATUS))
-		pr_notice("DSR.7: (0) Device is Busy\n");
-	if (dsr & DSR_ESS)
-		pr_notice("DSR.6: (1) Erase Suspended\n");
-	if (dsr & DSR_ERASE_STATUS)
-		pr_notice("DSR.5: (1) Erase/Blank check error\n");
-	if (dsr & DSR_PROGRAM_STATUS)
-		pr_notice("DSR.4: (1) Program Error\n");
-	if (dsr & DSR_VPPS)
-		pr_notice("DSR.3: (1) Vpp low detect, operation "
-					"aborted\n");
-	if (dsr & DSR_PSS)
-		pr_notice("DSR.2: (1) Program suspended\n");
-	if (dsr & DSR_DPS)
-		pr_notice("DSR.1: (1) Aborted Erase/Program attempt "
-					"on locked block\n");
-}
 #endif /* __LINUX_MTD_PFOW_H */
-- 
2.26.0

