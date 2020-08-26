Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC6DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184DE2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="w3AavdH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHZEIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 00:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHZEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:08:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506EC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:08:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so979150ejr.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95OkwIst0BgaPvc79h1qg3LdSl4GbI3ESVZ1x5Cd4z0=;
        b=w3AavdH0CyRLn2mOVhiA8ofnTFU2tiv0idnEtoYtPz2RJ4kF6Y16v7krJTN6PSVAFI
         YR1pnuK23K1JhzKFqWreGiH4MtMtarkOxlWLpDr3vMdndO+OG5/lqVb3r5urLv3+46nn
         YgrMtlYOPz/AxSuSPEpBGYlGH9F2WAGGF8SnQC/rU8xeogtu/Jrlh4Efjnj3Fw9z2dZ6
         yVkSaZDlIMNQ75L92889n7mCEM4f0TZJkOt5JT1I2lgQIgAc3D293N+xVqJ+7RBLBC6H
         fzJFjCo72iJ56EM3VKIh/X5dLkztY3hRPylFz5oAJadMaKa3a6g5ryQmWCilInZ+jQ4S
         KlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95OkwIst0BgaPvc79h1qg3LdSl4GbI3ESVZ1x5Cd4z0=;
        b=JlLe4iy7Lg1vtgoAfau2tItXMN9YKerVCdqdg3XRTlzrnVe3DKMpX3RHpj2XtpGCid
         vgKyv6fsTFyZX73fjrAloZxf1/FdDMO5SIRbvLXIoDWvr49BorJk81ILsAFw+VXva48R
         YXNsXJhIrFqhx8YVyERsupHFwRBBeaxYaCr9XmMSJ9owBKsUe6fydMF+cuKKrgaWgxc4
         LJyvXpfB+Mah0ZXzBmc7VHOYM9elp3/CzRq7vl2d/ETXTQ5GqOF4Mehnvg/wssMEPLwB
         UZluWAkJrqW3tpQSXsSNrSqpBHuajfzDQlTbWv7RvXDO9CZs+Uje8GHEHJjCswqEKg4l
         pavQ==
X-Gm-Message-State: AOAM530r+Vgijfb+ZJSe71S98q3EPypkLsg/CZ/S8rMbG/w/RGGRLepA
        /G1XjddleCjVf6/dMSv28lX5N1MioA74ANO6zoIQYyG+sJt6bw==
X-Google-Smtp-Source: ABdhPJyoYnCNOMQ+6QmiXrwUF4MIrr17+WMQ1LxjEMAHIJvLxYUEY4kqmAJBXewcsUxRhC90vZWQkqCVXYFI9C6bvbE=
X-Received: by 2002:a17:906:c108:: with SMTP id do8mr14361365ejc.88.1598414883304;
 Tue, 25 Aug 2020 21:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825145556.637323-1-gnurou@gmail.com> <20200825145556.637323-2-gnurou@gmail.com>
In-Reply-To: <20200825145556.637323-2-gnurou@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 26 Aug 2020 01:07:52 -0300
Message-ID: <CAAEAJfBeJnSjqfyhosM_6jP4C+wQ7UVmt=oG_O0w--sAf0=0PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: v4l2-mem2mem: consider OUTPUT queue first when polling
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, 25 Aug 2020 at 11:56, Alexandre Courbot <gnurou@gmail.com> wrote:
>
> If poll() is called on a m2m device with the EPOLLOUT event after the
> last buffer of the CAPTURE queue is dequeued, any buffer available on
> OUTPUT queue will never be signaled because v4l2_m2m_poll_for_data()
> starts by checking whether dst_q->last_buffer_dequeued is set and
> returns EPOLLIN in this case, without looking at the state of the OUTPUT
> queue.
>
> Fix this by checking the state of the OUTPUT queue before considering
> that early-return case.
>
> This also has the side-effect of bringing the two blocks of code dealing
> with the CAPTURE queue next to one another, and saves us one spin
> lock/unlock cycle, for what it's worth.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

Change looks good to me.

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Do you think it qualifies for -stable? The issue has been
here since the dawn of time.

Thanks,
Ezequiel

> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index 95a8f2dc5341d..0d0192119af20 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -862,6 +862,15 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
>              list_empty(&dst_q->queued_list)))
>                 return EPOLLERR;
>
> +       spin_lock_irqsave(&src_q->done_lock, flags);
> +       if (!list_empty(&src_q->done_list))
> +               src_vb = list_first_entry(&src_q->done_list, struct vb2_buffer,
> +                                               done_entry);
> +       if (src_vb && (src_vb->state == VB2_BUF_STATE_DONE
> +                       || src_vb->state == VB2_BUF_STATE_ERROR))
> +               rc |= EPOLLOUT | EPOLLWRNORM;
> +       spin_unlock_irqrestore(&src_q->done_lock, flags);
> +
>         spin_lock_irqsave(&dst_q->done_lock, flags);
>         if (list_empty(&dst_q->done_list)) {
>                 /*
> @@ -870,21 +879,11 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
>                  */
>                 if (dst_q->last_buffer_dequeued) {
>                         spin_unlock_irqrestore(&dst_q->done_lock, flags);
> -                       return EPOLLIN | EPOLLRDNORM;
> +                       rc |= EPOLLIN | EPOLLRDNORM;
> +                       return rc;
>                 }
>         }
> -       spin_unlock_irqrestore(&dst_q->done_lock, flags);
>
> -       spin_lock_irqsave(&src_q->done_lock, flags);
> -       if (!list_empty(&src_q->done_list))
> -               src_vb = list_first_entry(&src_q->done_list, struct vb2_buffer,
> -                                               done_entry);
> -       if (src_vb && (src_vb->state == VB2_BUF_STATE_DONE
> -                       || src_vb->state == VB2_BUF_STATE_ERROR))
> -               rc |= EPOLLOUT | EPOLLWRNORM;
> -       spin_unlock_irqrestore(&src_q->done_lock, flags);
> -
> -       spin_lock_irqsave(&dst_q->done_lock, flags);
>         if (!list_empty(&dst_q->done_list))
>                 dst_vb = list_first_entry(&dst_q->done_list, struct vb2_buffer,
>                                                 done_entry);
> --
> 2.28.0
>
