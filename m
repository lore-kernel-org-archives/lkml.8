Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA356C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FCA2100A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK7Rt5VM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgFXBgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbgFXBgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:36:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E1AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:36:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i3so748414ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7jjyfHFC9E96qUQNIK0iSzZnFmQnU7S2H0dsaVw/bw=;
        b=hK7Rt5VMB2G5gbaRdIV0Ca6lV0ZaRMz+RDV4xUL2XkVbCQIDEzOKm49gQBGCHYiOM5
         01IoGspdppI0EkYYitQghqMlWYxjWXvA/+3qZbU0KlZVs+xj1BqcrcCEPMGKW5PZTm8B
         g9u75oDqyl7m46djbSPk/Yw7xqTFCNyLCpUbGbck/WRnJMui8c89yeFj96+8belvxbna
         M5SZyJJ+dcvDMGJTLw4H2SZPdurlPzX0BYo0XgITMwuMlw8TnsTwTgIriOt2Exj06PtJ
         StY//vwUk0msYU4UBdT8AfDX73f5umwrQ7ITct+uyRy9dil1w0CADNCuTewpgAaJdsVC
         dPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7jjyfHFC9E96qUQNIK0iSzZnFmQnU7S2H0dsaVw/bw=;
        b=apK06BfL8gUfHkwvM8r3pTiJHpKJjXKiXP27aWIxvRBjOhVIeo3tmfE8ATFV7YxuwG
         zWTVWrkhCg1RbpNDwmf7qCVwwbaqfZm1aeJzYD+k0A0VrEnbm4xy7kpDeyRhY5NNBJ7U
         fQjo9mNHDodmYTV7wNMCR+elI97HaMQ8FxThgdRlHjj0QzexM6NP/pXkrUJscJsKhr70
         Ka87oEB0h9MYpue2/P0glvOCYwh80Ir93pvY/3b/ZU5tlxqJd2yl7AoW9yBhqm9hbfQr
         6p/96W4pzSiu01HJ7uupJyNQ2p99/9sFHFNNGg0evq0HUdRbdfY3n+poM+F4FmvSK6Hg
         Fp8A==
X-Gm-Message-State: AOAM532i9ESquGZ6p8T1sTeSA+Hogvrgmv6UwqRaM3cIEJCvCzXe/jGX
        LXTEiyya8hP333daqErJRIUs6NjWILQIrWKmNJs=
X-Google-Smtp-Source: ABdhPJzOqFFVqbyUclpMCMOSdJwxZz/i0ZJW9EZ9Y352Wdacz7Zh9xF7VmRJgb1LV8FRvn+GdRWFYPs8nErn9OhneVQ=
X-Received: by 2002:a2e:b704:: with SMTP id j4mr13041345ljo.458.1592962573834;
 Tue, 23 Jun 2020 18:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <1592913499-15558-1-git-send-email-jrdr.linux@gmail.com> <c68a3805-080f-22c3-a4d3-f03be6b32176@oracle.com>
In-Reply-To: <c68a3805-080f-22c3-a4d3-f03be6b32176@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 24 Jun 2020 07:06:01 +0530
Message-ID: <CAFqt6zZo4ZZ9sHGqMGiYoGoA8HQ2z_ijwnpr_b+PHuAzq31scw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:11 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 6/23/20 7:58 AM, Souptick Joarder wrote:
> > In 2019, we introduced pin_user_pages*() and now we are converting
> > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > be referred for more information. This is case 5 as per document [1].
> >
> > As discussed, pages need to be marked as dirty before unpinned it.
> >
> > Previously, if lock_pages() end up partially mapping pages, it used
> > to return -ERRNO due to which unlock_pages() have to go through
> > each pages[i] till *nr_pages* to validate them. This can be avoided
> > by passing correct number partially mapped pages & -ERRNO separately
> > while returning from lock_pages() due to error.
> > With this fix unlock_pages() doesn't need to validate pages[i] till
> > *nr_pages* for error scenario.
>
>
> This should be split into two patches please. The first one will fix the
> return value bug (and will need to go to stable branches) and the second
> will use new routine to pin pages.

Initially I split the patches into 2 commits. But at last moment I
figure out that,
this bug fix ( better to call coding error, doesn't looks like lead to
any runtime bug) is tightly coupled to 2nd commit for
pin_user_pages*() conversion,
which means we don't need the bug fix patch if we are not converting the API to
pin_user_pages*()/ unpin_user_pages_dirty_lock(). That's the reason to
clubbed these two
commits into a single one.

If this looks unreasonable, will split it into 2 patches again.


>
>
> > @@ -580,25 +580,30 @@ static long privcmd_ioctl_mmap_batch(
> >
> >  static int lock_pages(
> >       struct privcmd_dm_op_buf kbufs[], unsigned int num,
> > -     struct page *pages[], unsigned int nr_pages)
> > +     struct page *pages[], unsigned int nr_pages, int *errno)
>
>
> I'd prefer if you used more traditional way of returning error code by
> the function, and pass the number of pinned pages as an argument. This
> will also make call site simpler.

Sure, Will do it.

>
>
> -boris
>
