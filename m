Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D6BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DD220801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf0hW7Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:27:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE6C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:27:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q25so8698682wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02KYCiUi0pgpoGPaAyXU3/Qv3U6znMf82l3OyYwC3f0=;
        b=Gf0hW7Z+qHXyJ7gqSW2FBj8L9rejLee+kNaDyyrXb8UAvRwO+yF+tD7PvTfKAwvBP0
         SyDKqfSQXWJabq2Q8W7bwZfcS8Kxv0c+uZXfmy9p057xIz2o+YKFP7PYhEAakJD4nO4T
         awbi5kARLAlz3fkftBK+WcMgYqhvnDgZki5NJqCkG5Hl6qLHjAihU4ku6KcewteIPa4d
         WiLGnt7xycuMbG8hPHTPIeEaBWw74zYMKUsK4WGyqVpKKGZpVymcGka3FrrJVeBytLnF
         9sdNADqiJQc/XXjZVOpua4a51EPutwSLYkcPa40k4qzJzHqe2mAWGCHEjJ2wsgu3ZlL6
         15/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02KYCiUi0pgpoGPaAyXU3/Qv3U6znMf82l3OyYwC3f0=;
        b=BCB1B1VyhUu7YPi0r8J0cSKTPOOrFxbI1S/9cbkFi05lFvCyoymXnQ1Dk9GNSGhC4U
         M8uTaobhCZGZOoJ2fAb5jkfS5FBTSadW2DEqFjBzyxgovJcNBTIOWfkk5nP7kQQ+qwml
         tOQ4sODdmULkag3t9F4aqCgCuVeEmZdQBVySSAFNWDsOyKZePExM1SjebI3FpmwbYxh7
         gqeF7TDfmcJWIxb0P8AcwVF0hW/dm2Rl0NwFOF7bb7lcrX3u1HoxA20L1LhY0av8gq5A
         fzzNBzb4g1MH6yc7Bt8JS8C7oIR4Vm1FUlo/65c/tIOlSKsBXUzKy4lNoN8ez6rJLHoR
         XQAA==
X-Gm-Message-State: AOAM531mAkfBmFJysh04nAEawNbxnDKs3IWqvv9208kbCbQHqABpRA89
        SYYuHrfDqH412m8dxyB3zz9N8NHbz3/A7jyxOjg=
X-Google-Smtp-Source: ABdhPJyZnmHTSsRayslyx0/eLvs546da9/M8cW8sRZBJrZlTygAmnfxUjX6OCy5tAILeS9eDuY0SpcrrQujUIPsMSMU=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr13885808wmb.39.1591975663618;
 Fri, 12 Jun 2020 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200612115851.7123-1-bernard@vivo.com>
In-Reply-To: <20200612115851.7123-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Jun 2020 11:27:32 -0400
Message-ID: <CADnq5_OSYYySsYr=0R2Qo7Ku2Vs5+DAv=X4R=Nfpzmg=8G=dCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: add missing fill of the array`s first element
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wyatt Wood <wyatt.wood@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 9:22 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In function fill_iram_v_2, the ram_table->bright_neg_gain`s
> first element [0][0] seems to be missing. This change is just
> to make the code a bit readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index 8c37bcc27132..7604a01be19c 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -350,6 +350,7 @@ void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters
>         ram_table->bright_pos_gain[4][1] = 0x20;
>         ram_table->bright_pos_gain[4][2] = 0x20;
>         ram_table->bright_pos_gain[4][3] = 0x20;
> +       ram_table->bright_neg_gain[0][0] = 0x00;
>         ram_table->bright_neg_gain[0][1] = 0x00;
>         ram_table->bright_neg_gain[0][2] = 0x00;
>         ram_table->bright_neg_gain[0][3] = 0x00;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
