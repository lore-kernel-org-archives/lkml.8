Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338BC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CB322243
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LCr+mWdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgDQOms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:42:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F82C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:42:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so1997127lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zzlLXAatli3mHj6DMIEtFuYqtKXabAt7os3nPavE+lU=;
        b=LCr+mWdQ/dVHOI5NqEalEd8z6Ot/NTyadgBYw3nZjMRozmx65UwadBF+DK2nwk+9x1
         kCHRnR8hB+ECfKe9YYNUpwKH9h7MGVNKexV19ZlEfSQqwiJZ6VyaHiRJEy+UAAGQT3/t
         ojK6tJEZacvRgY8rJWFN2+dorZ0U8BFw95EPomY1PwYoGBjkzAP7oQw/CVx1f7zvVnKG
         JBxT7EpOB99eaqpZB4trFPGwh/lkdGnIhUAamWgmXSOvv3GP2kjdxUhJ+bvgQPtHOocF
         eHPcVh67J1EKfWcqj5kBdRrXkS1+7nB3jDTF9ZLMM5rw/kXVBE9fsX8V6OS+/ajhj+xa
         0dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zzlLXAatli3mHj6DMIEtFuYqtKXabAt7os3nPavE+lU=;
        b=ka25QmwMgimyo42IoqlXmAFOPELjhSCchzoyXkjzdyehe82n1xipvlDikog+itqbVu
         rQbUbhVFlYszip5X5jMTLTyIV/LJo1s6eI0n4v45g376KLPNnjDH3OsfOHt2q+A7SndL
         Rr8G0w3eqNTEWh72m3cZe2viP8o/eanOAvtciFM3YnpzFWsm3sS9PkbQAWyjcWwKIpz4
         DkMEUCL/0orJYU+f5AKziY8DUEMNduk3NPFUqiLLeOXqLSe1Z+khpFUwidcvwlwUoAgs
         +U2tfHvT7Le0fQRpif90BCoCAyHoGYpjRYrPUEYlXxN3LfwBI14lrN+nHjSpZkCq5Lw5
         63/A==
X-Gm-Message-State: AGi0PuaNoG8QEcC+JvEyFZhJhCI06jGfSUd/i/Omblk9uOb6PaX7GQ81
        qsnSk8SKSeXprMtdfisUMGg46g==
X-Google-Smtp-Source: APiQypK79uAhwZLTWtXqd74b2iExou05FnIoSTmiRJaC0DebUFBT3Yq2Y4dIKobULvvgZiUBDEG6uw==
X-Received: by 2002:a19:5510:: with SMTP id n16mr2359055lfe.58.1587134565418;
        Fri, 17 Apr 2020 07:42:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p23sm17790596lfc.95.2020.04.17.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 07:42:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1B1B3100AEA; Fri, 17 Apr 2020 17:42:44 +0300 (+03)
Date:   Fri, 17 Apr 2020 17:42:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200417144244.gdoblao656l6ktkr@box>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
 <20200417121828.GB20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417121828.GB20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:18:28PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2020 at 12:32:29AM +0300, Kirill A. Shutemov wrote:
> > Change of attributes of the pages may lead to fragmentation of direct
> > mapping over time and performance degradation as result.
> > 
> > With current code it's one way road: kernel tries to avoid splitting
> > large pages, but it doesn't restore them back even if page attributes
> > got compatible again.
> > 
> > Any change to the mapping may potentially allow to restore large page.
> > 
> > Hook up into cpa_flush() path to check if there's any pages to be
> > recovered in PUD_SIZE range around pages we've just touched.
> 
> What does this do to the cost of the various set_memory_*() calls? ISTR
> there were performance concerns at some point, graphics drivers doing
> lots of it, or something like that.

Okay, I'll come up with some numbers.

> > CPUs don't like[1] to have to have TLB entries of different size for the
> > same memory, but looks like it's okay as long as these entries have
> > matching attributes[2]. Therefore it's critical to flush TLB before any
> > following changes to the mapping.
> > 
> > Note that we already allow for multiple TLB entries of different sizes
> > for the same memory now in split_large_page() path. It's not a new
> > situation.
> > 
> > set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> > not remap such pages as large. Re-use one of software PTE bits to
> > indicate such pages.
> > 
> > [1] See Erratum 383 of AMD Family 10h Processors
> > [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> 
> Also, we can revert:
> 
>   7af0145067bc ("x86/mm/cpa: Prevent large page split when ftrace flips RW on kernel text")
> 
> now. ftrace no longer does crazy things like that.

Yeah, good point.

> > @@ -344,22 +344,56 @@ static void __cpa_flush_tlb(void *data)
> >  		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
> >  }
> >  
> > +static void restore_large_pages(unsigned long addr, struct list_head *pgtables);
> > +
> > +static void cpa_restore_large_pages(struct cpa_data *cpa,
> > +		struct list_head *pgtables)
> 
> indent fail

Do you mean that it is not aligned to '(' on the previous line?

Okay, I'll fix it up (and change my vim setup). But I find indenting with
spaces disgusting.

> > +{
> > +	unsigned long start, addr, end;
> > +	int i;
> > +
> > +	if (cpa->flags & CPA_PAGES_ARRAY) {
> > +		for (i = 0; i < cpa->numpages; i++)
> > +			restore_large_pages(__cpa_addr(cpa, i), pgtables);
> > +		return;
> > +	}
> > +
> > +	start = __cpa_addr(cpa, 0);
> > +	end = start + PAGE_SIZE * cpa->numpages;
> > +
> > +	for (addr = start; addr >= start && addr < end; addr += PUD_SIZE)
> 
> we have within()

Neat. Thanks.
> 
> > +		restore_large_pages(addr, pgtables);
> > +}
> > +
> >  static void cpa_flush(struct cpa_data *data, int cache)
> >  {
> > +	LIST_HEAD(pgtables);
> > +	struct page *page, *tmp;
> 
> xmas fail

Emm. What are rules here?

> >  	struct cpa_data *cpa = data;
> >  	unsigned int i;
> >  
> >  	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
> >  
> > +	cpa_restore_large_pages(data, &pgtables);
> > +
> >  	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
> >  		cpa_flush_all(cache);
> > +		list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> > +			list_del(&page->lru);
> > +			__free_page(page);
> > +		}
> >  		return;
> >  	}
> >  
> > -	if (cpa->numpages <= tlb_single_page_flush_ceiling)
> > -		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> > -	else
> > +	if (cpa->numpages > tlb_single_page_flush_ceiling || !list_empty(&pgtables))
> >  		flush_tlb_all();
> > +	else
> > +		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> > +
> > +	list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> > +		list_del(&page->lru);
> > +		__free_page(page);
> > +	}
> >  
> >  	if (!cache)
> >  		return;
> 
> That's a bit of a mess there, I'm thinking you can fix that with a goto.

Will look into this.

> > +	/* Check that the rest of PTEs are compatible with the first one */
> > +	for (i = 1, pte++; i < PTRS_PER_PTE; i++, pte++) {
> > +		pte_t entry = *pte;
> > +		if (!pte_present(entry))
> > +			return;
> > +		if (pte_flags(entry) != pte_flags(first))
> > +			return;
> > +		if (pte_pfn(entry) - pte_pfn(first) != i)
> 
> I think I'd perfer: pte_pfn(entry) != pte_pfn(first) + i

Sure.

> > +	pr_debug("2M restored at %#lx\n", addr);
> 
> While I appreciate it's usefulness while writing this, I do think we can
> do without that print once we know it works.

Even with pr_debug()? I shouldn't be noisy for most users.

> > +/*
> > + * Restore PMD and PUD pages in the kernel mapping around the address where
> > + * possible.
> > + *
> > + * Caller must flush TLB and free page tables queued on the list before
> > + * touching the new entries. CPU must not see TLB entries of different size
> > + * with different attributes.
> > + */
> > +static void restore_large_pages(unsigned long addr, struct list_head *pgtables)
> > +{
> > +	pgd_t *pgd;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +
> > +	addr &= PUD_MASK;
> > +
> > +	spin_lock(&pgd_lock);
> > +	pgd = pgd_offset_k(addr);
> > +	if (pgd_none(*pgd))
> > +		goto out;
> > +	p4d = p4d_offset(pgd, addr);
> > +	if (p4d_none(*p4d))
> > +		goto out;
> > +	pud = pud_offset(p4d, addr);
> > +	if (!pud_present(*pud) || pud_large(*pud))
> > +		goto out;
> > +
> > +	restore_pud_page(pud, addr, pgtables);
> > +out:
> > +	spin_unlock(&pgd_lock);
> > +}
> 
> I find this odd, at best. AFAICT this does not attempt to reconstruct a
> PMD around @addr when possible. When the first PMD of the PUD can't be
> reconstructed, we give up entirely.

No, you misread. If the first PMD is not suitable, we give up
reconstructing PUD page, but we still look at all PMD of the PUD range.

But this might be excessive. What you are proposing below should be fine
and more efficient. If we do everything right the rest of PMDs in the PUD
have to already large or not suitable for reconstructing.

We might still look at the rest of PMDs for CONFIG_CPA_DEBUG, just to make
sure we don't miss some corner case where we didn't restore a PMD.

(Also I think about s/restore/reconstruct/g)

> Why not something like:
> 
> static void restore_large_pages(unsigned long addr, struct list_head *pgtables)
> {
> 	pgd_t *pgd;
> 	p4d_t *p4d;
> 	pud_t *pud;
> 	pmd_t *pmd;
> 
> 	spin_lock(&pgd_lock);
> 	pgd = pgd_offset_k(addr);
> 	if (pgd_none(*pgd))
> 		goto out;
> 
> 	p4d = p4d_offset(pgd, addr);
> 	if (p4d_none(*p4d))
> 		goto out;
> 
> 	pud = pud_offset(p4d, addr);
> 	if (!pud_present(*pud) || pud_large(*pud))
> 		goto out;
> 
> 	pmd = pmd_offset(pud, addr);
> 	if (pmd_present(*pmd) && !pmd_large(*pmd)) {
> 		if (!restore_pmd_page(pmd, addr & PMD_MASK, pgtables))
> 			goto out;
> 	}
> 		
> 	restore_pud_page(pud, addr & PUD_MASK, pgtables);
> out:
> 	spin_unlock(&pgd_lock);
> }
> 
> That would also much simplify restore_pud_page(), it would not have to
> call restore_pmd_page().

-- 
 Kirill A. Shutemov
