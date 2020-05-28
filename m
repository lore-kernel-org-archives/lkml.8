Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE56C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCEB205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405096AbgE1QfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405004AbgE1QfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:35:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91950C08C5C6;
        Thu, 28 May 2020 09:35:15 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeLUs-0004lA-55; Thu, 28 May 2020 18:35:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B7AD31C0051;
        Thu, 28 May 2020 18:35:09 +0200 (CEST)
Date:   Thu, 28 May 2020 16:35:09 -0000
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Update config and kernel doc for MPK
 feature on AMD
Cc:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159068199556.26992.17733929401377275140.stgit@naples-babu.amd.com>
References: <159068199556.26992.17733929401377275140.stgit@naples-babu.amd.com>
MIME-Version: 1.0
Message-ID: <159068370958.17951.6798718433379577502.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     38f3e775e9c242f5430a9c08c11be7577f63a41c
Gitweb:        https://git.kernel.org/tip/38f3e775e9c242f5430a9c08c11be7577f63a41c
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Thu, 28 May 2020 11:08:23 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 May 2020 18:27:40 +02:00

x86/Kconfig: Update config and kernel doc for MPK feature on AMD

AMD's next generation of EPYC processors support the MPK (Memory
Protection Keys) feature. Update the dependency and documentation.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/159068199556.26992.17733929401377275140.stgit@naples-babu.amd.com
---
 Documentation/core-api/protection-keys.rst | 5 +++--
 arch/x86/Kconfig                           | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 49d9833..ec575e7 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -5,8 +5,9 @@ Memory Protection Keys
 ======================
 
 Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
-which is found on Intel's Skylake "Scalable Processor" Server CPUs.
-It will be avalable in future non-server parts.
+which is found on Intel's Skylake (and later) "Scalable Processor"
+Server CPUs. It will be available in future non-server Intel parts
+and future AMD processors.
 
 For anyone wishing to test or use this feature, it is available in
 Amazon's EC2 C5 instances and is known to work there using an Ubuntu
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104e..968d23f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1887,10 +1887,10 @@ config X86_UMIP
 	  results are dummy.
 
 config X86_INTEL_MEMORY_PROTECTION_KEYS
-	prompt "Intel Memory Protection Keys"
+	prompt "Memory Protection Keys"
 	def_bool y
 	# Note: only available in 64-bit mode
-	depends on CPU_SUP_INTEL && X86_64
+	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	---help---
