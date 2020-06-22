Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE86C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5A2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkI2USsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgFVSon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:44:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C2AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:44:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so10226929lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bsa2D8UcUdmWeSVi19Th9t5QWO+7dW+3wkTgqvnKWig=;
        b=rkI2USsN/jAc+p2oilopycy25wr5sVI0tpE2XgEi6pMS/rAQbP7Hu26UR19nfOq1AJ
         1Np5Qo2/xMDdO95rUi5ytBqxbCK2w4BlWMl5z+bmsPHMTUSBbdJt5DbMQuaFAHu3GsE3
         hwGcOZtlqQSOx98Ccw6FViwLUqd8WVOjvdPIk8D9wZMA9ReaVhAYgEHpiR64jXe9FJKD
         SSXVNwkefgbQAKI/mrun0pFeINVWBsg+T/l3iCorhuci/7B5/ehgHBErhOy9GFBHPr08
         lmKZj+cqwUytlTTcH2nJyWykLOcJJ/aZT0F2qIBlAhfLdLnxlmRp+NlswiEiG6VvnbO5
         PZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bsa2D8UcUdmWeSVi19Th9t5QWO+7dW+3wkTgqvnKWig=;
        b=bn6SC6nYMRPnbs6vIncDtvP7hpFmn96OvrRIVS7pLoW+yOHNpnIheRyKqd2GjKajOe
         4/mZw1nKI9lekk9RPA5Lzga6oj8Z06NjBPJp0MLhCPXR+jnJXVjHYXvUZ+A8nVcmH4fB
         vWdiruHqZwylNCEXXMqlfRSQBit/X51XdaKBxdhRxeJAPzbVAyAG+eo2wGDAKFhA2tUT
         aX/60zw7TF7tY5YPMWvobKXc2kTQ6+xyVSZSVdCXOlhOcOR1wBAW8yH9LPbgvZsR7zNQ
         ehKIledbN0AoZhX83NCpTyZqVT+87T4eV0Tqt9AsbIVH5Fm2JPx0gaoME4GvYhIhNmQY
         GEDw==
X-Gm-Message-State: AOAM5316bMd0jV2wHTv9cx1JLc2HwXU6bFER+Zc9EFgTOBffjmlaIktA
        cfTSHYS8Lrz8DaKY87WJZK63EcAdChnNycWQXcCF8rA4
X-Google-Smtp-Source: ABdhPJxr4uBUcKdGTWVm9gTrdLJWlX+Uz75PHVP1LlPA9Qi3PeqXxZmwj0YtBtqv0zY1bHUzBIsUY0GR1ixqYwH0wio=
X-Received: by 2002:a19:c744:: with SMTP id x65mr10603363lff.133.1592851479925;
 Mon, 22 Jun 2020 11:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <1592363698-4266-1-git-send-email-jrdr.linux@gmail.com>
 <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com> <CAFqt6zbJD+k9xkV9Se0nL2qKfnea3mRrWJ4gzPmPJBquYk4M+w@mail.gmail.com>
 <fe2a1d23-7abd-86a9-4aec-2c14fb11cdea@nvidia.com>
In-Reply-To: <fe2a1d23-7abd-86a9-4aec-2c14fb11cdea@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 23 Jun 2020 00:22:56 +0530
Message-ID: <CAFqt6zb8hK+mpqfrZ_QoGLO4nNfbHvZ7aJLRrcNRgDsywFHKqg@mail.gmail.com>
Subject: Re: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 1:00 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-06-18 20:12, Souptick Joarder wrote:
> > On Wed, Jun 17, 2020 at 11:29 PM Boris Ostrovsky
> > <boris.ostrovsky@oracle.com> wrote:
> >>
> >> On 6/16/20 11:14 PM, Souptick Joarder wrote:
> >>> In 2019, we introduced pin_user_pages*() and now we are converting
> >>> get_user_pages*() to the new API as appropriate. [1] & [2] could
> >>> be referred for more information.
>
>
> Ideally, the commit description should say which case, in
> pin_user_pages.rst, that this is.
>

Ok.

>
> >>>
> >>> [1] Documentation/core-api/pin_user_pages.rst
> >>>
> >>> [2] "Explicit pinning of user-space pages":
> >>>          https://lwn.net/Articles/807108/
> >>>
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>> ---
> >>> Hi,
> >>>
> >>> I have compile tested this patch but unable to run-time test,
> >>> so any testing help is much appriciated.
> >>>
> >>> Also have a question, why the existing code is not marking the
> >>> pages dirty (since it did FOLL_WRITE) ?
> >>
> >>
> >> Indeed, seems to me it should. Paul?
>
> Definitely good to get an answer from an expert in this code, but
> meanwhile, it's reasonable to just mark them dirty. Below...
>
> >>
> >>
> >>>
> >>>   drivers/xen/privcmd.c | 7 ++-----
> >>>   1 file changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> >>> index a250d11..543739e 100644
> >>> --- a/drivers/xen/privcmd.c
> >>> +++ b/drivers/xen/privcmd.c
> >>> @@ -594,7 +594,7 @@ static int lock_pages(
> >>>                if (requested > nr_pages)
> >>>                        return -ENOSPC;
> >>>
> >>> -             pinned = get_user_pages_fast(
> >>> +             pinned = pin_user_pages_fast(
> >>>                        (unsigned long) kbufs[i].uptr,
> >>>                        requested, FOLL_WRITE, pages);
> >>>                if (pinned < 0)
> >>> @@ -614,10 +614,7 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
> >>>        if (!pages)
> >>>                return;
> >>>
> >>> -     for (i = 0; i < nr_pages; i++) {
> >>> -             if (pages[i])
> >>> -                     put_page(pages[i]);
> >>> -     }
> >>> +     unpin_user_pages(pages, nr_pages);
>
>
> ...so just use unpin_user_pages_dirty_lock() here, I think.
>
>
> >>
> >>
> >> Why are you no longer checking for valid pages?
> >
> > My understanding is, in case of lock_pages() end up returning partial
> > mapped pages,
> > we should pass no. of partial mapped pages to unlock_pages(), not nr_pages.
> > This will avoid checking extra check to validate the pages[i].
> >
> > and if lock_pages() returns 0 in success, anyway we have all the pages[i] valid.
> > I will try to correct it in v2.
> >
> > But I agree, there is no harm to check for pages[i] and I believe,
>
>
> Generally, it *is* harmful to do unnecessary checks, in most code, but especially
> in most kernel code. If you can convince yourself that the check for null pages
> is redundant here, then please let's remove that check. The code becomes then
> becomes shorter, simpler, and faster.

I read the code again. I think, this check is needed to handle a scenario when
lock_pages() return -ENOSPC. Better to keep this check. Let me post v2 of this
RFC for a clear view.

>
>
> > unpin_user_pages()
> > is the right place to do so.
> >
> > John any thought ?
>
>
> So far I haven't seen any cases to justify changing the implementation of
> unpin_user_pages().
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
