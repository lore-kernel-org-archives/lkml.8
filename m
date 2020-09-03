Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD10520716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD5y4AVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgICFS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICFSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:18:55 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA8C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 22:18:53 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h20so1291265ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMG/YvwAu6GpU0qnZrimosi1RruS9P3GeGTh89bHuS4=;
        b=MD5y4AVGM/7BLLih2AJc7iRJNh+2+RVnOs49zHeruvZa/TB8KHE1Jiim9E2y4j+XvP
         VyWp+V4hsV9dq48Ns3A2hxsgbzeFxIKLQzEAba2GzLB9/INNhzPYnAmNQWCdkjtCxQ6e
         L0o9703xBFvS8rrPzttkIX+sBHe5BURG9Z14YRRPfWIStqVapvH3bnPGupYpLMSdlwYT
         pomekm9JzNWlE2S3mCRXfrZPkzhO0BehTTlyYqHf+KLKUHgL0cbX2xDDK0XEFI3SXWfy
         KeMi7rzz6gaHhwV8rA/UCks1xpYvoGM6LSGFgMJ0TsYELaPK4tqsIofSwukpeVTXNqQL
         qtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMG/YvwAu6GpU0qnZrimosi1RruS9P3GeGTh89bHuS4=;
        b=GcaSOswK1UmvWNEqA6IhnX3BM0gXIFdsHzmpG0R/0IaplT5XTZ56Ctesil+TivI9Ac
         VKc2alRo+UCERf9dZWyM3SWgHKPmQ0BQ6lnXQBNGC7Y9Fjiaj/1h24uObvyTO8s5BMcl
         8bJ+pMG5MrV6UB7RHwW2dNRtZxtq+IYH/oP+57Ngrlvfi+/n6ChgnBK7+oYVqVzVjSrK
         UiwvX/tWkKlznfepIKGezEneZAo5snjlmc9+Ogf8ufFFZ7yrxK8NJPzApabAS/PQmpwc
         g3oItpNzwHEsQ0sUoFGhsKR6g5x8bGFQktUXNK8BcIKZO9GNBk6vAfTcO1J+52F/AICz
         q1TA==
X-Gm-Message-State: AOAM530XqvbL6pAnP1+gmdpd5htPLo7FFFnmw1bNeGq4akFhLfuucT8x
        D0twW8LkvRcTt6TJQkW3VqTZ/Xp9au10XtvTDGAoJIuKDBwxbA==
X-Google-Smtp-Source: ABdhPJwzxhx6AheCQUktX6BlMnijmZT8oElnOkvBR4U+ZQbkb0EnD93LCQoV8OO4qZSs5v4iExtA/XcXPHWaxm+ZA+o=
X-Received: by 2002:a25:bc82:: with SMTP id e2mr312073ybk.435.1599110332474;
 Wed, 02 Sep 2020 22:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200831203111.4940-1-rcampbell@nvidia.com>
In-Reply-To: <20200831203111.4940-1-rcampbell@nvidia.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 3 Sep 2020 15:18:41 +1000
Message-ID: <CACAvsv4yP2xR4aayzFDT8nGfM69j5ogZUxjoV4f0P58pEJq3RQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] nouveau: fix the start/end range for migration
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 06:31, Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> The user level OpenCL code shouldn't have to align start and end
> addresses to a page boundary. That is better handled in the nouveau
> driver. The npages field is also redundant since it can be computed
> from the start and end addresses.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Thanks Ralph,

Queued in my tree.

Ben.

> ---
>
> This is for Ben Skegg's nouveau tree.
>
> I have been working with Karol Herbst on the OpenCL mesa changes for
> nouveau which will be merged upstream soon.
> With or without those changes, the user visible effect of this patch
> only extends the range by one page (round up vs. round down to page
> boundary).
>
> Changes in v2:
> I changed the start/end check to require a size so start has to be less
> than end.
>
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 2df1c0460559..4f69e4c3dafd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -105,11 +105,11 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
>         struct nouveau_cli *cli = nouveau_cli(file_priv);
>         struct drm_nouveau_svm_bind *args = data;
>         unsigned target, cmd, priority;
> -       unsigned long addr, end, size;
> +       unsigned long addr, end;
>         struct mm_struct *mm;
>
>         args->va_start &= PAGE_MASK;
> -       args->va_end &= PAGE_MASK;
> +       args->va_end = ALIGN(args->va_end, PAGE_SIZE);
>
>         /* Sanity check arguments */
>         if (args->reserved0 || args->reserved1)
> @@ -118,8 +118,6 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
>                 return -EINVAL;
>         if (args->va_start >= args->va_end)
>                 return -EINVAL;
> -       if (!args->npages)
> -               return -EINVAL;
>
>         cmd = args->header >> NOUVEAU_SVM_BIND_COMMAND_SHIFT;
>         cmd &= NOUVEAU_SVM_BIND_COMMAND_MASK;
> @@ -151,12 +149,6 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
>         if (args->stride)
>                 return -EINVAL;
>
> -       size = ((unsigned long)args->npages) << PAGE_SHIFT;
> -       if ((args->va_start + size) <= args->va_start)
> -               return -EINVAL;
> -       if ((args->va_start + size) > args->va_end)
> -               return -EINVAL;
> -
>         /*
>          * Ok we are ask to do something sane, for now we only support migrate
>          * commands but we will add things like memory policy (what to do on
> @@ -171,7 +163,7 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
>                 return -EINVAL;
>         }
>
> -       for (addr = args->va_start, end = args->va_start + size; addr < end;) {
> +       for (addr = args->va_start, end = args->va_end; addr < end;) {
>                 struct vm_area_struct *vma;
>                 unsigned long next;
>
> --
> 2.20.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
