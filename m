Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F3C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54BA20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiYJa3L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgDXOQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727914AbgDXOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:16:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250DC09B045;
        Fri, 24 Apr 2020 07:16:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h2so10632834wmb.4;
        Fri, 24 Apr 2020 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8w7+uCUhpHYzbGOZ01QDp28us1IRO4sOqHhMEDTp6HU=;
        b=BiYJa3L1GcSsLCZerQTAWPtUGBFNe3HAGW+NlURNhdrUIHx5elsf6OKXLm9Pd8Qhyz
         SHsVP0xONFLTM0+8MEQTudYClzAUc0NAVzG/NuAgOYVpCaN6Xb7/Y5KKQ34m0jCnVJYR
         K+3WDdXRQ4M7Jnu3w8hl/XSkLFdp/sWxUydnF5mdRUQV4eEhIbyvFYHcwAwjPQ4KUOL1
         jdSRa7oO5bjwZNmgWqNsxhxSRu5DKThAKFe3PU+pijmgadH5BEj/UQLbc833T6GU2D3S
         tebRFoUOq9csCYKkH1F2n/ddySjJYAT6aRG98nfYpSLfVPp462kyWdugchTc7KdbNeNe
         qDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8w7+uCUhpHYzbGOZ01QDp28us1IRO4sOqHhMEDTp6HU=;
        b=bqzHA0aecUFaxRpgbGlEudNXcefrFnhMflUUP8HLu+5CwS0eK4nqfDvVeo/XXDKY/T
         popxVD9zWzUPsQ7cmfNXoBQhZJZc4QyztPXiJu3C4+eMsLfp85oYrjdbC1RPRBSrEmXo
         WWj7/BA5+oPCvWRG5qkvHszpfxS7lCF0fRQF+ITlN5tGKbGz2SCiV6TmT9UsYfhIsxrR
         AWupyAzGIH3f4PfDi1okywc96B6ncGR0ARTXznvQyKNgzNkzNcovqsOQFqBaWByLRSGU
         guC2sT0+AHoLCBoBKnacuABA4IbsolsWE5+B6ji51I+NunzIVfo+roxtLYZFQ7PHQiHp
         GLjg==
X-Gm-Message-State: AGi0PuYVkYIspcG6/VL9RaXJ7GOEYTJf6kUhjLzNCk8WPAgtTc7w4IFH
        CAVkSOzawYdXHGCY27FcU4p2aOzOKPmTkz5T/80=
X-Google-Smtp-Source: APiQypJxpZVUieBMlP6z0fAEtLmFyuOe11V+/kd2k3pWQy9UVGsp+SwtFgmr/+ixgaFFx8G3scEDN72dvcJ81EwgYIU=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr10535226wmb.56.1587737759026;
 Fri, 24 Apr 2020 07:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200424125640.22656-1-colin.king@canonical.com>
In-Reply-To: <20200424125640.22656-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 24 Apr 2020 10:15:48 -0400
Message-ID: <CADnq5_OXYD0bkLZtfQeL0+B6RrcWjEn2yrAPRANpx0HAtEREEg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix unlocks on error return path
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 8:56 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the error returns paths are unlocking lock kiq->ring_lock
> however it seems this should be dev->gfx.kiq.ring_lock as this
> is the lock that is being locked and unlocked around the ring
> operations.  This looks like a bug, fix it by unlocking the
> correct lock.
>
> [ Note: untested ]
>
> Addresses-Coverity: ("Missing unlock")
> Fixes: 82478876eaac ("drm/amdgpu: protect ring overrun")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

It's the same lock, just accessed via a local pointer.  I'll take the
patch and update the commit message when I apply it to avoid confusion
in the future.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index b120f9160f13..edaa50d850a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -430,7 +430,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>                 r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>                 if (r) {
>                         amdgpu_ring_undo(ring);
> -                       spin_unlock(&kiq->ring_lock);
> +                       spin_unlock(&adev->gfx.kiq.ring_lock);
>                         return -ETIME;
>                 }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 0a6026308343..055ecba754ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -624,7 +624,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>                 r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>                 if (r) {
>                         amdgpu_ring_undo(ring);
> -                       spin_unlock(&kiq->ring_lock);
> +                       spin_unlock(&adev->gfx.kiq.ring_lock);
>                         return -ETIME;
>                 }
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
