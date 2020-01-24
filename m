Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qfe6+PLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbgAXLSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:18:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35735 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390477AbgAXLSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:18:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1351898wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANMpFHUuJ7AoaEIR0Mfi1Yglq+QTNbfCcaUKdxl54oM=;
        b=qfe6+PLd80Lj9i8WHJ5i/jm5S39Vl4ZarKRjFY+DLcmhl2tYWYIWC8NfPFTLDJ3QMk
         A8VchwGeZaDVrjIeegtr0+RSpk1JwwVi2NVqPdLNcSkBKix2CxRD+cTcwUc6aPWP7Jg6
         KYMTpr7vVH+a7IA03jv7nmKzhXwZJm5nHe/4p0reELPsxBxjkSxSugxwBnI9UzB4k2m9
         9zgxahOSxAER+hf5xAcpxvfC8C5fpZQ6ipZ09a85vXtDYsvKtYeHNY8gSqgGO6FWImEe
         RPMEuMLvZHdQzD4DoZSxJo+yR//AgNNAU+Q6KpVDLQlyIzNE+fnjV5NA69w9mdIcojB1
         CR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANMpFHUuJ7AoaEIR0Mfi1Yglq+QTNbfCcaUKdxl54oM=;
        b=oLggcD0yiWxkAg01fjbOM30K1tDxwR74UpZD3CZVBt3QenvtqoMUV/c89ggXXTn8+Y
         EY6NXCK2ILA0YiKmW3hpfjfFCswBd3md363tfovqy+IB8ErDRwq8qmYuMUByd1E7xDGL
         MYoKEpnMl5ZVtGqfhCz0I7Nd6+6E6yx2Gv62PQ7osTRkpwn82/qGiw5yIlqnItLUvbK+
         Pklcx7xTZtfkinCWcf5IwwTKrcbOjDrOf/Ih0X6R0P6BeVqE/hm56L4VOLQuy5GOf072
         ueSoyxxGgrpVH/vLQTStHK3XxenHqkSfGqhXCsqaJrC9pS9j77885+fd5wvTyTsCijuu
         k9YA==
X-Gm-Message-State: APjAAAULhOcN/mDcyh8UKyStVy/2Tm6HxkndwH/KsR9zYkFMsrogokKD
        BffEEkVoLdfk++vaudgky0XDgVraDsMlC+/461WeUA==
X-Google-Smtp-Source: APXvYqzaopuaYUqr3B668awTBBxMMz+ierAFISQIhE+3j4KVokdIsPwFPjjwv1X/LnQF7rKqW8YZCmf7n53HPoZyd5w=
X-Received: by 2002:a05:600c:108a:: with SMTP id e10mr2897384wmd.10.1579864723486;
 Fri, 24 Jan 2020 03:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20200116133437.2443-1-narmstrong@baylibre.com> <20200116133437.2443-5-narmstrong@baylibre.com>
In-Reply-To: <20200116133437.2443-5-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Fri, 24 Jan 2020 12:18:32 +0100
Message-ID: <CAMO6naw79tYi7gbwVcHyTG=T=HTNPErp352ZdFOQqzZTvz=89Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] media: meson: vdec: add VP9 input support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 2:34 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Maxime Jourdan <mjourdan@baylibre.com>
>
> Amlogic VP9 decoder requires an additional 16-byte payload before every
> frame header.
>
> The source buffer is updated in-place, then given to the Parser FIFO DMA.
>
> The FIFO DMA copies the blocks into the 16MiB parser ring buffer, then parses
> and copies the slice into the decoder "workspace".
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

[...]

> @@ -186,13 +294,27 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>         int ret;
>         struct vb2_buffer *vb = &vbuf->vb2_buf;
>         struct amvdec_core *core = sess->core;
> +       struct amvdec_codec_ops *codec_ops = sess->fmt_out->codec_ops;
>         u32 payload_size = vb2_get_plane_payload(vb, 0);
>         dma_addr_t phy = vb2_dma_contig_plane_dma_addr(vb, 0);
> +       u32 num_dst_bufs = 0;
>         u32 offset;
>         u32 pad_size;
>
> -       if (esparser_vififo_get_free_space(sess) < payload_size)
> +       if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9) {
> +               if (codec_ops->num_pending_bufs)
> +                       num_dst_bufs = codec_ops->num_pending_bufs(sess);
> +
> +               num_dst_bufs += v4l2_m2m_num_dst_bufs_ready(sess->m2m_ctx);
> +               if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9)
> +                       num_dst_bufs -= 2;

With the changes that happened in the updated series where one more
ref frame is held by VP9, this should be -= 3 to prevent a shortage of
CAPTURE buffers on the decoder side.

For the future, a good enhancement of the way this is handled could be
to notify new capture buffers to the decoding modules (codec_*.c), so
that they could pause when there is no capture buffer available and
resume on this notification.

> +
> +               if (esparser_vififo_get_free_space(sess) < payload_size ||
> +                   atomic_read(&sess->esparser_queued_bufs) >= num_dst_bufs)
> +                       return -EAGAIN;
> +       } else if (esparser_vififo_get_free_space(sess) < payload_size) {
>                 return -EAGAIN;
> +       }
>
>         v4l2_m2m_src_buf_remove_by_buf(sess->m2m_ctx, vbuf);
>
> @@ -206,7 +328,19 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>         vbuf->field = V4L2_FIELD_NONE;
>         vbuf->sequence = sess->sequence_out++;
>
> -       pad_size = esparser_pad_start_code(core, vb);
> +       if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9) {
> +               payload_size = vp9_update_header(core, vb);
> +
> +               /* If unable to alter buffer to add headers */
> +               if (payload_size == 0) {
> +                       amvdec_remove_ts(sess, vb->timestamp);
> +                       v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +
> +                       return 0;
> +               }
> +       }
> +
> +       pad_size = esparser_pad_start_code(core, vb, payload_size);
>         ret = esparser_write_data(core, phy, payload_size + pad_size);
>
>         if (ret <= 0) {
> --
> 2.22.0
>
