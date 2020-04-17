Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43712C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EED62223D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4nMi2cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgDQPRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728931AbgDQPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:17:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793CBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lDhK24/3VfMY+kaIKaOjzCIhlyuFHST/ho68SD7snQ4=; b=I4nMi2cz9vD+aV9R4LkIJuiyyW
        HZQkqN3UKAw9RWzDtH5u3Ksl86EGd9EqP2L/mU8oEOEHOTC4m4SwRH9mkrKybaux+WMCT7n0khmL9
        bR7HFGigMgvpVEHNtxa8E5zRAoGCZ7+zRgwewuGPRK5N8IBv9RD7Gnd6j05DqknyHbUkeSLixK9sH
        Psqd2rE5OAdGC2TnVXiJMIBAkvik0DkkGSav1/PNV+3GWdDWUtW6xW5e67XNlqotENImc52uvlC9e
        oP6Y8F186H/iDJEjJJwiLL4fWommmEvBpy4asKsvP/jHxvBurrZk8hmsA66g4pT55lRrLvl+JTS+5
        dQsDuV6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPSju-0002rs-Bp; Fri, 17 Apr 2020 15:17:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B025C3015D0;
        Fri, 17 Apr 2020 17:17:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AC622B121814; Fri, 17 Apr 2020 17:17:07 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:17:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200417151707.GG20730@hirez.programming.kicks-ass.net>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
 <20200417121828.GB20730@hirez.programming.kicks-ass.net>
 <20200417144244.gdoblao656l6ktkr@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417144244.gdoblao656l6ktkr@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:42:44PM +0300, Kirill A. Shutemov wrote:
> On Fri, Apr 17, 2020 at 02:18:28PM +0200, Peter Zijlstra wrote:
> Do you mean that it is not aligned to '(' on the previous line?
> 
> Okay, I'll fix it up (and change my vim setup). But I find indenting with
> spaces disgusting.

set cino=:0(0


> > >  static void cpa_flush(struct cpa_data *data, int cache)
> > >  {
> > > +	LIST_HEAD(pgtables);
> > > +	struct page *page, *tmp;
> > 
> > xmas fail
> 
> Emm. What are rules here?
> 
> > >  	struct cpa_data *cpa = data;
> > >  	unsigned int i;

Basically we (tip) strive for the inverse xmas tree thing, so here that
would be:

	struct cpa_data *cpa = data;
+	struct page *page, *tmp;
+	LIST_HEAD(pgtables);
	unsigned int i;


> > > +	pr_debug("2M restored at %#lx\n", addr);
> > 
> > While I appreciate it's usefulness while writing this, I do think we can
> > do without that print once we know it works.
> 
> Even with pr_debug()? I shouldn't be noisy for most users.

I always have debug on; also there is no counterpart on split either.

> > > +/*
> > > + * Restore PMD and PUD pages in the kernel mapping around the address where
> > > + * possible.
> > > + *
> > > + * Caller must flush TLB and free page tables queued on the list before
> > > + * touching the new entries. CPU must not see TLB entries of different size
> > > + * with different attributes.
> > > + */
> > > +static void restore_large_pages(unsigned long addr, struct list_head *pgtables)
> > > +{
> > > +	pgd_t *pgd;
> > > +	p4d_t *p4d;
> > > +	pud_t *pud;
> > > +
> > > +	addr &= PUD_MASK;
> > > +
> > > +	spin_lock(&pgd_lock);
> > > +	pgd = pgd_offset_k(addr);
> > > +	if (pgd_none(*pgd))
> > > +		goto out;
> > > +	p4d = p4d_offset(pgd, addr);
> > > +	if (p4d_none(*p4d))
> > > +		goto out;
> > > +	pud = pud_offset(p4d, addr);
> > > +	if (!pud_present(*pud) || pud_large(*pud))
> > > +		goto out;
> > > +
> > > +	restore_pud_page(pud, addr, pgtables);
> > > +out:
> > > +	spin_unlock(&pgd_lock);
> > > +}
> > 
> > I find this odd, at best. AFAICT this does not attempt to reconstruct a
> > PMD around @addr when possible. When the first PMD of the PUD can't be
> > reconstructed, we give up entirely.
> 
> No, you misread. If the first PMD is not suitable, we give up
> reconstructing PUD page, but we still look at all PMD of the PUD range.

Aah, indeed. I got my brain in a twist reading that pud function.

> But this might be excessive. What you are proposing below should be fine
> and more efficient. If we do everything right the rest of PMDs in the PUD
> have to already large or not suitable for reconstructing.

Just so.

> We might still look at the rest of PMDs for CONFIG_CPA_DEBUG, just to make
> sure we don't miss some corner case where we didn't restore a PMD.
> 
> (Also I think about s/restore/reconstruct/g)

Right, and WARN if they do succeed collapsing ;-)
