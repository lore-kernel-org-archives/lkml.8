Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E08C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D982E20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPfcm0nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgDCUhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:37:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36063 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:37:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so651405wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+LvCt9qhAFpj3aG3kw3OiW81EprahiJdVZ5TutAfFQ=;
        b=uPfcm0nj5hMvo6GiSlcuvInLBcJ2k4qS/AJRY/DITisJzW/jSuv57MZ62EXBmSYKQI
         4Mr5SDR43oKr0A6ofhkaL3iRkX1cq87c2TsxtZYq4W5JuytX/nAMzO4uEU2j2nY0WZ+2
         snkTPDDQeF6/DT/Y/2vxw9+h1X+meoA+JTp1xLVtEJBbnGBYwzXyYpIsPxqLI2HxXUFq
         jZy7r70+mnms5eBQPrsSrqg8Obod44qfddFaX60hj7+y8TkrXZG4+MWXNeo24CbFDieb
         rR4YUYksdxre/YKiLFxfbaa+zkObrNuzQTigCtAO7saQ6WbxcAtzYKTRq1D3iFjAzDUa
         LEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+LvCt9qhAFpj3aG3kw3OiW81EprahiJdVZ5TutAfFQ=;
        b=EydW/YNVm3l3a//8NgPgM2+ar4dEahwEt6pYqqWHGexlLHQEz1K60VhFQb0mfrXpky
         +/761yCgrjvxTH5KnqOGi5xQfjQnoTE4xtv0H83JW0FLeAtzFBwOjqvw+g8HHVpsxXp+
         MGxLPe+0HK0YnzQr3Z+dSvdZHezNBPVyXZkedQC/ILyiJENGLQqFnGUiDamDFXTRjciQ
         JVOhrKlwmgqpiulofWffjIm0mn8WjodciiUJw+QaBOtHbvAHea6sOZt83z8uE6wkvq8F
         bVXgOdZi3EmeenofEbDHVs+WZxO9g3mO5v+z8P0otGfiO+846cM+gxwq9rlzJUBrvHVa
         dAug==
X-Gm-Message-State: AGi0PuapMK0CPz8+9XI6enGqs7Kn2cqF1z/zMHql/MXVC3SMLo+kFKkL
        Fpai1t5B+PkEa6MuQTx/onvWc5MDKYk2354CRZ095g==
X-Google-Smtp-Source: APiQypJUPo10j7ErhZkwbPSCOJdNNULVakATbooMPRF180BK4dv4mEanANUn8ZBD+P10a3gQ9rsf7j5N5i2AJYmVqV8=
X-Received: by 2002:a5d:500d:: with SMTP id e13mr1761051wrt.362.1585946224335;
 Fri, 03 Apr 2020 13:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200403143419.155503-1-aaron.ma@canonical.com>
In-Reply-To: <20200403143419.155503-1-aaron.ma@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 3 Apr 2020 16:36:52 -0400
Message-ID: <CADnq5_OVUSfXPoUse+xTPcqifOT1AHmjqF98QrGWmzppeujgMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix oops when pp_funcs is unset in ACPI event
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Yuan, Xiaojie" <xiaojie.yuan@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 11:18 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> On ARCTURUS and RENOIR, powerplay is not supported yet.
> When plug in or unplug power jack, ACPI event will issue.
> Then kernel NULL pointer BUG will be triggered.
> Check for NULL pointers before calling.
>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index f197f1be0969..611de69f9d48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -89,7 +89,8 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>                         adev->pm.ac_power = true;
>                 else
>                         adev->pm.ac_power = false;
> -               if (adev->powerplay.pp_funcs->enable_bapm)
> +               if (adev->powerplay.pp_funcs &&
> +                               adev->powerplay.pp_funcs->enable_bapm)
>                         amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
>                 mutex_unlock(&adev->pm.mutex);
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
