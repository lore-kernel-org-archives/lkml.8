Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD0C55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2F1206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587480369;
	bh=0Ad/A9z2lhTpqC0z0TO87/muFDrYCCd621EqzePwh7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bRZjzaLZTBBWeJCuKQik8NKzEW/RubF/UZ7blTjynLDjMfWwQXxwKGiL2orT5FHnW
	 JO4tzlmACIAsCHvM7eZqqEFKPAT7ksyejH/05fmoRj9C7Z6SeQk1hai2l0q6mm2bVy
	 xdIg5JMoJpDXr3elsSdI2m7lVUr/bPPgbi+Oz1hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgDUOqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:46:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33099 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:46:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id v8so2702355wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=svu8564LKdLnKu6gBnOesOYzjFLYf57KsDUlEEtSHNc=;
        b=m5VDkm1unEZlrB27B2CgDnw5nrJtNQfkIhDLrI5tcgne77IpUhfhxZy54cd9hT5DT4
         4XRXMBerFDxCXgsgSUlrCYJE9/v5EXPmci/7KCZC2tMkHThN0epWObgip+lVs2Asj8H2
         ibfyR3WyftCTtL+Yds0CokuVjfvYTiqc9MxzryQF5TcQLFjNuZEXxSV46QnWG2Hpp6tL
         QSUhPxiq96ZQeBaIN7DzHkHXX2WNAqhRgkGAShLBqkoeJHEa3Tc226KvceOZ355ZoWSQ
         SrClQ4PJEZJdVVPRS1X1LxXzA8GnZf7eCqIrLck866+lh3tRJwchcikr62iMAciWG57q
         GkeQ==
X-Gm-Message-State: AGi0PuaZLyq4GuJ60m/rQ4eWcC6pKbygxv/c+HU1WAysVmbYOxtUfT3m
        y9J3AhmUgV2q4e+3wPSrR+4=
X-Google-Smtp-Source: APiQypI4nm3PpY6slnBrYwapUNpbciVZkvfg0WeWKA3FMdSCyvX194wFF/VxKCwjg63+z0vqwhX9Cw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr4984377wmi.64.1587480365842;
        Tue, 21 Apr 2020 07:46:05 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id i17sm3811872wml.23.2020.04.21.07.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:46:04 -0700 (PDT)
Date:   Tue, 21 Apr 2020 16:46:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, mempolicy: fix up gup usage in lookup_node
Message-ID: <20200421144603.GI27314@dhcp22.suse.cz>
References: <20200421071026.18394-1-mhocko@kernel.org>
 <20200421132916.GE420399@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421132916.GE420399@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-04-20 09:29:16, Peter Xu wrote:
> On Tue, Apr 21, 2020 at 09:10:26AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
> > added a special casing for 0 return value because that was a possible
> > gup return value when interrupted by fatal signal. This has been fixed
> > by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
> > for fatal signal") in the mean time so ba841078cd05 can be reverted.
> > 
> > This patch however doesn't go all the way to revert it because the check
> > for 0 is wrong and confusing here. Firstly it is inherently unsafe to
> > access the page when get_user_pages_locked returns 0 (aka no page
> > returned).
> > Fortunatelly this will not happen because get_user_pages_locked will not
> > return 0 when nr_pages > 0 unless FOLL_NOWAIT is specified which is not
> > the case here. Document this potential error code in gup code while we
> > are at it.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/gup.c       | 5 +++++
> >  mm/mempolicy.c | 5 +----
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 50681f0286de..a8575b880baf 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -980,6 +980,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
> >   * -- If nr_pages is >0, but no pages were pinned, returns -errno.
> >   * -- If nr_pages is >0, and some pages were pinned, returns the number of
> >   *    pages pinned. Again, this may be less than nr_pages.
> > + * -- 0 return value is possible when the fault would need to be retried.
> >   *
> >   * The caller is responsible for releasing returned @pages, via put_page().
> >   *
> > @@ -1247,6 +1248,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
> >  }
> >  EXPORT_SYMBOL_GPL(fixup_user_fault);
> >  
> > +/*
> > + * Please note that this function, unlike __get_user_pages will not
> > + * return 0 for nr_pages > 0 without FOLL_NOWAIT
> 
> It's a bit unclear to me on whether "will not return 0" applies to "this
> function" or "__get_user_pages"...  Might be easier just to avoid mentioning
> __get_user_pages?

I really wanted to call out __get_user_pages because the semantic of
0 return value is different. If you have a suggestion how to reformulate
this to be more clear then I will incorporate that.

> > + */
> >  static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
> >  						struct mm_struct *mm,
> >  						unsigned long start,
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 48ba9729062e..1965e2681877 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -927,10 +927,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> >  
> >  	int locked = 1;
> >  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > -	if (err == 0) {
> > -		/* E.g. GUP interrupted by fatal signal */
> > -		err = -EFAULT;
> > -	} else if (err > 0) {
> > +	if (err > 0) {
> >  		err = page_to_nid(p);
> >  		put_page(p);
> >  	}
> 
> Again, this is my totally humble opinion: I'm fine with removing the comment,
> however I still don't think it's helpful at all to explicitly remove a check
> against invalid return value (err==0), especially if that's the only functional
> change in this patch.

I thought I have explained that when we have discussed last time and the
changelog is explaining that as well. Checking for impossible error code
is simply confusing and provokes for copy&pasting this pattern. I
wouldn't really bother if I haven't seen this cargo cult pattern in the
so many times.
-- 
Michal Hocko
SUSE Labs
