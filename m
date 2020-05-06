Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB8C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F020663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YXZg1/hK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEFHP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgEFHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:15:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 00:15:25 -0700 (PDT)
Received: from zn.tnic (p200300EC2F069600BCEB9C28D5742179.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:bceb:9c28:d574:2179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E65C91EC0347;
        Wed,  6 May 2020 09:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588749324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hV03FKjzJjQFIqIyuAnEvBFHiePxqbsE/nFtEqnAYJk=;
        b=YXZg1/hKguuAT17GD0/DUpueXb2c4eVxdo57NyZ0Pp9mYCEZi9/jxipEaUdOSvTvTBWw5I
        pmn4so0cUYlDnDRGOeTjsxrD59s1HQgwte+pNyRvI7YqkemzKaON6VyNIiLKK9ZQ1Hqks6
        tqYludYEG/aiLCswHIYSgRCOZfgB+58=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 1/3] x86/cpu: Add a steppings field to struct x86_cpu_id
Date:   Wed,  6 May 2020 09:15:14 +0200
Message-Id: <20200506071516.25445-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506071516.25445-1-bp@alien8.de>
References: <20200506071516.25445-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Gross <mgross@linux.intel.com>

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
 include/linux/mod_devicetable.h      |  2 ++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index cf3d621c6892..10426cd56dca 100644
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
@@ -37,15 +39,34 @@
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
 
+/**
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
 /**
  * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
  * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index d3482eb43ff3..ad6776081e60 100644
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
index 4c2ddd0941a7..0754b8d71262 100644
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
-- 
2.21.0

