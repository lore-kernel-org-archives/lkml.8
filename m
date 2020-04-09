Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2CEC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929732078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586440415;
	bh=wjKcKMZARIJxiZrzZ+4flV4spmcgA/SO/1am3yuPW+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xRz1nljxphF/q8Sq2hxYSTCxOBM/Wg1jUbSXnmbczOy6f5Rs/2rdr8HUYTOI/WdMo
	 b8KTCeJ8gdHcDAorYuQkVXKYC/oICG3zetkGA7lDSm7qa61yOCIgFf1hxE36zW2a+Y
	 J/562t+UL2D0H4raHvU/KH+AyK65xJHZ6r2rDgRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDINxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:53:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDINxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:53:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so12038157wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 06:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Akux9Z+0zMr8xGqw8muVR/uP7F01RBhzaSi9ymvwPQM=;
        b=f7gH6S7zRZy6zPPfAsJ49/pmhMT6gga2GfxcM1wIir4TkD1OaqUyMtY96zotzjRpw4
         ubUBQm2ybiZAwvsgFY+HsaItvx36zHXrOgfb5bKkFErQpu6zjQ3+CnyKP0E2Kj1MT5RZ
         xwn+yR9d7ho0rcW5KHDaNMy+Xn6PBo71/rrWnrfJFGQ5PzifhgJDs/3VEF9IKRiTRnr5
         d9Vrgi6BBYD1rIvuN0JrCfRfZUFeqMeD2OfX8MeI1GPsU7B/NgG7W5CqaBImB8IB6yCV
         OA5F3j71Ua1zJQ/R7QGBlzZ1xje560Zfh1F3t0d049ZfbKKZDcexVTPY/rtMMR5MO1ZM
         R2aA==
X-Gm-Message-State: AGi0PuZWn7xEYbRq0SMMN8m3n7+UCPjmHX3a8eEIdjNAO+npRSXQBr7d
        e/k3IBD6W/MtOerwnwZsS4w=
X-Google-Smtp-Source: APiQypINKEmkU4epplatrkkKI1w1E/Sro3er6C0peFb0ml5TVRO95ltAF/sw9en/EZ9w//IPWwYWuw==
X-Received: by 2002:a5d:66c4:: with SMTP id k4mr15336291wrw.53.1586440411560;
        Thu, 09 Apr 2020 06:53:31 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id f14sm3807055wmb.3.2020.04.09.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 06:53:30 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:53:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200409135329.GI18386@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
 <20200409125258.GA362416@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409125258.GA362416@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-04-20 08:52:58, Peter Xu wrote:
> On Thu, Apr 09, 2020 at 09:02:53AM +0200, Michal Hocko wrote:
> > This patch has been merged and it is actually wrong after ae46d2aa6a7f
> > has been merged. We can either revert or I suggest just handling >0,
> > like the patch below:
> > 
> > From 03fbe30ec61e65b0927d0d41bccc7dff5f7eafd8 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Thu, 9 Apr 2020 08:26:57 +0200
> > Subject: [PATCH] mm, mempolicy: fix up gup usage in lookup_node
> > 
> > ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
> > added a special casing for 0 return value because that was a possible
> > gup return value when interrupted by fatal signal. This has been fixed
> > by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
> > for fatal signal") in the mean time so ba841078cd05 can be reverted.
> > This patch however doesn't go all the way to revert it because 0 return
> > value is impossible. We always get an error or 1 for a single page
> > request.
> > 
> > Fixes: ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal")
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/mempolicy.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
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
> I'm totally not against this, but note that get_user_pages_locked()
> could still return zero. Although I'm not 100% sure now on whether
> npages==0 will be the only case, it won't hurt to keep this ret==0
> check until we consolidate the whole gup code to never return zero.

As we have discussed in other email thread, returning 0 should be really
possible only for an nr_pages == 0. And even in that case we should
rather return EINVAL. I wanted to do that change as well but gup is a
heavily used interface and I do not have time to check all existing
callers.
 
> Assuming there's another case (even possible for a future gup bug)
> that could return a zero, your patch will let err be anything (which
> you didn't initialize err with your patch), then the function will
> return a random value.  So even if you really want this change, I
> would suggest you initialize err to some error code.

I wouldn't really overcomplicate it. If you are worried about future
bugs then we can warn into the log when !err && nr_pages somewher inside
gup code. But let's keep callers as simple as possible. We surely do not
want to check for !err in all users now.

> I just don't see much gain we get from removing that check.

The code clarity is the primary reason.
-- 
Michal Hocko
SUSE Labs
