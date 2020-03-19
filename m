Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1478C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3212078C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhhRP9CT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCSSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:07:08 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41308 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:07:08 -0400
Received: by mail-vs1-f67.google.com with SMTP id a63so2279596vsa.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNbkuwcxRY/5NdpGatcuzNNiZqstQLs90QoS76KAs3c=;
        b=IhhRP9CTg02j9zaxsX8RCjJcCZ5AtYZL4qbmjD1DrW5528Hpb0kijgdCy0sBZFiO7T
         yRw0OxLaQu/lqpWnC6ETkFwLmc2ERbZf3HZEdWJn3uZ5TxQmdSnkI/Es94NckDNUg++D
         vrpHSj6S9uP+dbj+IJjvQIdY9fJ3cy/r6P2syGYs8KE7ZnOEUGCWMr24Urj9Y6EkGMk4
         1xgK+oqQfw1krowg9XnkmXgB0VxogBvB/P5ba/vYoRdLYFyCg7VW9WusMhRMa/Y8jp/i
         16XFpLenou+5+ePb1NqNWUCtOhu+SaiJkMmqNZ/hKs4dapM4v+zZHrlDzXdVoUDfcrjx
         TitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNbkuwcxRY/5NdpGatcuzNNiZqstQLs90QoS76KAs3c=;
        b=RRsJ92IIb+sY98spGHw6p+3KI5fhg0UrEwp+KOuPWREMfHSi/vHniU4ourFQ4Gdbnj
         NUDd7OH8BsIlc4rDfrKqqAe9CnWd8qnr1hh4BmQgdXlZQY9VxRSyRcn7IpuYXDtGbd8w
         rZQH4gbG4mdRonGbgPXhmkARNKgj+0Z9TQRo0E9rEWKcLdA7H8MohMSj+0uTh3/ouyAt
         yCpIDLMJ3oS9DcQhDYxBeev2G0jTSa90DDPnomJw6p1uRfOCmi6WjC+EhsxZCne2bTQ4
         SG2XApQAbcBN7XFzcvA+M1ZLsiMhgcyc+WxCV37igpn5eioo7Sv/ZogTmQy9vTTm31j9
         Py4g==
X-Gm-Message-State: ANhLgQ30t9umvZw0XgEtsON9TS+n6jt0SRFwbkUPu8etgF8W4SOfXvvT
        GOmEUvjEuA75RgqoYSxAGRippG0Ul2NxfUXh4Mxy3a7J
X-Google-Smtp-Source: ADFU+vsBl5JlqDidxCK7LsaP6aXL5cdzzZUbyABF3OMZru0KbtSTc43XEhfdwj2xG3j3D7wZBRKKP7ZcYqxLzYL7QOA=
X-Received: by 2002:a67:cb84:: with SMTP id h4mr3195097vsl.85.1584641226832;
 Thu, 19 Mar 2020 11:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com> <1584105767-11963-5-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1584105767-11963-5-git-send-email-kevin3.tang@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 19 Mar 2020 18:06:02 +0000
Message-ID: <CACvgo52_KT6O79PujodCPbkegP6LLwuVSFEoRdbarZ=y50B63A@mail.gmail.com>
Subject: Re: [PATCH RFC v5 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Kevin,

On Sun, 15 Mar 2020 at 23:19, Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> Adds DPU(Display Processor Unit) support for the Unisoc's display subsystem.
> It's support multi planes, scaler, rotation, PQ(Picture Quality) and more.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  drivers/gpu/drm/sprd/Makefile       |   5 +-
>  drivers/gpu/drm/sprd/dpu/Makefile   |   7 +
>  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c | 750 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.c     | 501 ++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h     | 170 ++++++++
>  drivers/gpu/drm/sprd/sprd_drm.c     |   1 +
>  drivers/gpu/drm/sprd/sprd_drm.h     |   2 +

Seems like v5 (patch at least, I did not look at the rest) does not
address a handful of the feedback.
 - Access registers via readl/writel, instead of current approach
 - With ^^ you can drop the compiler workaround
 - Checking for unsupported KMS properties (format, rotation, etc)
should happen in the XXX_check callbacks
 - Remove always true checks, around the (rather moot) abstraction layer

For the future, please keep the revision/changelog within the
corresponding patch. This way reviewers can see, from the onset, what
is addressed.
Look at `git log -- drivers/gpu/drm` for examples.


-Emil
