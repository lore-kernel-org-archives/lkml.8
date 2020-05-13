Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8409C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9932205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgEMWLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:11:51 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:60360 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730130AbgEMWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:11:50 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DLx935007225;
        Wed, 13 May 2020 22:11:26 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 3100yw20df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 22:11:26 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 9CDB066;
        Wed, 13 May 2020 22:11:25 +0000 (UTC)
Received: from raspberrypi (unknown [16.214.83.120])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id F1E6D45;
        Wed, 13 May 2020 22:11:23 +0000 (UTC)
Date:   Wed, 13 May 2020 17:11:23 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] x86/api/uv: Remove code for unused distributed GRU mode
Message-ID: <20200513221123.GJ3240@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 suspectscore=1 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 cotscore=-2147483648 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distributed GRU mode appeared in only one generation of UV hardware,
and no version of the BIOS has shipped with this feature enabled, and
we have no plans to ever change that.  The gru.s3.mode check has
always been and will continue to be false.  So remove this dead code.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Dimitri Sivanich <sivanich@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 59 +-------------------------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index ad53b2abc859..76971c8ea2d6 100644
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
@@ -85,20 +83,7 @@ static unsigned long __init uv_early_read_mmr(unsigned long addr)
 
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
-- 
2.12.3

From: Steve Wahl <steve.wahl@hpe.com>
To: 
Cc: 
Bcc: 
Subject: 
Reply-To: 

