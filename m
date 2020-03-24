Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A90C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB322080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgCXWc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgCXWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5n-0006sa-SK; Tue, 24 Mar 2020 23:32:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 788C81C0451;
        Tue, 24 Mar 2020 23:32:15 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:15 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] powercap/intel_rapl: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131510.501728797@linutronix.de>
References: <20200320131510.501728797@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913506.28353.9986072676088338857.tip-bot2@tip-bot2>
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

Commit-ID:     f07225128865b30093c9ccf946564673c77d0233
Gitweb:        https://git.kernel.org/tip/f07225128865b30093c9ccf946564673c77d0233
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:14:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:35:32 +01:00

powercap/intel_rapl: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131510.501728797@linutronix.de
---
 drivers/powercap/intel_rapl_common.c | 87 +++++++++++++--------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 73257cf..eb32865 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -951,52 +951,51 @@ static const struct rapl_defaults rapl_defaults_cht = {
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	INTEL_CPU_FAM6(SANDYBRIDGE, rapl_defaults_core),
-	INTEL_CPU_FAM6(SANDYBRIDGE_X, rapl_defaults_core),
-
-	INTEL_CPU_FAM6(IVYBRIDGE, rapl_defaults_core),
-	INTEL_CPU_FAM6(IVYBRIDGE_X, rapl_defaults_core),
-
-	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_G, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
-
-	INTEL_CPU_FAM6(BROADWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_G, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_D, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
-
-	INTEL_CPU_FAM6(SKYLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(SKYLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(SKYLAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(KABYLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(KABYLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(CANNONLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(COMETLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(COMETLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(TIGERLAKE_L, rapl_defaults_core),
-
-	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
-	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID, rapl_defaults_tng),
-	INTEL_CPU_FAM6(ATOM_AIRMONT_MID, rapl_defaults_ann),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_D, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_TREMONT_D, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_TREMONT_L, rapl_defaults_core),
-
-	INTEL_CPU_FAM6(XEON_PHI_KNL, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(XEON_PHI_KNM, rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
+
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
+
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 	{}
 };
-
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
 
 /* Read once for all raw primitive data for domains */
