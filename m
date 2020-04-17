Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666EC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14B0208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgDQKUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728631AbgDQKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:20:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0380BC061A0C;
        Fri, 17 Apr 2020 03:20:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPO6Z-00062G-Bp; Fri, 17 Apr 2020 12:20:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C76361C0072;
        Fri, 17 Apr 2020 12:20:14 +0200 (CEST)
Date:   Fri, 17 Apr 2020 10:20:14 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/split_lock: Update to use X86_MATCH_INTEL_FAM6_MODEL()
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416205754.21177-2-tony.luck@intel.com>
References: <20200416205754.21177-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158711881435.28353.9813486883264323804.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3ab0762d1edfda6ccbc08f636acab42c103c299f
Gitweb:        https://git.kernel.org/tip/3ab0762d1edfda6ccbc08f636acab42c103c299f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 16 Apr 2020 13:57:52 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Apr 2020 12:14:12 +02:00

x86/split_lock: Update to use X86_MATCH_INTEL_FAM6_MODEL()

The SPLIT_LOCK_CPU() macro escaped the tree-wide sweep for old-style
initialization. Update to use X86_MATCH_INTEL_FAM6_MODEL().

Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200416205754.21177-2-tony.luck@intel.com

---
 arch/x86/kernel/cpu/intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bf08d45..ec0d8c7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1119,8 +1119,6 @@ void switch_to_sld(unsigned long tifn)
 	sld_update_msr(!(tifn & _TIF_SLD));
 }
 
-#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
-
 /*
  * The following processors have the split lock detection feature. But
  * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
@@ -1128,8 +1126,8 @@ void switch_to_sld(unsigned long tifn)
  * processors.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
-	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
-	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
 	{}
 };
 
