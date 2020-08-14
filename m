Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C72C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC25120791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgHNG2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:28:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgHNG2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:28:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12BF994CB70F7B40688F;
        Fri, 14 Aug 2020 14:28:03 +0800 (CST)
Received: from huawei.com (10.44.142.101) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 14 Aug 2020
 14:27:54 +0800
From:   Sang Yan <sangyan@huawei.com>
To:     <kexec@lists.infradead.org>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>
CC:     <zhuling8@huawei.com>, <luanjianhai@huawei.com>,
        <luchunhua@huawei.com>
Subject: [PATCH 1/2] kexec: Add quick kexec support for kernel
Date:   Fri, 14 Aug 2020 01:52:38 -0400
Message-ID: <20200814055239.47348-1-sangyan@huawei.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.44.142.101]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
copy all segments from vmalloced memory to kernel boot memory,
because of disabled mmu.

We introduce quick kexec to save time of copying memory as above,
just like kdump(kexec on crash), by using reserved memory
"Quick Kexec".

Constructing quick kimage as the same as crash kernel,
then simply copy all segments of kimage to reserved memroy.

We also add this support in syscall kexec_load using flags
of KEXEC_QUICK.

Signed-off-by: Sang Yan <sangyan@huawei.com>
---
 arch/Kconfig               | 10 ++++++++++
 include/linux/ioport.h     |  3 +++
 include/linux/kexec.h      | 13 +++++++++++-
 include/uapi/linux/kexec.h |  3 +++
 kernel/kexec.c             | 10 ++++++++++
 kernel/kexec_core.c        | 41 +++++++++++++++++++++++++++++---------
 6 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3329fa143637..eca782cb8e29 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -21,6 +21,16 @@ config KEXEC_CORE
 config KEXEC_ELF
 	bool
 
+config QUICK_KEXEC
+	bool "Support for quick kexec"
+	depends on KEXEC_CORE
+	help
+	  Say y here to enable this feature.
+	  It use reserved memory to accelerate kexec, just like crash
+	  kexec, load new kernel and initrd to reserved memory, and
+	  boot new kernel on that memory. It will save the time of
+	  relocating kernel.
+
 config HAVE_IMA_KEXEC
 	bool
 
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6c2b06fe8beb..f37c632accbe 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -136,6 +136,9 @@ enum {
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
+#ifdef CONFIG_QUICK_KEXEC
+	IORES_DESC_QUICK_KEXEC			= 9,
+#endif
 };
 
 /*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..976bf9631070 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -269,9 +269,12 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	unsigned int type : 1;
+	unsigned int type : 2;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
+#ifdef CONFIG_QUICK_KEXEC
+#define KEXEC_TYPE_QUICK   2
+#endif
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
@@ -331,6 +334,11 @@ extern int kexec_load_disabled;
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
 #endif
 
+#ifdef CONFIG_QUICK_KEXEC
+#undef KEXEC_FLAGS
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_QUICK)
+#endif
+
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS)
@@ -340,6 +348,9 @@ extern int kexec_load_disabled;
 extern struct resource crashk_res;
 extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
+#ifdef CONFIG_QUICK_KEXEC
+extern struct resource quick_kexec_res;
+#endif
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 05669c87a0af..e3213614b713 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,9 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#ifdef CONFIG_QUICK_KEXEC
+#define KEXEC_QUICK		0x00000004
+#endif
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..428af4cd3e1a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -44,6 +44,9 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	int ret;
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_ON_CRASH;
+#ifdef CONFIG_QUICK_KEXEC
+	bool kexec_on_quick = flags & KEXEC_QUICK;
+#endif
 
 	if (kexec_on_panic) {
 		/* Verify we have a valid entry point */
@@ -69,6 +72,13 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 		image->type = KEXEC_TYPE_CRASH;
 	}
 
+#ifdef CONFIG_QUICK_KEXEC
+	if (kexec_on_quick) {
+		image->control_page = quick_kexec_res.start;
+		image->type = KEXEC_TYPE_QUICK;
+	}
+#endif
+
 	ret = sanity_check_segment_list(image);
 	if (ret)
 		goto out_free_image;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..b73dd749368b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -70,6 +70,16 @@ struct resource crashk_low_res = {
 	.desc  = IORES_DESC_CRASH_KERNEL
 };
 
+#ifdef CONFIG_QUICK_KEXEC
+struct resource quick_kexec_res = {
+	.name  = "Quick kexec",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_QUICK_KEXEC
+};
+#endif
+
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
@@ -413,8 +423,10 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 	return pages;
 }
 
-static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
-						      unsigned int order)
+
+static struct page *kimage_alloc_special_control_pages(struct kimage *image,
+						       unsigned int order,
+						       unsigned long end)
 {
 	/* Control pages are special, they are the intermediaries
 	 * that are needed while we copy the rest of the pages
@@ -444,7 +456,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 	size = (1 << order) << PAGE_SHIFT;
 	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
 	hole_end   = hole_start + size - 1;
-	while (hole_end <= crashk_res.end) {
+	while (hole_end <= end) {
 		unsigned long i;
 
 		cond_resched();
@@ -479,7 +491,6 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 	return pages;
 }
 
-
 struct page *kimage_alloc_control_pages(struct kimage *image,
 					 unsigned int order)
 {
@@ -490,8 +501,15 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
 		pages = kimage_alloc_normal_control_pages(image, order);
 		break;
 	case KEXEC_TYPE_CRASH:
-		pages = kimage_alloc_crash_control_pages(image, order);
+		pages = kimage_alloc_special_control_pages(image, order,
+							   crashk_res.end);
+		break;
+#ifdef CONFIG_QUICK_KEXEC
+	case KEXEC_TYPE_QUICK:
+		pages = kimage_alloc_special_control_pages(image, order,
+							   quick_kexec_res.end);
 		break;
+#endif
 	}
 
 	return pages;
@@ -847,11 +865,11 @@ static int kimage_load_normal_segment(struct kimage *image,
 	return result;
 }
 
-static int kimage_load_crash_segment(struct kimage *image,
+static int kimage_load_special_segment(struct kimage *image,
 					struct kexec_segment *segment)
 {
-	/* For crash dumps kernels we simply copy the data from
-	 * user space to it's destination.
+	/* For crash dumps kernels and quick kexec kernels
+	 * we simply copy the data from user space to it's destination.
 	 * We do things a page at a time for the sake of kmap.
 	 */
 	unsigned long maddr;
@@ -925,8 +943,13 @@ int kimage_load_segment(struct kimage *image,
 		result = kimage_load_normal_segment(image, segment);
 		break;
 	case KEXEC_TYPE_CRASH:
-		result = kimage_load_crash_segment(image, segment);
+		result = kimage_load_special_segment(image, segment);
+		break;
+#ifdef CONFIG_QUICK_KEXEC
+	case KEXEC_TYPE_QUICK:
+		result = kimage_load_special_segment(image, segment);
 		break;
+#endif
 	}
 
 	return result;
-- 
2.19.1

