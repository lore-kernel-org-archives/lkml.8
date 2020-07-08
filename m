Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93983C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4B20738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADC+/wSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgGHB6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGHB6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:58:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44937C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 18:58:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so52260362ljv.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=753o6lI+14JCSrORPzmiJM1I+sNyMEUrssi+r3hqays=;
        b=ADC+/wSk/ZvHTMRaqZVMsFab7QmR7F76m5bIXFQTCrGykFlnIcim/Mt9DsEFFmtIqH
         7QdE4Mw68tnCRxeihzvLD2YG4tKnCEXfsbVEMo502yX58MvOY1yGfgr9ZxBhctr/ThOQ
         nmwwiLCIVazXAt/cNFopl1b2jRhIDsjMxgzz/AcofwcRa/m2kc7oVv068u0HrhCjGaD1
         NjSUa0zJjtYdkT5c1r6Xd4h+m7qBgQGpKNIrXpkJLxjJw2T+Illoq7YlHWKRR0ySKZcs
         +993mJrKClq5YuIXWBrcwfJi1dvDLxJgtnPKMg6mk9uDmVkn1Oq3q2EkSBmIdL2XbUto
         /0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=753o6lI+14JCSrORPzmiJM1I+sNyMEUrssi+r3hqays=;
        b=BfhfXPJvptAaTWjYWqK/g1bWEJcaygCctc+aKPDUjNSCPKcPZet+N1Bahv2UtKZdWu
         elc94a/HUFCQzEuJDrRVPrSwcEHMCe3o5GvyMF5xeOSFm2mb+9DJ0rEohlhb4OMRxaXr
         yg86kC9mPoRT338LIQ4IQHp9sgb1DAUoYvYc+d6XBPEqD81DvFJ3Y/z0EXB7FFHgFFaf
         nY4osewP0qdmq2xKEEhRNTapAkoimB/3vmen/pYAG0oTr46QcqeWCZVM8vDiDD4ebW5R
         YTvxRrUakH9hVbBMTtxTu5g25kR0bsDZziaAE5EICsKrkqbLcRxYNciS+uUlw6q0GjmR
         55YA==
X-Gm-Message-State: AOAM532d5Fz72YRPDA29sFs1UAOribzNzwryx4PkI8FwaFS105L2hf+p
        eF5mgbfW6HDqJD1+ykdgk5fAPAnAlCWN/zPEJQY=
X-Google-Smtp-Source: ABdhPJwX7jxnpPSaGjGI8Z53hHfavgWbxkjQSz6JsvYOwflqZC+IcLyYA9D4DBIx0PEz3GyhJjdcCJ8z+zeYHjD+EwI=
X-Received: by 2002:a2e:920e:: with SMTP id k14mr33414682ljg.430.1594173518700;
 Tue, 07 Jul 2020 18:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
 <1594059372-15563-2-git-send-email-jrdr.linux@gmail.com> <4bafb184-6f07-2582-3d0f-86fb53dd30dc@suse.com>
 <CAFqt6zaWbEiozfkEuMvusxig15buuS1vjJaj4Q5okxNsRz_1vw@mail.gmail.com> <7208d7fe-8822-8e9b-e531-05238ece0b02@suse.com>
In-Reply-To: <7208d7fe-8822-8e9b-e531-05238ece0b02@suse.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 8 Jul 2020 07:37:00 +0530
Message-ID: <CAFqt6zYXnD2VvGNcAnLC3BTyA4vSBpFLHQq3h+BzEDQcGRJD2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] xen/privcmd: Corrected error handling path
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 5:15 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrot=
e:
>
> On 07.07.20 13:40, Souptick Joarder wrote:
> > On Tue, Jul 7, 2020 at 3:05 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> =
wrote:
> >>
> >> On 06.07.20 20:16, Souptick Joarder wrote:
> >>> Previously, if lock_pages() end up partially mapping pages, it used
> >>> to return -ERRNO due to which unlock_pages() have to go through
> >>> each pages[i] till *nr_pages* to validate them. This can be avoided
> >>> by passing correct number of partially mapped pages & -ERRNO separate=
ly,
> >>> while returning from lock_pages() due to error.
> >>>
> >>> With this fix unlock_pages() doesn't need to validate pages[i] till
> >>> *nr_pages* for error scenario and few condition checks can be ignored=
.
> >>>
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >>> Cc: Paul Durrant <xadimgnik@gmail.com>
> >>> ---
> >>>    drivers/xen/privcmd.c | 31 +++++++++++++++----------------
> >>>    1 file changed, 15 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> >>> index a250d11..33677ea 100644
> >>> --- a/drivers/xen/privcmd.c
> >>> +++ b/drivers/xen/privcmd.c
> >>> @@ -580,13 +580,13 @@ static long privcmd_ioctl_mmap_batch(
> >>>
> >>>    static int lock_pages(
> >>>        struct privcmd_dm_op_buf kbufs[], unsigned int num,
> >>> -     struct page *pages[], unsigned int nr_pages)
> >>> +     struct page *pages[], unsigned int nr_pages, unsigned int *pinn=
ed)
> >>>    {
> >>>        unsigned int i;
> >>> +     int page_count =3D 0;
> >>
> >> Initial value shouldn't be needed, and ...
> >>
> >>>
> >>>        for (i =3D 0; i < num; i++) {
> >>>                unsigned int requested;
> >>> -             int pinned;
> >>
> >> ... you could move the declaration here.
> >>
> >> With that done you can add my
> >>
> >> Reviewed-by: Juergen Gross <jgross@suse.com>
> >
> > Ok. But does it going make any difference other than limiting scope ?
>
> Dropping the initializer surely does, and in the end page_count just
> replaces the former pinned variable, so why would we want to widen the
> scope with this patch?

Agree, no reason to move it up. Will change it in v3.

>
>
> Juergen
