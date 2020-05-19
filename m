Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF52B2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPf5Ms8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgESQGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgESQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:06:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D3C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:06:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so3612774wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guiQOg83wk8Re5uEuJo1BoPo7XFCPazuk/VvCpyeK1M=;
        b=mXPf5Ms8ET6YablA99JN6u4VA/YVAadQQ7qlTUqWiZa4Yy/4v1W/A6Hv8uDOCqKDBt
         wHLXvP92KiOdRfjd4mtpEoNpOKuApoZeyI4+FEWwTxp8Y1Rv+kYjTTfYUyOeMGkNmxz/
         sSk1e675A9gKKswjNZfpBOf2SylUC6w60t6FM6t2Sd7OYy+S6MV3GLkFeUUBuzZ8Xrww
         mEBRF42H5WAodaO+zprmH8O6EfTarkUc7fySKqO5yt6mNJypof+qVkczsBHnxAUpzdMQ
         toDM2XnrMZeD/g1mLak/DlAd8BCI0ibMIWMHKRtvuMW4JJ0QFKXx0dJc7QcfM0ga4yH5
         Wt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guiQOg83wk8Re5uEuJo1BoPo7XFCPazuk/VvCpyeK1M=;
        b=FJZousb/+PuJsmbnQFkO6f00GRLRdx+1+cvpUSFoKeB5O9uBsloNQ7epB7RZ6XHvJ3
         wQSOUrxEEHDabQeDTIAd3UEY5pzH284HC+C1t2g/zLlDhmR7YJdJfbNe7NT4wYBz+5wT
         iA7P7IXBDW8o41035dTUKKKF7PR6F5YCJc9VL6290/2xVO8Vx7s5KUk+Ef9PkX3e1gSk
         zHQQsZ1oEV29iuZBZ4e3Ov/FZp4eLVkv9QWcoOkHQ0p4TPe1etrJBnE+qlYlLtoBJ1Ry
         SoTNA+BecvwMrXlx3UD4EY0niP2P6aEE7S/5onGWFSfX5M1f9+4nTxjPR7eCUwHo0Rh7
         BcXA==
X-Gm-Message-State: AOAM530xrfuWZW57VPCozXdoQZDTeRYYiUGVroFcb/QFydEfJLHV0OwW
        +sQcxBV/m30S+li1rKFQyBDCbvSw9xeBOGgrAoE=
X-Google-Smtp-Source: ABdhPJzL5f1OBDcocPrtJ6fbylZ/xk9NChZVvHdXkRF7kKd7yOgiz/X65De/UPsERoG9SUFs6bKzwUqLMWaPLIl68ac=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr94893wmp.73.1589904378124;
 Tue, 19 May 2020 09:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200518162312.18059-1-aishwaryarj100@gmail.com>
In-Reply-To: <20200518162312.18059-1-aishwaryarj100@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 May 2020 12:06:06 -0400
Message-ID: <CADnq5_N4u5GD+j=RSsTzpdOmZjAKV45aAtN2ffb+cizMcB9ygg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix boolreturn.cocci warnings
To:     Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:37 PM Aishwarya Ramakrishnan
<aishwaryarj100@gmail.com> wrote:
>
> Return statements in functions returning bool should use
> true/false instead of 1/0.
>
> drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c:40:9-10:
> WARNING: return of 0/1 in function 'event_interrupt_isr_v9' with return type bool
>
> Generated by: scripts/coccinelle/misc/boolreturn.cocci
>
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e05d75ecda21..fce6ccabe38b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -37,7 +37,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>         vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
>         if (vmid < dev->vm_info.first_vmid_kfd ||
>             vmid > dev->vm_info.last_vmid_kfd)
> -               return 0;
> +               return false;
>
>         source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
>         client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> @@ -69,7 +69,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>
>         /* If there is no valid PASID, it's likely a bug */
>         if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
> -               return 0;
> +               return false;
>
>         /* Interrupt types we care about: various signals and faults.
>          * They will be forwarded to a work queue (see below).
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
