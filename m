Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C958DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86D320767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsNiBJat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503708AbgDNSPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503671AbgDNSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:15:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0862EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:15:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so14141519wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VclBjPf0G+5Fbq0gaSlTkJ1trKfc494vLUCcFmtZb4c=;
        b=PsNiBJat77NUlKls3n38NeJLDYLaxdO6QQ6kNr7NquUmAWTr4Xr/gyZ+hbFWU/eXM7
         2RULAsbItfI/aUioDQWzlNzU9OwRPaWk6JkOzaTreyYLviOdSSY453B7dw+PDBDHSt5F
         x+ojvn8taK7Eh5VzTxRhgWytqULvg+MjLbTb5qPvwe3GT/SM9ICpx465II+ZHxlvDEu6
         EdZu5PKeyOnl92lAJp0VvmNLIhz/DfFnnJXqACQ6ap+4a4nM1nzV/2vePaF6OLLpoPp6
         VhB8C6nOdPPLhz3JyOYIeW/DRBlSu3OAR06M2NqGsi/j9hp5y8zxBDFL/blKkRX+TQ3S
         +mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VclBjPf0G+5Fbq0gaSlTkJ1trKfc494vLUCcFmtZb4c=;
        b=Nc6mw3v1GmuQppj7NwgEnkkajyIeNLB0redkdQBB9MtIEwBNuIKpKMMupI6gfjj9sO
         qE8nyU9ro4KulLkInGyHq/xUctljn0DTUJlo8+APDCToxzNFpXxy8ag6gUPb9RIjNZVx
         qOV2/iCG/I19bZsHt29GgSHk/oSZFR/f4zc9dSoY5+uM5Z4hk0l6BKGU6lo1HVZJhUfP
         i2OR6850oDC26VuxhLPS3mtfpd/73FAFZvv5fAKOMw8Nv3wf3LForLhLXyBZLRQ/PpwD
         EZRp/CzZ/1aTN7mTqosliGjNd3PnRy7w7BZMXWrbwl4OBNvj9+KpETa5j829rwJ5rnCO
         j4GA==
X-Gm-Message-State: AGi0PuZbd1TSsDJNRKMobl5WcmoSoBsY/hm1QbcjYvs5n9aBYqQpPA3f
        joAdccvWP+9GSiPAL5I9CQh/V9I25rynBLdj9DI=
X-Google-Smtp-Source: APiQypLEf8jmLLVAWrEjgPnl0rCghmXeebEJ0OPl3F3M89wXZj0sFLn3oBx6ZCBDgzxk4rui1NHBjDA+ZFAHFVN+3TA=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr1101168wmb.56.1586888114753;
 Tue, 14 Apr 2020 11:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <1586864113-30682-1-git-send-email-bernard@vivo.com>
In-Reply-To: <1586864113-30682-1-git-send-email-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 14 Apr 2020 14:15:03 -0400
Message-ID: <CADnq5_Phca3L-HGOQz0DPBoARHgwcJRK_a7-WmeFMPkrPWeOeg@mail.gmail.com>
Subject: Re: [PATCH] Optimized division operation to shift operation
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Oak Zeng <Oak.Zeng@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:05 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> On some processors, the / operate will call the compiler`s div lib,
> which is low efficient, We can replace the / operation with shift,
> so that we can replace the call of the division library with one
> shift assembly instruction.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied.  thanks.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index b205039..66cd078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -175,10 +175,10 @@ static int gmc_v6_0_mc_load_microcode(struct amdgpu_device *adev)
>         amdgpu_ucode_print_mc_hdr(&hdr->header);
>
>         adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
> -       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
> +       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
>         new_io_mc_regs = (const __le32 *)
>                 (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
> -       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> +       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
>         new_fw_data = (const __le32 *)
>                 (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 9da9596..ca26d63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -193,10 +193,10 @@ static int gmc_v7_0_mc_load_microcode(struct amdgpu_device *adev)
>         amdgpu_ucode_print_mc_hdr(&hdr->header);
>
>         adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
> -       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
> +       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
>         io_mc_regs = (const __le32 *)
>                 (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
> -       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> +       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
>         fw_data = (const __le32 *)
>                 (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 27d83204..295039c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -318,10 +318,10 @@ static int gmc_v8_0_tonga_mc_load_microcode(struct amdgpu_device *adev)
>         amdgpu_ucode_print_mc_hdr(&hdr->header);
>
>         adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
> -       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
> +       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
>         io_mc_regs = (const __le32 *)
>                 (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
> -       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
> +       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
>         fw_data = (const __le32 *)
>                 (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
