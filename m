Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A75120658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QybsQxJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHJUfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgHJUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:35:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF70C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:35:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d190so691998wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rj9eDSRUMS+uoQYuFAG8NxQuUnLDOM6gUVvpTrrcc8w=;
        b=QybsQxJy/ElzjYPLGbTsU/V8hleE5mE6MAqb3CN+8bjIDiEzMYYctbRm3KiA/O+W0+
         rwUdf8vPY5tCPP/BkjSJM5fF5d3Cq5f71/15cpTM5+SM1ov8SkvVKCwjEHpmW/ltg2ku
         1GBp5RP1kpFpLPrmUduqMb9p1800gj4eNPhfBCi8xjZd/7W4/JIhRWWpBftKwsP7f/lS
         gylzj0kBSVcvxnj8qRGtTyaLfE0y6pgMsYwtk+i75Pz3NzTVNfs+ulSReUEIuhah2Wco
         V+2zo0zMLLAdRQRbKyD3bte+IcjwpWDkuznlk3if8uQFjDaVWRiJWWljzEvDb0UwDl4m
         XCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rj9eDSRUMS+uoQYuFAG8NxQuUnLDOM6gUVvpTrrcc8w=;
        b=bYT0HTAjsntwxXBVKGGPY/aSYNo6gdd8tmlT+aAwHATpMW2SLCdxj2h9g5eK6taQkU
         E2JkexgMFP2/tvWt8e7AdLqbmxzQ7+vKTKTYbDNza16whWtVRwWTutMudO6movSkey2u
         Q8VDh5bKjr6hiOjkfhbEsGz2fxu+A9L/R9hLkrzHZORj2BE0q5rSpgYzEJ1za3OuCpBn
         NzG2qlZLOK44qEG0JK94WZZH6l+xxIDkeBRYOARaNy6L1dmAdqCAi4sntj9KsZ83/toq
         jcCKPLIB7JikiZzO23htWAsj7WgPAu6nLCYFZIBCZrkmhzYXacRhcmmg/QmLBk4lCFzk
         c3vA==
X-Gm-Message-State: AOAM533gFMyEjvQko2UKvLEPeTO+qNOUt2bM9UejZP+C6tOjRFMh3snV
        Re/acuPtwjHL5wV/dhAGsNKi57RcO6Hqeo0ZJxI=
X-Google-Smtp-Source: ABdhPJwHB9sIi+j3T1OLW8JLlCEir2qtZHzNKYnP01f0oYBnT1ztBA/Al7WGFDeax9Yn3C2g7QwGWG39DVsnYOgmVgg=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr909508wmj.56.1597091748595;
 Mon, 10 Aug 2020 13:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAB-2Q08KQmS0D06k1QEUpccybGqCY+HYaZkF=sY0t1EX8Y_u2Q@mail.gmail.com>
 <alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru> <3f687bb2-d5c0-d538-53f4-af2b444bb1b6@gmail.com>
In-Reply-To: <3f687bb2-d5c0-d538-53f4-af2b444bb1b6@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Aug 2020 16:35:37 -0400
Message-ID: <CADnq5_P6SSJCiHkZfgzZcMLbFOG1_qHe8D+oQgZppXQhEEhttQ@mail.gmail.com>
Subject: Re: Non-deterministically boot into dark screen with `amdgpu`
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Ignat Insarov <kindaro@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 7:46 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi guys,
>
> Am 10.08.20 um 08:43 schrieb Alexander Monakov:
>
> Hi,
>
> you should =D0=A1=D1=81 a specialized mailing list and a relevant maintai=
ner,
> otherwise your email is likely to be ignored as LKML is an incredibly
> high-volume list. Adding amd-gfx and Alex Deucher.
>
>
> Thanks for forwarding this. AFAIK we haven't heard of this bug before, bu=
t Alex already might know more about it.
>
> More thoughts below.
>
> On Sun, 9 Aug 2020, Ignat Insarov wrote:
>
> Hello!
>
> This is an issue report.=E2=80=82I am not familiar with the Linux kernel
> development procedure, so please direct me to a more appropriate or
> specialized medium if this is not the right avenue.
>
> My laptop (Ryzen 7 Pro CPU/GPU) boots into dark screen more often than
> not.=E2=80=82Screen blackness correlates with a line in the `systemd` jou=
rnal
> that says `RAM width Nbits DDR4`, where N is either 128 (resulting in
> dark screen) or 64 (resulting in a healthy boot).=E2=80=82The number seem=
s to
> be chosen at random with bias towards 128.=E2=80=82This has been going on=
 for
> a while so here is some statistics:
>
> * 356 boots proceed far enough to  attempt mode setting.
> * 82 boots set RAM width to 64 bits and presumably succeed.
> * 274 boots set RAM width to 128 bits and presumably fail.
>
> The issue is prevented with the `nomodeset` kernel option.
>
> I reported this previously (about a year ago) on the forum of my Linux
> distribution.[1]=E2=80=82The issue still persists as of  linux 5.8.0.
>
> The details of my graphics controller, as well as some journal
> excerpts, can be seen at [1].=E2=80=82One thing that has changed since th=
en is
> that on failure, there now appears a null pointer dereference error.=E2=
=80=82I
> am attaching the log of kernel messages from the most recent failed
> boot =E2=80=94 please request more information if needed.
>
> I appreciate any directions and advice as to how I may go about fixing
> this annoyance.
>
> [1]: https://bbs.archlinux.org/viewtopic.php?id=3D248273
>
> On the forum you show that in the "success" case there's one less "BIOS
> signature incorrect" message. This implies that amdgpu_get_bios() in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> gets the video BIOS from a different source. If that happens every time
> (one "signature incorrect" message for "success", two for "failure")
> that may be relevant to the problem you're experiencing.
>
> If you don't mind patching and rebuilding the kernel I suggest adding
> debug printks to the aforementioned function to see exactly which methods
> fail with wrong signature and which succeeds.
>
> Also might be worthwhile to check if there's a BIOS update for your lapto=
p.
>
>
> It might also be a good idea to try the latest amd-staging-drm-next branc=
h from Alex repository (bear with me I don't have the link at hand, but it =
should be easy to find).
>
> Opening a bug report or searching the existing ones for something similar=
 under https://gitlab.freedesktop.org/drm/amd/-/issues might be a good idea=
 as well.
>
> And I completely agree that this sounds like an issue getting the BIOS im=
age.

I've not heard of an issue like this either.  Best to file a gitlab
bug and attach your full dmesg output in both the working and
non-working cases and we can go from there.

Alex

>
> Thanks,
> Christian.
>
>
> Alexander
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
