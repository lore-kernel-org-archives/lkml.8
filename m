Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669DFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CD42067D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+9s19Xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEQI5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgEQI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 04:57:06 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E6C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 01:57:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so5231502lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvpXMEOf2oxqeoDFBUGaoQrCDCUASjw+5ZCaj4IPFUA=;
        b=X+9s19XdQP80lXP5Sjh8s4RID+xsRiuS3c/tvmZ85keK4N2oLRMjVP8P1MnQ9a0nm1
         /4RbctmQYyu+5OyQMIgu51iHUqxg9gEn7YQdE/DrHy8ItLvYmPltewzKo5uKm2Y9Qb60
         TkgnKUtTRjOxUt8VtfEHNSW0cSRUQCUaOsN3vHIYXS+CaLKs/NfWAPwvSZZfv5+U0aO7
         w/3vpt2FbEd0MDw0rUvh4vwRM6sbbDGORBcP56feuKtb/p6hjJ13tEvHujUFeMOouxmY
         XDXl6cagxsPUvxsKi/xwEo6v8xpX52SeRcDEusOweb55npLKtNNAVQ2iiJJkGJlUxPsQ
         vA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvpXMEOf2oxqeoDFBUGaoQrCDCUASjw+5ZCaj4IPFUA=;
        b=r0ga+oEvgPEhcBVozBBA1JouvltzrVczWYSz3RQqAp7P3IIJiJ3SPGQhaJYWBv+5J9
         Ls5kjcQWjccolBNMI1/nQDWUKiL4bMelCakz/AJXLkltlK+E5UXnqEVWKtnEnAjvUKAi
         HKZ4HVPD6MsjN/C4d48RDUMvsePSQawie1pVY086wxi0s19ndiaB1BeUkRW1/Jz5nPCO
         Gc51mVxVVXk1rfSbV8+X/gI2lLhTk0SiiJrH3PxUs7LEaC8s0KGhY4H4iBocNH+tCmi+
         gWly+g8hvSnXXAhn+k9KRq5UZNO6yWzEHeHG4hACC1Y8luTU8+oDue3NZu1HRd6qPgne
         U6fw==
X-Gm-Message-State: AOAM532xshv9Y91g7n+02gNbcOfO6NlBtElkhpsH71lYHM5qDYrruq68
        G63KNF562O+euF+5U90qc3mnHLr7Cc8cPvnIfA5PzA==
X-Google-Smtp-Source: ABdhPJxElErHEdfNwgeT4Hd1sAY7LshF4fkRI3MHB7XOYA8qVQqdBkInMaRntb7RfRuCdPpIQ16q/Mkh/SFYVicmtGU=
X-Received: by 2002:a19:b06:: with SMTP id 6mr4389392lfl.104.1589705824212;
 Sun, 17 May 2020 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589623456.git.baolin.wang7@gmail.com> <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
 <CA+H2tpEJo3a7N5Sq0BzkGrGSrtBY61egZo9Xfc=nOMp2igKGFA@mail.gmail.com>
In-Reply-To: <CA+H2tpEJo3a7N5Sq0BzkGrGSrtBY61egZo9Xfc=nOMp2igKGFA@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 17 May 2020 16:56:53 +0800
Message-ID: <CADBw62rt6ABu5A9ex2PkND-XYXNLV7b=HhG0RX-qxUUBphvSAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mfd: syscon: Support physical regmap bus
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 8:08 AM Orson Zhai <orsonzhai@gmail.com> wrote:
>
> On Sat, May 16, 2020 at 6:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Some platforms such as Spreadtrum platform, define a special method to
> > update bits of the registers instead of reading and writing, which means
> > we should use a physical regmap bus to define the reg_update_bits()
> > operation instead of the MMIO regmap bus.
> >
> > Thus add a a __weak function  for the syscon driver to allow to register
>
> Typo -- duplicated "a".

Ah, right, will fix.

>
> It seems to be a better idea than before.

Let's see Arnd and Lee's opinion.

>
> -Orson
>
> > a physical regmap bus to support this new requirement.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/mfd/syscon.c       |  9 ++++++++-
> >  include/linux/mfd/syscon.h | 11 +++++++++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index 3a97816d0cba..dc92f3177ceb 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -40,6 +40,13 @@ static const struct regmap_config syscon_regmap_config = {
> >         .reg_stride = 4,
> >  };
> >
> > +struct regmap * __weak syscon_regmap_init(struct device_node *np,
> > +                                         void __iomem *base,
> > +                                         struct regmap_config *syscon_config)
> > +{
> > +       return regmap_init_mmio(NULL, base, syscon_config);
> > +}
> > +
> >  static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> >  {
> >         struct clk *clk;
> > @@ -106,7 +113,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> >         syscon_config.val_bits = reg_io_width * 8;
> >         syscon_config.max_register = resource_size(&res) - reg_io_width;
> >
> > -       regmap = regmap_init_mmio(NULL, base, &syscon_config);
> > +       regmap = syscon_regmap_init(np, base, &syscon_config);
> >         if (IS_ERR(regmap)) {
> >                 pr_err("regmap init failed\n");
> >                 ret = PTR_ERR(regmap);
> > diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> > index 7f20e9b502a5..85088e44fe7c 100644
> > --- a/include/linux/mfd/syscon.h
> > +++ b/include/linux/mfd/syscon.h
> > @@ -13,6 +13,7 @@
> >
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/regmap.h>
> >
> >  struct device_node;
> >
> > @@ -28,6 +29,9 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
> >                                         const char *property,
> >                                         int arg_count,
> >                                         unsigned int *out_args);
> > +extern struct regmap *syscon_regmap_init(struct device_node *np,
> > +                                        void __iomem *base,
> > +                                        struct regmap_config *syscon_config);
> >  #else
> >  static inline struct regmap *device_node_to_regmap(struct device_node *np)
> >  {
> > @@ -59,6 +63,13 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
> >  {
> >         return ERR_PTR(-ENOTSUPP);
> >  }
> > +
> > +static inline struct regmap *syscon_regmap_init(struct device_node *np,
> > +                                               void __iomem *base,
> > +                                               struct regmap_config *syscon_config)
> > +{
> > +       return ERR_PTR(-ENOTSUPP);
> > +}
> >  #endif
> >
> >  #endif /* __LINUX_MFD_SYSCON_H__ */
> > --
> > 2.17.1
> >



-- 
Baolin Wang
