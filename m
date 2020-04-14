Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFFDC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585E92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586873968;
	bh=WrgNlg4c/bqDmoOdi9O2QdWjiiGVBoD/3riqG6QzEEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fSYZBnb6PZyAXxtMr5Iq8MDAOBqpIMsJ14fmcB79wpeiIaQib8YG+mZKhyk9Krqkv
	 SQpIEmREfoZ/7mKlURXJdusT7RssxXXK8qhZVvqJujh7Cp06z7rcqcRj1DKwhpTCSz
	 TZmbah+4yuUQT9T95MDRlOKNq4LuMyCbV4QH4j70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbgDNOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:19:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41180 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389553AbgDNOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:19:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so14519947wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5WfYF9qaISCkQkLdw8YD4qrqM7NyTjsNf6l5QbjJTo=;
        b=JHBW9mz6aeY+lffMWQ2zaWgl2BJsVb0Oyt5abQVDCM0QtA8aU1Nmw8b/7NP9bVkn6z
         5VnAzQ5g/12Gfh4Iv2iyrUPQR3XP7mOkfQ+Wg5oE09xruAMyL9BbmVx1lFficeoNieOS
         KChZucfxqCGhFWk7C6dy0km4HwCZ7nBFkL6JL/s8sSYq/x1ObjKjw3Rydh7dkyeSL7k7
         l3YOpsGKZYnXyQOH1NgSOVDRSL/PtuwmaHcPOcGC+KvM64Y3N8fOj0rVTDhv8syorT1V
         v25wq2q0w56YhSTU+FCZo0jRsNTRSKbbfpv5ax+y26/K2uaUUhbYIvAkOAXRHTXLM6rA
         f1fg==
X-Gm-Message-State: AGi0Pubcuj33afOEGbA98IM6E3mudwsdlbH8Fkn1y2mMvSUEridvM8f9
        cmXET4fnfoiR1QgCMAh0Qvc=
X-Google-Smtp-Source: APiQypK6NuQVH3WM+olPPFxSgaP3SCd9gU4Iqdtq/fG4GGGHxVcSyqB43KmhAKxVv7wBOx/6NIt5Ew==
X-Received: by 2002:adf:f812:: with SMTP id s18mr26513530wrp.347.1586873941783;
        Tue, 14 Apr 2020 07:19:01 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id b11sm19320446wrq.26.2020.04.14.07.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:19:00 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:18:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200414141859.GM4629@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
 <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
 <20200414110429.GF4629@dhcp22.suse.cz>
 <20200414134906.GF38470@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414134906.GF38470@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-04-20 09:49:06, Peter Xu wrote:
> On Tue, Apr 14, 2020 at 01:04:29PM +0200, Michal Hocko wrote:
> 
> [...]
> 
> > @@ -1247,6 +1248,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
> >  }
> >  EXPORT_SYMBOL_GPL(fixup_user_fault);
> >  
> > +/*
> > + * Please note that this function, unlike __get_user_pages will not
> > + * return 0 for nr_pages > 0 without FOLL_NOWAIT
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
> Hi, Michal,
> 
> IIUC this is not the only place that we check against ret==0 for gup.
> For example, the other direct caller of the same function,
> get_vaddr_frames(), which will set -EFAULT too if ret==0.  So do we
> want to change all the places and don't check against zero explicitly?

This would require to analyze each such a call. For example
get_vaddr_frames has to handle get_user_pages_locked returning 0 because
it allows callers to specify FOLL_NOWAIT. Whether EFAULT is a proper
return value for that case is a question I didn't really get to analyze.

> I'm now thinking whether this would be good even if we refactored gup
> and only allow it to return either >0 as number of page pinned, or <0
> for all the rest.  I'm not sure how others will see this, but the
> answer is probably the same at least to me as before for this issue.

I would consider a semantic without that special case for FOLL_NOWAIT
much more clear but I do not really understand the historical background
for it TBH so I do not dare to touch that.

> As a caller, I'll see gup as a black box.  Even if the gup function
> guarantees that the retcode won't be zero and documented it, I (as a
> caller) will be using that to index page array so I'd still better to
> check that value before I do anything (because it's meaningless to
> index an array with zero size), and a convertion of "ret==0" -->
> "-EFAULT" (or some other failures) in this case still makes sense.
> While removing that doesn't help a lot, imho, but instead make it
> slightly unsafer.

Well, my experience tells me that people really love to copy&paste code
and error handling and if the error handling is bogus it just spreads
all over the place until it really defines a new standard which is close
to impossible to get rid of. So if the error handling can be done
properly then I would really prefer it. In the above case it is clearly
misleading, because fatal signal should be never reflected by err==0.
-- 
Michal Hocko
SUSE Labs
