Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B986C206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386890;
	bh=XKZQX5COxhCjrzhmq4pkfOcYz9rNm6psATmP13l/Dnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IJFIyNcdXfT45kZbvEolMXXuWgPVIXKsaqGwNQOI+JgYHs5MQ+IA47LPn36M9wB7h
	 N/VLf77MIfd2XjZOq4wBo8Sbva+2weP+vwwz49VRcC3obFbe5y/KYgcqhyFps83LUn
	 QgwzvbW6dX/JleCV1Zdf2rXxpM9is35h0T4rI01o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgDTMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:48:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42860 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgDTMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:48:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id j2so11961069wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3AA5nKJa9c6s6FlbQo/6mY7J53e9Eg80etGWlubH0U=;
        b=SKiDcN68TnpYVNtJLOJfkSZfEbl4MyX7aAR3buYeu80jQBKhwYF/siHIbqJijcJgPT
         3anux5aGdEhE3zRpgPmAw9y/EbOETWcKOYcCpX3kbgBYqOBvF7cWFepBVStTDRan8wJT
         ZmVWcMYPzU+HDG245shfzPdzcq2g5aJipOeRiye9RG/sWsZ1u6VN6Gnz7SnwfVaZPsQU
         dH8U9PP3q7P/EB8gjfFFVkPeqFR+fbgcN0wlCbr4l00Ogm6EfkEXCapL7IWHHUnlGdc1
         jtNoqEW9OCPfvbQhK38nYLMZPEql9U9zwklCckVauZx1cbqxAo+wvwpBZccJc7Lvm15f
         jXcg==
X-Gm-Message-State: AGi0PubskFAE0FEPLMdjwf2MiRhs4DpiGjGvgkw25qg/z4ArCmyOnwiW
        0iWlda4YznxjgXQZlZT3/BE=
X-Google-Smtp-Source: APiQypLbhAmK3NCyzU7tywTCNY8RZ2vyH73UMX6DtrRrGvSaKnG/exPr+Scz8kcMHrIk1NwctovPVA==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr20343745wrq.25.1587386881285;
        Mon, 20 Apr 2020 05:48:01 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id z16sm1124064wrl.0.2020.04.20.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:48:00 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:47:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200420124759.GO27314@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
 <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
 <20200414110429.GF4629@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414110429.GF4629@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any opinion on this Linus? Should I just repost the patch?

On Tue 14-04-20 13:04:32, Michal Hocko wrote:
> On Thu 09-04-20 09:42:20, Linus Torvalds wrote:
> > On Thu, Apr 9, 2020 at 12:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > This patch however doesn't go all the way to revert it because 0 return
> > > value is impossible.
> > 
> > I'm not convinced it's impossible.
> 
> __get_user_pages is documented as
>  * -- If nr_pages is 0, returns 0.
>  * -- If nr_pages is >0, but no pages were pinned, returns -errno.
>  * -- If nr_pages is >0, and some pages were pinned, returns the number of
>  *    pages pinned. Again, this may be less than nr_pages.
> 
> but let me double check the actual code... There seem to be only one
> exception the above rule AFAICS. faultin_page returning EBUSY will
> be overriden to either 0 for the first page or return the number of
> already pinned pages. So nr_pages > 0 && ret = 0 is indeed possible
> from __get_user_pages :/ That will be the case only for VM_FAULT_RETRY,
> thoug.
> 
> Now __get_user_pages_locked behaves differently. It keeps retrying the
> fault until it succeeds unless FOLL_NOWAIT is specified. Then it would
> return 0. Why we need to return 0 is not really clear to me but it
> seem to be a long term behavior. I believe we need to document it.
> 
> > And if it is, then the current code is harmless.
> 
> Yes from the above it seems that the check is indeed harmless becasue
> this path doesn't use FOLL_NOWAIT and so it will never see 0 return.
> I find a reference to EINTR confusing so I would still love to change
> that.
> 
> > Now, I do agree that we probably should go through and clarify the
> > whole range of different get_user_pages() cases of returning zero (or
> > not doing so), but right now it's so confusing that I'd prefer to keep
> > that (possibly unnecessary) belt-and-suspenders check for zero in
> > there.
> >
> > If/when somebody actually does a real audit and the result is "these
> > functions cannot return zero" and it's documented, then we can remove
> > those checks.
> 
> Would you mind this patch instead?
> 
> commit bc6c0fa7c7fb5eb54963dca65ae4a62ba04c9efa
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Thu Apr 9 08:26:57 2020 +0200
> 
>     mm, mempolicy: fix up gup usage in lookup_node
>     
>     ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
>     added a special casing for 0 return value because that was a possible
>     gup return value when interrupted by fatal signal. This has been fixed
>     by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
>     for fatal signal") in the mean time so ba841078cd05 can be reverted.
>     
>     This patch however doesn't go all the way to revert it because the check
>     for 0 is wrong and confusing here. Firstly it is inherently unsafe to
>     access the page when get_user_pages_locked returns 0 (aka no page
>     returned).
>     Fortunatelly this will not happen because get_user_pages_locked will not
>     return 0 when nr_pages > 0 unless FOLL_NOWAIT is specified which is not
>     the case here. Document this potential error code in gup code while we
>     are at it.
>     
>     Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 50681f0286de..a8575b880baf 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -980,6 +980,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   * -- If nr_pages is >0, but no pages were pinned, returns -errno.
>   * -- If nr_pages is >0, and some pages were pinned, returns the number of
>   *    pages pinned. Again, this may be less than nr_pages.
> + * -- 0 return value is possible when the fault would need to be retried.
>   *
>   * The caller is responsible for releasing returned @pages, via put_page().
>   *
> @@ -1247,6 +1248,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  }
>  EXPORT_SYMBOL_GPL(fixup_user_fault);
>  
> +/*
> + * Please note that this function, unlike __get_user_pages will not
> + * return 0 for nr_pages > 0 without FOLL_NOWAIT
> + */
>  static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  						struct mm_struct *mm,
>  						unsigned long start,
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 48ba9729062e..1965e2681877 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -927,10 +927,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  
>  	int locked = 1;
>  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err == 0) {
> -		/* E.g. GUP interrupted by fatal signal */
> -		err = -EFAULT;
> -	} else if (err > 0) {
> +	if (err > 0) {
>  		err = page_to_nid(p);
>  		put_page(p);
>  	}
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
