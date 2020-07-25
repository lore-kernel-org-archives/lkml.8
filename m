Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D5C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EB120674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a52n/QvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGYOqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGYOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:45:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ADFC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:45:58 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k22so10626514oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrYFb2IYZKFYNy0ZRqbrO/ZpY3ot25T0Fu/kJw/KuIo=;
        b=a52n/QvUYfIOQ1LipBknthVlW9Mcm3lbMy3gRRgPbFFfUjZULnS0fWRKJEpWifwT88
         1jvcX4G60H61GouIWGnYOKEQL5cSHNAXXfhBfPOhpU3a8+GA1QqQHfuiHRhCstCOt60t
         tiZ0zXsmcoHSVqHUba7f3nuC/T8AGy58vUksw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrYFb2IYZKFYNy0ZRqbrO/ZpY3ot25T0Fu/kJw/KuIo=;
        b=sRJiaAtp0zfd0OHvpkVmFkl9sxYgYj8jeJUsKfSUCli2nd6u17kSBeFe8SHNusJ3d/
         DjFFHF2Hhlaa9P4Q7ynSpTppc7V0esXCAf3vlwDqeTkh2JF8puE+E5dVTwUygQglOA4o
         VR0S4TvOimIdbVhEuZzJjuO/T6sKCpmGOjTl7Rk9JpgCO20kzv+/u7V0zgdHcKZL0sZa
         v+2fib/TNeAlbyvtNbMc+kx9Uhg61lNsiipbdxKlPKchNyR5nSFudGnZWMYWYNchieja
         h5CBZNII99lKKR1kwkdXUzn7LbfTXvKqwBZtctT/pID7VSSHhpP7Ucd0lYl5b+KfV9Ar
         ofeg==
X-Gm-Message-State: AOAM532cJZDqfPOMz7LR9i/CwjmlkVcIzu3wEFjb0DnHIi1BVX6Lqbfp
        RkiViaDrpqHmHRNH/f7kEZzMeriR3kY=
X-Google-Smtp-Source: ABdhPJzqgPwMOB5P7lDqO56tk5S2S1tvezakIVCMQB2mTYfTusfEO4wr6AgnGhy0QlSNnx1dHp8Tyw==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr12325582oib.143.1595688356887;
        Sat, 25 Jul 2020 07:45:56 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id s26sm739902ooc.31.2020.07.25.07.45.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 07:45:55 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id w17so9173708otl.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:45:55 -0700 (PDT)
X-Received: by 2002:a05:6830:1daa:: with SMTP id z10mr13317108oti.36.1595688354490;
 Sat, 25 Jul 2020 07:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200715202233.185680-1-ezequiel@collabora.com> <20200715202233.185680-10-ezequiel@collabora.com>
In-Reply-To: <20200715202233.185680-10-ezequiel@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sat, 25 Jul 2020 23:45:41 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWG5aXuc7ExiaKvgtLL0o=HDYKFa4D4-v8hfvyGiNFBdA@mail.gmail.com>
Message-ID: <CAPBb6MWG5aXuc7ExiaKvgtLL0o=HDYKFa4D4-v8hfvyGiNFBdA@mail.gmail.com>
Subject: Re: [PATCH 09/10] media: hantro: Don't require unneeded H264_SLICE_PARAMS
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
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

On Thu, Jul 16, 2020 at 5:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Now that slice invariant parameters have been moved,
> the driver no longer needs this control, so drop it.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro_drv.c  | 5 -----
>  drivers/staging/media/hantro/hantro_h264.c | 5 -----
>  drivers/staging/media/hantro/hantro_hw.h   | 2 --
>  3 files changed, 12 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 34797507f214..3cd00cc0a364 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -306,11 +306,6 @@ static const struct hantro_ctrl controls[] = {
>                 .cfg = {
>                         .id = V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS,
>                 },
> -       }, {
> -               .codec = HANTRO_H264_DECODER,
> -               .cfg = {
> -                       .id = V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS,
> -               },

Isn't this going to make the driver reject (as opposed to just ignore)
this control altogether? Also, even though the control is not required
anymore, don't we want to check that it is provided in order to ensure
user-space follows the spec (granted, this would be better done in a
common framework shared by all drivers).

I'd also suggest this patch (and the following one) to be merged into
the previous one as they are just removing fields that have become
unneeded because of it.
