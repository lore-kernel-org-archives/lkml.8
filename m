Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD225C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4B020838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEGPwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727794AbgEGPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:52:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6AEC05BD43;
        Thu,  7 May 2020 08:52:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWioR-0005US-Af; Thu, 07 May 2020 17:51:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EF9171C0480;
        Thu,  7 May 2020 17:51:50 +0200 (CEST)
Date:   Thu, 07 May 2020 15:51:50 -0000
From:   "tip-bot2 for Mark Gross" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add a steppings field to struct x86_cpu_id
Cc:     Mark Gross <mgross@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158886671095.8414.883037551095680128.tip-bot2@tip-bot2>
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

Commit-ID:     e9d7144597b10ff13ff2264c059f7d4a7fbc89ac
Gitweb:        https://git.kernel.org/tip/e9d7144597b10ff13ff2264c059f7d4a7fbc89ac
Author:        Mark Gross <mgross@linux.intel.com>
AuthorDate:    Thu, 16 Apr 2020 17:23:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 20 Apr 2020 12:19:21 +02:00

x86/cpu: Add a steppings field to struct x86_cpu_id

Intel uses the same family/model for several CPUs. Sometimes the
stepping must be checked to tell them apart.

On x86 there can be at most 16 steppings. Add a steppings bitmask to
x86_cpu_id and a X86_MATCH_VENDOR_FAMILY_MODEL_STEPPING_FEATURE macro
and support for matching against family/model/stepping.

 [ bp: Massage. ]

Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/cpu_device_id.h | 27 ++++++++++++++++++++++++---
 arch/x86/kernel/cpu/match.c          |  7 ++++++-
 include/linux/mod_devicetable.h      |  2 ++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index cf3d621..10426cd 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -20,12 +20,14 @@
 #define X86_CENTAUR_FAM6_C7_D		0xd
 #define X86_CENTAUR_FAM6_NANO		0xf
 
+#define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
- * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Base macro for CPU matching
+ * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
  *		The name is expanded to X86_VENDOR_@_vendor
  * @_family:	The family number or X86_FAMILY_ANY
  * @_model:	The model number, model constant or X86_MODEL_ANY
+ * @_steppings:	Bitmask for steppings, stepping constant or X86_STEPPING_ANY
  * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
  * @_data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
@@ -37,16 +39,35 @@
  * into another macro at the usage site for good reasons, then please
  * start this local macro with X86_MATCH to allow easy grepping.
  */
-#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(_vendor, _family, _model,	\
-					   _feature, _data) {		\
+#define X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
+						    _steppings, _feature, _data) { \
 	.vendor		= X86_VENDOR_##_vendor,				\
 	.family		= _family,					\
 	.model		= _model,					\
+	.steppings	= _steppings,					\
 	.feature	= _feature,					\
 	.driver_data	= (unsigned long) _data				\
 }
 
 /**
+ * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Macro for CPU matching
+ * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
+ *		The name is expanded to X86_VENDOR_@_vendor
+ * @_family:	The family number or X86_FAMILY_ANY
+ * @_model:	The model number, model constant or X86_MODEL_ANY
+ * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
+ * @_data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
+ * set to wildcards.
+ */
+#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
+	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
+						X86_STEPPING_ANY, feature, data)
+
+/**
  * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
  * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
  *		The name is expanded to X86_VENDOR_@vendor
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index d3482eb..ad67760 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -39,13 +39,18 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	const struct x86_cpu_id *m;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	for (m = match; m->vendor | m->family | m->model | m->feature; m++) {
+	for (m = match;
+	     m->vendor | m->family | m->model | m->steppings | m->feature;
+	     m++) {
 		if (m->vendor != X86_VENDOR_ANY && c->x86_vendor != m->vendor)
 			continue;
 		if (m->family != X86_FAMILY_ANY && c->x86 != m->family)
 			continue;
 		if (m->model != X86_MODEL_ANY && c->x86_model != m->model)
 			continue;
+		if (m->steppings != X86_STEPPING_ANY &&
+		    !(BIT(c->x86_stepping) & m->steppings))
+			continue;
 		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
 		return m;
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4c2ddd0..0754b8d 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -663,6 +663,7 @@ struct x86_cpu_id {
 	__u16 vendor;
 	__u16 family;
 	__u16 model;
+	__u16 steppings;
 	__u16 feature;	/* bit index */
 	kernel_ulong_t driver_data;
 };
@@ -671,6 +672,7 @@ struct x86_cpu_id {
 #define X86_VENDOR_ANY 0xffff
 #define X86_FAMILY_ANY 0
 #define X86_MODEL_ANY  0
+#define X86_STEPPING_ANY 0
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
 
 /*
