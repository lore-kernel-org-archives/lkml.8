Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EDAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32562146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OzXiZdZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgCKLDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:03:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33235 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCKLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:03:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so2374384ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jb6YNfpy0i4p0prPq7fXurxyCpu3UioYP/wK0SXZz40=;
        b=OzXiZdZxcla8lff01e5y1xu8R1or7O5akJh7vkF0kGDv+FIl4k+KI5dt7+u7bNa22f
         pEgi1+VeIA0u2roWjwGSIIVN7DccoliwZNCmhlmVo4+QDcI5e0XEPbQld3FfpR1P8z8I
         MP4yhJz3sMk7jvtXq8o0TB7XLMZod2m/M8uIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jb6YNfpy0i4p0prPq7fXurxyCpu3UioYP/wK0SXZz40=;
        b=HEFpaGwcT1VSJIS745CNWs1EsXKzfK7FoKw4REHj8oEhRfxATI03mVWFudfvouhHOZ
         426JtFhLMkwrTR9nmSjsdmWyI0fhySOPOW1EjLbiKc5+nyj8H1pq3Tm/+dTrnwJQ1zl8
         tJl41U7G1bSw+UxnRQSMcsGe754FUkrtiBSlQTtV7HksP9pt8D/gb3zrnPW5KH8CxqAS
         1u9OVsjA7Dlnbk6PZWNJU5f2jWsc2KMVMkMSAy8M5TlApGFJDlJbpUkaF2iEIrKdKYvY
         T7TbVgqD7/mrXPcOKGRq64cTXLeRuTpIr2GsPz2Rc/f+zKBD9PziTCxGY+DqNPsPRQZu
         eTmg==
X-Gm-Message-State: ANhLgQ0BycNgDZFO3Qks+h+1H3mmeVJXdvjK+P+LAptlkKrPasCS7mto
        sZoHmTp8QF2NeRzcHd3x1rMm+dgvuvQatQ==
X-Google-Smtp-Source: ADFU+vsOAJoSM+Lckvqu+CgHW/ok3f41wf+W5PjPDRUFI2ur+Q6Ak7PNRh5Nk1asj0uIZEBNcuaqFg==
X-Received: by 2002:a50:9ae4:: with SMTP id p91mr2185773edb.114.1583924581947;
        Wed, 11 Mar 2020 04:03:01 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id m3sm1415728ejj.22.2020.03.11.04.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 04:03:00 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id t11so2026469wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:03:00 -0700 (PDT)
X-Received: by 2002:adf:f545:: with SMTP id j5mr3918965wrp.295.1583924580138;
 Wed, 11 Mar 2020 04:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200303123446.20095-1-xia.jiang@mediatek.com> <20200303123446.20095-4-xia.jiang@mediatek.com>
In-Reply-To: <20200303123446.20095-4-xia.jiang@mediatek.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 11 Mar 2020 20:02:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AA6NtLDsqL3Ph8cwv5=ZYoPOiu4Wa85ky037qOyMH1QQ@mail.gmail.com>
Message-ID: <CAAFQd5AA6NtLDsqL3Ph8cwv5=ZYoPOiu4Wa85ky037qOyMH1QQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] media: platform: Improve s_selection flow for
 bug fixing
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

On Tue, Mar 3, 2020 at 9:35 PM Xia Jiang <xia.jiang@mediatek.com> wrote:
>
> Get correct compose value in mtk_jpeg_s_selection function.

It's a good practice to describe why the current code is wrong and new is good.

>
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks for the patch. Please see my comment inline.

> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index da0dae4b0fc9..fb2c8d026580 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -492,8 +492,8 @@ static int mtk_jpeg_s_selection(struct file *file, void *priv,
>         case V4L2_SEL_TGT_COMPOSE:
>                 s->r.left = 0;
>                 s->r.top = 0;
> -               s->r.width = ctx->out_q.w;
> -               s->r.height = ctx->out_q.h;
> +               ctx->out_q.w = s->r.width;
> +               ctx->out_q.h = s->r.height;
>                 break;
>         default:
>                 return -EINVAL;

The decoder compose target means the visible rectangle of the decoded
image, which comes from the stream metadata. It's not something that
can be set by the userspace.

Best regards,
Tomasz
