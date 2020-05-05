Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99143C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73980206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrc0/YFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgEEOox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgEEOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:44:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:44:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so3032976wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSNzqE9w9ggP7uPPAK4KUUUBVcwgOZ6j5qNH5gD8e9M=;
        b=Vrc0/YFLCwJscVtU+i19mS5ZPJ4jJwcbi1fjI6iSdiVA6OPDvdjhENuyWxI4BkCiaG
         Xr2hpK0QyALgA7Ybaf4ot3Nu7EzljpTTaX7gotdwnfOMXDO3RHOE3dbDBFQgaXK1Gg92
         h7I4fweMdD6WRiiZN5fi1xfyhNBqsrjPRkgY0VSlakJi3r8Gf9g3MgVjYT1qjrzdEXme
         zjWW0y+HTxsnpCVPCxQNzqAOhvZrKEMGQYyAizxpKafY1AieP7z+V9T5WB5VGxZPv0Hb
         OCtnke1/f+JpiPEol/Lrk/t9K27CKVwPyAW5JGPpVyMQoYxgIjYXW5w+s4go/ckRPoko
         x5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSNzqE9w9ggP7uPPAK4KUUUBVcwgOZ6j5qNH5gD8e9M=;
        b=tl7ONGukdE0VfeVqdNhXsXlRlVslUZ9OGGsMtNfK+U3xizwKbYUA9u2vlT1f/gQJOB
         vz4L6g2/rr71GIZrdRCRcjmr8K3PaD4g/4PpxoFRcfjmUWDNaxSqzTpa6utSutXtuW4A
         uRzAoI8fK2yThtszmyrYeRB4biTgKJQy5C0apRctJS9AJsj5g05Vmatxbu0BLLpQ2/oq
         s+nXQlfrhaLZ21bNuYNEv88JHUdT/DCvAVwzh6YPsVkhd+lnYFoW1I7VCyovasKzwMnR
         N/Iq/wbxKaKkpgl2/Cpfkus2Q0K+G1WARTlEKmR0+fL1z53F6AwnDSd/7HhQQDHSDf0V
         hWBQ==
X-Gm-Message-State: AGi0PuaVZd1z/RcB8jWcnAfWh0H4FG6fgelrmF0zAuGkYBMfLCTFH49/
        0pFRXImOiw4QX4mJrdUbyYC9zXltLv9aKrmSlng=
X-Google-Smtp-Source: APiQypKTq0dXp0DSGKg2+q37wBHHkO+EXX+oz5MRyNqq/kymYUpV5ub11RuMWZHYWMrUunT1XhX2hQFAfXHne9/rvtM=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr4322821wrq.374.1588689891557;
 Tue, 05 May 2020 07:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200502031141.2732221-1-natechancellor@gmail.com>
In-Reply-To: <20200502031141.2732221-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 May 2020 10:44:40 -0400
Message-ID: <CADnq5_NdtZh5_RGDWKJ9c_42XLvrncCs5DDU1YSptfZP94KXkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid integer overflow in amdgpu_device_suspend_display_audio
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 4:35 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with Clang:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4160:53: warning: overflow in
> expression; result is -294967296 with type 'long' [-Winteger-overflow]
>                 expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
>                                                                   ^
> 1 warning generated.
>
> Multiplication happens first due to order of operations and both
> NSEC_PER_SEC and 4 are long literals so the expression overflows. To
> avoid this, make 4 an unsigned long long literal, which matches the
> type of expires (u64).
>
> Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state before gpu reset V3")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1017
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6f93af972b0a..caa38e7d502e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4157,7 +4157,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>                  * the audio controller default autosuspend delay setting.
>                  * 4S used here is guaranteed to cover that.
>                  */
> -               expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
> +               expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4ULL;
>
>         while (!pm_runtime_status_suspended(&(p->dev))) {
>                 if (!pm_runtime_suspend(&(p->dev)))
>
> base-commit: fb9d670f57e3f6478602328bbbf71138be06ca4f
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
