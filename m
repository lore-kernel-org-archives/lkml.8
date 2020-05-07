Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0435C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998BA20747
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XdK+ZklR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEGA4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEGA4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:56:09 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 17:56:07 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u11so4397935iow.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTZI/F41ZnJFrUE+FVQ0Jc0NsPmmFnVbnHSoplh9O30=;
        b=XdK+ZklREmT8RhLEEu0G6URSmzXx9v8mRFMStVvR9AnyZA+y/65G8eUd16BCnxCElq
         agRhJuRnP4dfKugRBjiiqqh8GTv9Hr1hkmubVwk/bqxq2OxImiPGA5K+45iv1/kLtm4L
         PlQh8IBBTlKCRKNHAFeml4o4CiGJYAB86oucI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTZI/F41ZnJFrUE+FVQ0Jc0NsPmmFnVbnHSoplh9O30=;
        b=A6NuG6Mnt7aSlzteh+Gmcz+mm6ftju6S+Y+0dWzXdUeVpN4oiYLCUGmvgZPWsPXf/c
         elNSJ3dLXxE3b9Guru2+fqzeUZtmqmtKuoZ9o6xXkDY+YQwq0Ad5WY9kdqRH/ASn+mm/
         BH14GwbNIlKXeCDtaoISqk1ZrqfQpm1vz8ITfgkoIhBC4exRPzp9K5bzMLc2X0KzQpCI
         5n3ipVV5zNjhxEMh8HKt8ctc/ISROgT2DS9LCBjSuD8OaOp4ySYZeoSXwCJxdatvvib7
         aQOERsOazJhQxSrEhP6smC8VDbjolRhx0TSRlH/7UP5f8PpyaWcsB5PR5L2I5hDidLbV
         Sjaw==
X-Gm-Message-State: AGi0PuaeLBqebxTbP7Eg61AN7SyPnsZe4Hkj5f6GPVaBBFv3wPFuoyeo
        RcDAEPACpxpj1XQjkE1rKMRU1v0GeUFZ6vxZSdzzDA==
X-Google-Smtp-Source: APiQypK7tW3MfW0FGcrXaMeS/bmC/PyGWc0vtFD5prm2IEa/O6Nv5e6InE5cxBEN7bvCrIzsH5jyGLFDfiDh1UET0RQ=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr11161027ion.1.1588812967176;
 Wed, 06 May 2020 17:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200506172158.218366-1-bgeffon@google.com> <CAEXW_YQ+iC9tot+HbHARiXz_o_KrDU7LjvuyPkj46DVfGvSOng@mail.gmail.com>
 <CADyq12xRzr53hM7_ejEG-O8kDF5XBdrLM7yWVpbByd8pOWsTrA@mail.gmail.com>
In-Reply-To: <CADyq12xRzr53hM7_ejEG-O8kDF5XBdrLM7yWVpbByd8pOWsTrA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 6 May 2020 20:55:55 -0400
Message-ID: <CAEXW_YR2=g5Sh1uFCoLKDSxswyeJieOP8uxMrf4ievePdkgbSg@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix remap event with MREMAP_DONTUNMAP.
To:     Brian Geffon <bgeffon@google.com>
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

Hi Brian,

On Wed, May 6, 2020 at 1:32 PM Brian Geffon <bgeffon@google.com> wrote:
>
> It hasn't landed in a stable kernel yet, 5.7 is rc4 so I don't think
> it needs to cc stable, right?

I think the criteria is, if it has been merged into Linus's tree in a
kernel release, then CC'ing stable means any future stable releases of
the kernel will have the patch applied to the stable tree. The fix
patch itself will need to be merged into Linus tree at a future date
before being applied to the stable tree. But at least CC'ing stable
means it is tracked my stable bots and they'll do the right. This is
my understanding.

If the patch you are fixing was applied for v5.7 merge window, then I
don't think you need to CC stable.

> Andrew, I'd be happy to mail a new patch if necessary, otherwise here
> is the fixes:
>
> Fixes: e346b38 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")

I'd also avoid top-posting and send inline replies:
https://web.archive.org/web/20080722025748/http://www.zip.com.au/~akpm/linux/patches/stuff/top-posting.txt
https://lkml.org/lkml/2019/12/4/267

Thanks!

 - Joel


>
> Brian
>
>
> On Wed, May 6, 2020 at 10:28 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, May 6, 2020 at 1:22 PM Brian Geffon <bgeffon@google.com> wrote:
> > >
> > > A user is not required to set a new address when using
> > > MREMAP_DONTUNMAP as it can be used without MREMAP_FIXED.
> > > When doing so the remap event will use new_addr which may not
> > > have been set and we didn't propagate it back other then
> > > in the return value of remap_to.
> > >
> > > Because ret is always the new address it's probably more
> > > correct to use it rather than new_addr on the remap_event_complete
> > > call, and it resolves this bug.
> > >
> >
> > Does it need Fixes: tag, and CC to stable? Going into a stable kernel
> > will mean the stable kernel merges into ChromeOS also gets it.
> >
> > thanks,
> >
> >  - Joel
> >
> > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > ---
> > >  mm/mremap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index c881abeba0bf..6aa6ea605068 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -794,7 +794,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > >         if (locked && new_len > old_len)
> > >                 mm_populate(new_addr + old_len, new_len - old_len);
> > >         userfaultfd_unmap_complete(mm, &uf_unmap_early);
> > > -       mremap_userfaultfd_complete(&uf, addr, new_addr, old_len);
> > > +       mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> > >         userfaultfd_unmap_complete(mm, &uf_unmap);
> > >         return ret;
> > >  }
> > > --
> > > 2.26.2.526.g744177e7f7-goog
> > >
