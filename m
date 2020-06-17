Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2292C21655
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXuESxTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFQUoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFQUo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:44:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A044C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:44:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so1845657wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izNQ/AUBePYNQ9lFfRhkbYFYOvim7jrWfUSC8PuNm50=;
        b=IXuESxTW1GDtdZdcUhaUxCMmqR0alOzlFYEBB6cNiOWNqNKga8hTG5Hpk8e+jPgfs7
         gKRbcrFHT/bWqDDjWW1Tu0YTxMUPgU3/zaO7ZYFVAB7sZ5/odoojGtjQaAjqQcISTIRV
         21JjuFUVAp2SULD0ievL+VDKAIV4k3A7ZvwkkUpYlqJyABsW/fENnkF9JkHDsmSI8BPu
         lTx1kIP34vOyLqlII9KESAAKJppWEmMCqsPsjTAr9hgHKVBogXM1wNRzyliJEEMpb4Fs
         wM9VKEIlU+zdEi8dgAC6gR4OOYEJEiqf/0YobEdxc2vAIUU4tWPB0ACvaZ+E1SxG3EjY
         tp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izNQ/AUBePYNQ9lFfRhkbYFYOvim7jrWfUSC8PuNm50=;
        b=LVXffu3/dx7HvUi2R5avxOuYGcbP93s0ugxvj6nkG8ZjDW7JGCo5stN1KXe5MNkxRv
         YnfABmegUDqodB8/oHNa+0i4wj6U7FmobQa+Ygge/iNJ5eLfUgCXuCCazC8Dh+kqwWXT
         eg+r+VXXmAU+s5t5B1Q/z3psfW3z6ncQbaIJ5z/CcAsMqxjj7q0jx1GurSscsXUaHZ75
         /4cBCV0YdWHMcoyt642AD17AS3Tle2sD08VxD11Q4VZMfIN5+Jx8bcYD/LZP+6D1GxCr
         WYmiueDAsD/Geb9guikVr6sRvsBfj8hp7+oX5JUZyheCFAcSJ7T7I3dnCXs+6fk+OBM2
         DROA==
X-Gm-Message-State: AOAM533SN9+FY/fqR+5gb/9qqZsCoKZMsxCne+5Qe5Vml3giyGhZp/E2
        R9AwOhd+6PSGS4toGxwmQBtBRG7964qztyhuKEYf2w==
X-Google-Smtp-Source: ABdhPJx4KYJD9wjC9cWcd4dSFsQSQGMcDhbMVkYCssEzFcqvWczHJXD0Mb1mQo4LGh5tn1IdBmBvR3RzvVWXmaZ51kw=
X-Received: by 2002:adf:9c12:: with SMTP id f18mr1114248wrc.105.1592426668016;
 Wed, 17 Jun 2020 13:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200617180801.158331-1-helen.koike@collabora.com>
In-Reply-To: <20200617180801.158331-1-helen.koike@collabora.com>
From:   Tomasz Figa <tfiga@google.com>
Date:   Wed, 17 Jun 2020 22:44:16 +0200
Message-ID: <CAAFQd5ACgNJLzWSYW9_=vDxoUhO8gUjz0_+ntfVsRsRJbceA0A@mail.gmail.com>
Subject: Re: [PATCH] media: staging: rkisp1: rsz: fix resolution limitation on
 sink pad
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:08 PM Helen Koike <helen.koike@collabora.com> wrote:
>
> Resizer sink pad is limited by what the ISP can generate.
> The configurations describes what the resizer can produce.
>
> This was tested on a Scarlet device with ChromiumOs, where the selfpath
> receives 2592x1944 and produces 1600x1200 (which isn't possible without
> this fix).
>
> Fixes: 56e3b29f9f6b2 ("media: staging: rkisp1: add streaming paths")
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>
> ---
>
>  drivers/staging/media/rkisp1/rkisp1-resizer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
> index d049374413dcf..0d41f43b5339f 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
> @@ -553,11 +553,11 @@ static void rkisp1_rsz_set_sink_fmt(struct rkisp1_resizer *rsz,
>         src_fmt->code = sink_fmt->code;
>
>         sink_fmt->width = clamp_t(u32, format->width,
> -                                 rsz->config->min_rsz_width,
> -                                 rsz->config->max_rsz_width);
> +                                 RKISP1_ISP_MIN_WIDTH,
> +                                 RKISP1_ISP_MAX_WIDTH);
>         sink_fmt->height = clamp_t(u32, format->height,
> -                                  rsz->config->min_rsz_height,
> -                                  rsz->config->max_rsz_height);
> +                                 RKISP1_ISP_MIN_HEIGHT,
> +                                 RKISP1_ISP_MAX_HEIGHT);
>
>         *format = *sink_fmt;
>
> --
> 2.26.0
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
