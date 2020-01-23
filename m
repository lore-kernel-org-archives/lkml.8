Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A66C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36BF21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svRs4+Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAWBq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:46:59 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:56863 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgAWBq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 20:46:58 -0500
Received: by mail-pj1-f74.google.com with SMTP id d6so561880pjs.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QCHXxNK8/BbuJuJBSwzdO5h2VdmSh01YZxJCYkkB4Qw=;
        b=svRs4+NnIb8miZBRuWlIo1vn0BvkuOjAkFbeLBRV0SSyde+oZbYjiDCB4uNM5bN0mO
         DdDMAC88hxUA//KKlSgC9kaUgBcRkpQbKbAKpsyJUNVS8Whp9pUs36g2putQngJj8TQz
         RGR3CFpXTJSA8JPk3nzeZF26g8idlPT8YXAYLSzLkY0bhiezkAKuDrNC+uRVo3E3b0cf
         GVfow4dQF9ULUNIr1amkN6ddAaB5PftcRqKchcJQRR81QtyzcWb5oqvgX1UauvBhVvtK
         nCcBRmh3baRGraWhSGPSUDnVu3WquIUlG7edbRVHYSiAcrVe8sAZ0Fmz9u7bPr4JrZRt
         ME0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QCHXxNK8/BbuJuJBSwzdO5h2VdmSh01YZxJCYkkB4Qw=;
        b=iLi1zJt9EzvA3DY/rUZn8nbJlYqrRVu8snN0W4I2oES8CHVl8oW3if7rAv3K8Nobb7
         k2ESZqcNS0ogbcZFF0uKLiJNS8iNgpw+9A2iHenbRoM77y+A92SxrFkAMjK1NCyuQtlO
         uHCUdKomp6hE4XbMyuleM7EJJdEgefw8H0t7/Hc24rp7QK0PGmkE8hFcgEHTGV1rQTPi
         iksPkezQNL9sjiy37876AVxUJd5GDywTIKS2t+ubgy0BVIaoBJ6PtsrFx97j1vc9iAvX
         8NQvyaGnpWOb/1VjC8q8PJc3Ad/W2d8gnAHYqvsFcgZQY7Sq2ZG/6+oN8lBebx0Faspj
         X8nw==
X-Gm-Message-State: APjAAAVkA7BBM8qvivP3wVPaXiGui4RHZ2RbenSiTSJ43pYnyZy/TUZL
        huHfpyDY7FdesPTnWhe1kcyqXMUorT3N
X-Google-Smtp-Source: APXvYqwEYpTzBJK3gG4R2RwTyQ62AuSI118fUjTqIftveRta/RrFTaFwaouAg3YZavLW7ZKqqATAdPCrm6PT
X-Received: by 2002:a63:e649:: with SMTP id p9mr1318848pgj.15.1579744017943;
 Wed, 22 Jan 2020 17:46:57 -0800 (PST)
Date:   Wed, 22 Jan 2020 17:46:27 -0800
Message-Id: <20200123014627.71720-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] mm: Add MREMAP_DONTUNMAP to mremap().
From:   Brian Geffon <bgeffon@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Geffon <bgeffon@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MREMAP_DONTUNMAP is an additional flag that can be used with
MREMAP_FIXED to move a mapping to a new address. Normally, mremap(2)
would then tear down the old vma so subsequent accesses to the vma
cause a segfault. However, with this new flag it will keep the old
vma with zapping PTEs so any access to the old VMA after that point
will result in a pagefault.

This feature will find a use in ChromeOS along with userfaultfd.
Specifically we will want to register a VMA with userfaultfd and then
pull it out from under a running process. By using MREMAP_DONTUNMAP we
don't have to worry about mprotecting and then potentially racing with
VMA permission changes from a running process.

This feature also has a use case in Android, Lokesh Gidra has said
that "As part of using userfaultfd for GC, We'll have to move the physical
pages of the java heap to a separate location. For this purpose mremap
will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
heap, its virtual mapping will be removed as well. Therefore, we'll
require performing mmap immediately after. This is not only time consuming
but also opens a time window where a native thread may call mmap and
reserve the java heap's address range for its own usage. This flag
solves the problem."

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 include/uapi/linux/mman.h |  5 +++--
 mm/mremap.c               | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index fc1a64c3447b..923cc162609c 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -5,8 +5,9 @@
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
 
-#define MREMAP_MAYMOVE	1
-#define MREMAP_FIXED	2
+#define MREMAP_MAYMOVE		1
+#define MREMAP_FIXED		2
+#define MREMAP_DONTUNMAP	4
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/mm/mremap.c b/mm/mremap.c
index 122938dcec15..bf97c3eb538b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 static unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr,
-		bool *locked, struct vm_userfaultfd_ctx *uf,
-		struct list_head *uf_unmap)
+		bool *locked, unsigned long flags,
+		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma;
@@ -408,6 +408,13 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_moved(vma);
 
+	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		if (vm_flags & VM_ACCOUNT)
+			vma->vm_flags |= VM_ACCOUNT;
+
+		goto out;
+	}
+
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
@@ -422,6 +429,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			vma->vm_next->vm_flags |= VM_ACCOUNT;
 	}
 
+out:
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		*locked = true;
@@ -497,7 +505,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		unsigned long new_addr, unsigned long new_len, bool *locked,
-		struct vm_userfaultfd_ctx *uf,
+		unsigned long flags, struct vm_userfaultfd_ctx *uf,
 		struct list_head *uf_unmap_early,
 		struct list_head *uf_unmap)
 {
@@ -545,6 +553,17 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		old_len = new_len;
 	}
 
+	/*
+	 * MREMAP_DONTUNMAP expands by old_len + (new_len - old_len), we will
+	 * check that we can expand by old_len and vma_to_resize will handle
+	 * the vma growing.
+	 */
+	if (unlikely(flags & MREMAP_DONTUNMAP && !may_expand_vm(mm,
+				vma->vm_flags, old_len >> PAGE_SHIFT))) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	vma = vma_to_resize(addr, old_len, new_len, &charged);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
@@ -561,7 +580,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if (IS_ERR_VALUE(ret))
 		goto out1;
 
-	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
+	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
 		       uf_unmap);
 	if (!(offset_in_page(ret)))
 		goto out;
@@ -609,12 +628,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	addr = untagged_addr(addr);
 	new_addr = untagged_addr(new_addr);
 
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return ret;
 
 	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
 		return ret;
 
+	if (flags & MREMAP_DONTUNMAP && !(flags & MREMAP_FIXED))
+		return ret;
+
 	if (offset_in_page(addr))
 		return ret;
 
@@ -634,7 +656,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
 	if (flags & MREMAP_FIXED) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
-				&locked, &uf, &uf_unmap_early, &uf_unmap);
+				&locked, flags, &uf, &uf_unmap_early,
+				&uf_unmap);
 		goto out;
 	}
 
@@ -712,7 +735,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		}
 
 		ret = move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, &uf, &uf_unmap);
+			       &locked, flags, &uf, &uf_unmap);
 	}
 out:
 	if (offset_in_page(ret)) {
-- 
2.25.0.341.g760bfbb309-goog

