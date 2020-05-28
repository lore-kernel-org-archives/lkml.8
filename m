Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA63C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CA0207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbgE1Nm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbgE1Nmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:42:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E12BC05BD1E;
        Thu, 28 May 2020 06:42:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeIny-0000XQ-QB; Thu, 28 May 2020 15:42:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5DD051C0051;
        Thu, 28 May 2020 15:42:42 +0200 (CEST)
Date:   Thu, 28 May 2020 13:42:42 -0000
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] xen: Move xen_setup_callback_vector() definition to
 include/xen/hvm.h
Cc:     kbuild test robot <lkp@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520161600.361895-1-vkuznets@redhat.com>
References: <20200520161600.361895-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <159067336218.17951.8587192036769603306.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     28447ea4154239025044381144f849ff749ee9ef
Gitweb:        https://git.kernel.org/tip/28447ea4154239025044381144f849ff749ee9ef
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Wed, 20 May 2020 18:16:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 May 2020 15:39:18 +02:00

xen: Move xen_setup_callback_vector() definition to include/xen/hvm.h

Kbuild test robot reports the following problem on ARM:

  for 'xen_setup_callback_vector' [-Wmissing-prototypes]
1664 | void xen_setup_callback_vector(void) {}
|      ^~~~~~~~~~~~~~~~~~~~~~~~~

The problem is that xen_setup_callback_vector is a x86 only thing, its
definition is present in arch/x86/xen/xen-ops.h but not on ARM. In
events_base.c there is a stub for !CONFIG_XEN_PVHVM but it is not declared
as 'static'.

On x86 the situation is hardly better: drivers/xen/events/events_base.c
doesn't include 'xen-ops.h' from arch/x86/xen/, it includes its namesake
from include/xen/ which also results in a 'no previous prototype' warning.

Currently, xen_setup_callback_vector() has two call sites: one in
drivers/xen/events_base.c and another in arch/x86/xen/suspend_hvm.c. The
former is placed under #ifdef CONFIG_X86 and the later is only compiled
in when CONFIG_XEN_PVHVM.

Resolve the issue by moving xen_setup_callback_vector() declaration to
arch neutral 'include/xen/hvm.h' as the implementation lives in arch
neutral drivers/xen/events/events_base.c.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20200520161600.361895-1-vkuznets@redhat.com

---
 arch/x86/xen/suspend_hvm.c | 1 +
 arch/x86/xen/xen-ops.h     | 1 -
 include/xen/hvm.h          | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index 5152afe..9d548b0 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 
 #include <xen/xen.h>
+#include <xen/hvm.h>
 #include <xen/features.h>
 #include <xen/interface/features.h>
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index ad05d05..53b224f 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -54,7 +54,6 @@ void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
 
-void xen_setup_callback_vector(void);
 void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);
 
diff --git a/include/xen/hvm.h b/include/xen/hvm.h
index 0b15f8c..b7fd7fc 100644
--- a/include/xen/hvm.h
+++ b/include/xen/hvm.h
@@ -58,4 +58,6 @@ static inline int hvm_get_parameter(int idx, uint64_t *value)
 #define HVM_CALLBACK_VECTOR(x) (((uint64_t)HVM_CALLBACK_VIA_TYPE_VECTOR)<<\
 		HVM_CALLBACK_VIA_TYPE_SHIFT | (x))
 
+void xen_setup_callback_vector(void);
+
 #endif /* XEN_HVM_H__ */
