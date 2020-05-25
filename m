Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44AE20888
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590418792;
	bh=za8M6SYG37f2r37jOzhfcSQ14wRR2UBQzu9O+z/iF3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=spsFBekr5M5mW6w/icYMJleKdYxgkEd8FXvt+vpCol7iIXjAYVJpbbS7wTfzwBKeV
	 gBExdnn5m1TApgBjbj2lHJv6Yd3PWPqnmRT3oEX6sUdohSxqxvWpems6qUSmmXuib4
	 y0qrzvtvCKiAKoerXk1levKwBKWC2pqfecDkFn88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbgEYO7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgEYO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:59:51 -0400
Received: from kernel.org (unknown [87.70.212.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4BB2089D;
        Mon, 25 May 2020 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590418791;
        bh=za8M6SYG37f2r37jOzhfcSQ14wRR2UBQzu9O+z/iF3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVnarHtGSdY0+zxYOzF0lj+8bKzmEla+wxb3nHJ6RoFi7u4Aw2sZFXkYVFlRD6p1m
         pZPPAgthmLLMn6YmtmQABLbY4y5ufNYAVyPuGnLWZYovXxnOf/4VryEYsIIpjxhlp9
         ysUcOF/XEaQT7UcNqnqOLcFaX3JpRanryiU2IBXc=
Date:   Mon, 25 May 2020 17:59:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix boot with some memory above MAXMEM
Message-ID: <20200525145943.GA13247@kernel.org>
References: <20200511191721.1416-1-kirill.shutemov@linux.intel.com>
 <20200525044902.rsb46bxu5hdsqglt@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525044902.rsb46bxu5hdsqglt@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 07:49:02AM +0300, Kirill A. Shutemov wrote:
> On Mon, May 11, 2020 at 10:17:21PM +0300, Kirill A. Shutemov wrote:
> > A 5-level paging capable machine can have memory above 46-bit in the
> > physical address space. This memory is only addressable in the 5-level
> > paging mode: we don't have enough virtual address space to create direct
> > mapping for such memory in the 4-level paging mode.
> > 
> > Currently, we fail boot completely: NULL pointer dereference in
> > subsection_map_init().
> > 
> > Skip creating a memblock for such memory instead and notify user that
> > some memory is not addressable.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> > Cc: stable@vger.kernel.org # v4.14
> > ---
> 
> Gentle ping.
> 
> It's not urgent, but it's a bug fix. Please consider applying.
> 
> > Tested with a hacked QEMU: https://gist.github.com/kiryl/d45eb54110944ff95e544972d8bdac1d
> > 
> > ---
> >  arch/x86/kernel/e820.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index c5399e80c59c..d320d37d0f95 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1280,8 +1280,8 @@ void __init e820__memory_setup(void)
> >  
> >  void __init e820__memblock_setup(void)
> >  {
> > +	u64 size, end, not_addressable = 0;
> >  	int i;
> > -	u64 end;
> >  
> >  	/*
> >  	 * The bootstrap memblock region count maximum is 128 entries
> > @@ -1307,7 +1307,22 @@ void __init e820__memblock_setup(void)
> >  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> >  			continue;
> >  
> > -		memblock_add(entry->addr, entry->size);
> > +		if (entry->addr >= MAXMEM) {
> > +			not_addressable += entry->size;
> > +			continue;
> > +		}
> > +
> > +		end = min_t(u64, end, MAXMEM - 1);
> > +		size = end - entry->addr;
> > +		not_addressable += entry->size - size;
> > +		memblock_add(entry->addr, size);
> > +	}
> > +
> > +	if (not_addressable) {
> > +		pr_err("%lldGB of physical memory is not addressable in the paging mode\n",
> > +		       not_addressable >> 30);
> > +		if (!pgtable_l5_enabled())
> > +			pr_err("Consider enabling 5-level paging\n");

Could this happen at all when l5 is enabled?
Does it mean we need kmap() for 64-bit?

> >  	}
> >  
> >  	/* Throw away partial pages: */
> > -- 
> > 2.26.2
> > 
> > 
> 
> -- 
>  Kirill A. Shutemov
> 

-- 
Sincerely yours,
Mike.
