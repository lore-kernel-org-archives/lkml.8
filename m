Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F324C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C04820678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgANKRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbgANKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFj-0007ex-Py; Tue, 14 Jan 2020 11:16:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 120D81C001A;
        Tue, 14 Jan 2020 11:16:51 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:50 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] KVM: VMX: Allow KVM_INTEL when building for Centaur
 and/or Zhaoxin CPUs
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-20-sean.j.christopherson@intel.com>
References: <20191221044513.21680-20-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701088.1022.10241551646411306885.tip-bot2@tip-bot2>
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

Commit-ID:     8f63aaf5c493c6502a058585cdfa3c71cdf8c44a
Gitweb:        https://git.kernel.org/tip/8f63aaf5c493c6502a058585cdfa3c71cdf8c44a
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:13 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 19:35:33 +01:00

KVM: VMX: Allow KVM_INTEL when building for Centaur and/or Zhaoxin CPUs

Change the dependency for KVM_INTEL, i.e. KVM w/ VMX, from Intel CPUs to
any CPU that supports the IA32_FEAT_CTL MSR and thus VMX functionality.
This effectively allows building KVM_INTEL for Centaur and Zhaoxin CPUs.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-20-sean.j.christopherson@intel.com
---
 arch/x86/kvm/Kconfig | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 840e125..991019d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -60,13 +60,11 @@ config KVM
 	  If unsure, say N.
 
 config KVM_INTEL
-	tristate "KVM for Intel processors support"
-	depends on KVM
-	# for perf_guest_get_msrs():
-	depends on CPU_SUP_INTEL
+	tristate "KVM for Intel (and compatible) processors support"
+	depends on KVM && IA32_FEAT_CTL
 	---help---
-	  Provides support for KVM on Intel processors equipped with the VT
-	  extensions.
+	  Provides support for KVM on processors equipped with Intel's VT
+	  extensions, a.k.a. Virtual Machine Extensions (VMX).
 
 	  To compile this as a module, choose M here: the module
 	  will be called kvm-intel.
