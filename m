Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4214207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uerlbCVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgFZNqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgFZNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:46:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581EC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:46:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r8so8105823oij.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u52uSN3tbB8BJ8TCDzaGgSoU5fUp65xk0NIsBfbCuUw=;
        b=uerlbCVTm6bhJPJdRojlnnrVxEtxsK8hQALAle/RapM3i54Jijx/GgCL+gWqtF3N4k
         xtoF9Ck1Y5zFKR0Z2vnTmdS2fJFdPQdqPZQFCzOhXT+aVX4jtdutgtJ3HVU//vGV1hhV
         7RU6uVK+canEjisRISkr6f0QyXTs7+YdWYczjlZXP/1I9mdm9upwfBNqlIKNuBDuaAtV
         V/IQKKwxQKQ0i3Hh3jilqGiytDNjm043a1ON5gHoMzySV4VqLzeC0/saz7/dm+WCwZYK
         3G1w5vNinpFUaW3sVnXPPCQJh9+5vc4M+qmgMLq0+6PFc4LvO9DPTn61OMSBzdaJVgkz
         P6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u52uSN3tbB8BJ8TCDzaGgSoU5fUp65xk0NIsBfbCuUw=;
        b=Y6PDjE6FYR1vE1g2nyH26AcTW/aiToSMUDGLF7WGosV3k7JCiaC3Iq4zWTdr1SXWil
         kxABwfBYMFNWx5S6nTxthMy9+/5dY1E+SFdAWTPeNYaY3XInSwSAeK/nj8Qd9LW/mAdx
         kKm3uKUgfplOvIJUcfdVCP2pHeyJz+Dj9JV6WZvzJZWSi2av4N4u0/yhpe3UMt+k4gfa
         DAU1/XK4lZ+jfIUegCoLSIF4C5MUXbigm2J+uUWcvMRPu1I0E/JUoiaOT4x6Z0mOfzAP
         3/4uIfSZGV9pIGMdwYUnWqe6/t6ZMyLXvF7aWlFTt8IbsJQYYgL/o/i9QSjAxzUm85Q7
         Wvnw==
X-Gm-Message-State: AOAM531vkxkE5KCpYNKRHupaWitkcLoZv4KZ8Y4DK1tJ9bIvW9xiVno3
        Ei6efE1pj9YLWHcWJW3fexWVdkEj6rPs59Kx741hMk8W
X-Google-Smtp-Source: ABdhPJw+adT2C8ScqVlyivOWskDWeFChgGpyoi580SKSGJZ6QdPB5OZwDMfLxuG0ID1SRCoWOBHtdfxqS6DttVK53nQ=
X-Received: by 2002:a54:4494:: with SMTP id v20mr2521613oiv.154.1593179211074;
 Fri, 26 Jun 2020 06:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-10-lee.jones@linaro.org>
 <CAFCwf12-s_xCvL9XggE7C3OJdDoK79DTYc7_A_Q4zD_aH-O4ew@mail.gmail.com>
In-Reply-To: <CAFCwf12-s_xCvL9XggE7C3OJdDoK79DTYc7_A_Q4zD_aH-O4ew@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 26 Jun 2020 16:46:23 +0300
Message-ID: <CAFCwf109CG0HiKD4+R581kSWhtoXrJU+CcLGMp1YiFF=QGVeGA@mail.gmail.com>
Subject: Re: [PATCH 09/10] misc: habanalabs: irq: Add missing struct
 identifier for 'struct hl_eqe_work'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 4:45 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 4:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > In kerneldoc format, data structures have to start with 'struct'
> > else the kerneldoc tooling/parsers/validators get confused.
> >
> > Squashes the following W=1 warning:
> >
> >  drivers/misc/habanalabs/irq.c:19: warning: cannot understand function prototype: 'struct hl_eqe_work '
> >
> > Cc: Oded Gabbay <oded.gabbay@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/habanalabs/irq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
> > index fac65fbd70e81..4e77a73857793 100644
> > --- a/drivers/misc/habanalabs/irq.c
> > +++ b/drivers/misc/habanalabs/irq.c
> > @@ -10,7 +10,8 @@
> >  #include <linux/slab.h>
> >
> >  /**
> > - * This structure is used to schedule work of EQ entry and armcp_reset event
> > + * struct hl_eqe_work - This structure is used to schedule work of EQ
> > + *                      entry and armcp_reset event
> >   *
> >   * @eq_work          - workqueue object to run when EQ entry is received
> >   * @hdev             - pointer to device structure
> > --
> > 2.25.1
> >
>
> This patch is:
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
>
> Applied to my -fixes tree.
> Oded
Ah, just saw it is part of a series, so I'm not applying it to my tree.
Oded
