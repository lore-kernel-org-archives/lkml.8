Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D717BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23FD2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="q2lvQsmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbgEYPIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391007AbgEYPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:08:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F2C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:08:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so10685113lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oa2iGHMAfwR8yBdp/XdAPTpWebtgJxw2RoUWqbe8bLg=;
        b=q2lvQsmoQQujPEHo7xoKsvGH5W/B15C+C63rbPm0NBNFHj0FiG480gpP3b8c5a7jgq
         H+kdR6YAD+eyEX71cEQRYbFSedvPyLCqiBUFhJ9ROZKSgAvtqMj8V8C+XheAcMWvNLjg
         QpuWKX+tP8HInk85s0ZEsm+Q8NQaqsJ4DM19/p7IoWWAaoE6fXsRiKR4ZlPrsf0FsIwN
         b2DF9BrfaNJcBuTALRA9o6nFG7+k1B9+/CHHu3rbJMePmEmYoA/Fc5KRcyiakGhyK4vD
         HtoTe6KC7M0njQhOmiylLRYeCNJbNpuo5Rtt4PL1B+lCIo1wrfcLU3fiK1NmU53OWuGO
         VJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oa2iGHMAfwR8yBdp/XdAPTpWebtgJxw2RoUWqbe8bLg=;
        b=dArX6u7F+orYAsEIL6/wM/PMEscOX5GHxoSaQAFLLgoXc4QpLDFbU59JBOoCoYErK/
         lsYPBgEfQgRQvhDQ0Xg/aeFRjVCMhdE/ZJC/xueozqSsRiE5aX4zut3Ib9VKEBmdi+3G
         QuZoH5latoVo7ahKTLa6NCCbEdY/cGUyMZ84khNYVOA1mVmOwXu7tK3yLaAzvb5wwnQl
         SZY6Z4PokDdohw/CWmlQh/F+TY8REovlX72QCNRSuqkNgpORyeO/N+xYHPFH7/keCmq6
         Vd3GwbzoogOMWI65DAxGAgVQrvJausZjkXNE7aS8hiI2t80X0PYJUaFi4Da0pghT9YV1
         nW0w==
X-Gm-Message-State: AOAM532Np3QycpeyEmy9KmgSxIGYfTNXx/R3zp0UQiij50iBvULeSROC
        BhHojU6pKW36EUug1UZWz7fvnA==
X-Google-Smtp-Source: ABdhPJzl3CHKt/IVkC1I09fLdBhLG2emqpOWbecBUM+bsE27qDprYmCVYlpPZXMAT5ZNFQqc8mi27g==
X-Received: by 2002:a19:f119:: with SMTP id p25mr13963860lfh.99.1590419299778;
        Mon, 25 May 2020 08:08:19 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m26sm3838702ljb.129.2020.05.25.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:08:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 52E1D10230F; Mon, 25 May 2020 18:08:20 +0300 (+03)
Date:   Mon, 25 May 2020 18:08:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20200525150820.zljiamptpzi37ohx@box>
References: <20200511191721.1416-1-kirill.shutemov@linux.intel.com>
 <20200525044902.rsb46bxu5hdsqglt@box>
 <20200525145943.GA13247@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525145943.GA13247@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:59:43PM +0300, Mike Rapoport wrote:
> On Mon, May 25, 2020 at 07:49:02AM +0300, Kirill A. Shutemov wrote:
> > On Mon, May 11, 2020 at 10:17:21PM +0300, Kirill A. Shutemov wrote:
> > > A 5-level paging capable machine can have memory above 46-bit in the
> > > physical address space. This memory is only addressable in the 5-level
> > > paging mode: we don't have enough virtual address space to create direct
> > > mapping for such memory in the 4-level paging mode.
> > > 
> > > Currently, we fail boot completely: NULL pointer dereference in
> > > subsection_map_init().
> > > 
> > > Skip creating a memblock for such memory instead and notify user that
> > > some memory is not addressable.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> > > Cc: stable@vger.kernel.org # v4.14
> > > ---
> > 
> > Gentle ping.
> > 
> > It's not urgent, but it's a bug fix. Please consider applying.
> > 
> > > Tested with a hacked QEMU: https://gist.github.com/kiryl/d45eb54110944ff95e544972d8bdac1d
> > > 
> > > ---
> > >  arch/x86/kernel/e820.c | 19 +++++++++++++++++--
> > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > > index c5399e80c59c..d320d37d0f95 100644
> > > --- a/arch/x86/kernel/e820.c
> > > +++ b/arch/x86/kernel/e820.c
> > > @@ -1280,8 +1280,8 @@ void __init e820__memory_setup(void)
> > >  
> > >  void __init e820__memblock_setup(void)
> > >  {
> > > +	u64 size, end, not_addressable = 0;
> > >  	int i;
> > > -	u64 end;
> > >  
> > >  	/*
> > >  	 * The bootstrap memblock region count maximum is 128 entries
> > > @@ -1307,7 +1307,22 @@ void __init e820__memblock_setup(void)
> > >  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > >  			continue;
> > >  
> > > -		memblock_add(entry->addr, entry->size);
> > > +		if (entry->addr >= MAXMEM) {
> > > +			not_addressable += entry->size;
> > > +			continue;
> > > +		}
> > > +
> > > +		end = min_t(u64, end, MAXMEM - 1);
> > > +		size = end - entry->addr;
> > > +		not_addressable += entry->size - size;
> > > +		memblock_add(entry->addr, size);
> > > +	}
> > > +
> > > +	if (not_addressable) {
> > > +		pr_err("%lldGB of physical memory is not addressable in the paging mode\n",
> > > +		       not_addressable >> 30);
> > > +		if (!pgtable_l5_enabled())
> > > +			pr_err("Consider enabling 5-level paging\n");
> 
> Could this happen at all when l5 is enabled?
> Does it mean we need kmap() for 64-bit?

It's future-profing. Who knows what paging modes we would have in the
future.

-- 
 Kirill A. Shutemov
