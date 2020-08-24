Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5138B20702
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7/xUIsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHXVsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:48:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF77C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:48:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x9so288070wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKGobvxaA/gQH5FvPl8bNON5VaaRXAXqQ/5bge/ZH1g=;
        b=f7/xUIsUw/8m9YrHT02sZyzo8f2bTxYLOgRM4j2hgYiaiRydKn3u8Iuy00SUMslgBT
         GAt/iSwTDod/+67c1Hk74YgdIOuirAlnAcYOPltWxUm/z1Il7Ubnf7Z8Jnm7PvMPm9SK
         hDcY3LhrYtX+sY+g/Jb7SHUI92KlGpXWp27i8dfUlWzE6ccbzQrP3Hq+/H56KdUQYa9A
         ED4W8aG8s17X+dEYYF9z7GnRgDrRn9ZWDkucAf0IsS3dMWPRDlr6ZMJ53Y/iQ4uYKPhr
         fJe9k8B+1MfFuNpcK8zgSZH1nGiuEkFCLa30+chb8vWzVfja4rKGWwCiaFjrsztD/AjB
         U2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKGobvxaA/gQH5FvPl8bNON5VaaRXAXqQ/5bge/ZH1g=;
        b=nVdLzrPYYKEDOH/U2UHHvbx4q5I/aQsP/RQjspbKw9114scJ4PttALZ4NlAlEF6y4r
         wICdo26DbcS7d5rcJvgUr/Lh2DsojCIv4w8GZ67s0hPOZivewpVG8SPLl2dU0QabX5bb
         PqD16MQiU6PXfBKs2hATrv+yhNI6/JT7KXxhXBcSEXlKhxpnYvAYNEkQ/RtDdYO6x8GO
         ItGODyHRHzT6rJC615HEM+5/w66IZVQCcWUmfFtild8N90bDmzb0cL5VBot9KyKGRFSG
         N236nMdREYW4jzg35Dj8NrBAONdAZPPboWj8Kf+G+j8OTicDunbRkyJmjbqPCQTTEurw
         uI+Q==
X-Gm-Message-State: AOAM530E7d/1UTs6N2OMmLoTF0gqv40byIcKrKrQF4yXSwoMDo3BWL6f
        SQxZ6FOLclDQCiepbxBT0O1edFoXe54MElpAAgg=
X-Google-Smtp-Source: ABdhPJzvbRqXE4aOjJ+Upj4kAcDfNhVQ6DX5jAEDdbGkNWmHv9/zBG0JWgNxWNsqwfLo2NnfeSEr8f4TtzLfve8pduw=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr1138157wmh.39.1598305693567;
 Mon, 24 Aug 2020 14:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200824211530.592909-1-alex.dewar90@gmail.com>
In-Reply-To: <20200824211530.592909-1-alex.dewar90@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Aug 2020 17:48:02 -0400
Message-ID: <CADnq5_P2-6oHOtEa7zs0PVSJUQbpZBLgiNR2Dp+_CFG1-kKzqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: use kmemdup() rather than kmalloc+memcpy
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Li Heng <liheng40@huawei.com>,
        Evan Quan <evan.quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Aug 24, 2020 at 5:33 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> Issue identified with Coccinelle.
>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c   | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
> index f56a3cbdfa3b..1f9082539457 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
> @@ -890,14 +890,12 @@ static int init_powerplay_table_information(
>                                 power_saving_clock_count);
>         }
>
> -       pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
> +       pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
> +                                                  sizeof(PPTable_t),
> +                                                  GFP_KERNEL);
>         if (pptable_information->smc_pptable == NULL)
>                 return -ENOMEM;
>
> -       memcpy(pptable_information->smc_pptable,
> -                       &(powerplay_table->smcPPTable),
> -                       sizeof(PPTable_t));
> -
>
>         result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
>         if (result)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
