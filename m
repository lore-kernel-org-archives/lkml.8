Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BCC35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EF221744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7KUzQsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgBYHhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34256 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgBYHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:44 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so775415pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNwttvmFKoYVBH0KVogMBrXT//L/sy9v0dzLcDssBsw=;
        b=b7KUzQsAoWHyfp9zwaZIuUaeAkRrU5/nwfll3d2KlLtHX+VODsX5PmwXRxhguDwywI
         bbR20zCWD5JOGbTKKx/+QgE8DzKm6jrCiYK9glzgrD4wr6pl66d5nIAgzTaWRKVulUEb
         Hmhq1/M+KNLkASmPoAmVbCYZO3lw1MSCCSwEkmxWrTBChBJQZJMi13SKVmRWM0mSjZzA
         GWtU0LpsYsQiVd2MV+OxeJctj6CqXaTs1kputEflsrPf2BsxkxqJL6Se7miXMT0e91tN
         8eoSOV7r/+ee+O1XrqG7IIbemkxpG6VqnF6YPG6Tp3RceCWgl5zuou+j7MO4LJxnZX3b
         H7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNwttvmFKoYVBH0KVogMBrXT//L/sy9v0dzLcDssBsw=;
        b=U9OpZLiMfP9YQOqw0/K6jAz/eQAj2/uiwFjfrpu//q4aOv7izi3XVj414bZZM+M8+v
         msK/dnjYUXksCM8BEsGzmv+YveKEQJMgB73lEBuXUrzmMko0gAJpYfPqE3oHVDwODoct
         GqwFplIuZLXiXGVhc/L/Yd/5nyCXy5obzNaiw3b22GuVT54VNfe+NkXP8riKAsrKC9DI
         5xYejASTofdtqVyQiLTtyoa+qCgnhWyEvmUVObPB7J4pKpxw5OSabWodilPbHVIwsWjY
         F+IIKSeM7dPFU22CR+04n72vEd24hg5C/2DXPpeC4+371Vz+QAFKBFSLQxDeNSULtRtc
         NTBg==
X-Gm-Message-State: APjAAAU4js5Np0kWJBaeRks+3nyUYkI0ihODy64Va+3wbSWIGH1DeizX
        CKzgwlibLKQvHctxLjcBpio=
X-Google-Smtp-Source: APXvYqyi1PJgnKEARP1Ltype9QnDI3KSzgGnb7rFcRO9Tex4jDvYFLH3xS1tRJuHl2dDv13U5h51Vw==
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr3675614pjt.131.1582616263620;
        Mon, 24 Feb 2020 23:37:43 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:42 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 3/6] arm64/vdso: Add time napespace page
Date:   Mon, 24 Feb 2020 23:37:28 -0800
Message-Id: <20200225073731.465270-4-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
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

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/vdso.h                 |  6 ++++++
 .../include/asm/vdso/compat_gettimeofday.h    | 11 ++++++++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
 arch/arm64/kernel/vdso.c                      | 20 ++++++++++++++++---
 arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
 arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
 include/vdso/datapage.h                       |  1 +
 7 files changed, 51 insertions(+), 5 deletions(-)

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
index 81b0c394f1d8..042814339a63 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -160,6 +160,17 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return ret;
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	const struct vdso_data *ret;
+
+	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
+
+	return ret;
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 5a534432aa5d..553bdc19a91f 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -97,6 +97,14 @@ const struct vdso_data *__arch_get_vdso_data(void)
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
index 30c4cb0428d1..3494b5536b63 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -98,6 +98,7 @@ struct vdso_data {
  * relocation, and this is what we need.
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.24.1

