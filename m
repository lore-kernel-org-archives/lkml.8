Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5515C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CB72078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBuNpmAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgCaOKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:10:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41836 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbgCaOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:10:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so26122674wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6KkVAX9LHQdy5bHn212eBpteLV15dAVUf1jSf5zOtEI=;
        b=CBuNpmAdmCOS9vPjHPGBzs3t/L7Yy6BKi/X/WMLwNFHK85ob3GXcaVicIX131gfJn2
         OU8OqjmxYznVOzw9ShEUda19LDx6ErO2Z1y5NCgqYgJ9BmkpVH4/K8MyjDXe13mjsxg/
         BB2i6Sy9cMjQttATOhQ32MukPB1hmG3r5LI7JfjFRrRlI7C3qBFymVIWXYs+kVfaC3zk
         R1uXZpAWPjrh9ry545106iUh6fNP3A4aLtkpmQyyG20Bvkkfyr7VSel8H2al5hDn3JM7
         dCvpRDi901uzlVNmgDNP1wHvYyRMuDAxcI7kD5o/IFirSeHOgzVBdQko+U/ah64ZsuKK
         7bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6KkVAX9LHQdy5bHn212eBpteLV15dAVUf1jSf5zOtEI=;
        b=rsV0hEfjB2mwFfhm2blTCjFc0hjSmqoDiFvMOHq9Eg5C6k7+l4eyQ/l8oOk6IAsQdV
         /QyvBitSLSZcN9NFMfc22zonzJ0XBu//r0n68p/kcw/d33b0aWmu4wzUUMqmkatbU+hI
         YWITmuW5kc8pNfb75bZt8hLheXYIC5tscW0/mtw54Gm/caT0JXeKi8vnvzXuFKZOXsPI
         5O+bvFtQT9tFBhDCXJR9XFw2zj9hKPMF5wHkayjODcsJaKEdZ8VPrj1Jtw0pE7WvhWFl
         oAYKlqB/H/0Iy9Ll4ovYwkBGHXPe45b+om/moXfZd3CYOvwDl0cRktbU/Z6uK6Sg9lHj
         qgUw==
X-Gm-Message-State: ANhLgQ0noas0ao586CQdvijtrrBkDJXKYZ18f0LR19nletuW4xD04Ysn
        jCDnC7vvHMUOxrTlHGPYGO73fvR1sAboiiARixg=
X-Google-Smtp-Source: ADFU+vuptnxHXiRXfHruTSFrIWhJmSwzLXngCmzoyKLq6ikXfD7hMknhh7AogD4BJxghw+8QXj8CfDHg6qw7LeNCLRA=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr21860749wrw.124.1585663828600;
 Tue, 31 Mar 2020 07:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-2-bigbeeshane@gmail.com> <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
 <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com> <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
 <cd773011-969b-28df-7488-9fddae420d81@samsung.com> <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
 <CADnq5_O6pwxJsYdfJO0xZtmER05GtO+2-4uHTeexKNeHyUq8_Q@mail.gmail.com> <3a0cb2bc-84be-6f9f-a0e8-ecb653026301@samsung.com>
In-Reply-To: <3a0cb2bc-84be-6f9f-a0e8-ecb653026301@samsung.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Mar 2020 10:10:17 -0400
Message-ID: <CADnq5_NEhfZwE6B0UBu0My7Sk5YNoDE=7Nj_CUYpPe9HOjpjqQ@mail.gmail.com>
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

On Tue, Mar 31, 2020 at 1:25 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Alex,
>
> On 2020-03-30 15:23, Alex Deucher wrote:
> > On Mon, Mar 30, 2020 at 4:18 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> Hi
> >>
> >> On 2020-03-27 10:10, Marek Szyprowski wrote:
> >>> Hi Christian,
> >>>
> >>> On 2020-03-27 09:11, Christian K=C3=B6nig wrote:
> >>>> Am 27.03.20 um 08:54 schrieb Marek Szyprowski:
> >>>>> On 2020-03-25 10:07, Shane Francis wrote:
> >>>>>> As dma_map_sg can reorganize scatter-gather lists in a
> >>>>>> way that can cause some later segments to be empty we should
> >>>>>> always use the sg_dma_len macro to fetch the actual length.
> >>>>>>
> >>>>>> This could now be 0 and not need to be mapped to a page or
> >>>>>> address array
> >>>>>>
> >>>>>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> >>>>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> >>>>> This patch landed in linux-next 20200326 and it causes a kernel
> >>>>> panic on
> >>>>> various Exynos SoC based boards.
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/drm_prime.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_pri=
me.c
> >>>>>> index 86d9b0e45c8c..1de2cde2277c 100644
> >>>>>> --- a/drivers/gpu/drm/drm_prime.c
> >>>>>> +++ b/drivers/gpu/drm/drm_prime.c
> >>>>>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct
> >>>>>> sg_table *sgt, struct page **pages,
> >>>>>>            index =3D 0;
> >>>>>>         for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> >>>>>> -        len =3D sg->length;
> >>>>>> +        len =3D sg_dma_len(sg);
> >>>>>>             page =3D sg_page(sg);
> >>>>>>             addr =3D sg_dma_address(sg);
> >>>>> Sorry, but this code is wrong :(
> >>>> Well it is at least better than before because it makes most drivers
> >>>> work correctly again.
> >>> Well, I'm not sure that a half-broken fix should be considered as a
> >>> fix ;)
> >>>
> >>> Anyway, I just got the comment from Shane, that my patch is fixing th=
e
> >>> issues with amdgpu and radeon, while still working fine for exynos, s=
o
> >>> it is indeed a proper fix.
> >> Today I've noticed that this patch went to final v5.6 without even a d=
ay
> >> of testing in linux-next, so v5.6 is broken on Exynos and probably a f=
ew
> >> other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays
> >> function.
> > Please commit your patch and cc stable.
>
> I've already did that: https://lkml.org/lkml/2020/3/27/555

Do you have drm-misc commit rights or do you need someone to commit
this for you?

Alex


>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
