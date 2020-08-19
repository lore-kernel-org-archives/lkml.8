Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E257CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0A3206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0EtSvtsE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFTJhTvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHSMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgHSMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD32C061757;
        Wed, 19 Aug 2020 05:33:17 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:33:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3Jehl3a35aN5/4/NwUd3jBqhG6snxRKGpdWrkVAGSI=;
        b=0EtSvtsEwCBOsrzwAXUHO8XbpNKitMzc7CnPZlUlhKKrc2Ht3nBXvnNC53GfE4PrD6/sM3
        76ZrWIoj2ZU2OHMc+ATQ3Y0v9GlQndDb2qHHXg+0UL7t0UbGuug/Zh9ajWqt6aU9SmB+ip
        7+4hfhxjLXB5XnbNKaOXatc/wzAVH8OszDe6dLat0gAK6C8wqmW2U/J+LS4RNh/K52mW6u
        PIUIMMIdcQ2vKmM4NFpp3WClnCvpw6KbNrjvPm8YqgDv/mNUvQrCbJZER3iH+txYk1cCNk
        Bq5h+aRQkeP56AFuq0lnICjJnSTpm2hhHihSXTBhPEYRtjO/BHtHND/TIVMWBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3Jehl3a35aN5/4/NwUd3jBqhG6snxRKGpdWrkVAGSI=;
        b=OFTJhTvgAqv1nFAuvab/WHjOl3YtSUQfpCIm7ymO1TmCdejOjU/9o6ZNOy9IPLiQl6StR3
        4fXB7ImTRjeu0ZAg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] cacheinfo: Move resctrl's get_cache_id() to the
 cacheinfo header file
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Babu Moger <babu.moger@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-11-james.morse@arm.com>
References: <20200708163929.2783-11-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784038771.3192.628898918222476271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     709c4362725abb5fa1e36fd94893a9b0d049df82
Gitweb:        https://git.kernel.org/tip/709c4362725abb5fa1e36fd94893a9b0d049df82
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:29 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Aug 2020 11:04:23 +02:00

cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file

resctrl/core.c defines get_cache_id() for use in its cpu-hotplug
callbacks. This gets the id attribute of the cache at the corresponding
level of a CPU.

Later rework means this private function needs to be shared. Move
it to the header file.

The name conflicts with a different definition in intel_cacheinfo.c,
name it get_cpu_cacheinfo_id() to show its relation with
get_cpu_cacheinfo().

Now this is visible on other architectures, check the id attribute
has actually been set.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-11-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 17 ++---------------
 include/linux/cacheinfo.h          | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cbbd751..1c00f2f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -350,19 +350,6 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
 }
 
-static int get_cache_id(int cpu, int level)
-{
-	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
-	int i;
-
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == level)
-			return ci->info_list[i].id;
-	}
-
-	return -1;
-}
-
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
@@ -560,7 +547,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cache_id(cpu, r->cache_level);
+	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct list_head *add_pos = NULL;
 	struct rdt_domain *d;
 
@@ -606,7 +593,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cache_id(cpu, r->cache_level);
+	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, NULL);
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 46b92cd..4f72b47 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,6 +3,7 @@
 #define _LINUX_CACHEINFO_H
 
 #include <linux/bitops.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 
@@ -119,4 +120,24 @@ int acpi_find_last_cache_level(unsigned int cpu);
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
+/*
+ * Get the id of the cache associated with @cpu at level @level.
+ * cpuhp lock must be held.
+ */
+static inline int get_cpu_cacheinfo_id(int cpu, int level)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	int i;
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == level) {
+			if (ci->info_list[i].attributes & CACHE_ID)
+				return ci->info_list[i].id;
+			return -1;
+		}
+	}
+
+	return -1;
+}
+
 #endif /* _LINUX_CACHEINFO_H */
