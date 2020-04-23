Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3296C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FC22076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knNPV9b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgDWTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgDWTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:31:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FFC09B042;
        Thu, 23 Apr 2020 12:31:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so8227701wma.0;
        Thu, 23 Apr 2020 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgAZVOCSIveiuqGce1ll+R4dfIKogGqfZA6esAftSZo=;
        b=knNPV9b5pYpSRUOTLC+KLsUlCy9+s8M/aHaNwAEEc+coAm0Zro7GGhhs0Mf18UjMCk
         Jy3Kt7savdetdbXCxj3EuD0rloEFKCjOo35vvYb6xP/E59wRwRRjFHwuna3XNXp4CoXc
         /nrSqm2IgnEsTlOOXi7K87G+2ccTLb0x2Vt+GnzLU8eRdKLrLtssOb9jyLLol5JzKz3j
         5HogzgY3hb85+VCO8EuFrXJdw+E30xtlAudgmmM/r9dJ8C3lBzojgYhs6mZT61ZGk7Lt
         upjp+TdAjLC9w/XqRZ1a1qKeIG4q/YDKILPqf0VnI6/TP64WAXOcy+hqvijN0zeNHD9k
         Q+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgAZVOCSIveiuqGce1ll+R4dfIKogGqfZA6esAftSZo=;
        b=Pz65gSc9RQh3IBtJRIXekyAkaeq1n7YHT6owY/35BRMgEqKK5vCNvFLoWUA0MtnAkD
         pT8KcCsVdjmi9gPwfspkjhSksRd68/61itsU8wD7m4cU6jNWxa6jGP85YC+n3AgDrKZo
         R6MP8JA98kPwsmUaVriB0aPdyc5jmYLQOlu3E5gukrswdSjY1xMAr48nYYgFtEf8MBwj
         LIiXPSrTaarfWFEFlRmZDn5Z/le10/v1yTyN7jlCGHyAV/A+zvuYNCo04W2PgzNDEkd0
         0Yfm41E9PA1es7QPtmgDImqH+6JHYcVzZxis5O5foZDPqbFUn+ulMcnrPSHLH7gZ3tsQ
         8pqQ==
X-Gm-Message-State: AGi0PubAQDV+01Hma91tgSuL/iGWT0IePxcIZH99lwyM+O+NEjUXehri
        fk6fNpWO5yBdNPD18R+hpILHJ6xkCAJnGbxPuj8=
X-Google-Smtp-Source: APiQypJ6GT/p5QCtXDyj6Nc/UccKUVDP9vSEuI76TETHj+tm3Tp7yVKfb2mtdWEzWQCVuoW/zENlmPdp16iR0w6s3pw=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr5917826wmb.56.1587670274438;
 Thu, 23 Apr 2020 12:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200423141728.19949-1-colin.king@canonical.com>
In-Reply-To: <20200423141728.19949-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Apr 2020 15:31:02 -0400
Message-ID: <CADnq5_NWZaUeBz8ZyWF_+LFc3=NXiQYJqbj4cMsyBReASCbcEQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant assignment to
 variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:18 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index d5b306384d79..9ef9e50a34fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4231,7 +4231,7 @@ void dpcd_set_source_specific_data(struct dc_link *link)
>  {
>         const uint32_t post_oui_delay = 30; // 30ms
>         uint8_t dspc = 0;
> -       enum dc_status ret = DC_ERROR_UNEXPECTED;
> +       enum dc_status ret;
>
>         ret = core_link_read_dpcd(link, DP_DOWN_STREAM_PORT_COUNT, &dspc,
>                                   sizeof(dspc));
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
