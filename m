Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1237C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRDummkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgHJTPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:15:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29624 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730193AbgHJTP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597086925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmksXXp5eCW0myWZx4ZNrRKTFmCFpYt8CMr0iTWeX5I=;
        b=SRDummkLuDhspimq7ouwrW0Sy0BTEeH68SHdpCsY+o6BYHEMKAmh2qKIM/XUqx02RgCPnu
        O+b0d8Crswp6tOZJijuaQ6bzMXuQ1IdejBDo4poC4G+TmzEhdwKN0tiI7OGQrkl99qex2u
        X+6OFew84tQb0Y9Mg3RjwFG86ag+7Uc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-9u8V56LmOpqAxmVncbPlsg-1; Mon, 10 Aug 2020 15:15:23 -0400
X-MC-Unique: 9u8V56LmOpqAxmVncbPlsg-1
Received: by mail-qt1-f198.google.com with SMTP id g10so8151543qtr.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MmksXXp5eCW0myWZx4ZNrRKTFmCFpYt8CMr0iTWeX5I=;
        b=HQOz2RWHNW3FO53gIXUikkNq/HPLuy7FKYNkq3QH6PJy7R22DONPnTxudMvGuTI/MI
         mG1DTMTzKpCm05cAcgZGNMgYLuwGj+U5AiuEFOdbsrl8UEckswN6zHwhl4Dd/CWwNo1/
         q3WoAjE2dBJtb4zSBkaRemxNBXpyU73HDwezR3WNDla2IcxkpgPvhYNkorfTCGN+/d1U
         MAFu3kShzXD67dZhdztOtbkTAQ+ERgkkuOsZoklLxxCD6f7JtEK/g4+Bwp5+40AL0ezG
         SwFdXsFxhEtu+EOn8wgJFbj9B9XuGiI1de+9hn9kZi46zzV/7gbY2lhMSa/BNa+rYFpp
         n1fQ==
X-Gm-Message-State: AOAM531qj/z6PST0j9UzpTApKk0GY7O95MV3j2m6h+IOJOjwe89FIjy8
        JyWL4zbn6aUXnGIvffD+tgk0l8vwIha1j+FWfGnNn347Xf5wz/K5XyTuMHeY+1YsiVM1Bj5nyC8
        zji9jTk3BgMUycTwEWR/a0gm5
X-Received: by 2002:a37:a584:: with SMTP id o126mr27242704qke.170.1597086922979;
        Mon, 10 Aug 2020 12:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3cCm0ieLQq2jYxdMc6QUgOPFPAwZUGHsvifB/GG9q+xqtx+vY4O3L09oISz1FLZOVnDFCiA==
X-Received: by 2002:a37:a584:: with SMTP id o126mr27242659qke.170.1597086922526;
        Mon, 10 Aug 2020 12:15:22 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id x50sm10704960qtb.10.2020.08.10.12.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:15:21 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:15:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200810191520.GA132381@xz-x1>
References: <20200810145701.129228-1-peterx@redhat.com>
 <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 09:47:22AM -0700, Linus Torvalds wrote:
> On Mon, Aug 10, 2020 at 7:57 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > One solution is actually already mentioned in commit 17839856fd58, which is to
> > provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
> > use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
> > "enfornced COW (read) request".
> 
> I think the patch is fine, but during discussions we also discussed
> having the flag the other way around, in order to have the default be
> "break COW", and the use cases that explicitly know they can handle
> the ambiguity would have to say so explicitly with a "don't break COW"
> bit.
> 
> I don't think this matters in theory, but in practice I think it would
> be a good thing as documentation.
> 
> Because FAULT_FLAG_BREAK_COW doesn't really tell you anything:
> breaking COW is "always safe".
> 
> In contrast, a "FAULT_FLAG_DONT_COW" bit could be accompanied with a
> note like "I don't care which side I get - I'm not going to keep track
> of the page, I just want random data, and it's ok if I get it from
> another forked process".

My previous understanding was that although COW is always safe, we should still
avoid it when unnecessary because it's still expensive.  Currently we will do
enforced COW only if should_force_cow_break() returns true, which seems to be a
good justification of when to ask for the enforcement.

> 
> In fact, maybe it shouldn't be called "DONT_COW", but more along the
> lines of those semantics of "READ_WRONG_SIDE_COW_OK", so that people
> who use the bit have to _think_ about it.
> 
> I think comments in general should be there.

How about squashing below comments into the patch?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eab4b833680e..09a2dde93b4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -409,7 +409,8 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
- * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read)
+ * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
+ *                        Please read FOLL_BREAK_COW for more information.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -2807,7 +2808,11 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD 0x20000 /* split huge pmd before returning */
 #define FOLL_PIN       0x40000 /* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY 0x80000 /* gup_fast: prevent fall-back to slow gup */
-#define FOLL_BREAK_COW  0x100000 /* request for explicit COW (even for read) */
+/*
+ * request for explicit COW (even for read).  Normally COW is always safe for
+ * gup, but we don't always pass it to avoid unnecessary COW.
+ */
+#define FOLL_BREAK_COW  0x100000

> 
> Looking at your patch, for example, I go "Hmm" when I see this part:
> 
> -       if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> +       if ((vmf->flags & FAULT_FLAG_WRITE) &&
> +           userfaultfd_pte_wp(vma, *vmf->pte)) {
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>                 return handle_userfault(vmf, VM_UFFD_WP);
>         }
> 
> and I go "ok, for reads with COW breaking, we'll just silently break
> the COW and not do VM_UFFD_WP?"
> 
> An explanation of why that is the right thing to do would be good. And
> no, I don't mean "UFFD doesn't want a WP fault in this case". I mean
> literally why "we do want the silent COW, but UFFD doesn't care about
> it".

Userfaultfd-wp should not care about this because it's not a write operation,
so we don't need to capture it.  We should only trigger uffd-wp when the COWed
page got written later again either by a real write gup or a write #pf.

This is a good question anyway...  Because I totally forgot to check the other
part of the COW logic to keep the UFFD_WP bit properly during COW.  Without
that extra change in wp_page_copy() we could potentially lose uffd-wp bit when
there's enforced COW on read-only gups.

Moreover, I definitely missed some special handling for huge pages too here and
there.  As a summary of above...

> 
> End result: I think the patch is fine, but the reason we had
> discussion about it and the reason it wasn't done initially was that
> you get all these kinds of subtle behavior differences, and I think
> they need clarifying.

... I think I'll squash these into v2:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eab4b833680e..09a2dde93b4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -409,7 +409,8 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
- * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read)
+ * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
+ *                        Please read FOLL_BREAK_COW for more information.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -2807,7 +2808,11 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD 0x20000 /* split huge pmd before returning */
 #define FOLL_PIN       0x40000 /* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY 0x80000 /* gup_fast: prevent fall-back to slow gup */
-#define FOLL_BREAK_COW  0x100000 /* request for explicit COW (even for read) */
+/*
+ * request for explicit COW (even for read).  Normally COW is always safe for
+ * gup, but we don't always pass it to avoid unnecessary COW.
+ */
+#define FOLL_BREAK_COW  0x100000

 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..9d4d308811a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1296,7 +1296,17 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
        if (reuse_swap_page(page, NULL)) {
                pmd_t entry;
                entry = pmd_mkyoung(orig_pmd);
-               entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+               entry = pmd_mkdirty(entry);
+               if (pmd_uffd_wp(orig_pmd))
+                       /*
+                        * This can happen when an uffd-wp protected page is
+                        * copied due to enfornced COW.  When it happens, we
+                        * need to keep the uffd-wp bit even after COW, and
+                        * make sure write bit is kept cleared.
+                        */
+                       entry = pmd_mkuffd_wp(pmd_wrprotect(entry));
+               else
+                       entry = maybe_pmd_mkwrite(entry, vma);
                if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
                        update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
                unlock_page(page);
diff --git a/mm/memory.c b/mm/memory.c
index f11c87bfc60e..2ed1b68b2323 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2703,7 +2703,17 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
                flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
                entry = mk_pte(new_page, vma->vm_page_prot);
                entry = pte_sw_mkyoung(entry);
-               entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+               entry = pte_mkdirty(entry);
+               if (pte_uffd_wp(vmf->orig_pte))
+                       /*
+                        * This can happen when an uffd-wp protected page is
+                        * copied due to enfornced COW.  When it happens, we
+                        * need to keep the uffd-wp bit even after COW, and
+                        * make sure write bit is kept cleared.
+                        */
+                       entry = pte_mkuffd_wp(pte_wrprotect(entry));
+               else
+                       entry = maybe_mkwrite(entry, vma);
                /*
                 * Clear the pte entry and flush it first, before updating the
                 * pte with the new entry. This will avoid a race condition
@@ -4115,7 +4125,8 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
        if (vma_is_anonymous(vmf->vma)) {
-               if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
+               if ((vmf->flags & FAULT_FLAG_WRITE) &&
+                   userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
                        return handle_userfault(vmf, VM_UFFD_WP);
                return do_huge_pmd_wp_page(vmf, orig_pmd);
        }
@@ -4279,7 +4290,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
                .pgoff = linear_page_index(vma, address),
                .gfp_mask = __get_fault_gfp_mask(vma),
        };
-       unsigned int dirty = flags & FAULT_FLAG_WRITE;
+       bool cow = flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW);
        struct mm_struct *mm = vma->vm_mm;
        pgd_t *pgd;
        p4d_t *p4d;
@@ -4306,7 +4317,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,

                        /* NUMA case for anonymous PUDs would go here */

-                       if (dirty && !pud_write(orig_pud)) {
+                       if (cow && !pud_write(orig_pud)) {
                                ret = wp_huge_pud(&vmf, orig_pud);
                                if (!(ret & VM_FAULT_FALLBACK))
                                        return ret;
@@ -4344,7 +4355,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
                        if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
                                return do_huge_pmd_numa_page(&vmf, orig_pmd);

-                       if (dirty && !pmd_write(orig_pmd)) {
+                       if (cow && !pmd_write(orig_pmd)) {
                                ret = wp_huge_pmd(&vmf, orig_pmd);
                                if (!(ret & VM_FAULT_FALLBACK))
                                        return ret;

Thanks,

-- 
Peter Xu

