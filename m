Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1877EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4102078C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="YZDlR7wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEEMpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgEEMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:45:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F17C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:45:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so1640288edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YMVoM8MB/DmaYSfgc1C7r97WJiRJ98Zuz8O8b2fB1Tk=;
        b=YZDlR7wbgPixPGqp6u7w1A7c0PPVBfjS74wwW7ww4Ig5XezgZvl9QiF9A0RFr/W9Ih
         rwj2bR4V3i7wXxokh95QBlfNsec5zxioWSkkvqgXo2Jgr9pUUnw45qBqaNiG9N2sbBdZ
         VNT78i2Uaat8Os2U8RbN0mHi2SZjlpTYFnafK3h7c0cts4BjvSTLmL+AQ0sOHj1OfrJx
         VyRIhjHZ85wtcQMoCHETeWA3CSUcPMQ35mZiZOAAJA/KIfWTwuxPJ/NfT9UqUXsOBTCq
         Ol/NeYcxTHXH1dJk4OIDZsX8vpsCtpkW96uaiICi5xxxIu2m8QY/ymo0aAf1b1VjYe5g
         ovyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YMVoM8MB/DmaYSfgc1C7r97WJiRJ98Zuz8O8b2fB1Tk=;
        b=j4EBtEvTIkuUKUogqgiVdE76Yt3wF6b7h/q4nppV9sw54wRPefjotfrzZgDDL+bGP8
         zjaw5/fWjSR9WNs0iQc6QqcHmzr4p3fWZ8WQrIMR+4pt/UwFxSHyPzjrHaD0GhQWLb76
         0J0AHtzkNZ5Y2hvtbqm84GA9lVv/Jz192rqIZrMsSOdOULsvOBad0Xk+WiKHPH3xPdGV
         tLdU+tUnfAUApJ+myS21CKJs+0IWruMwJri07bxXorxWQbUqNzA9WlWIIdod6foV10QM
         i4etyny61Ul0LE2WMLzA5E+LD364HDEBkkKrJTTKEMTnKopbXmZZqlp4GMVmsd5E3pV0
         N7ZA==
X-Gm-Message-State: AGi0PuZ1WhmNjC72qK9tldlABTbIRMID9dNFsrsqcpJwom+/Fs17yxni
        jKtke/8/X97wu4qKTcVUp+MrNMGoaqJo/Gggr5564w==
X-Google-Smtp-Source: APiQypKckLPqHpRxF9lpdKOAJMSVW/WHsfxFruoN9Jp/mBAEIJISr+H5BCKREAnltXZk8VCTHOkQ5PA01iVWPjvSa2Y=
X-Received: by 2002:a05:6402:1587:: with SMTP id c7mr2263913edv.61.1588682746473;
 Tue, 05 May 2020 05:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200422040410.6251-1-samuel@sholland.org>
In-Reply-To: <20200422040410.6251-1-samuel@sholland.org>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 5 May 2020 09:45:35 -0300
Message-ID: <CAAEAJfCffyB_7xUVsJsScXNpO7iMuwsQ8Cu5p_xw3dtqqQgwbg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: cedrus: Program output format
 during each run
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 01:00, Samuel Holland <samuel@sholland.org> wrote:
>
> Previously, the output format was programmed as part of the ioctl()
> handler. However, this has two problems:
>
>   1) If there are multiple active streams with different output
>      formats, the hardware will use whichever format was set last
>      for both streams. Similary, an ioctl() done in an inactive
>      context will wrongly affect other active contexts.
>   2) The registers are written while the device is not actively
>      streaming. To enable runtime PM tied to the streaming state,
>      all hardware access needs to be moved inside cedrus_device_run().
>
> The call to cedrus_dst_format_set() is now placed just before the
> codec-specific callback that programs the hardware.
>

Cc: <stable@vger.kernel.org>

> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Suggested-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>
> Suggested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks,
Ezequiel

> ---
>
> v2: added patch
>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 2 ++
>  drivers/staging/media/sunxi/cedrus/cedrus_video.c | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_dec.c
> index 4a2fc33a1d79..58c48e4fdfe9 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -74,6 +74,8 @@ void cedrus_device_run(void *priv)
>
>         v4l2_m2m_buf_copy_metadata(run.src, run.dst, true);
>
> +       cedrus_dst_format_set(dev, &ctx->dst_fmt);
> +
>         dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
>
>         /* Complete request(s) controls if needed. */
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_video.c
> index 15cf1f10221b..ed3f511f066f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -273,7 +273,6 @@ static int cedrus_s_fmt_vid_cap(struct file *file, vo=
id *priv,
>                                 struct v4l2_format *f)
>  {
>         struct cedrus_ctx *ctx =3D cedrus_file2ctx(file);
> -       struct cedrus_dev *dev =3D ctx->dev;
>         struct vb2_queue *vq;
>         int ret;
>
> @@ -287,8 +286,6 @@ static int cedrus_s_fmt_vid_cap(struct file *file, vo=
id *priv,
>
>         ctx->dst_fmt =3D f->fmt.pix;
>
> -       cedrus_dst_format_set(dev, &ctx->dst_fmt);
> -
>         return 0;
>  }
>
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20200422040410.6251-1-samuel%40sholland.org.
