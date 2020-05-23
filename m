Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F9A204EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgEWTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgEWTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:50:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B94C061A0E;
        Sat, 23 May 2020 12:50:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcaAI-0004Ui-0K; Sat, 23 May 2020 21:50:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89C1D1C0082;
        Sat, 23 May 2020 21:50:37 +0200 (CEST)
Date:   Sat, 23 May 2020 19:50:37 -0000
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/apic/uv: Remove code for unused distributed GRU mode
Cc:     Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <sivanich@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200513221123.GJ3240@raspberrypi>
References: <20200513221123.GJ3240@raspberrypi>
MIME-Version: 1.0
Message-ID: <159026343739.17951.3625174887155578318.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     33649bf4494c1feaf1956a84895fcc0621aafd90
Gitweb:        https://git.kernel.org/tip/33649bf4494c1feaf1956a84895fcc0621aafd90
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Wed, 13 May 2020 17:11:23 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 23 May 2020 16:19:57 +02:00

x86/apic/uv: Remove code for unused distributed GRU mode

Distributed GRU mode appeared in only one generation of UV hardware,
and no version of the BIOS has shipped with this feature enabled, and
we have no plans to ever change that.  The gru.s3.mode check has
always been and will continue to be false.  So remove this dead code.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dimitri Sivanich <sivanich@hpe.com>
Link: https://lkml.kernel.org/r/20200513221123.GJ3240@raspberrypi
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 59 +-----------------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 10339ad..69e70ed 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -30,8 +30,6 @@ static enum uv_system_type	uv_system_type;
 static int			uv_hubbed_system;
 static int			uv_hubless_system;
 static u64			gru_start_paddr, gru_end_paddr;
-static u64			gru_dist_base, gru_first_node_paddr = -1LL, gru_last_node_paddr;
-static u64			gru_dist_lmask, gru_dist_umask;
 static union uvh_apicid		uvh_apicid;
 
 /* Unpack OEM/TABLE ID's to be NULL terminated strings */
@@ -83,20 +81,7 @@ static unsigned long __init uv_early_read_mmr(unsigned long addr)
 
 static inline bool is_GRU_range(u64 start, u64 end)
 {
-	if (gru_dist_base) {
-		u64 su = start & gru_dist_umask; /* Upper (incl pnode) bits */
-		u64 sl = start & gru_dist_lmask; /* Base offset bits */
-		u64 eu = end & gru_dist_umask;
-		u64 el = end & gru_dist_lmask;
-
-		/* Must reside completely within a single GRU range: */
-		return (sl == gru_dist_base && el == gru_dist_base &&
-			su >= gru_first_node_paddr &&
-			su <= gru_last_node_paddr &&
-			eu == su);
-	} else {
-		return start >= gru_start_paddr && end <= gru_end_paddr;
-	}
+	return start >= gru_start_paddr && end <= gru_end_paddr;
 }
 
 static bool uv_is_untracked_pat_range(u64 start, u64 end)
@@ -797,42 +782,6 @@ static __init void map_high(char *id, unsigned long base, int pshift, int bshift
 		init_extra_mapping_wb(paddr, bytes);
 }
 
-static __init void map_gru_distributed(unsigned long c)
-{
-	union uvh_rh_gam_gru_overlay_config_mmr_u gru;
-	u64 paddr;
-	unsigned long bytes;
-	int nid;
-
-	gru.v = c;
-
-	/* Only base bits 42:28 relevant in dist mode */
-	gru_dist_base = gru.v & 0x000007fff0000000UL;
-	if (!gru_dist_base) {
-		pr_info("UV: Map GRU_DIST base address NULL\n");
-		return;
-	}
-
-	bytes = 1UL << UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT;
-	gru_dist_lmask = ((1UL << uv_hub_info->m_val) - 1) & ~(bytes - 1);
-	gru_dist_umask = ~((1UL << uv_hub_info->m_val) - 1);
-	gru_dist_base &= gru_dist_lmask; /* Clear bits above M */
-
-	for_each_online_node(nid) {
-		paddr = ((u64)uv_node_to_pnode(nid) << uv_hub_info->m_val) |
-				gru_dist_base;
-		init_extra_mapping_wb(paddr, bytes);
-		gru_first_node_paddr = min(paddr, gru_first_node_paddr);
-		gru_last_node_paddr = max(paddr, gru_last_node_paddr);
-	}
-
-	/* Save upper (63:M) bits of address only for is_GRU_range */
-	gru_first_node_paddr &= gru_dist_umask;
-	gru_last_node_paddr &= gru_dist_umask;
-
-	pr_debug("UV: Map GRU_DIST base 0x%016llx  0x%016llx - 0x%016llx\n", gru_dist_base, gru_first_node_paddr, gru_last_node_paddr);
-}
-
 static __init void map_gru_high(int max_pnode)
 {
 	union uvh_rh_gam_gru_overlay_config_mmr_u gru;
@@ -846,12 +795,6 @@ static __init void map_gru_high(int max_pnode)
 		return;
 	}
 
-	/* Only UV3 has distributed GRU mode */
-	if (is_uv3_hub() && gru.s3.mode) {
-		map_gru_distributed(gru.v);
-		return;
-	}
-
 	base = (gru.v & mask) >> shift;
 	map_high("GRU", base, shift, shift, max_pnode, map_wb);
 	gru_start_paddr = ((u64)base << shift);
