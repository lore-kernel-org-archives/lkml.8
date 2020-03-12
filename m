Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D8C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3E7206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgCLXM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:12:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:61982 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgCLXM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:12:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 16:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="416106878"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 16:12:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 70A5E301BF9; Thu, 12 Mar 2020 16:12:28 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/speculation: Allow overriding seccomp speculation disable
Date:   Thu, 12 Mar 2020 16:12:22 -0700
Message-Id: <20200312231222.81861-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

seccomp currently force enables the SSBD and IB mitigations,
which disable certain features in the CPU to avoid speculation
attacks at a performance penalty.

This is a heuristic to detect applications that may run untrusted code
(such as web browsers) and provide mitigation for them.

At least for SSBD the mitigation is really only for side channel
leaks inside processes.

There are two cases when the heuristic has problems:

- The seccomp user has a superior mitigation and doesn't need the
CPU level disables. For example for a Web Browser this is using
site isolation, which separates different sites in different
processes, so side channel leaks inside a process are not
of a concern.

- Another case are seccomp users who don't run untrusted code,
such as sshd, and don't really benefit from SSBD

As currently implemented seccomp force enables the mitigation
so it's not possible for processes to opt-in that they don't
need mitigations (such as when they already use site isolation).

In some cases we're seeing significant performance penalties
of enabling the SSBD mitigation on web workloads.

This patch changes the seccomp code to not force enable,
but merely enable, the SSBD and IB mitigations.

This allows processes to use the PR_SET_SPECULATION prctl
after running seccomp and reenable SSBD and/or IB
if they don't need any extra mitigation.

The effective default has not changed, it just allows
processes to opt-out of the default.

It's not clear to me what the use case for the force
disable is anyways. Certainly if someone controls the process,
and can run prctl(), they can leak data in all kinds of
ways anyways, or just read the whole memory map.

Longer term we probably need to discuss if the seccomp heuristic
is still warranted and should be perhaps changed. It seemed
like a good idea when these vulnerabilities were new, and
no web browsers supported site isolation. But with site isolation
widely deployed -- Chrome has it on by default, and as I understand
it, Firefox is going to enable it by default soon. And other seccomp
users (like sshd or systemd) probably don't really need it.
Given that it's not clear the default heuristic is still a good
idea.

But anyways this patch doesn't change any defaults, just
let's applications override it.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c39..f15ae9bfd7ad 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1215,9 +1215,9 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
-		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+		ssb_prctl_set(task, PR_SPEC_DISABLE);
 	if (spectre_v2_user == SPECTRE_V2_USER_SECCOMP)
-		ib_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+		ib_prctl_set(task, PR_SPEC_DISABLE);
 }
 #endif
 
-- 
2.24.1

