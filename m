Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71971C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A5B20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXzKzmzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406769AbgDPF1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406482AbgDPF0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kb16so211202pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N78dzL9RDjNSrVVXaZvpSrsYlDpWnvFa6LeaBKX6A3M=;
        b=iXzKzmzUGRZ79DNzqp7Lm+96DzIAkVxUTU2OnyiqdTZmvNoMrc0iD4LPGynFQSP+hw
         0c7kvDtIBgG6eYGVdCTQnMHe9Phq+c++xfNmu5KsQgnLrhvDg3XzWYsfD1P420v2bywR
         9w6UoP738FCjKhaQ/IQ5/smJEnWLeuFcfs3gsgchpYb9S+XTfVCcl6B1OfuHtCPNmfDw
         XsOD2ZZeYBEMkkLU8UyqokIC2AejpI1ZCS1LX3vhTkFM1uauH6P6/b6lbVZpGyEftgLp
         XQbEU7aL3hFQL5PLQsQyZO+3KIhEXnXbnR8nEUdH63EZjdW1y6Tk3jMz0xxSxWcBoUY9
         Kj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N78dzL9RDjNSrVVXaZvpSrsYlDpWnvFa6LeaBKX6A3M=;
        b=J1qxnwWVOouFGcdEEah35NWpojn4VE2duJ3fQ/SoW9OkNTBHeAvbQoUjdNNhgFpSRW
         svlCGwZpFoCznOj2hANcp2jo2e0W9hARZK2lh2h3CZf3OOl0MAe+i6LovpcFroTaLYw1
         kxClnmZ3qYja6SN5Phnb0iD562+buTbTBaDfPBmJAPaq5vVzrsIJJi2j4+nW8iKQebpr
         4f5B7ZR2t7sRdlEWMekus+Jkp1VzmG6ZRRv4mx8hSJBltKAY2SQy2EPb+Xq/yoV+Qmtt
         MrQhJQHbj3nLTu5hMj/VdlGh2k1/3dC4CSVZEabcE0PMnpObI1v2QqlLSlxo7tkvR4+O
         ZUNQ==
X-Gm-Message-State: AGi0Pua4gBCN3vst3IC2S5RG60dDg7RNY8sdShVugJ02Oq9T2gCFjacy
        0hJqM/K+wu8TeVyjya7Tb1U=
X-Google-Smtp-Source: APiQypJm6qkvdje68GzeVvp/6hKrvxEOUtOBYSXGJ6Y+l9oTaF/eE9HzlwVrZWRqtor//umHCg6UtQ==
X-Received: by 2002:a17:90a:1743:: with SMTP id 3mr3162889pjm.106.1587014805842;
        Wed, 15 Apr 2020 22:26:45 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:45 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 3/6] arm64/vdso: Add time napespace page
Date:   Wed, 15 Apr 2020 22:26:15 -0700
Message-Id: <20200416052618.804515-4-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the time namespace page among VVAR pages.  Provide
__arch_get_timens_vdso_data() helper for VDSO code to get the
code-relative position of VVARs on that special page.

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page. That page has vdso_data->seq
set to 1 to enforce the slow path and vdso_data->clock_mode set to
VCLOCK_TIMENS to enforce the time namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the VDSO data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/vdso.h                 |  6 ++++++
 .../include/asm/vdso/compat_gettimeofday.h    | 14 +++++++++++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
 arch/arm64/kernel/vdso.c                      | 20 ++++++++++++++++---
 arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
 arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
 include/vdso/datapage.h                       |  1 +
 7 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 07468428fd29..351c145d3808 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -12,6 +12,12 @@
  */
 #define VDSO_LBASE	0x0
 
+#ifdef CONFIG_TIME_NS
+#define __VVAR_PAGES    2
+#else
+#define __VVAR_PAGES    1
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index b6907ae78e53..6ce9cdf5e08b 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -7,6 +7,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/compiler.h>
+
 #include <asm/unistd.h>
 #include <asm/errno.h>
 
@@ -152,6 +154,18 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return ret;
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	const struct vdso_data *ret;
+
+	ret = _timens_data;
+	OPTIMIZER_HIDE_VAR(ret);
+
+	return ret;
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index afba6ba332f8..cf39eae5eaaf 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -96,6 +96,14 @@ const struct vdso_data *__arch_get_vdso_data(void)
 	return _vdso_data;
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return _timens_data;
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 6ac9cdeac5be..b3e7ce24e59b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -46,6 +46,14 @@ enum arch_vdso_type {
 #define VDSO_TYPES		(ARM64_VDSO + 1)
 #endif /* CONFIG_COMPAT_VDSO */
 
+enum vvar_pages {
+	VVAR_DATA_PAGE_OFFSET = 0,
+#ifdef CONFIG_TIME_NS
+	VVAR_TIMENS_PAGE_OFFSET = 1,
+#endif /* CONFIG_TIME_NS */
+	VVAR_NR_PAGES = __VVAR_PAGES,
+};
+
 struct __vdso_abi {
 	const char *name;
 	const char *vdso_code_start;
@@ -81,6 +89,12 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
+
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page);
+}
+
 static int __vdso_remap(enum arch_vdso_type arch_index,
 			const struct vm_special_mapping *sm,
 			struct vm_area_struct *new_vma)
@@ -182,7 +196,7 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 
 	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	vdso_mapping_len = vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
 
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
@@ -190,13 +204,13 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 		goto up_fail;
 	}
 
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_PFNMAP,
 				       vdso_lookup[arch_index].dm);
 	if (IS_ERR(ret))
 		goto up_fail;
 
-	vdso_base += PAGE_SIZE;
+	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 7ad2d3a0cd48..d808ad31e01f 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -17,7 +17,10 @@ OUTPUT_ARCH(aarch64)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - PAGE_SIZE);
+	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
+#ifdef CONFIG_TIME_NS
+	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
+#endif
 	. = VDSO_LBASE + SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index a3944927eaeb..06cc60a9630f 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -17,7 +17,10 @@ OUTPUT_ARCH(arm)
 
 SECTIONS
 {
-	PROVIDE_HIDDEN(_vdso_data = . - PAGE_SIZE);
+	PROVIDE_HIDDEN(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
+#ifdef CONFIG_TIME_NS
+	PROVIDE_HIDDEN(_timens_data = _vdso_data + PAGE_SIZE);
+#endif
 	. = VDSO_LBASE + SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5cbc9fcbfd45..2022e8c653c1 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -109,6 +109,7 @@ struct vdso_data {
  * relocation, and this is what we need.
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
 
 /*
  * The generic vDSO implementation requires that gettimeofday.h
-- 
2.24.1

