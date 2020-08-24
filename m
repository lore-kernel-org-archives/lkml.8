Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01ED206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/kO8WW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHXPJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgHXPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:08:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B37C0617A5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:59:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so9007854wrl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECIS0WvUxPFVgMktd3Czk1dDXzjjTjHRcV5bwp6ngFM=;
        b=j/kO8WW7gObqi+5HMo+buADm2a+ih9UengrJgOL337n5w/QcYEKWJwJeubXbEMtiKN
         CVRXlXaD3Jg6gon3qEW20iuBmhjk98hPdRzD7tIEvkfL2a54/QhHZxaepO1uL59JplHQ
         5myoJF1ALxkCmikteTDObYZkb8JLR7i0sJ9kURl8MLaBZ4DfVAun0eNeBz6FXO4xkQQg
         bXNzjLeljviOdI0ywe9TbFzpUeS5/P1aUzNd/f8KAXbJZbjyiu00AR8/1BVF6ic36dn1
         ywT8qGFhc7b5soVlklRQYH8zafaQCy07MALVx3l+55ZOGqWX0VN0c1lvgsZM3gqjM58o
         QoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECIS0WvUxPFVgMktd3Czk1dDXzjjTjHRcV5bwp6ngFM=;
        b=cxtUJP17dzbWd76QUN0/CTFP72YPn2Z38MN51eM0/Lh30Kn6fMl+Nuc/kCgqyYhrix
         iZAFGRrEBCbhSfIBarFXPmR1WVIHN1kAbZpqA8YPEG6B5iJcfawvLNquvjRJcMkbd0Nr
         CM25uR9zMnNg9ueFMO+n5lMtixNuOuvzrx/hf2+nJIZxLCIQxD3JQTeaJpAXIkoyleFi
         /d/8w8qs5pFdjFrV1CijB+M0uSXM7VFWznRYRXjtrVU98oJv9PEHfbPyxsL0N7VF37C7
         gCKSSlEl5H4/EGHVEh3g1QxurOn/Sq13H7WtRMIYfOUczqr+ZukXzoQ8R7l27unG7Omh
         6gww==
X-Gm-Message-State: AOAM532ah5eoICRj0v8o4DNZqxvrHjRTvfiPTtNm+R+V8lB5XpZUL2VD
        zo5o5nAYZCZfmtdCOMuxhD+luCeFCybMK5QZ7PA=
X-Google-Smtp-Source: ABdhPJxCuqKgX0AFTlWxXp2R3Wly05aExi3+NuRrzLBuuUo4hIBiE2jI2dPZrZMyJusG1E1ajD5TG3Fa5oWOUZIlgiI=
X-Received: by 2002:adf:fecc:: with SMTP id q12mr6445535wrs.374.1598281197086;
 Mon, 24 Aug 2020 07:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <88d43daf-f29b-0fbe-cf58-930e8caca0e7@infradead.org> <DM6PR12MB261924212A1791B949B43903E4560@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261924212A1791B949B43903E4560@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Aug 2020 10:59:46 -0400
Message-ID: <CADnq5_M7TA_w5vNctfC2vCDwxZAsGcagjsS8WNUWQGFiS--s+A@mail.gmail.com>
Subject: Re: [PATCH -next] amdgpu: fix Documentation builds for pm/ file movement
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Aug 23, 2020 at 11:00 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks for fixing this. The patch is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> BR
> Evan
> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Monday, August 24, 2020 6:36 AM
> To: dri-devel <dri-devel@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; Stephen Rothwell <sfr@canb.auug.org.au>
> Subject: [PATCH -next] amdgpu: fix Documentation builds for pm/ file movement
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Documentation errors for amdgpu.rst due to file rename (moved to another subdirectory).
>
> Error: Cannot open file ../drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -function hwmon ../drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c' failed with return code 1
>
> Fixes: e098bc9612c2 ("drm/amd/pm: optimize the power related source code layout")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu.rst |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> --- linux-next-20200821.orig/Documentation/gpu/amdgpu.rst
> +++ linux-next-20200821/Documentation/gpu/amdgpu.rst
> @@ -153,7 +153,7 @@ This section covers hwmon and power/ther  HWMON Interfaces
>  ----------------
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: hwmon
>
>  GPU sysfs Power State Interfaces
> @@ -164,52 +164,52 @@ GPU power controls are exposed via sysfs  power_dpm_state  ~~~~~~~~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: power_dpm_state
>
>  power_dpm_force_performance_level
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: power_dpm_force_performance_level
>
>  pp_table
>  ~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pp_table
>
>  pp_od_clk_voltage
>  ~~~~~~~~~~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pp_od_clk_voltage
>
>  pp_dpm_*
>  ~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
>
>  pp_power_profile_mode
>  ~~~~~~~~~~~~~~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pp_power_profile_mode
>
>  *_busy_percent
>  ~~~~~~~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: gpu_busy_percent
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: mem_busy_percent
>
>  gpu_metrics
>  ~~~~~~~~~~~~~~~~~~~~~
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: gpu_metrics
>
>  GPU Product Information
> @@ -239,7 +239,7 @@ serial_number
>  unique_id
>  ---------
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: unique_id
>
>  GPU Memory Usage Information
> @@ -289,7 +289,7 @@ PCIe Accounting Information  pcie_bw
>  -------
>
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pcie_bw
>
>  pcie_replay_count
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
