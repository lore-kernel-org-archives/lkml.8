Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8307FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3051820838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJo/AfkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgH2C2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgH2C2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 22:28:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE4FC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 19:28:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so888006ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c/6L03NdWGE6AQXXtSEjpAnXkROpYqS0yGikXRKdwCU=;
        b=OJo/AfkPdtvxvzEpAkA40aISAJTBhiZwUEQ1+aEscMcFvPUT90MfCXwtKI11gUuvvN
         uPAREkB/B1EcN3Xpr+fZ4iFFrRdjRs6jGGgShvlqD1AjJAOyXmjWlAhY52xReR6nM1nR
         IeTwCZbSAa7aJGs00o7b+KPMKrynXTwg6IwsWOQaRIxjh3gHsa2w3S4XV76t7nBRurc7
         MpJkTWsnvXlhcfi46H5ZQaqfNSIBz6GYgM23/CsBjwj9aLtkXRletxr36jfOvm29x4wq
         ZtJDUwF/IV6hRnvbjhXY46+an6cPH//W+eEKHrFirw7ncD2DtRVpzIiELcnhMBNLFerb
         qivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c/6L03NdWGE6AQXXtSEjpAnXkROpYqS0yGikXRKdwCU=;
        b=BgjYJYoL51W3EhmOU7kzGMGqO/wsfxfvp04JMp5BTHv1Ws47uw5SC2UPUVU60H/hzU
         a6V/6rppbtpGKD4ME7/bEqa6KtlxCfBKYPiSygTv8QfJOezcoF2UxeB78B6FfwDvl519
         ZlvWJo3HK/sSML2ecxGmNK2MTf4/QGnCYiHwSgvb5dNKFg6Y5YbIHyH6LcpFEYtWfWWx
         6Z1Ol0Y94SRQ9lTwn0dKuu1mwfDLkTbAhydRIhErsF+4IHmMhaPRzyN5psbTuP7Z95BH
         +GUx/udaTQtC2ZfQfGigELKZp/Tuie6rXYUDGjQ1lTlshYwXle4gRZk65cj/iVqHGKQO
         K8hA==
X-Gm-Message-State: AOAM53135wv+9WLk0CWFWoPcpfLJoQJtHsM8KaiMm7pPsdg6itDevbOm
        CdSeyqspLfbDZUn8IcMFto88IxB7xt9UPFKgfnq5qtqbi9c=
X-Google-Smtp-Source: ABdhPJydBdlj5FAjRjKL6dpnvXtDJ4TKe/O1abYtAKcw3INPwm/o43FGjAgY7MBZ/rMLHnyss2NjjMnntmtHaDp4xTM=
X-Received: by 2002:a2e:968c:: with SMTP id q12mr630765lji.51.1598668132159;
 Fri, 28 Aug 2020 19:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200821070537.30317-1-jameslouisebond@gmail.com> <20200827144600.2ec7c4ab@xps13>
In-Reply-To: <20200827144600.2ec7c4ab@xps13>
From:   James Bond <jameslouisebond@gmail.com>
Date:   Fri, 28 Aug 2020 21:28:40 -0500
Message-ID: <CAPKyc-si2e2-9RDgLBO4Ox0wX5fr+NjSM_Noih_Pay+trNzndQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: ck804xrom: fix missing pci device put in error paths
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryan Jackson <rjackson@lnxi.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,
Thanks for your feedback.
I have just rechecked this function and find that "pdev" currently is
already put
inside ck804xrom_cleanup, so my previous patch is meaningless...
The current calling order is like:

window->pdev =3D pci_dev_get(pdev);
...
    ck804xrom_cleanup(window)
             ->
                  pci_dev_put(window->pdev);
And sorry for bothering you.
Thanks,
James

On Thu, Aug 27, 2020 at 7:46 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi James,
>
> James Bond <jameslouisebond@gmail.com> wrote on Fri, 21 Aug 2020
> 02:05:36 -0500:
>
> > pci_dev_get increases the refcount of "pdev".
> > In the error paths, pci_dev_put should be called
> > to handle the "pdev" and decrease the corresponding refcount.
> >
> > Fixes: 90afffc8bd79 ("[MTD] [MAPS] Support for BIOS flash chips on the =
nvidia ck804 southbridge")
> > Signed-off-by: James Bond <jameslouisebond@gmail.com>
> > ---
> >  drivers/mtd/maps/ck804xrom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.=
c
> > index 460494212f6a..16af8b5ee653 100644
> > --- a/drivers/mtd/maps/ck804xrom.c
> > +++ b/drivers/mtd/maps/ck804xrom.c
> > @@ -195,6 +195,7 @@ static int __init ck804xrom_init_one(struct pci_dev=
 *pdev,
> >       if (!window->virt) {
> >               printk(KERN_ERR MOD_NAME ": ioremap(%08lx, %08lx) failed\=
n",
> >                       window->phys, window->size);
> > +             pci_dev_put(pdev);
> >               goto out;
> >       }
> >
> > @@ -222,6 +223,7 @@ static int __init ck804xrom_init_one(struct pci_dev=
 *pdev,
> >
> >               if (!map) {
> >                       printk(KERN_ERR MOD_NAME ": kmalloc failed");
> > +                     pci_dev_put(pdev);
> >                       goto out;
> >               }
> >               memset(map, 0, sizeof(*map));
> > @@ -295,6 +297,7 @@ static int __init ck804xrom_init_one(struct pci_dev=
 *pdev,
> >               if (mtd_device_register(map->mtd, NULL, 0)) {
> >                       map_destroy(map->mtd);
> >                       map->mtd =3D NULL;
> > +                     pci_dev_put(pdev);
> >                       goto out;
> >               }
> >
>
> I suppose in these three cases, the window->maps list will be empty and
> you will end up returning -ENODEV and the bottom of the function? If
> yes, it woudl probably be better to move these pci_dev_put() calls to
> this location.
>
> Otherwise, it might bit interesting to clean up a little bit the error
> path and perhaps have a distinct success vs. failure path.
>
>
> Thanks,
> Miqu=C3=A8l
