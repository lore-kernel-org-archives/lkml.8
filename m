Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8235C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2662072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMr2IQjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFBJte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:49:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37142C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 02:49:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so1154475plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCSz+uYodVj42SY8RVM02hyZNCG8C1YkgVUlyk0KTjU=;
        b=SMr2IQjG7D46C5m9upI3klxct3blMqDraFFkJYfnknlybYOmcYPnZXmRNHIfss5yzk
         vQwSNY0YWdC9St5dXcDpurLKIOvgtbBNTpvf9/pSI7opdPZsuy/4G7kQMoY1aoN6YbJv
         Ksspyv4MxvHyha/frHRMpppbr7/jIkNgTNn7SegtOf46UcpRZtQrmHMhyKxhHle8TzaB
         y946LTPjdgOnZLq1+UyZOSU0fXd7x8wLUZlmmEDDfRZ1OieUK6DrER+Z/MeFXCiIoeCp
         MPVbFnZ8fhfvWNZZtLbHs8YyqacdK90NiR5+7T5p41J31Ailu1w9e6c73WdufDG+4iBM
         o2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCSz+uYodVj42SY8RVM02hyZNCG8C1YkgVUlyk0KTjU=;
        b=hXY9Mkzq3hpi+RQepBp/hYgvd/+o4eH4NFvNzqq5mZGuyYFXCQiSybf5J5zqtbGRtN
         U0vjnq2cH+ZgRU34Jt09sxFrraWIpgqlQShbXlM9UoCL4O8y6bNLz88kgD4+c10pZevx
         K5Kpf+LOVq5lRKssxrnkOzPTgVJsQsv7VAD+S4y1inzaYdKi9FsIGK0uYWRUv5oPurYh
         W02a9hZ4QDO6YZg0LAdW66KXBLCEUzpthDhrcasxSxGn7Oq6RFaBjlhra1ZlU2Dsk/u0
         reKyyGbFzAiBDwk9lmMkUjx0V3+E7faIzVTk+/lvIjyqVWljp3iN8eBPFPcR+m2AXJMI
         /tTQ==
X-Gm-Message-State: AOAM530/xu6+1xkmNAyXpdxM9ZRUJLEzJdw3GHM2dYmPpEUunDVnPcpA
        ECHcwQj129PMxnPFrr05smdXSG7DECF4qb4deG8=
X-Google-Smtp-Source: ABdhPJymZ6h2WYYw5fSCwRyhn3hpPpEakJ8uvqOtOyGfE8Ue5GAXhScl1/g8/52s+KsGW/qY9axU6XvClMPQIAyj23Y=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr4643652pje.129.1591091371638;
 Tue, 02 Jun 2020 02:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 12:49:20 +0300
Message-ID: <CAHp75Ve9tdNB7s+gybsg-OUjA3HiZBgzxeOzw=qkx8t1Ybbmsg@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 12:24 PM Piotr Stankiewicz
<piotr.stankiewicz@intel.com> wrote:
>
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
>
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 5ed4227f304b..6dbe173a9fd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -251,11 +251,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>                 int nvec = pci_msix_vec_count(adev->pdev);
>                 unsigned int flags;
>
> -               if (nvec <= 0) {
> +               if (nvec > 0)
> +                       flags = PCI_IRQ_MSI_TYPES;
> +               else
>                         flags = PCI_IRQ_MSI;
> -               } else {
> -                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -               }
> +
>                 /* we only need one vector */
>                 nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);

I'm not sure if you have seen my last comment internally about this patch.

I don't understand why we need these pci_msix_vec_count() followed by
conditional at all.
Perhaps we may simple drop all these and supply flag directly?

But OTOH, I don't know the initial motivation, so, the above patch is
non-intrusive and keeps original logic.

>                 if (nvec > 0) {
> --
> 2.17.2
>


-- 
With Best Regards,
Andy Shevchenko
