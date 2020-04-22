Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE13206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBRXr4j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgDVOlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgDVOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:41:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE8C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:40:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so1186913pgi.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QD4gvoO62U8g5ke55m5+fi2BWTvN1Nc+EFebE6YyQOw=;
        b=kBRXr4j4qq3NXWS/pXf/1+3fcHvwMlFDdQUdNXX8Wu7dcmXSWvGvQIGl1GSeXcszn9
         TWs5J+JwWja8Evmpng7eCALs5Y8vur5RbDbdVdchoUgUl+MLfPl+POJlopFg6bfp7YwI
         T/2dJTikefM8Is4MK8e4SbGDLkDqdDMEp+Y0xDXJjL3f5/jV2m5uzvEwGs0g5feG3TPp
         718JbvYPONmKPMcWHAhJtbZ4L5j7qLNnoLdJCu2yrR8SEb7b3wZqIDFRSojAydH0D4b/
         KPeCh+QvkEvXxu5Cj+p5EBZhEZKtuvbQGNYw6SISkzcBo7M86NBCM2/gLAVY+uwQqmDI
         lT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QD4gvoO62U8g5ke55m5+fi2BWTvN1Nc+EFebE6YyQOw=;
        b=aGkYhemG665mAm7kET/tQcY49N9XyPU0KIY56GX5M5Y4tJUcPMTmUkaqoHf19MEajp
         FuA+5cqNGKqiA9jNBJjxpBO4mLm7r0Uy7k7TKZErZ4xz4nmSFOnTOuqmVNcrrHxgsVdK
         TKxWJAlVKymDgQcPjgj38/VgKMMDZM6fM9fiXj/ihuHfm2HfKJ50c5FKXoF1cVnpdGOa
         BrBMWYEyHtf0NvrkdD7R2QRygE+uzjGvUocj6MpPTiCzu6UUIyR0mbewq8j1nQ7bUxgi
         E1lybu2BsthleeIAc+LrnCTJXBX091U3rcWO3zAoXSZdhfwdv9hktSdzlNfFoBZ6a8XX
         ENlw==
X-Gm-Message-State: AGi0PuYmU2GL8JUOtb0Q56niqB6VunyYj3DE4bhv5J82b1g98ihIWMCP
        auH0J7NTcPG0gfQNAGd5BVrX8is0a15cQiCT27c=
X-Google-Smtp-Source: APiQypLalIxaytZo4bcWW/4fbstSP2AlbGVR5eg6nB09MxoKZVT8wAEJIrtspvA3WhXKsbt/27U45IisFwsyi4PqiHE=
X-Received: by 2002:a63:5511:: with SMTP id j17mr25966905pgb.4.1587566458280;
 Wed, 22 Apr 2020 07:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200421164543.16605-1-zhengdejin5@gmail.com> <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
 <20200422135215.GA25950@nuc8i5>
In-Reply-To: <20200422135215.GA25950@nuc8i5>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 17:40:51 +0300
Message-ID: <CAHp75Vf2j-QraBxKofgyhtAxpHXnik3DP9kefPhA_d3BuSjfvw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     kraxel@redhat.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 4:52 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> On Tue, Apr 21, 2020 at 08:24:24PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 21, 2020 at 7:45 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> > >
> > > It forgot to call bochs_hw_fini() to release related resources when
> > > bochs_pci_probe() fail. eg: io virtual address get by ioremap().
> >
> > Good start, although I think the best is to switch this driver to use
> > pcim_*() functions and drop tons of legacy code.
> >
> Andy, thanks for your encouragement, I think we might be able to fix this
> issue first, after that, drop tons of legacy code by pcim_*() functions.
> Do you think it is ok?

It's really up to maintainer. I'm not the one here.

> > > Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
> > > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > > ---
> > >  drivers/gpu/drm/bochs/bochs_drv.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> > > index addb0568c1af..210a60135c8a 100644
> > > --- a/drivers/gpu/drm/bochs/bochs_drv.c
> > > +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> > > @@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
> > >         return ret;
> > >
> > >  err_unload:
> > > +       bochs_hw_fini(dev);
> > >         bochs_unload(dev);
> > >  err_free_dev:
> > >         drm_dev_put(dev);
> > > --
> > > 2.25.0
> > >
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
