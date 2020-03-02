Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35EA214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqYRGb9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCBRpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:45:08 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33129 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCBRpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:45:08 -0500
Received: by mail-il1-f196.google.com with SMTP id r4so283859iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sboKaEzAb8dDo8ic4Txr+gqE6z2BPnl5/jyRIrg2YGs=;
        b=vqYRGb9r7GpichkDcc8O4hlFY3pp72EXr8zLy4oOuHUN9wWnR8g5FD1EvQfGOVvqkY
         sRuF1ADlrISNDfp5JyFqoNVDLijFdF7aFGLcAaWcfNq4oe0r6gU9hLFYpuT1ickVklCn
         CLdpu7ULXNDWB9LlrtmXXRyNXJV7rolmIRoH8Ul0nXYVzZ3M0hpPq6Bsr3VdXLXBHVUP
         FENYOFAJwEpnilVvYgKSOV/FOVjGchZD2DwFoJ+v23lmQOhqLzX2VjFcvj9QRFgQpLX5
         BwfvicC0Ih7eg5Lp2vOptMvGRAEWXlh57bcb/4UJhBVhkn0Y2oOvC8ny6tDMLTYib2os
         /Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sboKaEzAb8dDo8ic4Txr+gqE6z2BPnl5/jyRIrg2YGs=;
        b=Ubs2EqyLL/ln5G8T8Mbba46/Y44b1sVf50RZVwLfXnYvkAvAFwMj5frKxJip9G9Zz/
         i3ECFwVKFdXB5SFblm/US28a6lLm0pMCCDdebZseTSzFhb6zZDq16O3HSwt1UN8s/mIH
         DGvEFPED7wBv71xLq+kP/HO15eEE/nSy375gNTupOzjH4ibDdmTO3JUhIuxzTB+tWQnG
         xwJsQsiiKOTklxwJX+8lvD+0+MVw8SU0794OcWqz1XY5j7t8Oq5fAlZG5B1FWkFEww2u
         w3YLIKG+x2liguC3phSEVOX9XWdMUt+fAoT44GGMFdq8kqhCQm4hbJiB3zBVnYJ1bpl7
         q74A==
X-Gm-Message-State: ANhLgQ15fCd2Y8CajB4ND7shYLtqmgsa/mnxFAZpw20XGCvS5IwiR/Xv
        Cu8JTLjUUlr/LRKEYnkI6cnsMBjTkyJ/LR/eqylGOvaQ
X-Google-Smtp-Source: ADFU+vu0psz60mr8tK59SdVhE45L5RTpGteOpOydAzRFmNEUtHC65Ad33Ww3KbZbMBtK+aWWHY777/OBZyi95ecGDI8=
X-Received: by 2002:a05:6e02:eb4:: with SMTP id u20mr708304ilj.57.1583171107274;
 Mon, 02 Mar 2020 09:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20200228110804.25822-1-nikita.shubin@maquefel.me>
In-Reply-To: <20200228110804.25822-1-nikita.shubin@maquefel.me>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 2 Mar 2020 10:44:56 -0700
Message-ID: <CANLsYkyDsJaxO_37qTjEP+aeQju8W2+jhHFRF7+oifBMqJqyng@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: error on kick missing
To:     nikita.shubin@maquefel.me
Cc:     Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Fri, 28 Feb 2020 at 04:07, <nikita.shubin@maquefel.me> wrote:
>
> From: Nikita Shubin <NShubin@topcon.com>
>
> .kick method not set in rproc_ops will result in:
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference
>
> in rproc_virtio_notify, after firmware loading.

There wasn't any kernel stack trace?  What platform was this observed
on? I'm afraid we won't be able to move forward with this patch
without one, or more information on what is happening.

>
> refuse to register an rproc-induced virtio device if no kick method was
> defined for rproc.
>
> Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 8c07cb2ca8ba..31a62a0b470e 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -334,6 +334,13 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>         struct rproc_mem_entry *mem;
>         int ret;
>
> +       if (rproc->ops->kick == NULL) {
> +               ret = -EINVAL;
> +               dev_err(dev, ".kick method not defined for %s",
> +                               rproc->name);
> +               goto out;
> +       }

I think it would be better to use WARN_ONCE() in rproc_virtio_notify()
than prevent a virtio device from being added.  But again I will need
more information on this case to know for sure.

Thanks,
Mathieu

> +
>         /* Try to find dedicated vdev buffer carveout */
>         mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
>         if (mem) {
> --
> 2.24.1
>
