Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA29C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643462070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tD6nlKwP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bnJvwgaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGQOvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgGQOvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:14 -0400
Date:   Fri, 17 Jul 2020 14:51:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lS+t5jPVtW4ya5DQ0VX0TYnYWANSmMy0vRoq8kEGljk=;
        b=tD6nlKwPQWGQGWrIDXiPrkSWlmXqM3IyOoUjUqWg3u5+ZU1WBXXxqTKTMNtW3HQ93gkjZy
        bYE2MkQEOBxVi4x33efNvlPtXmURj0YIu0/76h9gWlUBD2OHCzp1Cvy26IZky8B+4UC4KA
        YAz3MJEggZH+RYkf8Ggv2pBvWWQLZlCJxJ+F25WsMUVimsi03E0k61tGJ/tEufuRydKGmg
        HXYFUF/TXcfwUTra59pov+qhEpZMNkjibDqCojkLcBvnMt73xi1CIe2X5K9y4x6hwFIjsc
        o2TFlOags2LAhn6yo0ArlKwSHIdd1viECR74/kdTQWUkwNuS3tFBKKK+0BjTsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lS+t5jPVtW4ya5DQ0VX0TYnYWANSmMy0vRoq8kEGljk=;
        b=bnJvwgaL4yEPgGwDYTyJAckXGgNwprVVj/RaxTuOPYQcmWFloTYIq81n1eKhYBG4FqxYaF
        bH2pahc7EdanWGAg==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove support for uv1 platform
 from uv_hub
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.203480177@hpe.com>
References: <20200713212955.203480177@hpe.com>
MIME-Version: 1.0
Message-ID: <159499747063.4006.10455442521413710528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     9b9ee172410d839ca55ad2e25e96f7398fb66f4f
Gitweb:        https://git.kernel.org/tip/9b9ee172410d839ca55ad2e25e96f7398fb66f4f
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:00 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:45 +02:00

x86/platform/uv: Remove support for uv1 platform from uv_hub

UV1 is not longer supported by HPE.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212955.203480177@hpe.com

---
 arch/x86/include/asm/uv/uv_hub.h | 34 ++-----------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 60ca0af..c0bcadf 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -224,17 +224,11 @@ static inline struct uv_hub_info_s *uv_cpu_hub_info(int cpu)
  * This is a software convention - NOT the hardware revision numbers in
  * the hub chip.
  */
-#define UV1_HUB_REVISION_BASE		1
 #define UV2_HUB_REVISION_BASE		3
 #define UV3_HUB_REVISION_BASE		5
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-static inline int is_uv1_hub(void)
-{
-	return is_uv_hubbed(uv(1));
-}
-
 static inline int is_uv2_hub(void)
 {
 	return is_uv_hubbed(uv(2));
@@ -265,7 +259,7 @@ static inline int is_uvx_hub(void)
 
 static inline int is_uv_hub(void)
 {
-	return is_uv1_hub() || is_uvx_hub();
+	return is_uvx_hub();
 }
 
 union uvh_apicid {
@@ -292,11 +286,6 @@ union uvh_apicid {
 #define UV_PNODE_TO_GNODE(p)		((p) |uv_hub_info->gnode_extra)
 #define UV_PNODE_TO_NASID(p)		(UV_PNODE_TO_GNODE(p) << 1)
 
-#define UV1_LOCAL_MMR_BASE		0xf4000000UL
-#define UV1_GLOBAL_MMR32_BASE		0xf8000000UL
-#define UV1_LOCAL_MMR_SIZE		(64UL * 1024 * 1024)
-#define UV1_GLOBAL_MMR32_SIZE		(64UL * 1024 * 1024)
-
 #define UV2_LOCAL_MMR_BASE		0xfa000000UL
 #define UV2_GLOBAL_MMR32_BASE		0xfc000000UL
 #define UV2_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
@@ -313,25 +302,21 @@ union uvh_apicid {
 #define UV4_GLOBAL_MMR32_SIZE		(16UL * 1024 * 1024)
 
 #define UV_LOCAL_MMR_BASE		(				\
-					is_uv1_hub() ? UV1_LOCAL_MMR_BASE : \
 					is_uv2_hub() ? UV2_LOCAL_MMR_BASE : \
 					is_uv3_hub() ? UV3_LOCAL_MMR_BASE : \
 					/*is_uv4_hub*/ UV4_LOCAL_MMR_BASE)
 
 #define UV_GLOBAL_MMR32_BASE		(				\
-					is_uv1_hub() ? UV1_GLOBAL_MMR32_BASE : \
 					is_uv2_hub() ? UV2_GLOBAL_MMR32_BASE : \
 					is_uv3_hub() ? UV3_GLOBAL_MMR32_BASE : \
 					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_BASE)
 
 #define UV_LOCAL_MMR_SIZE		(				\
-					is_uv1_hub() ? UV1_LOCAL_MMR_SIZE : \
 					is_uv2_hub() ? UV2_LOCAL_MMR_SIZE : \
 					is_uv3_hub() ? UV3_LOCAL_MMR_SIZE : \
 					/*is_uv4_hub*/ UV4_LOCAL_MMR_SIZE)
 
 #define UV_GLOBAL_MMR32_SIZE		(				\
-					is_uv1_hub() ? UV1_GLOBAL_MMR32_SIZE : \
 					is_uv2_hub() ? UV2_GLOBAL_MMR32_SIZE : \
 					is_uv3_hub() ? UV3_GLOBAL_MMR32_SIZE : \
 					/*is_uv4_hub*/ UV4_GLOBAL_MMR32_SIZE)
@@ -352,8 +337,6 @@ union uvh_apicid {
 #define UVH_APICID		0x002D0E00L
 #define UV_APIC_PNODE_SHIFT	6
 
-#define UV_APICID_HIBIT_MASK	0xffff0000
-
 /* Local Bus from cpu's perspective */
 #define LOCAL_BUS_BASE		0x1c00000
 #define LOCAL_BUS_SIZE		(4 * 1024 * 1024)
@@ -560,15 +543,6 @@ static inline int uv_apicid_to_pnode(int apicid)
 	return s2pn ? s2pn[pnode - uv_hub_info->min_socket] : pnode;
 }
 
-/* Convert an apicid to the socket number on the blade */
-static inline int uv_apicid_to_socket(int apicid)
-{
-	if (is_uv1_hub())
-		return (apicid >> (uv_hub_info->apic_pnode_shift - 1)) & 1;
-	else
-		return 0;
-}
-
 /*
  * Access global MMRs using the low memory MMR32 space. This region supports
  * faster MMR access but not all MMRs are accessible in this space.
@@ -660,7 +634,7 @@ static inline int uv_cpu_blade_processor_id(int cpu)
 	return uv_cpu_info_per(cpu)->blade_cpu_id;
 }
 
-/* Blade number to Node number (UV1..UV4 is 1:1) */
+/* Blade number to Node number (UV2..UV4 is 1:1) */
 static inline int uv_blade_to_node(int blade)
 {
 	return blade;
@@ -674,7 +648,7 @@ static inline int uv_numa_blade_id(void)
 
 /*
  * Convert linux node number to the UV blade number.
- * .. Currently for UV1 thru UV4 the node and the blade are identical.
+ * .. Currently for UV2 thru UV4 the node and the blade are identical.
  * .. If this changes then you MUST check references to this function!
  */
 static inline int uv_node_to_blade_id(int nid)
@@ -821,8 +795,6 @@ static inline void uv_set_cpu_scir_bits(int cpu, unsigned char value)
 	}
 }
 
-extern unsigned int uv_apicid_hibits;
-
 /*
  * Get the minimum revision number of the hub chips within the partition.
  * (See UVx_HUB_REVISION_BASE above for specific values.)
