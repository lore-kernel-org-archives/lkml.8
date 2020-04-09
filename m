Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851DCC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593B820771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9A1T5RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDINAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:00:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbgDINAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586437222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6J81ztz61bi/hNuEa9vgW8/L4CIx+oFB9L/c9ZjgtAk=;
        b=E9A1T5RBzB56PU+LAplZsZuxUJHFvqCpg3jWVxM5qy3hGhB2VqZh+yA8E6AtyfdSJFDyII
        Yf/snEdMkb4iV26oHX3L75EoDXTugigl62KBaS+IbYBCTMKkptxSSc/BQsau/M70TuQFrG
        SfZg/pC5DspJXe5yZEz0W0t0Q+rhJZQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-9WVD-n3HNIikzWPfycV8nA-1; Thu, 09 Apr 2020 09:00:19 -0400
X-MC-Unique: 9WVD-n3HNIikzWPfycV8nA-1
Received: by mail-qk1-f200.google.com with SMTP id m1so3289935qkh.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 06:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6J81ztz61bi/hNuEa9vgW8/L4CIx+oFB9L/c9ZjgtAk=;
        b=rdsR8JgPhW4Cjiwz4uV//+WW13pV5GP8UzHUKZis25abF1ATgeqyfU/rX24meAp7Ev
         z3aU3GCvOJ77qCvqOG13LPKtemQYQhFSqN3O/IBuP0ZDVi8pT3/dcaUHVoVjYB/uCL3m
         PZreKEni4oJG+vBHSUup+p7W1FH5oBMBVY/A2XnLGCxQ3/AeaUJ3BNF41h5Sp93jw8cw
         7aUdcbD6a/jtg5Wew7bfp97hHoMmO0kE2iLPzC9KbbnpfPS3CgO/+kEAwigkD+kAHu1k
         YlrDyWKIi181RZJnJxizXxCllK21eqQd7eyFhaBN/ZGTScUCIzUORNkS832+gA9/VxnL
         3rcg==
X-Gm-Message-State: AGi0PuZzLbdY8E1tUu1zsivNQSM15seX56l8KXddfQc02mHV1hX7Nl/I
        OFdgCVa9+qMoIUwDfG3eEQSkWuRz9KjG3fgKY7dx5vIuitVUnUoOsFfybEtaEZRaak4S7/+4f+y
        xo2/VveyiAorl9gPEfjGvG4CC
X-Received: by 2002:a0c:efc2:: with SMTP id a2mr11942256qvt.249.1586437218649;
        Thu, 09 Apr 2020 06:00:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypIoRkPNMgjwKKbdOwgwgkyc1pKaD7FffW909TJ3FYJkgLt1d2W8qr7/cJUmXARzVhUpeSL3Gg==
X-Received: by 2002:a0c:efc2:: with SMTP id a2mr11942238qvt.249.1586437218392;
        Thu, 09 Apr 2020 06:00:18 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l22sm22074735qkj.120.2020.04.09.06.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 06:00:17 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:00:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200409130016.GB362416@xz-x1>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
 <20200409125258.GA362416@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200409125258.GA362416@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 08:52:58AM -0400, Peter Xu wrote:
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
> 
> Assuming there's another case (even possible for a future gup bug)
> that could return a zero, your patch will let err be anything (which
> you didn't initialize err with your patch), then the function will
> return a random value.  So even if you really want this change, I
> would suggest you initialize err to some error code.

I'm sorry, not a random value, but err=0 will be returned as the mem
policy by lookup_node().

> 
> I just don't see much gain we get from removing that check.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

