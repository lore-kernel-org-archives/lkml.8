Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A169C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4192078E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:41:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCYMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:41:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH5Lc-0001Xv-9h; Wed, 25 Mar 2020 13:41:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE2911C0450;
        Wed, 25 Mar 2020 13:41:15 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:41:15 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] cpufreq/intel_pstate: Fix wrong macro conversion
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324060124.GC11705@shao2-debian>
References: <20200324060124.GC11705@shao2-debian>
MIME-Version: 1.0
Message-ID: <158514007544.28353.4934308733566744386.tip-bot2@tip-bot2>
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

Commit-ID:     d97828072d0bcecb6655f0966efc38a2647d3dfb
Gitweb:        https://git.kernel.org/tip/d97828072d0bcecb6655f0966efc38a2647d3dfb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Mar 2020 13:21:55 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 25 Mar 2020 13:21:55 +01:00

cpufreq/intel_pstate: Fix wrong macro conversion

The feature flag hwp_support_ids are supposed to match on is
X86_FEATURE_HWP, not X86_FEATURE_APERFMPERF. Fix it.

 [ bp: Write commit message. ]

Fixes: b11d77fa300d ("cpufreq: Convert to new X86 CPU match macros")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200324060124.GC11705@shao2-debian
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 780c387..46bce09 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2727,7 +2727,7 @@ static inline void intel_pstate_request_control_from_smm(void) {}
 
 #define X86_MATCH_HWP(model, hwp_mode)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_APERFMPERF, hwp_mode)
+					   X86_FEATURE_HWP, hwp_mode)
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
 	X86_MATCH_HWP(BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
