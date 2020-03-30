Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE7C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877242073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtAcIcmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgC3NYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:24:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41796 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgC3NYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:24:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so21578052wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CMTqMgwFG5tqJgidUd5oMEQh79mmBxijxw/tBJhZNas=;
        b=JtAcIcmB49EOq2i+ns9besXPK/mGZS6KK9LFemRR2CTN49cBDzOLntZVbLq0ta0uPB
         GLOVL7Bhys+xD/vH09YvCqIbTZrZp6Au416K7VZ6Pg0vW/UoW71gGeJ1OxI6sq/9QMXn
         nNaZXhecWIucMDwCkq8Ld7iFzHdS7Q3CJ8+Q2USCatVuK9AWHVB2qkWQgb3vHsuBpb0K
         hMIXZ2Fjpu9Ec2pzWrY72V4jFd/zcXggm+jVbaCUrcFwiTZyWBuClUC38xAvhyrjbaHg
         Tk6mTK+xvpcROO/0LPkbH+nagJ0nQ/M2Qdcqbb4cHdSlYWtnl9RcDV7ErU7F02lUdT3C
         QwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CMTqMgwFG5tqJgidUd5oMEQh79mmBxijxw/tBJhZNas=;
        b=AyU0RO/BDc/QMuo6+wDwIdJbgjjBQjb2yrTG/Vk1I4rWIJlCco4fhMbvQTVR/AGIDn
         n+7sm7wFC5N7LdO5NpnHTzPGpcG0zUurj63tHJoH9C7ll9rN4zVii7xLRnyFXi5HuQZT
         cw/Bo7nMFy/2GimVy1NTTro1k0RrHzbkYWzpugfcsAutr2gHRoV2xgA1Fxp22CdT4H09
         tlk44zIHWwWyYYQlMxIOsuWTyQmpw6t5oslOLgnpNVSyoXN1fkHaEX2nsYMqRCNgVDOi
         SlSXIF9pkYWGt5vbkICynJ6aBWup042fLKZR7rTAaBgjN1DbWn7ieT5D+gAl+9Oo960j
         kgYw==
X-Gm-Message-State: ANhLgQ1lcufsj9mDd9FgYCTUe8vPZOVpemlGbKp+b/Ew9fA5ROHXr0+F
        sJttjylWQOBpzngOiiCUg0voetUeoh9YBxn0BhQ=
X-Google-Smtp-Source: ADFU+vtJye8xW+n9VCoeqE0xOpGyTc9Q3qOk0ZnFhU0eMORf5tBG0rZftxN1dqcqRiYTuaslunqVrqYQYaS24exoqyQ=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr15754494wrw.124.1585574641716;
 Mon, 30 Mar 2020 06:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-2-bigbeeshane@gmail.com> <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
 <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com> <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
 <cd773011-969b-28df-7488-9fddae420d81@samsung.com> <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
In-Reply-To: <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Mar 2020 09:23:50 -0400
Message-ID: <CADnq5_O6pwxJsYdfJO0xZtmER05GtO+2-4uHTeexKNeHyUq8_Q@mail.gmail.com>
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shane Francis <bigbeeshane@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx-request@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 4:18 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 2020-03-27 10:10, Marek Szyprowski wrote:
> > Hi Christian,
> >
> > On 2020-03-27 09:11, Christian K=C3=B6nig wrote:
> >> Am 27.03.20 um 08:54 schrieb Marek Szyprowski:
> >>> On 2020-03-25 10:07, Shane Francis wrote:
> >>>> As dma_map_sg can reorganize scatter-gather lists in a
> >>>> way that can cause some later segments to be empty we should
> >>>> always use the sg_dma_len macro to fetch the actual length.
> >>>>
> >>>> This could now be 0 and not need to be mapped to a page or
> >>>> address array
> >>>>
> >>>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> >>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> >>> This patch landed in linux-next 20200326 and it causes a kernel
> >>> panic on
> >>> various Exynos SoC based boards.
> >>>> ---
> >>>>    drivers/gpu/drm/drm_prime.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime=
.c
> >>>> index 86d9b0e45c8c..1de2cde2277c 100644
> >>>> --- a/drivers/gpu/drm/drm_prime.c
> >>>> +++ b/drivers/gpu/drm/drm_prime.c
> >>>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct
> >>>> sg_table *sgt, struct page **pages,
> >>>>           index =3D 0;
> >>>>        for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> >>>> -        len =3D sg->length;
> >>>> +        len =3D sg_dma_len(sg);
> >>>>            page =3D sg_page(sg);
> >>>>            addr =3D sg_dma_address(sg);
> >>> Sorry, but this code is wrong :(
> >>
> >> Well it is at least better than before because it makes most drivers
> >> work correctly again.
> >
> > Well, I'm not sure that a half-broken fix should be considered as a
> > fix ;)
> >
> > Anyway, I just got the comment from Shane, that my patch is fixing the
> > issues with amdgpu and radeon, while still working fine for exynos, so
> > it is indeed a proper fix.
>
> Today I've noticed that this patch went to final v5.6 without even a day
> of testing in linux-next, so v5.6 is broken on Exynos and probably a few
> other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays
> function.

Please commit your patch and cc stable.

Alex


>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
