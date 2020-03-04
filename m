Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E12DC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADB321775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="MqLjps25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgCDK3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:29:04 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:55070 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:28:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 92FA73F50E;
        Wed,  4 Mar 2020 11:28:52 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=MqLjps25;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5m1gArvW3r0h; Wed,  4 Mar 2020 11:28:50 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6474E3FDC1;
        Wed,  4 Mar 2020 11:28:50 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id AAB4B360653;
        Wed,  4 Mar 2020 11:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583317728; bh=OqSVoovR/+c4qu+cIitn9nr+0rwe7G3GlfCeEEsfKXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqLjps25hpLAqnful3hHzjtnD9iz/vTMvaNrAZ4xMWwsq8+xFOo4KFJ8DJvrfHhUk
         FkhoSKw/lXUwiDdDgYVdhWjui+Q5qOF3fK+cKWXpTxlXDZI2KON179zV1hj8muxIJp
         DzCSe7tuExwYqU/EVynkBiLfvB+ORNPB2n1FGb2k=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: [PATCH v6 7/9] drm: Add a drm_get_unmapped_area() helper
Date:   Wed,  4 Mar 2020 11:28:38 +0100
Message-Id: <20200304102840.2801-8-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304102840.2801-1-thomas_os@shipmail.org>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Unaligned virtual addresses makes it unlikely that huge page-table entries
can be used.
So align virtual buffer object address huge page boundaries to the
underlying physical address huge page boundaries taking buffer object
sizes into account to determine when it might be possible to use huge
page-table entries.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_file.c | 140 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_file.h     |   9 +++
 2 files changed, 149 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 92d16724f949..77e691202b52 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -48,6 +48,11 @@
 #include "drm_internal.h"
 #include "drm_legacy.h"
 
+#ifdef CONFIG_MMU
+#include <uapi/asm/mman.h>
+#include <drm/drm_vma_manager.h>
+#endif
+
 /* from BKL pushdown */
 DEFINE_MUTEX(drm_global_mutex);
 
@@ -796,3 +801,138 @@ struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags)
 	return file;
 }
 EXPORT_SYMBOL_FOR_TESTS_ONLY(mock_drm_getfile);
+
+#ifdef CONFIG_MMU
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * drm_addr_inflate() attempts to construct an aligned area by inflating
+ * the area size and skipping the unaligned start of the area.
+ * adapted from shmem_get_unmapped_area()
+ */
+static unsigned long drm_addr_inflate(unsigned long addr,
+				      unsigned long len,
+				      unsigned long pgoff,
+				      unsigned long flags,
+				      unsigned long huge_size)
+{
+	unsigned long offset, inflated_len;
+	unsigned long inflated_addr;
+	unsigned long inflated_offset;
+
+	offset = (pgoff << PAGE_SHIFT) & (huge_size - 1);
+	if (offset && offset + len < 2 * huge_size)
+		return addr;
+	if ((addr & (huge_size - 1)) == offset)
+		return addr;
+
+	inflated_len = len + huge_size - PAGE_SIZE;
+	if (inflated_len > TASK_SIZE)
+		return addr;
+	if (inflated_len < len)
+		return addr;
+
+	inflated_addr = current->mm->get_unmapped_area(NULL, 0, inflated_len,
+						       0, flags);
+	if (IS_ERR_VALUE(inflated_addr))
+		return addr;
+	if (inflated_addr & ~PAGE_MASK)
+		return addr;
+
+	inflated_offset = inflated_addr & (huge_size - 1);
+	inflated_addr += offset - inflated_offset;
+	if (inflated_offset > offset)
+		inflated_addr += huge_size;
+
+	if (inflated_addr > TASK_SIZE - len)
+		return addr;
+
+	return inflated_addr;
+}
+
+/**
+ * drm_get_unmapped_area() - Get an unused user-space virtual memory area
+ * suitable for huge page table entries.
+ * @file: The struct file representing the address space being mmap()'d.
+ * @uaddr: Start address suggested by user-space.
+ * @len: Length of the area.
+ * @pgoff: The page offset into the address space.
+ * @flags: mmap flags
+ * @mgr: The address space manager used by the drm driver. This argument can
+ * probably be removed at some point when all drivers use the same
+ * address space manager.
+ *
+ * This function attempts to find an unused user-space virtual memory area
+ * that can accommodate the size we want to map, and that is properly
+ * aligned to facilitate huge page table entries matching actual
+ * huge pages or huge page aligned memory in buffer objects. Buffer objects
+ * are assumed to start at huge page boundary pfns (io memory) or be
+ * populated by huge pages aligned to the start of the buffer object
+ * (system- or coherent memory). Adapted from shmem_get_unmapped_area.
+ *
+ * Return: aligned user-space address.
+ */
+unsigned long drm_get_unmapped_area(struct file *file,
+				    unsigned long uaddr, unsigned long len,
+				    unsigned long pgoff, unsigned long flags,
+				    struct drm_vma_offset_manager *mgr)
+{
+	unsigned long addr;
+	unsigned long inflated_addr;
+	struct drm_vma_offset_node *node;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/*
+	 * @pgoff is the file page-offset the huge page boundaries of
+	 * which typically aligns to physical address huge page boundaries.
+	 * That's not true for DRM, however, where physical address huge
+	 * page boundaries instead are aligned with the offset from
+	 * buffer object start. So adjust @pgoff to be the offset from
+	 * buffer object start.
+	 */
+	drm_vma_offset_lock_lookup(mgr);
+	node = drm_vma_offset_lookup_locked(mgr, pgoff, 1);
+	if (node)
+		pgoff -= node->vm_node.start;
+	drm_vma_offset_unlock_lookup(mgr);
+
+	addr = current->mm->get_unmapped_area(file, uaddr, len, pgoff, flags);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+	if (addr & ~PAGE_MASK)
+		return addr;
+	if (addr > TASK_SIZE - len)
+		return addr;
+
+	if (len < HPAGE_PMD_SIZE)
+		return addr;
+	if (flags & MAP_FIXED)
+		return addr;
+	/*
+	 * Our priority is to support MAP_SHARED mapped hugely;
+	 * and support MAP_PRIVATE mapped hugely too, until it is COWed.
+	 * But if caller specified an address hint, respect that as before.
+	 */
+	if (uaddr)
+		return addr;
+
+	inflated_addr = drm_addr_inflate(addr, len, pgoff, flags,
+					 HPAGE_PMD_SIZE);
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
+	    len >= HPAGE_PUD_SIZE)
+		inflated_addr = drm_addr_inflate(inflated_addr, len, pgoff,
+						 flags, HPAGE_PUD_SIZE);
+	return inflated_addr;
+}
+#else /* CONFIG_TRANSPARENT_HUGEPAGE */
+unsigned long drm_get_unmapped_area(struct file *file,
+				    unsigned long uaddr, unsigned long len,
+				    unsigned long pgoff, unsigned long flags,
+				    struct drm_vma_offset_manager *mgr)
+{
+	return current->mm->get_unmapped_area(file, uaddr, len, pgoff, flags);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_MMU */
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 8b099b347817..fd88fcb380d2 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -390,4 +390,13 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e);
 
 struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
 
+#ifdef CONFIG_MMU
+struct drm_vma_offset_manager;
+unsigned long drm_get_unmapped_area(struct file *file,
+				    unsigned long uaddr, unsigned long len,
+				    unsigned long pgoff, unsigned long flags,
+				    struct drm_vma_offset_manager *mgr);
+#endif /* CONFIG_MMU */
+
+
 #endif /* _DRM_FILE_H_ */
-- 
2.21.1

