Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E36C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2473A24672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgBKMtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45998 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgBKMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux8-0007Zh-RU; Tue, 11 Feb 2020 13:47:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 86E2D1C2018;
        Tue, 11 Feb 2020 13:47:46 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:46 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/cstate: Add Tremont support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1580236279-35492-2-git-send-email-kan.liang@linux.intel.com>
References: <1580236279-35492-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158142526622.411.6550480951011995887.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ecf71fbccb9ac5cb964eb7de59bb9da3755b7885
Gitweb:        https://git.kernel.org/tip/ecf71fbccb9ac5cb964eb7de59bb9da3755b7885
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 28 Jan 2020 10:31:18 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:17:49 +01:00

perf/x86/cstate: Add Tremont support

Tremont is Intel's successor to Goldmont Plus. From the perspective of
Intel cstate residency counters, there is nothing changed compared with
Goldmont Plus and Goldmont.

Share glm_cstates with Goldmont Plus and Goldmont.
Update the comments for Tremont.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1580236279-35492-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e1daf41..4814c96 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,17 +40,18 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL
+ *			 Available model: SLM,AMT,GLM,CNL,TNT
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
- *						CNL,KBL,CML
+ *						CNL,KBL,CML,TNT
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -60,17 +61,18 @@
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL
+ *						KBL,CML,ICL,TGL,TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL,TGL
+ *						GLM,CNL,KBL,CML,ICL,TGL,TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
- *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
+ *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -87,7 +89,8 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Package (physical package)
  *
  */
@@ -640,8 +643,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
-
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT_D, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
