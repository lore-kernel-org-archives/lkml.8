Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854CC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9B9221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rvFBujty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgDQLmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730267AbgDQLmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:42:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F7C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:42:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so1560808lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tp6jVhwi+xRCAGyKQkpoHRosqgSnPogzvYhjJt4/uZE=;
        b=rvFBujtyqcztc6I3rOxAieE/T91xnikLJAEZYM1HMuDrjln5UvdAC3OK/ccGQe9Az4
         zBMLxn5ne4wAWM/GIiGfHITFO8D6t8tqmsMYae57XVdnWDEPwF90bQXocESOoc21qUp5
         sJwVhK/t6c9xTe2VF8k3vB8kGc13f776bS9IQoEvidDBJEY7vUGc6ocnEvPOmW1yihOt
         MZyy/mEWa6mQi5pbQ/xah35Qh504R1uRBQlVa0jgHidGe2GzUZpmK4ufD8GDHt4vHmRc
         R9ZJh3gQvaxD8hlzr301b/6PZrsYf7NSls09/PaOdSq2mAUd/3T+mxSJvsKrW9dkdujQ
         wxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tp6jVhwi+xRCAGyKQkpoHRosqgSnPogzvYhjJt4/uZE=;
        b=pM/jzHNVPxeZ3Rr0zqUiGgl3o/5X5ja6LCeAu3fqpSIVvsHJzYKtTwtbuHw1W1C16W
         44OMK274Xlh50HoFyVEWOBwfMVAiOas3PZnud6zq3OxtlVkGC5Jwvi+LwawW5+tfdvm3
         EEFfNyhsIJxcgSbc5rpyFhiMoAcgxsYECbJHdEwkX2Fmg2U5+CF3eQX6q6PDP9MPxBBI
         +8bFQcuJ9vQpyh8H9GEgL3psTMyEWhzOhWFlzBG3OnuhlHDQT3i/TMqx8hsao1xflDzs
         1Qqewd9wYUmucGeSmfgq3kxD7baPFrSEc2995gM9q8Ps6bwe+64jexpX98Rli7lc7oKp
         jNOQ==
X-Gm-Message-State: AGi0PubafF9KG/n1tCrQM2My5ahUxWMsDSKfV542hf/uGv5l4PTz2CMZ
        nhFw6r5pxyr8Q+OwaRCaxlfn3A==
X-Google-Smtp-Source: APiQypJJ28kAO1Ab7ojaXJiiWF1P3Ah9Zc8rkUHQ6LYqq91T95IqAfLNAgdfFJHv9z1A1Cs8WCOqWw==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr1823053lfl.125.1587123772999;
        Fri, 17 Apr 2020 04:42:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p23sm17457710lfc.95.2020.04.17.04.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 04:42:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D62CF100AEA; Fri, 17 Apr 2020 14:42:51 +0300 (+03)
Date:   Fri, 17 Apr 2020 14:42:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200417114251.oy22udm3b2as32t5@box>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
 <0a28e6e8-3f18-0bbb-a4d0-ee88060f7e90@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a28e6e8-3f18-0bbb-a4d0-ee88060f7e90@nextfour.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:52:28AM +0300, Mika Penttilä wrote:
> Hi!
> 
> On 17.4.2020 0.32, Kirill A. Shutemov wrote:
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
> > 
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
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/include/asm/pgtable_types.h |   2 +
> >   arch/x86/mm/pat/set_memory.c         | 191 ++++++++++++++++++++++++++-
> >   2 files changed, 188 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index b6606fe6cfdf..11ed34804343 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -34,6 +34,7 @@
> >   #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
> >   #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
> >   #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
> > +#define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
> >   #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
> >   /* If _PAGE_BIT_PRESENT is clear, we use these: */
> > @@ -56,6 +57,7 @@
> >   #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
> >   #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
> >   #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
> > +#define _PAGE_KERNEL_4K	(_AT(pteval_t, 1) << _PAGE_BIT_KERNEL_4K)
> >   #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> >   #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
> >   #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 5414fabad1ae..7cb04a436d86 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -344,22 +344,56 @@ static void __cpa_flush_tlb(void *data)
> >   		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
> >   }
> > +static void restore_large_pages(unsigned long addr, struct list_head *pgtables);
> > +
> > +static void cpa_restore_large_pages(struct cpa_data *cpa,
> > +		struct list_head *pgtables)
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
> > +		restore_large_pages(addr, pgtables);
> > +}
> > +
> >   static void cpa_flush(struct cpa_data *data, int cache)
> >   {
> > +	LIST_HEAD(pgtables);
> > +	struct page *page, *tmp;
> >   	struct cpa_data *cpa = data;
> >   	unsigned int i;
> >   	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
> > +	cpa_restore_large_pages(data, &pgtables);
> > +
> >   	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
> >   		cpa_flush_all(cache);
> > +		list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> > +			list_del(&page->lru);
> > +			__free_page(page);
> > +		}
> >   		return;
> >   	}
> > -	if (cpa->numpages <= tlb_single_page_flush_ceiling)
> > -		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> > -	else
> > +	if (cpa->numpages > tlb_single_page_flush_ceiling || !list_empty(&pgtables))
> >   		flush_tlb_all();
> > +	else
> > +		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> > +
> > +	list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> > +		list_del(&page->lru);
> > +		__free_page(page);
> > +	}
> 
> 
> The pagetable pages are freed here but ren't you leaking the leaf 4K pages
> (except the first which is made large)?

Huh? There's no way to convert one 4k to large page. We convert all pages
in large page region to the large page.

-- 
 Kirill A. Shutemov
