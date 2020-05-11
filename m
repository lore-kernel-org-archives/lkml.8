Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D07C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DFE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEKXGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:06:10 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43857 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgEKXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:06:10 -0400
Received: by mail-vs1-f66.google.com with SMTP id m24so6703268vsq.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsOk0fjltEAaptnvoAyKNwWldPrO+GBFD6zagPKDmGg=;
        b=J2BC/FSbSimtlkuHaqnrZLT4ZN5Slp5ZNEFStJye2qP9h8yD2J9YMOUX4v5cYPGsxu
         ZUqB9myLafPox+D4n6Gkvmxp5IaWUHuHbxOZZJWJWQMqp+Q7ARy0SUQnlH0KHwQr+w9l
         v9YVLOJXDoxPiD27kno8lmyZHFCuk0ibTZEQGqxsHJCV+mF+Wq+Qcch9YkU2xUvxruGL
         diMnw0x4Dghq/V+m8r95u0A4aCfuM1A5SuotC46KM49duTZEg3RPSXg0MdWWi16bclde
         CRmL3mN3DxDcLUl0050yBZqw/lVFRHpCDh+VwvgfvijrjVtPasoBoIgFVNkXH/QMApUL
         DPXw==
X-Gm-Message-State: AGi0Pub+Hl6If14zrlqB17BeUvimIcRZ521uPCg+VX4ApDlIlVwNkcqv
        JtLRAQx7NeeGtnYjKhAkvGthc07M9hwbs9jWG9ofQi/G
X-Google-Smtp-Source: APiQypKo/KHLOg1rAy+czGJX+lzNM8SR5AyvpY845dOvPV0Ql06/64FQLVBC5d2MCJrmRRgt9Y9fFCvGby21/auV9/g=
X-Received: by 2002:a05:6102:502:: with SMTP id l2mr13181954vsa.210.1589238369237;
 Mon, 11 May 2020 16:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200511224148.598468-1-lyude@redhat.com> <20200511224148.598468-4-lyude@redhat.com>
In-Reply-To: <20200511224148.598468-4-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 11 May 2020 19:05:58 -0400
Message-ID: <CAKb7UvjQfw9UvxCdcu1k3t0dnq7PdQJrw5CtWhB42=uiW9-4dA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm/nouveau/kms/gv100-: Add support for interlaced modes
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 6:42 PM Lyude Paul <lyude@redhat.com> wrote:
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 43bcbb6d73c4..6dae00da5d7e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1065,7 +1065,7 @@ nouveau_connector_mode_valid(struct drm_connector *connector,
>                 return get_slave_funcs(encoder)->mode_valid(encoder, mode);
>         case DCB_OUTPUT_DP:
>                 if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
> -                   !nv_encoder->dp.caps.interlace)
> +                   !nv_encoder->caps.dp_interlace)
>                         return MODE_NO_INTERLACE;
>
>                 max_clock  = nv_encoder->dp.link_nr;

You probably meant for this hunk to go into an earlier patch.

  -ilia
