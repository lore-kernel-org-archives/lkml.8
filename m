Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9892C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF49A2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="KjPVpgMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFAVT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgFAVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:19:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76947C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:19:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r2so8577644ioo.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLJA34osZojtXwJVfuFDiRuCU0UG0pNat9rZBvD4N6o=;
        b=KjPVpgMjUaVFvgf4lgpJvrbVuOKbMptA5Zxy3BS2pdbAq2Sc20x1VHqV48I0BDhyMk
         /mrklzQVCb7IUZDXvkfXp+1IK3JctDfbAL8onndlwkV1ruHwLYhrt6eAef3fzrZO1qfo
         rQUrRjigths73TlnoTAjFoP2MTRFmXw9pwaFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLJA34osZojtXwJVfuFDiRuCU0UG0pNat9rZBvD4N6o=;
        b=JkZoIEZJQ2uKYpGRKiBXnzSfhabPhboE6jrLWFnW0x5dH4aFlCZG/pScfvB6ukI2dK
         Xe30Og6fpAHneBeQfn3ddb4xkS2wFwjkh7C6Lq9yswUd0a+QH90vguRuJmfbE1k37Qii
         7DjS/v2W7b9phVW7INhFnCRzHb8RH+5SQ0S00nPlnH7g9quGyjolhe+GDZImsTfHvJFo
         ke12lbOah+PcxXRSFHAHDbt+TSoii2tmtQPKNo3aXYpXT3jhdPsvc0sl6/2DWXDEI5gy
         tPYoiNbueauk+MNMJZScVVybAjw5mpxCGpDULyjF9JONVLf0Ifnwp5VkULBk/642CXzt
         AsrA==
X-Gm-Message-State: AOAM532z8FVUsqYd1LXjcYrLi+xzrg5+x1RXVBJaKdsLzZAon3AbXgxp
        ypcfivjOXeVLPCJoFgBfUn61YtZcRedZ4NWSbnX/Cg==
X-Google-Smtp-Source: ABdhPJzY3vtLDPH5lTq64moY0j94dlfRggTPJJcd1GjX1SJ4uolHEvJL8325ez0To/WT0clunDM76QvDOR7RGZFVXq4=
X-Received: by 2002:a6b:f812:: with SMTP id o18mr19976556ioh.87.1591046394929;
 Mon, 01 Jun 2020 14:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200601161552.34579-1-tomasz.duszynski@octakon.com>
In-Reply-To: <20200601161552.34579-1-tomasz.duszynski@octakon.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 1 Jun 2020 14:19:43 -0700
Message-ID: <CAJCx=gkXrNV1pHHBYFcKUttkN=Vc9i_1fOh4stCG3f_GWVJfYA@mail.gmail.com>
Subject: Re: [PATCH] iio: improve IIO_CONCENTRATION channel type description
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matt Ranostay <mranostay@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 9:18 AM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> IIO_CONCENTRATION together with INFO_RAW specifier is used for reporting
> raw concentrations of pollutants. Raw value should be meaningless
> before being properly scaled. Because of that description shouldn't
> mention raw value unit whatsoever.
>
> Fix this by rephrasing existing description so it follows conventions
> used throughout IIO ABI docs.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> Fixes: 8ff6b3bc94930 ("iio: chemical: Add IIO_CONCENTRATION channel type")
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3e53a6d8331..5c62bfb0f3f5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1569,7 +1569,8 @@ What:             /sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
>  KernelVersion: 4.3
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> -               Raw (unscaled no offset etc.) percentage reading of a substance.
> +               Raw (unscaled no offset etc.) reading of a substance. Units
> +               after application of scale and offset are percents.
>
>  What:          /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
> --
> 2.26.2
>
