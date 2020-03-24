Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BC72078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgCXWcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46381 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgCXWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5p-0006tn-5p; Tue, 24 Mar 2020 23:32:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D058E1C0470;
        Tue, 24 Mar 2020 23:32:16 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:16 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] intel_idle: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131510.193755545@linutronix.de>
References: <20200320131510.193755545@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913648.28353.6911615335097560053.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4a9f45a0533f47bcff27761821ee568875c5aee4
Gitweb:        https://git.kernel.org/tip/4a9f45a0533f47bcff27761821ee568875c5aee4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:14:00 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:34:32 +01:00

intel_idle: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131510.193755545@linutronix.de
---
 drivers/idle/intel_idle.c | 79 ++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d556066..88f6f92 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1068,51 +1068,48 @@ static const struct idle_cpu idle_cpu_dnv = {
 };
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
-	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(NEHALEM,			idle_cpu_nehalem),
-	INTEL_CPU_FAM6(NEHALEM_G,		idle_cpu_nehalem),
-	INTEL_CPU_FAM6(WESTMERE,		idle_cpu_nehalem),
-	INTEL_CPU_FAM6(WESTMERE_EP,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(NEHALEM_EX,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(ATOM_BONNELL,		idle_cpu_atom),
-	INTEL_CPU_FAM6(ATOM_BONNELL_MID,	idle_cpu_lincroft),
-	INTEL_CPU_FAM6(WESTMERE_EX,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(SANDYBRIDGE,		idle_cpu_snb),
-	INTEL_CPU_FAM6(SANDYBRIDGE_X,		idle_cpu_snx),
-	INTEL_CPU_FAM6(ATOM_SALTWELL,		idle_cpu_atom),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT,		idle_cpu_byt),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	idle_cpu_tangier),
-	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
-	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
-	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
-	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsx),
-	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_G,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_D,	idle_cpu_avn),
-	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_G,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdx),
-	INTEL_CPU_FAM6(BROADWELL_D,		idle_cpu_bdx),
-	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
-	INTEL_CPU_FAM6(SKYLAKE,			idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE_L,		idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE,		idle_cpu_skl),
-	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
-	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
-	INTEL_CPU_FAM6(XEON_PHI_KNM,		idle_cpu_knl),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT,		idle_cpu_bxt),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_D,		idle_cpu_dnv),
-	INTEL_CPU_FAM6(ATOM_TREMONT_D,		idle_cpu_dnv),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&idle_cpu_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,		&idle_cpu_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&idle_cpu_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL,	&idle_cpu_atom),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL_MID,	&idle_cpu_lincroft),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&idle_cpu_snb),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&idle_cpu_snx),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL,	&idle_cpu_atom),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&idle_cpu_byt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&idle_cpu_tangier),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&idle_cpu_cht),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&idle_cpu_ivb),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&idle_cpu_ivt),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&idle_cpu_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&idle_cpu_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&idle_cpu_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&idle_cpu_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&idle_cpu_avn),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&idle_cpu_bdw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&idle_cpu_bdw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&idle_cpu_bdx),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&idle_cpu_bdx),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_dnv),
 	{}
 };
 
-#define INTEL_CPU_FAM6_MWAIT \
-	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_MWAIT, 0 }
-
 static const struct x86_cpu_id intel_mwait_ids[] __initconst = {
-	INTEL_CPU_FAM6_MWAIT,
+	X86_MATCH_VENDOR_FAM_FEATURE(INTEL, 6, X86_FEATURE_MWAIT, NULL),
 	{}
 };
 
