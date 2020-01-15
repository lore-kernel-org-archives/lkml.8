Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4685C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755652467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgAOMj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:39:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47072 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:39:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irhxB-00057y-BI; Wed, 15 Jan 2020 13:39:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBF581C0870;
        Wed, 15 Jan 2020 13:39:20 +0100 (CET)
Date:   Wed, 15 Jan 2020 12:39:20 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Print "VMX disabled" error message iff KVM is enabled
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200114202545.20296-1-sean.j.christopherson@intel.com>
References: <20200114202545.20296-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157909196055.396.1953638570358257374.tip-bot2@tip-bot2>
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

Commit-ID:     bb02e2cb715a3f3552dbe765ea4a07799e4dff43
Gitweb:        https://git.kernel.org/tip/bb02e2cb715a3f3552dbe765ea4a07799e4dff43
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 14 Jan 2020 12:25:45 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Jan 2020 13:26:50 +01:00

x86/cpu: Print "VMX disabled" error message iff KVM is enabled

Don't print an error message about VMX being disabled by BIOS if KVM,
the sole user of VMX, is disabled. E.g. if KVM is disabled and the MSR
is unlocked, the kernel will intentionally disable VMX when locking
feature control and then complain that "BIOS" disabled VMX.

Fixes: ef4d3bf19855 ("x86/cpu: Clear VMX feature flag if VMX is not fully enabled")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200114202545.20296-1-sean.j.christopherson@intel.com
---
 arch/x86/kernel/cpu/feat_ctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 24a4fdc..0268185 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -133,8 +133,9 @@ update_caps:
 
 	if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
 	    (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
-		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
-			    tboot ? "inside" : "outside");
+		if (IS_ENABLED(CONFIG_KVM_INTEL))
+			pr_err_once("VMX (%s TXT) disabled by BIOS\n",
+				    tboot ? "inside" : "outside");
 		clear_cpu_cap(c, X86_FEATURE_VMX);
 	} else {
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
