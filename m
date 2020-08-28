Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C49AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4514720757
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="jb1ijdCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgH1PSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgH1PSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:18:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF97C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:18:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ba12so1500305edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2HuvEUb+cEO2pHupijluoyfGx/fDLghw4ohpb9DBko=;
        b=jb1ijdCLU2VqGTwpN0GkyjHGqUuflN+HR4/BGcjzb66XSRn+Ytp+o5R+uI9jaVI4R2
         9RSEibzSDz8xdJwlnB6hpPPjORRY4PJRzwTILSIhD4w6UICFhZBHtSIIJBjVR9zoW2PM
         uZ+/mOvzkFskzNseT4NqsTQS3dg354P+vZfeRHx4PgO1Y2sC1mqGwQEeCNy7jHWt8tYn
         mx8V56Z9DirO+jQxU0NDk6XqjPP38w78n8Fpv4tHgCzZS/vOvEldVaKC677Ub2Uj9lXD
         0MGzJULi8fc6gdkSnt90+vIumP9L7xRnjouVx3J77tQhFF3F58cH3RiT+dzQ9XGSCOGk
         1j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2HuvEUb+cEO2pHupijluoyfGx/fDLghw4ohpb9DBko=;
        b=kCm+KnVEp8gCTkDRak6usaboV1x8B9kfU+8RjzGMucOMG162PFv0OmIRbl390FHKfb
         WwNMz4yjPfKAlVgoTIIAEcwT+DZqu7HfIBvyoXzvxWFnJ5lLeuI8RbZ7Th+WB5+GVvZH
         Wbe0KR/EAeEsviVubjEG6Hj5MnrEbZ/aBGqGTBSfgDTKxz9YhMocbnhsPbthAb71TJ4P
         FEHlArX3+iZeQqACjBcfHtgcGclvKSDs0SGhwrDqL8qa0iPPbJ30P/4aT7kWN2yN3KMK
         lTF7GGFZDAGFt6poJxVOMFE1DWNG4ukwd7En6yKlfRY75sGsmhIe+8asQqIMKMfxTrWG
         dkpQ==
X-Gm-Message-State: AOAM533tOXFoYdwxlGW5s+LmxD2XLmifBQ8R9q573iCJ9phHkZjFqijc
        XGUd4+t61vA7e34cZYfKOAexjBBRyX2qr/knqFALaw==
X-Google-Smtp-Source: ABdhPJwPUV40y51nfan2Zoya5MFLcYsyf0FR6v1BLFghZ9inuwW3rmGdjDhvNrFEW+FxEApYffCxtZ1fBfvNSG6+5eI=
X-Received: by 2002:a50:cd15:: with SMTP id z21mr2430176edi.362.1598627884419;
 Fri, 28 Aug 2020 08:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200827124946.328700-1-gnurou@gmail.com> <20200827124946.328700-2-gnurou@gmail.com>
In-Reply-To: <20200827124946.328700-2-gnurou@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 28 Aug 2020 12:17:53 -0300
Message-ID: <CAAEAJfAqB2WAuWd4KKdhxp2=64n=hxkESrzGeBj1KN+Otz7mmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: v4l2-mem2mem: always consider OUTPUT queue
 during poll
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
> If poll() is called on a m2m device with the EPOLLOUT event after the
> last buffer of the CAPTURE queue is dequeued, any buffer available on
> OUTPUT queue will never be signaled because v4l2_m2m_poll_for_data()
> starts by checking whether dst_q->last_buffer_dequeued is set and
> returns EPOLLIN in this case, without looking at the state of the OUTPUT
> queue.
>
> Fix this by not early returning so we keep checking the state of the
> OUTPUT queue afterwards.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index 95a8f2dc5341d..fe90c3c0e4128 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -868,10 +868,8 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
>                  * If the last buffer was dequeued from the capture queue,
>                  * return immediately. DQBUF will return -EPIPE.
>                  */
> -               if (dst_q->last_buffer_dequeued) {
> -                       spin_unlock_irqrestore(&dst_q->done_lock, flags);
> -                       return EPOLLIN | EPOLLRDNORM;
> -               }
> +               if (dst_q->last_buffer_dequeued)
> +                       rc |= EPOLLIN | EPOLLRDNORM;
>         }
>         spin_unlock_irqrestore(&dst_q->done_lock, flags);
>
> --
> 2.28.0
>
