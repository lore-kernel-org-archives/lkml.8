Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197212077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2WVkv58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFBSD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:03:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CBC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:03:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so5445907pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvC2cXU3x8NgQmMPlghjw4hXQanJRRtC1oN/RWCq4y8=;
        b=j2WVkv58m9zpWyZJMOK3LR7zEyQEK88hzm3wtSJ+wZERVs+ZjUfLtQIR/HJ6RvNkEA
         dzGvMpNHDeisx7baXn3pR9PZGrH+smeZnm9HrCXm03HsIn5kQ63TC01bItzyvnj7GYqG
         RSYVI/5LLmUiLSNyBzEW7SdUbbe0Jaz9Wd7/3szQjYy6WYTa7cB1cos5Ka9j+J1Mezsa
         J83SehNNnj2GDSm8pOJfsF1agRjGOcee/rhhv9bTaHefjWVl5ckEhmWOyfkqbxqIht5a
         CsoP2PmodukwMsPB0Ezmp2SuouNPV1U4Ro5FhdnwoszVGZXuzv8gI02MqKzIHKG4AEQi
         BMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvC2cXU3x8NgQmMPlghjw4hXQanJRRtC1oN/RWCq4y8=;
        b=HhTmq12ldPsaoVFQ8GPCUljt6kidtNt/QvLgvHkr6/1QsmGQXguH5gVKkcZ6RRZg+j
         oxhFLwS34JmRnvDB+TX4PVx6x2AYbpw7Y4ezjNqCXHPLtPSHsSrbUTA8s1zukW2t39Vq
         24RHIx6hjuc5Mxvwn3D4JYyirPmjUl1xv2mGJj2MnAktVfrxVQuuFuaMBm5x6ahVzbkQ
         6aLUpkYMTH1PmszPBWlzDhC0Exb7+Mri81OgBb6EzJXlZPoT6LKu0PCTpWKKnhD6LTb1
         Vl8FxYRhVmou9bJi2Jd+OVv8ROp/t+8W5hCaP5ms1gEeqPA3IJU8BiQp8vyvBQgnNAgo
         9YaA==
X-Gm-Message-State: AOAM5310ioH+5SSNO3twm4pczdY5nEyKMlWU/N2EV4PvkWs1nTJGx7EY
        cGmA/NVQUlH/9z9rICVW0rk=
X-Google-Smtp-Source: ABdhPJyDdYPU0DoZ4PPbnuC7G/D+TcLR6xzD9xvDTtmOSog5BajkQT38Myr/BRAjL+H6/fpPpS2SXQ==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr24806038pgq.272.1591120987722;
        Tue, 02 Jun 2020 11:03:07 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id p8sm2740053pgs.29.2020.06.02.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:07 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 3/6] arm64/vdso: Add time namespace page
Date:   Tue,  2 Jun 2020 11:02:56 -0700
Message-Id: <20200602180259.76361-4-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200602180259.76361-1-avagin@gmail.com>
References: <20200602180259.76361-1-avagin@gmail.com>
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

Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/vdso.h                 |  6 +++++
 .../include/asm/vdso/compat_gettimeofday.h    | 12 ++++++++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  8 +++++++
 arch/arm64/kernel/vdso.c                      | 22 ++++++++++++++++---
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
index b6907ae78e53..b7c549d46d18 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -152,6 +152,18 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return ret;
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	const struct vdso_data *ret;
+
+	/* See __arch_get_vdso_data(). */
+	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
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
index 33df3cdf7982..1fa6f9362e56 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -46,6 +46,14 @@ enum arch_vdso_type {
 #define VDSO_TYPES		(ARM64_VDSO + 1)
 #endif /* CONFIG_COMPAT_VDSO */
 
+enum vvar_pages {
+	VVAR_DATA_PAGE_OFFSET,
+#ifdef CONFIG_TIME_NS
+	VVAR_TIMENS_PAGE_OFFSET,
+#endif /* CONFIG_TIME_NS */
+	VVAR_NR_PAGES,
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
@@ -180,9 +194,11 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
 
+	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
+
 	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	vdso_mapping_len = vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
 
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
@@ -190,13 +206,13 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
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
index 7955c56d6b3c..ee810cae4e1e 100644
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

