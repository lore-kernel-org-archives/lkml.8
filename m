Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A54C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90669206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgEDWC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:02:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47764 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgEDWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:02:59 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVjAp-0000jK-I2; Mon, 04 May 2020 16:02:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVjAb-0001O9-V1; Mon, 04 May 2020 16:02:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
        <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
        <87h7wzvjko.fsf@x220.int.ebiederm.org>
        <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
        <87ftcfpzjn.fsf@x220.int.ebiederm.org>
Date:   Mon, 04 May 2020 16:59:14 -0500
In-Reply-To: <87ftcfpzjn.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 04 May 2020 09:03:56 -0500")
Message-ID: <87368fmkel.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jVjAb-0001O9-V1;;;mid=<87368fmkel.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/u48Pr0HiQim87969boyxx6YAssOJg8Ms=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH] kexec: Teach indirect pages how to live in high memory
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently a patch was proposed to kimage_alloc_page to slightly alter
the logic of how pages allocated with incompatible flags were
detected.  The logic was being altered because the semantics of the
page alloctor were changing yet again.

Looking at that case I realized that there is no reason for it to even
exist.  Either the indirect page allocations and the source page
allocations could be separated out, or I could do as I am doing now
and simply teach the indirect pages to live in high memory.

This patch replaced pointers of type kimage_entry_t * with a new type
kimage_entry_pos_t.  This new type holds the physical address of the
indirect page and the offset within that page of the next indirect
entry to write.  A special constant KIMAGE_ENTRY_POS_INVALID is added
that kimage_image_pos_t variables that don't currently have a valid
may be set to.

Two new functions kimage_read_entry and kimage_write_entry have been
provided to write entries in way that works if they live in high
memory.

The now unnecessary checks to see if a destination entry is non-zero
and to increment it if so have been removed.  For safety new indrect
pages are now cleared so we have a guarantee everything that has not
been used yet is zero.  Along with this writing an extra trailing 0
entry has been removed, as it is known all trailing entries are now 0.

With highmem support implemented for indirect pages
kimage_image_alloc_page has been updated to always allocate
GFP_HIGHUSER pages, and handling of pages with different
gfp flags has been removed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I have not done more than compile test this but I think this will remove
that tricky case in the kexec highmem support.

Any comments?  Does anyone have a 32bit highmem system where they can
test this code?  I can probably do something with a 32bit x86 kernel
but it has been a few days.

Does anyone know how we can more effectively allocate memory below
whatever the maximum limit that kexec supports? Typically below
4G on 32bit and below 2^64 on 64bits.

Eric

 include/linux/kexec.h |   5 +-
 kernel/kexec_core.c   | 119 +++++++++++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 51 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1776eb2e43a4..6d3f6f4cb926 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -69,6 +69,8 @@
  */
 
 typedef unsigned long kimage_entry_t;
+typedef unsigned long kimage_entry_pos_t;
+#define KIMAGE_ENTRY_POS_INVALID ((kimage_entry_pos_t)-2)
 
 struct kexec_segment {
 	/*
@@ -243,8 +245,7 @@ int kexec_elf_probe(const char *buf, unsigned long len);
 #endif
 struct kimage {
 	kimage_entry_t head;
-	kimage_entry_t *entry;
-	kimage_entry_t *last_entry;
+	kimage_entry_pos_t entry_pos;
 
 	unsigned long start;
 	struct page *control_code_page;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..45862fda9e60 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -142,7 +142,6 @@ EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 #define PAGE_COUNT(x) (((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
 
 static struct page *kimage_alloc_page(struct kimage *image,
-				       gfp_t gfp_mask,
 				       unsigned long dest);
 
 int sanity_check_segment_list(struct kimage *image)
@@ -261,8 +260,7 @@ struct kimage *do_kimage_alloc_init(void)
 		return NULL;
 
 	image->head = 0;
-	image->entry = &image->head;
-	image->last_entry = &image->head;
+	image->entry_pos = KIMAGE_ENTRY_POS_INVALID;
 	image->control_page = ~0; /* By default this does not apply */
 	image->type = KEXEC_TYPE_DEFAULT;
 
@@ -531,28 +529,56 @@ int kimage_crash_copy_vmcoreinfo(struct kimage *image)
 	return 0;
 }
 
-static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
+static kimage_entry_t kimage_read_entry(kimage_entry_pos_t pos)
 {
-	if (*image->entry != 0)
-		image->entry++;
+	kimage_entry_t *arr, entry;
+	struct page *page;
+	unsigned long off;
+
+	page = boot_pfn_to_page(pos >> PAGE_SHIFT);
+	off = pos & ~PAGE_MASK;
+	arr = kmap_atomic(page);
+	entry = arr[off];
+	kunmap_atomic(arr);
+
+	return entry;
+}
 
-	if (image->entry == image->last_entry) {
-		kimage_entry_t *ind_page;
+static void kimage_write_entry(kimage_entry_pos_t pos, kimage_entry_t entry)
+{
+	kimage_entry_t *arr;
+	struct page *page;
+	unsigned long off;
+
+	page = boot_pfn_to_page(pos >> PAGE_SHIFT);
+	off = pos & ~PAGE_MASK;
+	arr = kmap_atomic(page);
+	arr[off] = entry;
+	kunmap_atomic(arr);
+}
+
+#define LAST_KIMAGE_ENTRY ((PAGE_SIZE/sizeof(kimage_entry_t)) - 1)
+static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
+{
+	if ((image->entry_pos == KIMAGE_ENTRY_POS_INVALID) ||
+	    ((image->entry_pos & ~PAGE_MASK) == LAST_KIMAGE_ENTRY)) {
+		unsigned long ind_addr;
 		struct page *page;
 
-		page = kimage_alloc_page(image, GFP_KERNEL, KIMAGE_NO_DEST);
+		page = kimage_alloc_page(image, KIMAGE_NO_DEST);
 		if (!page)
 			return -ENOMEM;
 
-		ind_page = page_address(page);
-		*image->entry = virt_to_boot_phys(ind_page) | IND_INDIRECTION;
-		image->entry = ind_page;
-		image->last_entry = ind_page +
-				      ((PAGE_SIZE/sizeof(kimage_entry_t)) - 1);
+		ind_addr = page_to_boot_pfn(page) << PAGE_SHIFT;
+		kimage_write_entry(image->entry_pos, ind_addr | IND_INDIRECTION);
+
+		clear_highpage(page);
+
+		image->entry_pos = ind_addr;
 	}
-	*image->entry = entry;
-	image->entry++;
-	*image->entry = 0;
+
+	kimage_write_entry(image->entry_pos, entry);
+	image->entry_pos++;
 
 	return 0;
 }
@@ -597,16 +623,14 @@ int __weak machine_kexec_post_load(struct kimage *image)
 
 void kimage_terminate(struct kimage *image)
 {
-	if (*image->entry != 0)
-		image->entry++;
-
-	*image->entry = IND_DONE;
+	kimage_write_entry(image->entry_pos, IND_DONE);
 }
 
-#define for_each_kimage_entry(image, ptr, entry) \
-	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
-		ptr = (entry & IND_INDIRECTION) ? \
-			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
+#define for_each_kimage_entry(image, pos, entry) 				\
+	for (entry = image->head, pos = KIMAGE_ENTRY_POS_INVALID;		\
+	     entry && !(entry & IND_DONE);					\
+	     pos = ((entry & IND_INDIRECTION) ? (entry & PAGE_MASK) : pos + 1), \
+	     entry = kimage_read_entry(pos))
 
 static void kimage_free_entry(kimage_entry_t entry)
 {
@@ -618,8 +642,8 @@ static void kimage_free_entry(kimage_entry_t entry)
 
 void kimage_free(struct kimage *image)
 {
-	kimage_entry_t *ptr, entry;
-	kimage_entry_t ind = 0;
+	kimage_entry_t entry, ind = 0;
+	kimage_entry_pos_t pos;
 
 	if (!image)
 		return;
@@ -630,7 +654,7 @@ void kimage_free(struct kimage *image)
 	}
 
 	kimage_free_extra_pages(image);
-	for_each_kimage_entry(image, ptr, entry) {
+	for_each_kimage_entry(image, pos, entry) {
 		if (entry & IND_INDIRECTION) {
 			/* Free the previous indirection page */
 			if (ind & IND_INDIRECTION)
@@ -662,27 +686,27 @@ void kimage_free(struct kimage *image)
 	kfree(image);
 }
 
-static kimage_entry_t *kimage_dst_used(struct kimage *image,
-					unsigned long page)
+static kimage_entry_pos_t kimage_dst_used(struct kimage *image,
+					  unsigned long page)
 {
-	kimage_entry_t *ptr, entry;
 	unsigned long destination = 0;
+	kimage_entry_pos_t pos;
+	kimage_entry_t entry;
 
-	for_each_kimage_entry(image, ptr, entry) {
+	for_each_kimage_entry(image, pos, entry) {
 		if (entry & IND_DESTINATION)
 			destination = entry & PAGE_MASK;
 		else if (entry & IND_SOURCE) {
 			if (page == destination)
-				return ptr;
+				return pos;
 			destination += PAGE_SIZE;
 		}
 	}
 
-	return NULL;
+	return KIMAGE_ENTRY_POS_INVALID;
 }
 
 static struct page *kimage_alloc_page(struct kimage *image,
-					gfp_t gfp_mask,
 					unsigned long destination)
 {
 	/*
@@ -719,10 +743,10 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	}
 	page = NULL;
 	while (1) {
-		kimage_entry_t *old;
+		kimage_entry_pos_t pos;
 
 		/* Allocate a page, if we run out of memory give up */
-		page = kimage_alloc_pages(gfp_mask, 0);
+		page = kimage_alloc_pages(GFP_HIGHUSER, 0);
 		if (!page)
 			return NULL;
 		/* If the page cannot be used file it away */
@@ -747,26 +771,23 @@ static struct page *kimage_alloc_page(struct kimage *image,
 		 * See if there is already a source page for this
 		 * destination page.  And if so swap the source pages.
 		 */
-		old = kimage_dst_used(image, addr);
-		if (old) {
+		pos = kimage_dst_used(image, addr);
+		if (pos != KIMAGE_ENTRY_POS_INVALID) {
 			/* If so move it */
+			kimage_entry_t old, replacement;
 			unsigned long old_addr;
 			struct page *old_page;
 
-			old_addr = *old & PAGE_MASK;
+			old = kimage_read_entry(pos);
+			old_addr = old & PAGE_MASK;
 			old_page = boot_pfn_to_page(old_addr >> PAGE_SHIFT);
 			copy_highpage(page, old_page);
-			*old = addr | (*old & ~PAGE_MASK);
+			replacement = addr | (old & ~PAGE_MASK);
+			kimage_write_entry(pos, replacement);
 
 			/* The old page I have found cannot be a
-			 * destination page, so return it if it's
-			 * gfp_flags honor the ones passed in.
+			 * destination page, so return it.
 			 */
-			if (!(gfp_mask & __GFP_HIGHMEM) &&
-			    PageHighMem(old_page)) {
-				kimage_free_pages(old_page);
-				continue;
-			}
 			addr = old_addr;
 			page = old_page;
 			break;
@@ -805,7 +826,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 		char *ptr;
 		size_t uchunk, mchunk;
 
-		page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
+		page = kimage_alloc_page(image, maddr);
 		if (!page) {
 			result  = -ENOMEM;
 			goto out;
-- 
2.25.0

