Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB0C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019C8208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="yVyoKyqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgH1PTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgH1PSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:18:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95279C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:18:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so2002641ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLp2qagswVisSwUhPji3X4e9+R7X4KPZn75PJ32/4eQ=;
        b=yVyoKyqZXuU1lVddeyUQszPeCQWTOeASrF2dR5tgqlPZEMRiN1EKdCpNioEgwC8q+P
         r1M+d+u9uLB5f+JfYgP7r9bm31N7S6aPmsXAN6LULKHleMTNGDYH0NXJH3yWF8+tDBFp
         KRQtgV4CLEWbbMgZCmLJMKad1pOrKCKuttBA0pHba/Z7I83odZbMay96ESYh+/Be1lkZ
         /9lrs+4ePmk6pbiK5X9rWgsEyI2vcaQOt4GgRckN+FWWGtLqiC6rmVuEWgDpsyZVe4rj
         oGO6da4aGJsxImuUwY3Fw975MC0kkUgjhGZITIsdNfgdt0c0/PmvQhtC38bj1WfO4sCT
         G34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLp2qagswVisSwUhPji3X4e9+R7X4KPZn75PJ32/4eQ=;
        b=mdIxhq0NLXEHP/uKd3Cziv2mJsefYNTuBhOZbCSx/s8mwf3Itfac71e06tYKZ0itDl
         KAqeFHpe7R6jeuaoCch82VUiXPbMFLAVvaFQkZUk4MmFG4GC+a2Grs9xr65hnfooppUE
         pvJ2pO7dmcilwP1Fycd+VL0tg85b/GKYqAW58Etoo23SQTGTCfxubTLWSFprOoEJuZNi
         O8dejkOfY+w1KhGjrQfRn9qu1J96WuNGqyb8amx0J3NavIpQudMxEj7rwxfOdezl507A
         TSfHa7xpfqwGWH895mkRSUeS65t2dVy3lyJ7Yf39FxhcPW8CZ6//OXIO3c9egtiquZM6
         S07g==
X-Gm-Message-State: AOAM531ypK3IdChZP5/YTpYIT8AJEgT3DsBk3qMATQDK4mYaiVIAZoul
        c10b7nLMTaVu0AsuD1EEv/Vi7UxSwcFgdKqz/d4/eA==
X-Google-Smtp-Source: ABdhPJwzuOCiKW8xZAt5+FxAc2kjneiSQ3kGfhVJkYTgi/85BXb83BGsmDvfrjvd/brJkPJbOHVpyr+kmgwFgQPxDck=
X-Received: by 2002:a17:906:c10c:: with SMTP id do12mr2324911ejc.92.1598627911293;
 Fri, 28 Aug 2020 08:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200827124946.328700-1-gnurou@gmail.com> <20200827124946.328700-3-gnurou@gmail.com>
In-Reply-To: <20200827124946.328700-3-gnurou@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 28 Aug 2020 12:18:20 -0300
Message-ID: <CAAEAJfCPqse-E9dekbS2A+thodJq7cP+29kxck-w5Rn4r83Qog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: v4l2-mem2mem: simplify poll logic
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

On Thu, 27 Aug 2020 at 09:50, Alexandre Courbot <gnurou@gmail.com> wrote:
>
> Factorize redundant checks into a single code block, remove unneeded
> checks (a buffer in done_list is necessarily in the DONE or ERROR
> state), and we end up with a much simpler version of this function.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

This is really good, thanks!

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index fe90c3c0e4128..af8138c5d7ced 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -841,7 +841,6 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
>                                        struct poll_table_struct *wait)
>  {
>         struct vb2_queue *src_q, *dst_q;
> -       struct vb2_buffer *src_vb = NULL, *dst_vb = NULL;
>         __poll_t rc = 0;
>         unsigned long flags;
>
> @@ -862,32 +861,17 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
>              list_empty(&dst_q->queued_list)))
>                 return EPOLLERR;
>
> -       spin_lock_irqsave(&dst_q->done_lock, flags);
> -       if (list_empty(&dst_q->done_list)) {
> -               /*
> -                * If the last buffer was dequeued from the capture queue,
> -                * return immediately. DQBUF will return -EPIPE.
> -                */
> -               if (dst_q->last_buffer_dequeued)
> -                       rc |= EPOLLIN | EPOLLRDNORM;
> -       }
> -       spin_unlock_irqrestore(&dst_q->done_lock, flags);
> -
>         spin_lock_irqsave(&src_q->done_lock, flags);
>         if (!list_empty(&src_q->done_list))
> -               src_vb = list_first_entry(&src_q->done_list, struct vb2_buffer,
> -                                               done_entry);
> -       if (src_vb && (src_vb->state == VB2_BUF_STATE_DONE
> -                       || src_vb->state == VB2_BUF_STATE_ERROR))
>                 rc |= EPOLLOUT | EPOLLWRNORM;
>         spin_unlock_irqrestore(&src_q->done_lock, flags);
>
>         spin_lock_irqsave(&dst_q->done_lock, flags);
> -       if (!list_empty(&dst_q->done_list))
> -               dst_vb = list_first_entry(&dst_q->done_list, struct vb2_buffer,
> -                                               done_entry);
> -       if (dst_vb && (dst_vb->state == VB2_BUF_STATE_DONE
> -                       || dst_vb->state == VB2_BUF_STATE_ERROR))
> +       /*
> +        * If the last buffer was dequeued from the capture queue, signal
> +        * userspace. DQBUF(CAPTURE) will return -EPIPE.
> +        */
> +       if (!list_empty(&dst_q->done_list) || dst_q->last_buffer_dequeued)
>                 rc |= EPOLLIN | EPOLLRDNORM;
>         spin_unlock_irqrestore(&dst_q->done_lock, flags);
>
> --
> 2.28.0
>
