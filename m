Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D43C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38EA2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8o6ZOeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgDGP7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:59:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgDGP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586275162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyjESamdwUR+qBAftAf1wggTNgdAJyF9I7vk6xL9aJk=;
        b=F8o6ZOebQNsRCAPiswS5HblN1xXA8JHEr46/0lCDVcTA34KN3sK6FIRveE+o6KZBWe2rfK
        tyWCXxoBQ4cbKkutfsnEA2o0GOn/uUiPNmkC/lV8uTP9Py98mXrMlov9TY/8PClXKNpUI8
        hz7M3p1vxBoajzZFCZ36/bs+7E2iALo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-IaUL2AI7Ony57DFJCFiRCA-1; Tue, 07 Apr 2020 11:59:21 -0400
X-MC-Unique: IaUL2AI7Ony57DFJCFiRCA-1
Received: by mail-qk1-f197.google.com with SMTP id 19so3579678qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyjESamdwUR+qBAftAf1wggTNgdAJyF9I7vk6xL9aJk=;
        b=Z1km62zef1obaQO4IuOZHBQsU8z8ij9z9eOPkkcjRoJdwZ9oEZL7Px6utxOp1u0izm
         MqSFcZZ9AiQ6drRKpUFXLsJcKQB7Sq1rq/3iexOIqp3H6V3AeSKorsd56fv0YAAKfl5S
         SImV3WnwEH8F9FCEE1sMGaq3xTaNgjbc+yl53oG39sSk5geYBo4JgrIcRJ+1D0v+khtu
         ssBAFcIcH4EbIVDfr2n77rpzbFDM9umqLaEi6pJBUTbxGosqJEUB2zdIbSCpK4H1llaK
         CW4RpRxMLxZnIUonzjyGMs2KO/cP7Y6sjdXOEcbjviVjUDUmblFWuw/k8OVTf5wpgTed
         jJjA==
X-Gm-Message-State: AGi0PuZmGbNpVAJhsyBb179/oTgRKt1S1Ukn/jnCTFtK/9OltpMEWelY
        ponDP8z+ebkb5qOmQ0xT9JJTaM1ME+PWHxWHSw93+Ipo5+86O8g6p5YTEjrzzMbYyYon7cEIksP
        NXcvrwj8FfWAgBZT3VVOHPGKN
X-Received: by 2002:ac8:544b:: with SMTP id d11mr2980135qtq.122.1586275160051;
        Tue, 07 Apr 2020 08:59:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypITVF/A5j/lHW/Mk28wZXwa0K1fTtGrCfGOtpwxDP9B0toGgUPl684klg2CCJr7b6M9QM6bHQ==
X-Received: by 2002:ac8:544b:: with SMTP id d11mr2980108qtq.122.1586275159771;
        Tue, 07 Apr 2020 08:59:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id z40sm7063418qtj.45.2020.04.07.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 08:59:18 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:59:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        Brian Geffon <bgeffon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
Message-ID: <20200407155917.GF48345@xz-x1>
References: <0000000000002b25f105a2a3434d@google.com>
 <20200407004745.GA48345@xz-x1>
 <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
 <20200407015535.GC48345@xz-x1>
 <20200406191534.aafd8f74406c242ba1a42549@linux-foundation.org>
 <20200407024254.GD48345@xz-x1>
 <CACT4Y+bxjLaK-QG+7WQ0S-N4_1-2-gtDU=ytUDd5fUOjsxEjdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bxjLaK-QG+7WQ0S-N4_1-2-gtDU=ytUDd5fUOjsxEjdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 10:27:15AM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 7, 2020 at 4:43 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Apr 06, 2020 at 07:15:34PM -0700, Andrew Morton wrote:
> > > On Mon, 6 Apr 2020 21:55:35 -0400 Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > On Mon, Apr 06, 2020 at 06:39:41PM -0700, Andrew Morton wrote:
> > > > > On Mon, 6 Apr 2020 20:47:45 -0400 Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > > >From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> > > > > > From: Peter Xu <peterx@redhat.com>
> > > > > > Date: Mon, 6 Apr 2020 20:40:13 -0400
> > > > > > Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> > > > > >
> > > > > > lookup_node() uses gup to pin the page and get node information.  It
> > > > > > checks against ret>=0 assuming the page will be filled in.  However
> > > > > > it's also possible that gup will return zero, for example, when the
> > > > > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > > > > gracefully return an error -EFAULT if it happens.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > --- a/mm/mempolicy.c
> > > > > > +++ b/mm/mempolicy.c
> > > > > > @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> > > > > >
> > > > > >         int locked = 1;
> > > > > >         err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > > > > > -       if (err >= 0) {
> > > > > > +       if (err == 0) {
> > > > > > +               /* E.g. GUP interupted by fatal signal */
> > > > > > +               err = -EFAULT;
> > > > > > +       } else if (err > 0) {
> > > > > >                 err = page_to_nid(p);
> > > > > >                 put_page(p);
> > > > > >         }
> > > > >
> > > > > Doh.  Thanks.
> > > > >
> > > > > Should it have been -EINTR?
> > > >
> > > > It looks ok to me too.  I was returning -EFAULT to follow the same
> > > > value as get_vaddr_frames() (which is the other caller of
> > > > get_user_pages_locked()).  So far the only path that I found can
> > > > trigger this is when there's a fatal signal pending right after the
> > > > gup.  If so, the userspace won't have a chance to see the -EINTR (or
> > > > whatever we return) anyways.
> > >
> > > Yup.  I guess we're a victim of get_user_pages()'s screwy return value
> > > conventions - the caller cannot distinguish between invalid-addr and
> > > fatal-signal.
> >
> > Indeed.
> >
> > >
> > > Which makes one wonder why lookup_node() ever worked.  What happens if
> > > get_mempolicy(MPOL_F_NODE) is passed a wild userspace address?
> > >
> >
> > I'm not familiar with mempolicy at all, but do you mean MPOL_F_NODE
> > with MPOL_F_ADDR?  Asked since iiuc if only MPOL_F_NODE is specified,
> > the kernel should not use the userspace addr at all (which seems to be
> > the thing we do now).  get_mempolicy(MPOL_F_NODE|MPOL_F_ADDR) seems to
> > return -EFAULT as expected, though I agree maybe it would still be
> > nicer to differentiate the two cases.
> 
> Am I reading this correctly that we put an initialized struct page* in
> this case? If so, with stack spraying this looks like an "interesting"
> bug.

Yeah, so far it should be fine, but... ideally I guess we should init
page==NULL in lookup_node() too to avoid potential risk on exploiting.
Maybe we could squash this into the fix if still possible.

Thanks,

-- 
Peter Xu

