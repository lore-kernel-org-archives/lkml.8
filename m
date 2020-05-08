Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5FC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385CF2496F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V843ea6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEHW1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgEHW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:27:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8CBC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 15:27:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so3418271ion.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vle6I6fdCR+MgLWGv8JrPtPNfXU53mZx6L1pAHaqj1g=;
        b=V843ea6ESg1x21Y6+gTjFBY0MV989R+qKt+LdVEmhVpIz91aJMmiflg2BAp0S88GUV
         1INgZt1g72jgtvnQvVSRKwpED9U1EFNWGHCFzWeQ3JaW+FAzuzDK9QhRMu8QMeXz7V95
         wLeJmHkHf7c2u683yKlTCnJtRG01hbD3tYDO48cc6xXEawWUHduJXTmQ52nX2gx0z6xk
         eJcv5XPytWPVGLE8VbxpzCwkSQ/CjiSZIkN3jqobql1mBAUPZ6HCYPOzU7wymQcGVt8W
         4jcWsF+ZAtHJS49l1bmrg/yTkgNDrapQltT0g8NwpSz55x7nvYwPdvssUjq1AOSbMjYA
         Lwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vle6I6fdCR+MgLWGv8JrPtPNfXU53mZx6L1pAHaqj1g=;
        b=PVdKk/oMptSgZyMAejYWv9VwmqdZkqXEVXZZ2O8Q1jod0I7OnUTpyYN1HyuDoJYmw+
         Wl5opvLQMWm3ClJAwCAZOPF64IsBNOfuE69y0tWEdftsgutfYmMtTPpZOpEh3UwQdTU1
         SYckVXghea4VVjWIjW9YaYq3Az/ndFV98H6r1wzgUTCANSj5zvLe0yZqvS4fsvxu7IZ5
         Lnj0ATcRKbwqCJ5JitnALGHqLukMgaG+CPXEW/cqPijJyFSk+zwveqx9B6a3UOC8Jggf
         VGO/pL1t7qo+VIULrvSR4aggW5dFrparE/xEsHQamugjW/hPS4h405QXgUMCyUBIPbXB
         B9dw==
X-Gm-Message-State: AGi0PuaCYJSZprNkkxTPf5j8cYOfNi9mQSAWr71PHuNGNcSaBwoVSRLR
        BsWV1sh84YpkmY7vHyfp2aIlkYLun8iTkmXEaO0Z7A==
X-Google-Smtp-Source: APiQypK80T14lZ+yTq0Yv7MsY9Tajr69Yl/r5H646/JxI/XctxB/azG3DHLQDj81TzoJNJvsCSSa+UKmKnxxaL1LRmg=
X-Received: by 2002:a02:2708:: with SMTP id g8mr4935476jaa.52.1588976833756;
 Fri, 08 May 2020 15:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200420160600.10467-1-s-anna@ti.com> <20200420160600.10467-2-s-anna@ti.com>
In-Reply-To: <20200420160600.10467-2-s-anna@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 8 May 2020 16:27:02 -0600
Message-ID: <CANLsYkwirm2SJoZM9T=VTZAG8iV77PC3ag0AkLbRwf1O84ai_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remoteproc: Fall back to using parent memory pool
 if no dedicated available
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 at 10:07, Suman Anna <s-anna@ti.com> wrote:
>
> From: Tero Kristo <t-kristo@ti.com>
>
> In some cases, like with OMAP remoteproc, we are not creating dedicated
> memory pool for the virtio device. Instead, we use the same memory pool
> for all shared memories. The current virtio memory pool handling forces
> a split between these two, as a separate device is created for it,
> causing memory to be allocated from bad location if the dedicated pool
> is not available. Fix this by falling back to using the parent device
> memory pool if dedicated is not available.
>
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>
> ---
> v3:
>  - Go back to v1 logic (removed the vdevbuf_mem_id variable added in v2)
>  - Revised the comment to remove references to vdevbuf_mem_id
>  - Capitalize the patch header
> v2: https://patchwork.kernel.org/patch/11447651/
>
>  drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index e61d738d9b47..44187fe43677 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -376,6 +376,18 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>                                 goto out;
>                         }
>                 }
> +       } else {
> +               struct device_node *np = rproc->dev.parent->of_node;
> +
> +               /*
> +                * If we don't have dedicated buffer, just attempt to re-assign
> +                * the reserved memory from our parent. A default memory-region
> +                * at index 0 from the parent's memory-regions is assigned for
> +                * the rvdev dev to allocate from. Failure is non-critical and
> +                * the allocations will fall back to global pools, so don't
> +                * check return value either.
> +                */
> +               of_reserved_mem_device_init_by_idx(dev, np, 0);
>         }
>
>         /* Allocate virtio device */
> --
> 2.26.0
>
