Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D31C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205BE206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fxxu4JR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgG2JA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgG2JA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:00:27 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BDC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:00:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so7806810otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UmK1EOoeopUULrxMXYLsTAJkDmG9cp7gb5zCMJmBIlA=;
        b=fxxu4JR/i7DE9O5ZlGLUKiQCAonIX7Qx8sB73sIGrT5/sVMBnHWtVsNvEecJpcV7+x
         554+oL8XfYLleyBftZfPL/LSSznYL53wscvIMTBaZCncR3rMdFptkcqxm6Bvi0jZOsF9
         ku/fkaTFvC9etvcASnV0ncWsWdMvwYkcL1rtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UmK1EOoeopUULrxMXYLsTAJkDmG9cp7gb5zCMJmBIlA=;
        b=QVW6pCILA3zdPT0LGLh45OGkmFhkj5a1zewx2o/wd/4dkmamWEeQjfK4fuIafZLvhM
         IlhRIzxp7HpkdhPISSpFjP0gXT7XxvgAKzyMBUEoYjZU7kDfFl2kMF6BHuVol3oLQ1fc
         DFivA01dEhXr/M5ZdIYN1k1gpDhlkSp5MZbP70+fQMHezpG+tPoFeKNVaFdB7B3xzNie
         WNHfQg7gR/kY0mxKC+FFpMDnlpPP3KhN7pydULyctFwyKvDMquqVhgnRGEfFoQa0lWEn
         jwOKcBKo02czabAi/m3cAQHLaxw6J6nteSh+blhunCtsVmaTiCnDKVrrJ7HCP8kAreq6
         ilFQ==
X-Gm-Message-State: AOAM533QFTAoiEo/i6ipQBe8viaST3lWs5OK8xxrKZlAcrQMW3LBqbTu
        LQYRAUg0r5cIOFp/WhqRpCXDzppW+0ZMVwh5zgfoWQ==
X-Google-Smtp-Source: ABdhPJzuwtYV5KNLw6BsyDmEjj9Kp3russJ2dBrvJpPjepKoMKpMAn/dYyNl5rzqcZeaX4W0mMeYEU/xVB4M7yuooRI=
X-Received: by 2002:a9d:f29:: with SMTP id 38mr19252926ott.281.1596013226515;
 Wed, 29 Jul 2020 02:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200728192924.441570-1-yepeilin.cs@gmail.com> <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
In-Reply-To: <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 29 Jul 2020 11:00:15 +0200
Message-ID: <CAKMK7uE81O8vgYC9g0kL03yAtACwU4c9pE2PzKxJ7=FiUFsRHQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Trek <trek00@inbox.ru>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Evan Quan <evan.quan@amd.com>, Leo Liu <leo.liu@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:11 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 28.07.20 um 21:29 schrieb Peilin Ye:
> > Compiler leaves a 4-byte hole near the end of `dev_info`, causing
> > amdgpu_info_ioctl() to copy uninitialized kernel stack memory to usersp=
ace
> > when `size` is greater than 356.
> >
> > In 2015 we tried to fix this issue by doing `=3D {};` on `dev_info`, wh=
ich
> > unfortunately does not initialize that 4-byte hole. Fix it by using
> > memset() instead.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl=
()")
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> I can't count how many of those we have fixed over the years.
>
> At some point we should probably document that using "=3D {}" or "=3D { 0=
 }"
> in the kernel is a really bad idea and should be avoided.

I think the rule is also "don't create uapi structs with holes in
them", but we've also fumbled that one quite a few times :-/
-Daniel

>
> Thanks,
> Christian.
>
> > ---
> > $ pahole -C "drm_amdgpu_info_device" drivers/gpu/drm/amd/amdgpu/amdgpu_=
kms.o
> > struct drm_amdgpu_info_device {
> >       __u32                      device_id;            /*     0     4 *=
/
> >       __u32                      chip_rev;             /*     4     4 *=
/
> >       __u32                      external_rev;         /*     8     4 *=
/
> >       __u32                      pci_rev;              /*    12     4 *=
/
> >       __u32                      family;               /*    16     4 *=
/
> >       __u32                      num_shader_engines;   /*    20     4 *=
/
> >       __u32                      num_shader_arrays_per_engine; /*    24=
     4 */
> >       __u32                      gpu_counter_freq;     /*    28     4 *=
/
> >       __u64                      max_engine_clock;     /*    32     8 *=
/
> >       __u64                      max_memory_clock;     /*    40     8 *=
/
> >       __u32                      cu_active_number;     /*    48     4 *=
/
> >       __u32                      cu_ao_mask;           /*    52     4 *=
/
> >       __u32                      cu_bitmap[4][4];      /*    56    64 *=
/
> >       /* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
> >       __u32                      enabled_rb_pipes_mask; /*   120     4 =
*/
> >       __u32                      num_rb_pipes;         /*   124     4 *=
/
> >       /* --- cacheline 2 boundary (128 bytes) --- */
> >       __u32                      num_hw_gfx_contexts;  /*   128     4 *=
/
> >       __u32                      _pad;                 /*   132     4 *=
/
> >       __u64                      ids_flags;            /*   136     8 *=
/
> >       __u64                      virtual_address_offset; /*   144     8=
 */
> >       __u64                      virtual_address_max;  /*   152     8 *=
/
> >       __u32                      virtual_address_alignment; /*   160   =
  4 */
> >       __u32                      pte_fragment_size;    /*   164     4 *=
/
> >       __u32                      gart_page_size;       /*   168     4 *=
/
> >       __u32                      ce_ram_size;          /*   172     4 *=
/
> >       __u32                      vram_type;            /*   176     4 *=
/
> >       __u32                      vram_bit_width;       /*   180     4 *=
/
> >       __u32                      vce_harvest_config;   /*   184     4 *=
/
> >       __u32                      gc_double_offchip_lds_buf; /*   188   =
  4 */
> >       /* --- cacheline 3 boundary (192 bytes) --- */
> >       __u64                      prim_buf_gpu_addr;    /*   192     8 *=
/
> >       __u64                      pos_buf_gpu_addr;     /*   200     8 *=
/
> >       __u64                      cntl_sb_buf_gpu_addr; /*   208     8 *=
/
> >       __u64                      param_buf_gpu_addr;   /*   216     8 *=
/
> >       __u32                      prim_buf_size;        /*   224     4 *=
/
> >       __u32                      pos_buf_size;         /*   228     4 *=
/
> >       __u32                      cntl_sb_buf_size;     /*   232     4 *=
/
> >       __u32                      param_buf_size;       /*   236     4 *=
/
> >       __u32                      wave_front_size;      /*   240     4 *=
/
> >       __u32                      num_shader_visible_vgprs; /*   244    =
 4 */
> >       __u32                      num_cu_per_sh;        /*   248     4 *=
/
> >       __u32                      num_tcc_blocks;       /*   252     4 *=
/
> >       /* --- cacheline 4 boundary (256 bytes) --- */
> >       __u32                      gs_vgt_table_depth;   /*   256     4 *=
/
> >       __u32                      gs_prim_buffer_depth; /*   260     4 *=
/
> >       __u32                      max_gs_waves_per_vgt; /*   264     4 *=
/
> >       __u32                      _pad1;                /*   268     4 *=
/
> >       __u32                      cu_ao_bitmap[4][4];   /*   272    64 *=
/
> >       /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
> >       __u64                      high_va_offset;       /*   336     8 *=
/
> >       __u64                      high_va_max;          /*   344     8 *=
/
> >       __u32                      pa_sc_tile_steering_override; /*   352=
     4 */
> >
> >       /* XXX 4 bytes hole, try to pack */
> >
> >       __u64                      tcc_disabled_mask;    /*   360     8 *=
/
> >
> >       /* size: 368, cachelines: 6, members: 49 */
> >       /* sum members: 364, holes: 1, sum holes: 4 */
> >       /* last cacheline: 48 bytes */
> > };
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index a8c47aecd342..0047da06041f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -707,9 +707,10 @@ static int amdgpu_info_ioctl(struct drm_device *de=
v, void *data, struct drm_file
> >               return n ? -EFAULT : 0;
> >       }
> >       case AMDGPU_INFO_DEV_INFO: {
> > -             struct drm_amdgpu_info_device dev_info =3D {};
> > +             struct drm_amdgpu_info_device dev_info;
> >               uint64_t vm_size;
> >
> > +             memset(&dev_info, 0, sizeof(dev_info));
> >               dev_info.device_id =3D dev->pdev->device;
> >               dev_info.chip_rev =3D adev->rev_id;
> >               dev_info.external_rev =3D adev->external_rev_id;
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
