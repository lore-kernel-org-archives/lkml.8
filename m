Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE1C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F01020CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU8Xg+y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgEFRc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:32:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4286C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:32:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so2682479edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zINnKrADJ456wEG+eExotg4mZm+1AAItrQjk1QMDkRw=;
        b=gU8Xg+y94kUk/jJIxbbaNYMn4rphbC4fBnewawj1Uh/frMvnwP7mLkSJpsbqZmnsg0
         dy0V++iiQf7VFwxKL8e4ZMwSo/ZVZtqDaZM/ACqSLASsNUwmiLgHErctdGmSUYPtROyE
         0XFlBPlZZnopz7Ar9VUqla93WH7yAvMdnSlgiq8m7kgKrUDEyOcWQCDakebeXhePjTl3
         7f4Sd9Q/s79BGA5MkzfBUc1QFR+hOp4j32DrpmCG0opc52MYma1Rz6VLQ71R8PqEuK9f
         3IH0431rnvHokYkc5P7f0fnmSwzqr6/uYVPAk0sEJJl/zFtsUXKnEc+HRQ8kPUuztXv3
         POPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zINnKrADJ456wEG+eExotg4mZm+1AAItrQjk1QMDkRw=;
        b=KKT5nDyb0npiLGelCDLoRt7Vr3F3dHASoP3LjDzKaYnNtiJoXVA+kTP7RcvIFhorZw
         QHDKTh8382QjACaUDmeW42KScR0b/DZPs5K4NEKCSh9h49GUHXKUW/zC6BZEQ41vHY9m
         K9R2XsurfD5K7df+8cm7ZTzym/WJ1BGRxjEjf5Z47/CLslaDlVmVrt+SSgRg8MihMrzs
         yY3LJZqv6tZFZkLY8GnPPy+4j4TiV1OIrUFv8zaMkZNSpyy7kGLfaKjgyxqAjoY86wCz
         EVVx2yJEYwR7+mo+0cGfbYTvO8qH9uz7p4fUnTlhkqCAzF8RqSsgc4OOjL2uSMEwTwth
         cogA==
X-Gm-Message-State: AGi0Puaky9Gfpz2yAaN30sTJh2G3w37DbqzxgmczxKOjkeL8re1Dzqle
        9eucCg8FOCtF5fX2yibx+IJeKClTI5tC3rf/I6nwVg==
X-Google-Smtp-Source: APiQypJRjLXomMpn1XVcFOW8Zv8LVVjTey/4sLxDYEh8dNjtfEU+SBnFiqdM5Xz7Nz2pyENEky70nKqDHLseidxPiUk=
X-Received: by 2002:a50:fb92:: with SMTP id e18mr7868188edq.177.1588786374285;
 Wed, 06 May 2020 10:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200506172158.218366-1-bgeffon@google.com> <CAEXW_YQ+iC9tot+HbHARiXz_o_KrDU7LjvuyPkj46DVfGvSOng@mail.gmail.com>
In-Reply-To: <CAEXW_YQ+iC9tot+HbHARiXz_o_KrDU7LjvuyPkj46DVfGvSOng@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 6 May 2020 10:32:18 -0700
Message-ID: <CADyq12xRzr53hM7_ejEG-O8kDF5XBdrLM7yWVpbByd8pOWsTrA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix remap event with MREMAP_DONTUNMAP.
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It hasn't landed in a stable kernel yet, 5.7 is rc4 so I don't think
it needs to cc stable, right?

Andrew, I'd be happy to mail a new patch if necessary, otherwise here
is the fixes:

Fixes: e346b38 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")

Brian


On Wed, May 6, 2020 at 10:28 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, May 6, 2020 at 1:22 PM Brian Geffon <bgeffon@google.com> wrote:
> >
> > A user is not required to set a new address when using
> > MREMAP_DONTUNMAP as it can be used without MREMAP_FIXED.
> > When doing so the remap event will use new_addr which may not
> > have been set and we didn't propagate it back other then
> > in the return value of remap_to.
> >
> > Because ret is always the new address it's probably more
> > correct to use it rather than new_addr on the remap_event_complete
> > call, and it resolves this bug.
> >
>
> Does it need Fixes: tag, and CC to stable? Going into a stable kernel
> will mean the stable kernel merges into ChromeOS also gets it.
>
> thanks,
>
>  - Joel
>
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  mm/mremap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index c881abeba0bf..6aa6ea605068 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -794,7 +794,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> >         if (locked && new_len > old_len)
> >                 mm_populate(new_addr + old_len, new_len - old_len);
> >         userfaultfd_unmap_complete(mm, &uf_unmap_early);
> > -       mremap_userfaultfd_complete(&uf, addr, new_addr, old_len);
> > +       mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> >         userfaultfd_unmap_complete(mm, &uf_unmap);
> >         return ret;
> >  }
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
