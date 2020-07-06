Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5610720724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHLmccG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgGFQQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgGFQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:16:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B46C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:16:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so41669535wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yz2Lu0SuQBxmA1yiSx4cV9N5MOcxP7/bmwy4RMynB00=;
        b=cHLmccG1IfLXxZSXQzHgTrTcO67QvQhmhBayONvjj4l+ywHXzr+gYA06IbHXd2Jn4l
         d58q7JP6OJm93GpaKt7iNjP4/x13IO0ZewWvO3fJW7GCRXgddSWPx7fzz8Vq7cdc2eIK
         23IBTE26v8UK5739T3ZvZ/41HZGoBkQNpIg/D1KHJzxc1S2K6lAbdvbpm2rh7LHNHKkW
         LYwkUZpZtI9Fcqjb2RYhPjUQMUzcIVzHSuokIsqTiJ4lju81JmyYkt4yDK3AqVDLl3fe
         LetIUbf59tTRpIrJV4XWWk7tvRs9Sa49ieF1EdP5KSnCSGrR07AJVBAuQjbFjDn5N4Bn
         dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yz2Lu0SuQBxmA1yiSx4cV9N5MOcxP7/bmwy4RMynB00=;
        b=dbYP/IEfVi1xy/6u3nuI/A89wIldE9LR/e3TVQ0DLhE8CzOdf/NATVjloCxrwM9qYX
         oyEaLcxf+rB1/XdxB9bhdJ+ZnBLNknUKxE8pOjrmZtNtleMSMFcDNZtt9guWsVw6ALPG
         JvP+onGS4d8ns8o9MnNOrRE/rmdKLA2MGrPfSj/NwltLNtGmJjRzFHFb6Dx7415fW+gz
         fyqIbdxLW617cignSOCtACiKjVzGWKwo5pFiRPxao2fakI7RrMadCriPnrB6uVIDtRYV
         +v+YSWwAlf3f5qyA1QqifHQ508l4N/MZK/BMD/eSR38qRIoIhYM4+rFnrHtgtI3wZFHf
         wjTw==
X-Gm-Message-State: AOAM530LFD80UGgM9vY2Wh01xTQrNAHJWpZDIb0gk4kISmg6eT8EflXX
        sBBvTmnnFA4pfszUS9ar1SkwDahhH190ZolBRm4swg==
X-Google-Smtp-Source: ABdhPJw/bbS5gsiasYmCtDJFirI5m3ZZ0tso1ApMUlc26NziFaaNZPdAf8DpkF1PoYjkwEOMZwcJa5SHaGk27O+6aXU=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr51382760wrw.374.1594052211679;
 Mon, 06 Jul 2020 09:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
 <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com> <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
 <7aa4d0c5-14ba-594d-e3fb-9acba82cf45d@amd.com> <897b806e-dba8-710f-6b62-2493e3033417@loongson.cn>
In-Reply-To: <897b806e-dba8-710f-6b62-2493e3033417@loongson.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Jul 2020 12:16:40 -0400
Message-ID: <CADnq5_M4Dk=+MDc7VdeQ1SN6QpPhkRMX9z84Qo4Q_DMw3xS7+A@mail.gmail.com>
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jul 2, 2020 at 11:54 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> On 07/02/2020 04:39 PM, Christian K=C3=B6nig wrote:
> > Am 02.07.20 um 10:35 schrieb Tiezhu Yang:
> >> On 07/02/2020 04:27 PM, Christian K=C3=B6nig wrote:
> >>> Am 02.07.20 um 04:27 schrieb Tiezhu Yang:
> >>>> When I update the latest kernel, I see the following
> >>>> "____ptrval____" boot
> >>>> messages.
> >>>>
> >>>> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu
> >>>> addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
> >>>> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu
> >>>> addr 0x0000000040056038 and cpu addr 0x(____ptrval____)
> >>>>
> >>>> Both radeon_fence_driver_start_ring() and
> >>>> amdgpu_fence_driver_start_ring()
> >>>> have the similar issue, there exists the following two methods to
> >>>> solve it:
> >>>> (1) Use "%pK" instead of "%p" so that the CPU address can be
> >>>> printed when
> >>>> the kptr_restrict sysctl is set to 1.
> >>>> (2) Just completely drop the CPU address suggested by Christian,
> >>>> because
> >>>> the CPU address was useful in the past, but isn't any more. We now
> >>>> have a
> >>>> debugfs file to read the current fence values.
> >>>>
> >>>> Since the CPU address is not much useful, just remove the debug
> >>>> info about
> >>>> CPU address.
> >>>>
> >>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>
> >>> Splitting it into one patch for radeon and one for amdgpu might be
> >>> nice to have.
> >>
> >> Should I split this patch into two patches and then send v3?
> >> If yes, I will do it soon.
> >
> > For me it's ok to merge it like it is now.
> >
> > Only Alex could insists to split the patches, but then he will
> > probably do it himself.
>
> OK, then I will not send v3.
>
> >
> > Thanks for the help,
> > Christian.
> >
> >>
> >>>
> >>> But either way Reviewed-by: Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> for the patch.
> >>>
> >>> Thanks,
> >>> Christian.
> >>>
> >>>> ---
> >>>>
> >>>> v2:
> >>>>    - Just remove the debug info about CPU address suggested by
> >>>> Christian
> >>>>    - Modify the patch subject and update the commit message
> >>>>
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
> >>>>   drivers/gpu/drm/radeon/radeon_fence.c     | 4 ++--
> >>>>   2 files changed, 4 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> index d878fe7..a29f2f9 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>>> @@ -422,9 +422,8 @@ int amdgpu_fence_driver_start_ring(struct
> >>>> amdgpu_ring *ring,
> >>>>       ring->fence_drv.irq_type =3D irq_type;
> >>>>       ring->fence_drv.initialized =3D true;
> >>>>   -    DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu
> >>>> addr "
> >>>> -              "0x%016llx, cpu addr 0x%p\n", ring->name,
> >>>> -              ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
> >>>> +    DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr
> >>>> 0x%016llx\n",
> >>>> +              ring->name, ring->fence_drv.gpu_addr);
> >>>>       return 0;
> >>>>   }
> >>>>   diff --git a/drivers/gpu/drm/radeon/radeon_fence.c
> >>>> b/drivers/gpu/drm/radeon/radeon_fence.c
> >>>> index 43f2f93..8735bf2 100644
> >>>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> >>>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> >>>> @@ -865,8 +865,8 @@ int radeon_fence_driver_start_ring(struct
> >>>> radeon_device *rdev, int ring)
> >>>>       }
> >>>>       radeon_fence_write(rdev,
> >>>> atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
> >>>>       rdev->fence_drv[ring].initialized =3D true;
> >>>> -    dev_info(rdev->dev, "fence driver on ring %d use gpu addr
> >>>> 0x%016llx and cpu addr 0x%p\n",
> >>>> -         ring, rdev->fence_drv[ring].gpu_addr,
> >>>> rdev->fence_drv[ring].cpu_addr);
> >>>> +    dev_info(rdev->dev, "fence driver on ring %d use gpu addr
> >>>> 0x%016llx\n",
> >>>> +         ring, rdev->fence_drv[ring].gpu_addr);
> >>>>       return 0;
> >>>>   }
> >>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
