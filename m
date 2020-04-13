Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A320DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A57A2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7eqRinw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgDMPMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgDMPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:12:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BDC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:12:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u13so10025406wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miTpPmRVhDhvijKW/x5oMYTRNn8wvs0mLO5J0nr2084=;
        b=U7eqRinwsYrq6IXBxzyvvKAcVM+VYOkoiiIpkOLjJI/+uGkiQ2ae19esSWNmX7/55x
         HLE1SQmDAHBajHl1h3Zvpge1o1RT3GQVhMVRodlQW3VO5iGEcuqlvLsRnqh6mH1AdUYj
         vagO0XSwWvclpM/77+sVeGD6j9xh08Wsz+91K3i9dj20TbwbY4DX0Qn994aJVc5XwUVK
         M0o3YAn9eyqIVMFO923iGZfMpmTUdxTDGhleGVq4wnNC+1pZDSMSTPfdFATABJHIQwPx
         dthoumPisb59N7MwkZXcwAHOOnNbLsLCO1EA7iiaSQ4Wto8XAePzLitKlTn3lj43zuDR
         rKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miTpPmRVhDhvijKW/x5oMYTRNn8wvs0mLO5J0nr2084=;
        b=cE+Iqj8mbqmPOjaLalxZPiHA/UkdTQlQ3ZDOCpXFjH+66ZDWzx7sJ2fbHWwv/KQ6Yv
         RnsNQzk+hx4MNgEtggPwnH5wCI4BWqyrBJDEpcI1UUXxvh1S9L7zNMJLYTMfqmluNqqw
         B/ykSMZZVE7fKcGZOJjhqdHwUM/Suhfq9HF2YrI1rN5DubldU+y+5z1o31AZWym1kL0b
         0LFPpY4X7Ya1pFQzBnkL9u8XC1qtAB2E5h2Xr9DBsblJeq/Q5mMZ8gEmBpnL75pXZ083
         W3bGPrZLtBNRt5yTejNxJLD4vxv134SNKvlnqf0vQqSeythhU1pESQiQNUvlHKuPCxS1
         4Wcg==
X-Gm-Message-State: AGi0PubhKxezHTYEP5/vNFMJCEZjBy2pSOUXK/DGKKOJM+GjrXVDufZj
        CL8TqpqiESTP0zu1VgA27VHc2efWkRUueJtJSHM=
X-Google-Smtp-Source: APiQypIlLep4ObkUpbnYLb9374cQ+lM33eeD4kNIbr7Zh/DtnITfyepbEUmDzUasVC3tnJvdqsT5XjWr66ibsXXlM/s=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr14736737wrq.374.1586790755179;
 Mon, 13 Apr 2020 08:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200409012815.22309-1-mail@aurabindo.in>
In-Reply-To: <20200409012815.22309-1-mail@aurabindo.in>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 11:12:23 -0400
Message-ID: <CADnq5_O+xg1Lro4UP3+_4GdkDQk-HzJaXMWzWWSn0ZiYG9Xt7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amd/amdgpu: Add print format prefix
To:     Aurabindo Pillai <mail@aurabindo.in>
Cc:     Christian Koenig <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 9:42 PM Aurabindo Pillai <mail@aurabindo.in> wrote:
>
> Changes in v2
>
> * Add dev_fmt format prefix
> * Removed hardcoded module names in pr_* and dev_* prints
>
> Aurabindo Pillai (3):
>   drm/amd/amdgpu: add prefix for pr_* prints
>   drm/amd/amdgpu: add print prefix for dev_* variants
>   drm/amd/amdgpu: remove hardcoded module name in prints

Applied.  thanks!

Alex

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            |  2 +-
>  7 files changed, 21 insertions(+), 9 deletions(-)
>
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
