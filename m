Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71996C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD382073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUGYdJZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405144AbgFXQlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404160AbgFXQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:41:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:41:21 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so1631649lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/MCASNnVi/ALzgM3WNJvUmY0h2sFHWtkBBpH4Al5bc=;
        b=SUGYdJZr+bMHYsVax8gJ9zldqlptd5kT4BBRGeENSZ+lBC2aiViK4YZ21YlKWckWtj
         78rogfijxVPK+wCfNKOEsnWws25VJFVUqOMZ74hBCT/b+V7//3IX5LmoPpT73wLr6UyE
         f9Or3PmrEO4tzctBFixp7xguO8JiV1I21ldwJUXWqgFRU9s9sRiMnelghsFX1qj5r387
         qN9gkK0f6h9/H7ZwGB2j0IMzDyJcMQ2UZMPvL9SCVasAlSKcpc1EoVJgatnaPih5GTGW
         xFlpqTdOrQIDUPF3HBr4SWcJYM9EzzINKaFEIKuenUhJwTGpyHMkKavREhDOlpHEHyfo
         O63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/MCASNnVi/ALzgM3WNJvUmY0h2sFHWtkBBpH4Al5bc=;
        b=jxjrBd9OFg0STPUvLht2sd4CRASp60pHnR06/Qvcr8aZIN4h5or5xWIt0CCKGVlaEa
         r98OC1OrV3lOGG23NcqRgBWES5hP+WBhvpBDvv6bngS0N/KksAYhO7L2ROQE4mcl/inI
         9LhqNGqe18LWbZP88/OCWnKgB4/uUB9072BExK6XYF8/rQSW+hM3ly6ptIpVN7jMwNA0
         oIRjyBQ5p7TDgzmaY+QtfZ7wmgnc9a5dq0bxIz1MPaAB5A5NOtB9D64m+o8P0xBJyD6L
         uFT+OhAyF5pGY6FrfP4pd9tlu2aUCdSeJ+HHpVHMS2SMo+XopECy12woZZ73TmkRNTO7
         gThA==
X-Gm-Message-State: AOAM532wq5iJTYlUCCNsNR6eDbdVKAT7FbQyp473ZCxLyblLnt76vezl
        KD/prBDJUgArB0RnQvUOV/+f1GESaek7dk7807sXxU8qjqU=
X-Google-Smtp-Source: ABdhPJyuFuqWzMzN0VCDv0hj3tUOZeuC5C7P9H6qKjUhTu9qMY0DiAXyK0/rc0u9PDV26qXkjvqHI3MZ8FO+htkdFHg=
X-Received: by 2002:a19:6c6:: with SMTP id 189mr15947269lfg.94.1593016880059;
 Wed, 24 Jun 2020 09:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <1592913499-15558-1-git-send-email-jrdr.linux@gmail.com>
 <c68a3805-080f-22c3-a4d3-f03be6b32176@oracle.com> <CAFqt6zZo4ZZ9sHGqMGiYoGoA8HQ2z_ijwnpr_b+PHuAzq31scw@mail.gmail.com>
 <c2130c7c-b545-218b-f2cf-69f5059f220c@oracle.com>
In-Reply-To: <c2130c7c-b545-218b-f2cf-69f5059f220c@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 24 Jun 2020 22:11:08 +0530
Message-ID: <CAFqt6zaO06gAJjWTLP4fGooLPHcm+oUJtpvhfpr6A0Zsj4PE7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 9:07 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 6/23/20 9:36 PM, Souptick Joarder wrote:
> > On Tue, Jun 23, 2020 at 11:11 PM Boris Ostrovsky
> > <boris.ostrovsky@oracle.com> wrote:
> >> On 6/23/20 7:58 AM, Souptick Joarder wrote:
> >>> In 2019, we introduced pin_user_pages*() and now we are converting
> >>> get_user_pages*() to the new API as appropriate. [1] & [2] could
> >>> be referred for more information. This is case 5 as per document [1].
> >>>
> >>> As discussed, pages need to be marked as dirty before unpinned it.
> >>>
> >>> Previously, if lock_pages() end up partially mapping pages, it used
> >>> to return -ERRNO due to which unlock_pages() have to go through
> >>> each pages[i] till *nr_pages* to validate them. This can be avoided
> >>> by passing correct number partially mapped pages & -ERRNO separately
> >>> while returning from lock_pages() due to error.
> >>> With this fix unlock_pages() doesn't need to validate pages[i] till
> >>> *nr_pages* for error scenario.
> >>
> >> This should be split into two patches please. The first one will fix the
> >> return value bug (and will need to go to stable branches) and the second
> >> will use new routine to pin pages.
> > Initially I split the patches into 2 commits. But at last moment I
> > figure out that,
> > this bug fix ( better to call coding error, doesn't looks like lead to
> > any runtime bug) is tightly coupled to 2nd commit for
> > pin_user_pages*() conversion,
> > which means we don't need the bug fix patch if we are not converting the API to
> > pin_user_pages*()/ unpin_user_pages_dirty_lock(). That's the reason to
> > clubbed these two
> > commits into a single one.
>
>
> I am not sure I understand why the two issues are connected. Failure of
> either get_user_pages_fast() or pin_user_pages() will result in the same
> kind of overall ioctl failure, won't it?
>

Sorry, I think, I need to go through the bug again for my clarity.

My understanding is ->

First, In case of success lock_pages() returns 0, so what privcmd_ioctl_dm_op()
will return to user is depend on the return value of HYPERVISOR_dm_op()
and at last all the pages are unpinned. At present I am not clear about the
return value of HYPERVISOR_dm_op(). But this path of code looks to be correct.

second, incase of failure from lock_pages() will return either -ENOSPC / -ERRNO
receive from {get|pin|_user_pages_fast() inside for loop. (at that
point there might
be some partially mapped pages as it is mapping inside the loop). Upon
receiving
-ERRNO privcmd_ioctl_dm_op() will pass the same -ERRNO to user (not the partial
mapped page count). This looks to be correct behaviour from user space.

The problem I was trying to address is, in the second scenario when
lock_pages() returns
-ERRNO and there are already existing mapped pages. In this scenario,
when unlcok_pages()
is called it will iterate till *nr_pages* to validate and unmap the
pages. But it is supposed to
unmap only the mapped pages which I am trying to address as part of bug fix.

Let me know if I am able to be in sync with what you are expecting ?


> One concern though is that we are changing how user will see this error.

My understanding from above is user will always see right -ERRNO and
will not be impacted.

Another scenario I was thinking, if {get|pin|_user_pages_fast() return
number of pages pinned
which may be fewer than the number requested. Then lock_pages()
returns 0 to caller
and caller/user space will continue with the assumption that all pages
are pinned correctly.
Is this an expected behaviour as per current code ?


> Currently Xen devicemodel (which AFAIK is the only caller) ignores it,
> which is I think is wrong. So another option would be to fix this in Xen
> and continue returning positive number here. I guess it's back to Paul
> again.
>
>
> -boris
>
>
