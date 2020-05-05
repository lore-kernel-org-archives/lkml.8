Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A8AC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C17206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgEEWgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:36:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:41848 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgEEWgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:44 -0400
IronPort-SDR: c0HpQGf4B60MGmI9z3kIexyVDNtAUKuKzbaySfOVj7GmRbAJFjxWWL7IRw8jW9N6fL+decH1it
 d34L/dlQxA2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:44 -0700
IronPort-SDR: Fi7+BuLSZn4pswOV9XXmFz31Skwvg9hiV7SQckA9RHhPuWnpeyr1Xb2PY9QEoc1Gv3napjGPNM
 bp7SjizYj01g==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410824"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:43 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH V2 1/7] x86/resctrl: Rename asm/resctrl_sched.h to asm/resctrl.h
Date:   Tue,  5 May 2020 15:36:12 -0700
Message-Id: <6914e0ef880b539a82a6d889f9423496d471ad1d.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/resctrl_sched.h is dedicated to the code used for configuration
of the CPU resource control state when a task is scheduled.

Rename resctrl_sched.h to resctrl.h in preparation of additions that
will no longer make this file dedicated to work done during scheduling.

No functional change.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 MAINTAINERS                                         | 2 +-
 arch/x86/include/asm/{resctrl_sched.h => resctrl.h} | 6 +++---
 arch/x86/kernel/cpu/resctrl/core.c                  | 2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c           | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c              | 2 +-
 arch/x86/kernel/process_32.c                        | 2 +-
 arch/x86/kernel/process_64.c                        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename arch/x86/include/asm/{resctrl_sched.h => resctrl.h} (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..ecfb07ab49b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14227,7 +14227,7 @@ M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/x86/resctrl*
-F:	arch/x86/include/asm/resctrl_sched.h
+F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
 F:	tools/testing/selftests/resctrl/
 
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl.h
similarity index 96%
rename from arch/x86/include/asm/resctrl_sched.h
rename to arch/x86/include/asm/resctrl.h
index f6b7fe2833cc..99b5728e441d 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_RESCTRL_SCHED_H
-#define _ASM_X86_RESCTRL_SCHED_H
+#ifndef _ASM_X86_RESCTRL_H
+#define _ASM_X86_RESCTRL_H
 
 #ifdef CONFIG_X86_CPU_RESCTRL
 
@@ -90,4 +90,4 @@ static inline void resctrl_sched_in(void) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
 
-#endif /* _ASM_X86_RESCTRL_SCHED_H */
+#endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d8cc5223b7ce..6f38c88226af 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
 #include <linux/cpuhotplug.h>
 
 #include <asm/intel-family.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include "internal.h"
 
 /* Mutex to protect rdtgroup access. */
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d7623e1b927d..4bd28b388a1a 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -24,7 +24,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5a359d9fcc05..6276ae015945 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -29,7 +29,7 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 954b013cc585..538d4e8d6589 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -52,7 +52,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/proto.h>
 
 #include "process.h"
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5ef9d8f25b0e..0c169a5687e1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
-- 
2.21.0

