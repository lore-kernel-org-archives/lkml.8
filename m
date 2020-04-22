Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E26C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608322071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDVTyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:54:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055BC03C1A9;
        Wed, 22 Apr 2020 12:54:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRLRm-0007aD-O3; Wed, 22 Apr 2020 21:54:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 355771C02FC;
        Wed, 22 Apr 2020 21:54:14 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:54:13 -0000
From:   "tip-bot2 for Harry Pan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/cstate: Add Jasper Lake CPU support
Cc:     Harry Pan <harry.pan@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402190658.1.Ic02e891daac41303aed1f2fc6c64f6110edd27bd@changeid>
References: <20200402190658.1.Ic02e891daac41303aed1f2fc6c64f6110edd27bd@changeid>
MIME-Version: 1.0
Message-ID: <158758525378.28353.13945235876360246667.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5b16ef2e43ffa1be596652d992235b1cbb244935
Gitweb:        https://git.kernel.org/tip/5b16ef2e43ffa1be596652d992235b1cbb244935
Author:        Harry Pan <harry.pan@intel.com>
AuthorDate:    Thu, 02 Apr 2020 19:07:09 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Apr 2020 21:43:12 +02:00

perf/x86/cstate: Add Jasper Lake CPU support

The Jasper Lake processor is Tremont microarchitecture, reuse the
glm_cstates table of Goldmont and Goldmont Plus to enable the C-states
residency profiling.

Signed-off-by: Harry Pan <harry.pan@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200402190658.1.Ic02e891daac41303aed1f2fc6c64f6110edd27bd@changeid
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e4aa20c..442e1ed 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -643,6 +643,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
