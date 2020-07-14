Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76724C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563DC22519
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="quO5N6og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGNQIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgGNQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:08:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AEDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:08:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so16053246qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fXf8zgvJD8RyvdGVU6SbrLCxfrnGixneNILyC8ZbGYQ=;
        b=quO5N6ogCCYMCYm0jbm7VGfgMCjMNG3GM9hD87QoYYFvrCvi+38UVqmSgHvpoMIvtp
         MK4ykcB/BoIm3XFsCMscMRa5eaFT+7xKl2rw3pj0xGgGwuSg2KA+KUQ0dVZgVWXhqKjh
         TSWDGLrqQ1V0hHYAbPLbQ37d/oBs3FOrP2lo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fXf8zgvJD8RyvdGVU6SbrLCxfrnGixneNILyC8ZbGYQ=;
        b=DDhRu700kW3hJNr+hcouHiBXeIbnyrdfDrkN533BByVGVp0mwIkqMOz0nEqktBnIq+
         Cyc+pjmJ8tJzryJfkBBaq4fYFBBVyisS46Rq+apdRon3DKz82ttX0o8qXc938vypR4hJ
         jlSlST3eVAXTa9iMX7jtFr5XCBCEPvURBDG3OTrP/ld4u0sks3ClxpexHhn/+dSgaWRx
         WVA0z45VTFPi1P1nDkZu17Azacd/k00w8db2k0zjLKnW956/wrfFOGpUnprJatc6QcBT
         vkUnKEDdf93kH9zkN9MWsur7JS+0pHGxxtC3nfSbObNS2NN+oD9DKyjwzGguimxRgLYY
         HUMw==
X-Gm-Message-State: AOAM530sHwxc9GlPsvfhUAUR4x4Mdie9c4LeJxAPWsyCiAZoNTQ5wbnX
        OpZvDKIcYLfdEprlyAap4RmnSA==
X-Google-Smtp-Source: ABdhPJz9QAcH+YKs1fhtplNEgSvm1zFmMYsJh/XrGm1MUTK4ti2w3rCC8VJsOCnzYlhLv6MJYRwPxw==
X-Received: by 2002:a37:a950:: with SMTP id s77mr5236642qke.171.1594742924543;
        Tue, 14 Jul 2020 09:08:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id m4sm25213289qtf.43.2020.07.14.09.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 09:08:43 -0700 (PDT)
Date:   Tue, 14 Jul 2020 12:08:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
Message-ID: <20200714160843.GA1685150@google.com>
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <20200712215041.GA3644504@google.com>
 <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
 <20200714073306.kq4zikkphqje2yzb@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714073306.kq4zikkphqje2yzb@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Tue, Jul 14, 2020 at 10:33:06AM +0300, Kirill A. Shutemov wrote:
> On Sun, Jul 12, 2020 at 03:58:06PM -0700, Linus Torvalds wrote:
> > Anybody else have any opinions?
> 
> Maybe we just shouldn't allow move_normal_pmd() if ranges overlap?
> 
> Other option: pass 'overlaps' down to move_normal_pmd() and only WARN() if
> see establised PMD without overlaps being true.

I was thinking we should not call move_page_tables() with overlapping ranges
at all, just to keep things simple. I am concerned about other issues such as
if you move a range forward, you will end up overwriting part of the source
range.

Allow me some time to develop a proper patch, I have it on my list. I will
try to get to it this week.

I think we can also add a patch to detect the overlap as you did and warn in
such situation.

Thoughts?

thanks,

 - Joel


> Untested patch:
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5dd572d57ca9..e33fcee541fe 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -245,6 +245,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	unsigned long extent, next, old_end;
>  	struct mmu_notifier_range range;
>  	pmd_t *old_pmd, *new_pmd;
> +	bool overlaps;
> +
> +	/*
> +	 * shift_arg_pages() can call move_page_tables() on overlapping ranges.
> +	 * In this case we cannot use move_normal_pmd() because destination pmd
> +	 * might be established page table: move_ptes() doesn't free page
> +	 * table.
> +	 */
> +	if (old_addr > new_addr)
> +		overlaps = old_addr - new_addr < len;
> +	else
> +		overlaps = new_addr - old_addr < len;
>  
>  	old_end = old_addr + len;
>  	flush_cache_range(vma, old_addr, old_end);
> @@ -282,7 +294,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, old_pmd, old_addr);
>  			if (pmd_trans_unstable(old_pmd))
>  				continue;
> -		} else if (extent == PMD_SIZE) {
> +		} else if (!overlaps && extent == PMD_SIZE) {
>  #ifdef CONFIG_HAVE_MOVE_PMD
>  			/*
>  			 * If the extent is PMD-sized, try to speed the move by
> -- 
>  Kirill A. Shutemov
