Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA6C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12EA20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gKxyrbz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895189AbgDOJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895120AbgDOJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:16:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28302C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:16:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k133so12187504oih.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NUFpX5X0+874xazg12sL5+CoHp00OHExFRdbolbY+Cs=;
        b=gKxyrbz+omFe6Izpzdw477lRVjZG0kgsOz7iuDPWRAwYjbuD5qUP4qJpSjabKDJRaU
         +BL/HXfY1tVxiHnTeWH8KCK+k02R+pu5jEbLxWwl+TxfwTXDN4tTRUJso2o+f0xlBhaL
         JFNM8p4ka2TKysv2KB+QMx+MQKqRwKC00GVek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NUFpX5X0+874xazg12sL5+CoHp00OHExFRdbolbY+Cs=;
        b=eWKO/R1NYnfQCgXtoktSX8S42523lfx47tW6rTq7rMVEPIHaMSnSXtWvd0FQ9l6cD1
         dT/fZvyPQp5P1KU47verHon/3yiPH/J9WeFPEAYNKAVQSCZwBou23Sn4bWcwwCBETwRg
         XSkPrHkgoYidJ7M4norANoyVPvok3MhCzUUg4/afsscbHAQwXHL4U4v+ml03vYNm6vr3
         hwsXy2vYprtMzV5OnMWVfBKBRJ6eXSEW5bPqf1KLtxlo25iwNtzDzlcIyU70oYtpWDIX
         3xcoGqWWdjjQMqC5DEcn0F4bQc0sphhUl4SgQIukr1cRx8kCooBfDTsc+ExSEyaVTs0j
         cwdg==
X-Gm-Message-State: AGi0PuZ30JGCu3EPmCEA7ldFw+WMCYsfxXnU/eDnyFsNHklrJRZ7mBCe
        ppP+ef1DLHoVc2++RGLaFJv3TsVH0Dtik4yu5Eaj9Ry3
X-Google-Smtp-Source: APiQypJjUOh6nv2pcgwPQMR6DVT/UE/f75S+/R0sjUu4lPd87AIjXo6A/D8OV/vl3Tae3FRr61UndcOwlV+jMRFnJps=
X-Received: by 2002:aca:4408:: with SMTP id r8mr16355603oia.14.1586942173410;
 Wed, 15 Apr 2020 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <1586864113-30682-1-git-send-email-bernard@vivo.com>
 <CADnq5_Phca3L-HGOQz0DPBoARHgwcJRK_a7-WmeFMPkrPWeOeg@mail.gmail.com>
 <87lfmx5h72.fsf@intel.com> <b5ffc6b7-bfa5-0827-a267-4e8c20027982@amd.com>
In-Reply-To: <b5ffc6b7-bfa5-0827-a267-4e8c20027982@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 15 Apr 2020 11:16:01 +0200
Message-ID: <CAKMK7uEYUnX3p0QUtosOaiB_9Z8epFkc8HxtBDW=mCTUrziPxw@mail.gmail.com>
Subject: Re: [PATCH] Optimized division operation to shift operation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Bernard Zhao <bernard@vivo.com>,
        Alex Sierra <alex.sierra@amd.com>,
        David Airlie <airlied@linux.ie>, Oak Zeng <Oak.Zeng@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel@vivo.com,
        Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 9:57 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.04.20 um 09:41 schrieb Jani Nikula:
> > On Tue, 14 Apr 2020, Alex Deucher <alexdeucher@gmail.com> wrote:
> >> On Tue, Apr 14, 2020 at 9:05 AM Bernard Zhao <bernard@vivo.com> wrote:
> >>> On some processors, the / operate will call the compiler`s div lib,
> >>> which is low efficient, We can replace the / operation with shift,
> >>> so that we can replace the call of the division library with one
> >>> shift assembly instruction.
> > This was applied already, and it's not in a driver I look after... but
> > to me this feels like something that really should be
> > justified. Using >> instead of / for multiples of 2 division mattered 2=
0
> > years ago, I'd be surprised if it still did on modern compilers.
>
> I have similar worries, especially since we replace the "/ (4 * 2)" with
> ">> 3" it's making the code just a bit less readable.
>
> And that the code runs exactly once while loading the driver and pushing
> the firmware into the hardware. So performance is completely irrelevant
> here.

Yeah, and even in general I'd really want to see proof that such bad
compilers exist first. Doing a peephole pass for stuff like this is
like undergrad compiler course stuff. Also I'd trust the compiler's
call on which is faster much more than humans doing a manual peephole
pass.

Or am I just massively biased from all the layman following of what
kind of our gl/vk/compute compiler people are doing on a daily basis?
-Daniel

>
> Regards,
> Christian.
>
> >
> > BR,
> > Jani.
> >
> >
> >>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> Applied.  thanks.
> >>
> >> Alex
> >>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
> >>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
> >>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
> >>>   3 files changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v6_0.c
> >>> index b205039..66cd078 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> >>> @@ -175,10 +175,10 @@ static int gmc_v6_0_mc_load_microcode(struct am=
dgpu_device *adev)
> >>>          amdgpu_ucode_print_mc_hdr(&hdr->header);
> >>>
> >>>          adev->gmc.fw_version =3D le32_to_cpu(hdr->header.ucode_versi=
on);
> >>> -       regs_size =3D le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2)=
;
> >>> +       regs_size =3D le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
> >>>          new_io_mc_regs =3D (const __le32 *)
> >>>                  (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_arra=
y_offset_bytes));
> >>> -       ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> >>> +       ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes) >> 2=
;
> >>>          new_fw_data =3D (const __le32 *)
> >>>                  (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_=
array_offset_bytes));
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v7_0.c
> >>> index 9da9596..ca26d63 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >>> @@ -193,10 +193,10 @@ static int gmc_v7_0_mc_load_microcode(struct am=
dgpu_device *adev)
> >>>          amdgpu_ucode_print_mc_hdr(&hdr->header);
> >>>
> >>>          adev->gmc.fw_version =3D le32_to_cpu(hdr->header.ucode_versi=
on);
> >>> -       regs_size =3D le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2)=
;
> >>> +       regs_size =3D le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
> >>>          io_mc_regs =3D (const __le32 *)
> >>>                  (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_arra=
y_offset_bytes));
> >>> -       ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> >>> +       ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes) >> 2=
;
> >>>          fw_data =3D (const __le32 *)
> >>>                  (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_=
array_offset_bytes));
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v8_0.c
> >>> index 27d83204..295039c 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >>> @@ -318,10 +318,10 @@ static int gmc_v8_0_tonga_mc_load_microcode(str=
uct amdgpu_device *adev)
> >>>          amdgpu_ucode_print_mc_hdr(&hdr->header);
> >>>
> >>>          adev->gmc.fw_version =3D le32_to_cpu(hdr->header.ucode_versi=
on);
> >>> -       regs_size =3D le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2)=
;
> >>> +       regs_size =3D le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
> >>>          io_mc_regs =3D (const __le32 *)
> >>>                  (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_arra=
y_offset_bytes));
> >>> -       ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> >>> +       ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes) >> 2=
;
> >>>          fw_data =3D (const __le32 *)
> >>>                  (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_=
array_offset_bytes));
> >>>
> >>> --
> >>> 2.7.4
> >>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cch=
ristian.koenig%40amd.com%7C1e91f7edcfe0473b0d7008d7e11074a8%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637225333103893889&amp;sdata=3DVDJlEY2%2Bl1SS=
O8Fw1dYqqPFqQtyHpsxQ0Tm7iVOgJQY%3D&amp;reserved=3D0
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D02%7C01%7Cc=
hristian.koenig%40amd.com%7C1e91f7edcfe0473b0d7008d7e11074a8%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637225333103893889&amp;sdata=3DEpqRRbCiksur%=
2BjMlVQplExuJsmw6UPODhyBOutOVukw%3D&amp;reserved=3D0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
