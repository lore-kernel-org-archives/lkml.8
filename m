Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B843C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AD0206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wI6qfAXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:48:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43591 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:48:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so1055003lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekk3epmRtb4kktaJRgEGHPMQodkaW9OqrA1qTiSwZeY=;
        b=wI6qfAXOBiHhpkwNW3AWl9JW59+ry53ODUbWHBSs4i7fkhNw3P0PhdA5TyWB587dr8
         LgR1tLxwTs9+jRsm5oZsDjExqfjreP4y7jah8Z8Po6KI8pE49iHucAm/M5ZbvN8nRgu+
         TvyONrd2aq2jRd9a6IPKNOOCCsXZOEkdgLlPZt7Fv+d5+M6d5fZV7eYwVI0jFjVx622a
         jdFOdXuZ55VJYqVy+Mo7EKcZJ3CMUPer5jF6PSVPgB/Di24j3uEPjB/BmYAU6TAFERYr
         dhsKijW9l5VYMuvWjPlffLMAy+k9U/8mF5z4ErErEqACnF5OvBtcrV4RaA1Q6IrXVyz5
         e6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekk3epmRtb4kktaJRgEGHPMQodkaW9OqrA1qTiSwZeY=;
        b=KHyXFdNSTzOoz6WIemohYZNL6j1oftyniOTRzdHC6+NNAAMWEWlltOUzwbL1UJ2uWh
         oNlZ34IPLb0vsSd79Ni6Qou9i9JH3j84/a4sIqwePAEKRHjCHUvJBmV81bCfib0lrNos
         NYKmAtT4qiYnrbKXAbKpEkbaMphSeaBumqBc2LVLDUZdn2oVpywChFdR/LO+skzNlW8o
         QnAQIRdQX9XuUdqa6/yJfvJzpi3AkUEIVWIDLchHTtu7ZkW4IeCpgaVP/4fmKOJnxxA2
         K2TOJebXSpAD+Bzm/g12ckVMmwthDc/SdDbHqxmqaVR3jGsk+38/TcZ/ltAyIbbwAaSe
         38xg==
X-Gm-Message-State: ANhLgQ1crnU98o9B8GA7gDMrU4w7+zTe5IGgDwiPfRBOwkZdVYUd1wFx
        svdH778ai8a6twri2gYNqkDdi5gaB5KnTPdSyCr+qQ==
X-Google-Smtp-Source: ADFU+vtFPMg01qUYtJbz3C8ePPnFM/QofX+hIXY+chkqxrTFdf5G/lueioxP/zyP0OQICL5ie06KBFsCheH763z0i6s=
X-Received: by 2002:a19:6f44:: with SMTP id n4mr1575590lfk.59.1585126119507;
 Wed, 25 Mar 2020 01:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org>
 <1584965910-19068-2-git-send-email-sumit.garg@linaro.org> <CAHUa44H_r=ttJphjOJRyAtSkzA8j3ZE7jG5a7G3FKCHqr8Tvjw@mail.gmail.com>
In-Reply-To: <CAHUa44H_r=ttJphjOJRyAtSkzA8j3ZE7jG5a7G3FKCHqr8Tvjw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 25 Mar 2020 14:18:27 +0530
Message-ID: <CAFA6WYM_nxkW69Ln2Dd0KconCRN6GfFdmE0ai4rS4MZUN7OQyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tee: enable support to register kernel memory
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, 25 Mar 2020 at 14:00, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Mon, Mar 23, 2020 at 1:19 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Enable support to register kernel memory reference with TEE. This change
> > will allow TEE bus drivers to register memory references.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c   | 26 ++++++++++++++++++++++++--
> >  include/linux/tee_drv.h |  1 +
> >  2 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 937ac5a..b88274c 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> > +#include <linux/uio.h>
> >  #include "tee_private.h"
> >
> >  static void tee_shm_release(struct tee_shm *shm)
> > @@ -218,13 +219,14 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >  {
> >         struct tee_device *teedev = ctx->teedev;
> >         const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
> > +       const u32 req_ker_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
>
> I'd prefer naming these two "req_user_flags" and "req_kernel_flags".
>

Okay, will update these in the next version.

-Sumit

> Thanks,
> Jens
>
> >         struct tee_shm *shm;
> >         void *ret;
> >         int rc;
> >         int num_pages;
> >         unsigned long start;
> >
> > -       if (flags != req_flags)
> > +       if (flags != req_flags && flags != req_ker_flags)
> >                 return ERR_PTR(-ENOTSUPP);
> >
> >         if (!tee_device_get(teedev))
> > @@ -259,7 +261,27 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >                 goto err;
> >         }
> >
> > -       rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> > +       if (flags & TEE_SHM_USER_MAPPED) {
> > +               rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> > +                                        shm->pages);
> > +       } else {
> > +               struct kvec *kiov;
> > +               int i;
> > +
> > +               kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
> > +               if (!kiov) {
> > +                       ret = ERR_PTR(-ENOMEM);
> > +                       goto err;
> > +               }
> > +
> > +               for (i = 0; i < num_pages; i++) {
> > +                       kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
> > +                       kiov[i].iov_len = PAGE_SIZE;
> > +               }
> > +
> > +               rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
> > +               kfree(kiov);
> > +       }
> >         if (rc > 0)
> >                 shm->num_pages = rc;
> >         if (rc != num_pages) {
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 7a03f68..dedf8fa 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -26,6 +26,7 @@
> >  #define TEE_SHM_REGISTER       BIT(3)  /* Memory registered in secure world */
> >  #define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
> >  #define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
> > +#define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space */
> >
> >  struct device;
> >  struct tee_device;
> > --
> > 2.7.4
> >
