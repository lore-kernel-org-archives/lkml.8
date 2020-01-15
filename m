Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032CCC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7841222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="blCG6NNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgAODrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:47:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37838 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAODrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:47:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so14916222otn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXE1pb9ZXSzUXM/cWp0vEuD1ufr49jnlyg/BuiYZBlA=;
        b=blCG6NNqmLU0+Yk3taOGfpNtJDvgllIRe1SUqtLakI2cGhtlgR7yOi6ZEASVsLviqR
         iyMUzuQ2s8+c3MOxNrGvBQg30aRdU8eM6KVBNxY9j8LAW4rePBASrqJ9bvNU+hQpe2Ea
         utDje7lx9JZAIV6DHWN8teCJ5y4glPgV1PECY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXE1pb9ZXSzUXM/cWp0vEuD1ufr49jnlyg/BuiYZBlA=;
        b=JSmPGx9T+2FhggVeYzSvlosdhvGeJKzSq0Ee6GVSO8P7cLFudpLLhBY5PVWE/xPfSr
         eoNpwEqQaIVTJRkGwdRPGrdwqSiBSF79GG7mfKjrAW6JnLhQXZoU26sdtBpZvGhsJ1Q6
         SO2LBTmWI8pbeVo/VkNK1hmGvU4LU76ZLjaPhJokoyKkNzOj1QsMDlRAnp+fAFrTlzZG
         IMoGl65T/fjeslp1YZkz4ploseugDV7j+IefGa596pGkQaodiQAqyWm7jpFLGKCmTPv4
         gG4BRT5pb1/97tlxEXqC2YmlOuUbbWeYGyZPQdqq6anU9rW91LTZN+qZgyURONwZN+0G
         469w==
X-Gm-Message-State: APjAAAX7MfA7kQHaiARBZbfukPgTGl13lt/T8gF+MdqBiXh5TPxV1jel
        EklXzi8fUEKp4paGmYmXm7QSPsIJOtk=
X-Google-Smtp-Source: APXvYqwrPnmWW+62YL/e85eL4cNdtFPK538r5TBymcHF4kBo89RrM7Yz7uKz7aNoPMvfFg6RIls4Mw==
X-Received: by 2002:a9d:198b:: with SMTP id k11mr1311190otk.295.1579060065239;
        Tue, 14 Jan 2020 19:47:45 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id m185sm5300864oia.26.2020.01.14.19.47.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 19:47:44 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 59so14871486otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:47:43 -0800 (PST)
X-Received: by 2002:a05:6830:13da:: with SMTP id e26mr1239454otq.97.1579060063207;
 Tue, 14 Jan 2020 19:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20200114033226.16786-1-gtk_ruiwang@mediatek.com>
In-Reply-To: <20200114033226.16786-1-gtk_ruiwang@mediatek.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 15 Jan 2020 12:47:32 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXhiNK84PuUy8=RUUeSh5j4VXw-Ar5SbZDHZAobp7xpEQ@mail.gmail.com>
Message-ID: <CAPBb6MXhiNK84PuUy8=RUUeSh5j4VXw-Ar5SbZDHZAobp7xpEQ@mail.gmail.com>
Subject: Re: media: mtk-vcodec: reset segment data then trig decoder
To:     gtk_ruiwang <gtk_ruiwang@mediatek.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:32 PM <gtk_ruiwang@mediatek.com> wrote:
>
> From: gtk_ruiwang <gtk_ruiwang@mediatek.com>
>
> VP9 bitstream specification indicate segment data should reset to
> default when meet key frames, intra only frames or enable error
> resilience mode. So memset segmentation map buffer before every
> decode process is not appropriate.
>
> Reset segment data only when needed, then trig decoder hardware
>
> Signed-off-by: Rui Wang <gtk_ruiwang@mediatek.com>
> ---
>  .../platform/mtk-vcodec/vdec/vdec_vp9_if.c    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> index 24c1f0bf2147..42c9c3c98076 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> @@ -110,7 +110,9 @@ struct vp9_sf_ref_fb {
>   * @buf_len_sz_c : size used to store cbcr plane ufo info (AP-R, VPU-W)
>
>   * @profile : profile sparsed from vpu (AP-R, VPU-W)
> - * @show_frame : display this frame or not (AP-R, VPU-W)
> + * @show_frame : [BIT(0)] display this frame or not (AP-R, VPU-W)
> + *     [BIT(14)] reset segment data or not (AP-R, VPU-W)
> + *     [BIT(15)] trig decoder hardware or not (AP-R, VPU-W)
>   * @show_existing_frame : inform this frame is show existing frame
>   *     (AP-R, VPU-W)
>   * @frm_to_show_idx : index to show frame (AP-R, VPU-W)
> @@ -494,12 +496,12 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
>                                         frm_to_show->fb->base_y.size);
>                 }
>                 if (!vp9_is_sf_ref_fb(inst, inst->cur_fb)) {
> -                       if (vsi->show_frame)
> +                       if (vsi->show_frame & BIT(0))
>                                 vp9_add_to_fb_disp_list(inst, inst->cur_fb);
>                 }
>         } else {
>                 if (!vp9_is_sf_ref_fb(inst, inst->cur_fb)) {
> -                       if (vsi->show_frame)
> +                       if (vsi->show_frame & BIT(0))
>                                 vp9_add_to_fb_disp_list(inst, frm_to_show->fb);
>                 }
>         }
> @@ -870,13 +872,22 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>                                         vsi->sf_frm_sz[idx]);
>                         }
>                 }
> -               memset(inst->seg_id_buf.va, 0, inst->seg_id_buf.size);
>                 ret = vpu_dec_start(&inst->vpu, data, 3);
>                 if (ret) {
>                         mtk_vcodec_err(inst, "vpu_dec_start failed");
>                         goto DECODE_ERROR;
>                 }
>
> +               if ((vsi->show_frame & BIT(15)) &&
> +                   (vsi->show_frame & BIT(14))) {

Using the new bits in this manner means this patch is not compatible
with the older firmware.

On an older firmware, these bits will be 0, which means the decoder
will never be started. To preserve compatibility, the behavior should
be reversed: *do not* reset and/or start the decoder if the bits are
set.

Also both bits are only used together - we should either separate the
data segment reset and decoder start, or rely on only one bit for
this.

> +                       memset(inst->seg_id_buf.va, 0, inst->seg_id_buf.size);
> +                       ret = vpu_dec_start(&inst->vpu, NULL, 0);
> +                       if (ret) {
> +                               mtk_vcodec_err(inst, "vpu trig decoder failed");
> +                               goto DECODE_ERROR;
> +                       }
> +               }
> +
>                 ret = validate_vsi_array_indexes(inst, vsi);
>                 if (ret) {
>                         mtk_vcodec_err(inst, "Invalid values from VPU.");
> --
> 2.18.0
