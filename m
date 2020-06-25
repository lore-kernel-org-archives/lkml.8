Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57972082F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJ8asht9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405810AbgFYPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405795AbgFYPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:30:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8BC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:30:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s28so4528527edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CFr8jzBzEkamA0nfO1v7fQEbEWs3FBjMcmzi4CDti0=;
        b=WJ8asht9a2bkKvjvqDVdRvxV8wwmqFaKK+ZBX62IL9uEpDarnfWyH8HXt2mgBTuz1V
         2IQjA6TRIvuXb2/XC8KADmNHTJfxRlA3uWmPoi7EBxtS3OUAD2lZ51uMFNVbYyyixdv9
         XdIW9PohcTMAZEV3Rk2AOTRvPMKqmUdQth4c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CFr8jzBzEkamA0nfO1v7fQEbEWs3FBjMcmzi4CDti0=;
        b=nmsGhJSFxs4J+9sJw8iV07f5qVGz04ebHzgPcJg59R+gvoCcYVaUUpvGcKtkwanj3G
         Qlr/skWO9lBxZBmbf5DEuZnjXZsSal5lXlOwbSJ3qymSv7jD9aiv/pkUWYr6Cim4tXPf
         OJPPAvfmro7VxEyR50d6gzfu1/XFvuStZKjL660EfXU5v5osid5rJfXMXifwhbshjg6V
         Yl2tyj0cl7nCuD+aGcRKRNLttozsrWVHwqBl6soYQiK94EwmtuD8maAYA3a1PMMmapuZ
         Z0pevM58uI1RufRKeWGiRGQ/pUjwDDHG1RePsluJZV9URQFHIQIGs7USWpfnsvK6oeoc
         DBgA==
X-Gm-Message-State: AOAM532OIur/N/dGBmWTAXiJDuMKH24EkJYH703h2BzaYgTTMM1g+pBc
        /Zewawyb406rdjmdhJUVqjpX1R4untA=
X-Google-Smtp-Source: ABdhPJwB2HPpTSrzGR2p+gYamIxzmMyOgY+nv30P0CQQ+sMK4zSg67qjUhByC2mIexvJoQ18ini6yQ==
X-Received: by 2002:a50:ec8f:: with SMTP id e15mr22668231edr.70.1593099046947;
        Thu, 25 Jun 2020 08:30:46 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id y12sm18712739edj.37.2020.06.25.08.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:30:46 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id f139so6377411wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:30:45 -0700 (PDT)
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr3725834wmm.183.1593099045444;
 Thu, 25 Jun 2020 08:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623182809.1375-1-ezequiel@collabora.com> <20200623182809.1375-3-ezequiel@collabora.com>
In-Reply-To: <20200623182809.1375-3-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 25 Jun 2020 17:30:33 +0200
X-Gmail-Original-Message-ID: <CAAFQd5DmsE4jvXNWVqRMifx48oLhQohm-sYYJNpsx2_ipb3Niw@mail.gmail.com>
Message-ID: <CAAFQd5DmsE4jvXNWVqRMifx48oLhQohm-sYYJNpsx2_ipb3Niw@mail.gmail.com>
Subject: Re: [RFC 2/7] fixup! media: uapi: h264: update reference lists
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 8:29 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Align v4l2_h264_reference to 32-bits, giving some room
> for future extensions.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst  |  3 +++
>  drivers/media/v4l2-core/v4l2-ctrls.c             | 16 ++++++++++++++++
>  include/media/h264-ctrls.h                       |  7 +++++--
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 6c36d298db20..7af12447a5b0 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1943,6 +1943,9 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>      * - __u8
>        - ``index``
>        -
> +    * - __u32
> +      - ``reserved``
> +      - Applications and drivers must set this to zero.

__u16?

Best regards,
Tomasz
