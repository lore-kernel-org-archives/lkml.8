Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B543206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCINmJCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCYRwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:52:09 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:56007 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCYRwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:52:08 -0400
Received: by mail-wm1-f48.google.com with SMTP id z5so3471428wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yif9NVG5qM8UtBHACYI/xY6SaBYSsuiUhHBQ73NO1N8=;
        b=HCINmJCDnfcY8ewgVE3xtasrXb2Z2dK1xZ52g5yfs86Xu+IPOOFxFN0RMEDaM8WTn5
         MBdmdXdsuHYmIT/0c28kx9D2hOfJEBzEGOgkI4t4fDVyVoPXlSfq3fAJ8VTv/meZB2BF
         LxFLM5khMPsp0u2AaYEte0XdIlWmo0hPm0hrRpR0huyXcqinP6Eg9uZjMj05l/oKvdFx
         tawr0bAcJpT2ZyavV1b9qFOeXFOTOpQbBOTgIpdpKp/4D58sRQaEEwZcUkRIg9U2T5mg
         lSsMwVf97o2lFZ51zDH/XXzC9GApnYJOM8pGTbj6DEbxombPZbRtXzrcsKMm+3YS+5uS
         ynjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yif9NVG5qM8UtBHACYI/xY6SaBYSsuiUhHBQ73NO1N8=;
        b=S93oIFVLExl/eb0ubyPwbtKPSj6bQBxkm7qPLVZazl9Gyz7rxFJJENHIwHqFHmwN30
         QA6u9BNxFYy3kYWTgpU0siFkXFtadG6yzzAC1fiJEGYTJmCxsu+X+UesAKlPK8X3SPAo
         IB/m2zG4hyAbf/SsO1+OZXdh2hV270eTdw3DZ9aMnYFUsdGkLLSZFuP2twsRQaebcI3g
         K6eJKuUOzd/XBald5GvSslIO3dl5Px9L25o/+mfHklrVAKxi9+dR5rt5Civs4w+LsKTB
         jHftRpHkGE8GRp2bo8u40JP53CF+HEiLKcwg2QwwX/6BFc0Qs0FSap6BxcBrIKno+amt
         Twvw==
X-Gm-Message-State: ANhLgQ1XTe1/JNxIru9ALgCyf9yG+xaCyqDxMvG2FZpPt0ADbj0UnIi/
        qYXKHczw3y5N3gM3X6iVSr+itvGGH+ZXnTmun48=
X-Google-Smtp-Source: ADFU+vsZ41U9VmICHzULJAe9eA3jQXQ/NCx1Q5ewlweYb1D4ftz0Lh9iocVH1RbzinRjkmpFzePMZ07vmsIXgYG/B/s=
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr4549621wmb.39.1585158727066;
 Wed, 25 Mar 2020 10:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200325023250.163321-1-chenzhou10@huawei.com>
In-Reply-To: <20200325023250.163321-1-chenzhou10@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 Mar 2020 13:51:55 -0400
Message-ID: <CADnq5_NQgugmHe0U_-b6EZB6JHX-qqcu0ATKVKKy105sANgHxQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/uvd7: remove unnecessary conversion to bool
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 4:17 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> The conversion to bool is not needed, remove it.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 0995378..20f10a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1694,7 +1694,7 @@ static int uvd_v7_0_set_clockgating_state(void *handle,
>                                           enum amd_clockgating_state state)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
> +       bool enable = (state == AMD_CG_STATE_GATE);
>
>         uvd_v7_0_set_bypass_mode(adev, enable);
>
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
