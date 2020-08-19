Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E88C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CF2204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afch/HeZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6I/EpNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgHSOFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgHSODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:03:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450EDC06134A;
        Wed, 19 Aug 2020 07:02:54 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+equZZer+4pX+ZwoGMAtp4n/hgCG0a1e6eTnS0gIDc=;
        b=afch/HeZk+7c9vVe5hVlSrFp3BZw0ZpCd2hLR1bD9wYooTn0aSzMsNY02UzffC3NJwdq1G
        Rmn/t2zjoi7Zlf6iOcHpXIZUv8cfKSbWjsTHkc3LgcakBiyzhWnGn01wYtvbkyYpHJr5TO
        DQpf1DWPQap1GKrnsBE5Y86IOz0mdn/XJyfGCDs8OTxKr/boqPnzBIMOiX+JKomXo05UNf
        JE4QdBSq2YJks7gTtyAp7nDpNBLpHaJvVLd+gcrWxnUWy4jH+oaIM1IFNYxrPAsdfhcOfS
        U4JB8P8m4oWk6as2gVdcg0RCNDOXwaS2XpctBA/+QChvP1HGGWGNySwQshgNJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+equZZer+4pX+ZwoGMAtp4n/hgCG0a1e6eTnS0gIDc=;
        b=P6I/EpNNl8EnPLGmXF3gFQm/nqZDNap3Y/J53wif2KmYo+bkRx8pOzlrh4vEQumEynLXLY
        4GTAoTR8Wf9cE8Bg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] ARM, sched/topology: Remove SD_SHARE_POWERDOMAIN
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-2-valentin.schneider@arm.com>
References: <20200817113003.20802-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784577154.3192.17872359236913870114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cfe7ddcbd72dc67ce5749cc6f451a2b0c6aec5b5
Gitweb:        https://git.kernel.org/tip/cfe7ddcbd72dc67ce5749cc6f451a2b0c6aec5b5
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:47 +02:00

ARM, sched/topology: Remove SD_SHARE_POWERDOMAIN

This flag was introduced in 2014 by commit:

  d77b3ed5c9f8 ("sched: Add a new SD_SHARE_POWERDOMAIN for sched_domain")

but AFAIA it was never leveraged by the scheduler. The closest thing I can
think of is EAS caring about frequency domains, and it does that by
leveraging performance domains.

Remove the flag. No change in functionality is expected.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-2-valentin.schneider@arm.com
---
 arch/arm/kernel/topology.c     |  2 +-
 include/linux/sched/topology.h | 13 ++++++-------
 kernel/sched/topology.c        | 10 +++-------
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index b5adaf7..353f3ee 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -243,7 +243,7 @@ topology_populated:
 
 static inline int cpu_corepower_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
+	return SD_SHARE_PKG_RESOURCES;
 }
 
 static struct sched_domain_topology_level arm_topology[] = {
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8205112..6ec7d7c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -18,13 +18,12 @@
 #define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
 #define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
 #define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
-#define SD_SHARE_POWERDOMAIN	0x0080	/* Domain members share power domain */
-#define SD_SHARE_PKG_RESOURCES	0x0100	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0200	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0400  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x0800	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x1000	/* sched_domains of this level overlap */
-#define SD_NUMA			0x2000	/* cross-node balancing */
+#define SD_SHARE_PKG_RESOURCES	0x0080	/* Domain members share CPU pkg resources */
+#define SD_SERIALIZE		0x0100	/* Only a single load balancing instance */
+#define SD_ASYM_PACKING		0x0200  /* Place busy groups earlier in the domain */
+#define SD_PREFER_SIBLING	0x0400	/* Prefer to place tasks in a sibling domain */
+#define SD_OVERLAP		0x0800	/* sched_domains of this level overlap */
+#define SD_NUMA			0x1000	/* cross-node balancing */
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 007b0a6..fe03969 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -148,8 +148,7 @@ static int sd_degenerate(struct sched_domain *sd)
 			 SD_BALANCE_EXEC |
 			 SD_SHARE_CPUCAPACITY |
 			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES |
-			 SD_SHARE_POWERDOMAIN)) {
+			 SD_SHARE_PKG_RESOURCES)) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
@@ -180,8 +179,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 			    SD_ASYM_CPUCAPACITY |
 			    SD_SHARE_CPUCAPACITY |
 			    SD_SHARE_PKG_RESOURCES |
-			    SD_PREFER_SIBLING |
-			    SD_SHARE_POWERDOMAIN);
+			    SD_PREFER_SIBLING);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
@@ -1292,7 +1290,6 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
- *   SD_SHARE_POWERDOMAIN   - describes shared power domain
  *
  * Odd one out, which beside describing the topology has a quirk also
  * prescribes the desired behaviour that goes along with it:
@@ -1303,8 +1300,7 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 	(SD_SHARE_CPUCAPACITY	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
-	 SD_ASYM_PACKING	|	\
-	 SD_SHARE_POWERDOMAIN)
+	 SD_ASYM_PACKING)
 
 static struct sched_domain *
 sd_init(struct sched_domain_topology_level *tl,
