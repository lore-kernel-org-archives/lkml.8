Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BDFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CE320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZUFrDwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbgFXIdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390122AbgFXId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71245C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so786765pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nh8ixUlNnwBVNpYpiBlN8ZCsRVA/fYFrYc83EzRIQwk=;
        b=JZUFrDwgybnu8DRTQLn5l45ozI7KCDc3XpQI8l7FXZOnQFc0z7S/jvORjNWYPiSRYl
         m2nT8CSXYMnZOrUY5RbwzR3AjPYsGL5erUv4cf/yrMYWl5nmllRzg2vy3fwizvvLWlAu
         2wR1sOkFRfleSbV83stbz0DjkY1eg8QzZzLybXlGXj3j63JE4SsyovMr/M8ZCP8CY+cz
         ZaDK6/faUUVVWkWBnFHpxGOisxGtlWdYxgqAvjt+LRa6sFRxD8SfzvB9rWPbDoieEzYK
         NnYiNjG8I5uDsVVAW2O/61z+M6wF+jKBLcuMyYhJ6dEtLmUKFk7wJb0ymBncDh34OqI+
         65bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nh8ixUlNnwBVNpYpiBlN8ZCsRVA/fYFrYc83EzRIQwk=;
        b=DcjMh0UnWlg8kb1hiXrG6nl/iysfo9B+PZ/n8zOGwn8xhkbivW7pCJKhW4NDYrCJxy
         V5An0shsoBcxn7nSrVHaP3YdOJR8HnB81Z7KxlUB2V4sAZjiOwS3cX9dmfTPt9XqVjCd
         KIXblvM+NlRLsioNSEOG152eAyct/GM0ZkJuYXFM+YpY4re6f/2fW/HwZmrp21Iw/lZp
         L5soMCAwCcomHdama1bpvSmNWfujAlG4ZmaULHS3xDsWrOcxutnP89iRNbC2pqTOWnoV
         lxtbRVokLKLKfP1ZlTeD9ImNd68Ei82qbQsHCnYhCnSBsscw1HQt45XuOTDuH48Jn37y
         9scA==
X-Gm-Message-State: AOAM530pBxvQQHMmTslX1W8ivNplxJpDzuUsaUuxrkf0mBzILZWEBjj1
        ycOYhmTQDW+U8ph/l3i9Mx8=
X-Google-Smtp-Source: ABdhPJx51nMYJNA8mM0v2aNWx13UfPnannrZyY9m1UO5p5COw+WLxdKb5jR6XUnvCQKMybNXJRcelg==
X-Received: by 2002:a17:90b:a0b:: with SMTP id gg11mr27283567pjb.17.1592987606768;
        Wed, 24 Jun 2020 01:33:26 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:26 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 3/6] arm64/vdso: Add time namespace page
Date:   Wed, 24 Jun 2020 01:33:18 -0700
Message-Id: <20200624083321.144975-4-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
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

The time-namespace page isn't allocated on !CONFIG_TIME_NAMESPACE, but
vma is the same size, which simplifies criu/vdso migration between
different kernel configs.

Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/vdso.h                 |  2 ++
 .../include/asm/vdso/compat_gettimeofday.h    | 12 ++++++++++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
 arch/arm64/kernel/vdso.c                      | 19 ++++++++++++++++---
 arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
 arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
 include/vdso/datapage.h                       |  1 +
 7 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 07468428fd29..f99dcb94b438 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -12,6 +12,8 @@
  */
 #define VDSO_LBASE	0x0
 
+#define __VVAR_PAGES    2
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
index bdf492a17dff..18854e6c1373 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -40,6 +40,12 @@ enum vdso_abi {
 #endif /* CONFIG_COMPAT_VDSO */
 };
 
+enum vvar_pages {
+	VVAR_DATA_PAGE_OFFSET,
+	VVAR_TIMENS_PAGE_OFFSET,
+	VVAR_NR_PAGES,
+};
+
 struct vdso_abi_info {
 	const char *name;
 	const char *vdso_code_start;
@@ -125,6 +131,11 @@ static int __vdso_init(enum vdso_abi abi)
 }
 
 #ifdef CONFIG_TIME_NS
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page);
+}
+
 /*
  * The vvar mapping contains data for a specific time namespace, so when a task
  * changes namespace we must unmap its vvar data for the old namespace.
@@ -173,9 +184,11 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	unsigned long gp_flags = 0;
 	void *ret;
 
+	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
+
 	vdso_text_len = vdso_info[abi].vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	vdso_mapping_len = vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
 
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
@@ -183,7 +196,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
 
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_PFNMAP,
 				       vdso_info[abi].dm);
 	if (IS_ERR(ret))
@@ -192,7 +205,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && system_supports_bti())
 		gp_flags = VM_ARM64_BTI;
 
-	vdso_base += PAGE_SIZE;
+	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
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

