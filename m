Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F077C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4922088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivDhSFxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGBT6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:58:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39563 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgGBT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593719914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCLQe5LsYyu8+abDQmSCBVAAF5BIKekyAy1XEbhzlKo=;
        b=ivDhSFxFRaZunoCtIeH5Up8PVHF6cVZPZ+dQPnCkQMlRTvOdW+sEqOjONKnTWKwNYW/PKM
        5bT37aGKqHguX0qvK3hN3fGnbOhb9LTFJUpMB6ILqRo/s+LpnmRuJ4lvwSCdkZi9VUMGs+
        Tli5mRQ3pfKclnLBFkZH5VQfbZ/KQ6s=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-lD7J-lzWMz2o-A2leOn6gg-1; Thu, 02 Jul 2020 15:58:33 -0400
X-MC-Unique: lD7J-lzWMz2o-A2leOn6gg-1
Received: by mail-oi1-f199.google.com with SMTP id n67so15945448oif.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCLQe5LsYyu8+abDQmSCBVAAF5BIKekyAy1XEbhzlKo=;
        b=I1WO2QXaOZ7R+BsO+sNxDRIkkUMBcO3aTV7j8XhFnXLX7oHGL1+WQJhUolo0AsNtwb
         AeHc8gXxRJFyf1fxhLcYNGk2RKgFM+Dnqwt04Olam/MjGNn+p/3oCHseeimBLvMdsUwG
         uN8CUIQXyzGa9GaEihigigTgQMTKDuMxh47f+9kGgC4+T+Qk5lb5T1+M/cbDoCOmNI1s
         gzrCLe6yighG1m9lpjrBcFOHh99wdngbrAs/s1zmEBMrb7kDP2riiok6TCsabUKu1MNW
         ReUkItlkStxK6FCcsk/I24jUxgB6LBj1cBqxF8LP0mrOX0QFMU2N8MUTm6umAg49sG6s
         eE4Q==
X-Gm-Message-State: AOAM5301sAZcM/34Sx81BtbS12QCxw1HM05W4BFI9QK3ZMNReqHuKjHE
        QhpJtROQTvmZcsDjQ2WhBcUZYI3KM5E/wp6eU4+kOtz/cvTZoG5TGTHp3wzxSyTNHGqDiu54oAG
        vJ73A5ADW3U/oc+1+QlTzF3OgPfo/ztB7HVTqANSN
X-Received: by 2002:aca:494d:: with SMTP id w74mr7056888oia.72.1593719912200;
        Thu, 02 Jul 2020 12:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1L6FpDy+eyJr4Pj9GcmJ4apoM6n8berudx0byqdTDebDSJ2HNON1jP0UpltmJ0Pff2egMjbmK6hUutlfdI4E=
X-Received: by 2002:aca:494d:: with SMTP id w74mr7056871oia.72.1593719911999;
 Thu, 02 Jul 2020 12:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jul 2020 21:58:20 +0200
Message-ID: <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> > shouldn't trigger any filesystem I/O for the actual request or for
> > readahead.  This allows to do tentative reads out of the page cache as
> > some filesystems allow, and to take the appropriate locks and retry the
> > reads only if the requested pages are not cached.
>
> This looks sane to me, except for this part:
> >                 if (!PageUptodate(page)) {
> > -                       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
> >                                 put_page(page);
> >                                 goto would_block;
> >                         }
>
> This path doesn't actually initiate reads at all - it waits for
> existing reads to finish.
>
> So I think it should only check for IOCB_NOWAIT.
>
> Of course, if you want to avoid both new reads to be submitted _and_
> avoid waiting for existing pending reads, you should just set both
> flags, and you get the semantics you want. So for your case, this may
> not make any difference.

Indeed, in the gfs2 case, waiting for existing pending reads should be
fine. I'll send an update after some testing.

Thanks,
Andreas

