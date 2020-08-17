Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939C3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFBE20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAa2zF06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHQFWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHQFWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:22:05 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04654C061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:22:05 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c6so13430489ilo.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRhcb2O8AaJEz9eMxliwlOdPhMhMY6WLI2NsdKxl3ko=;
        b=oAa2zF06p04uKthFZQF2bBEkOZ+6UqD8Fz9FQN9KPkJgoTG5nWrnJWfk/NK/fBShsu
         F5mo2GaGqLxt7WlI7Xtqf8VwF/GleJYpbAm/eOn5shh4+eE8jyBihDgisQolBAN5kavD
         OA0Vb5MCyYsfn7TnTanxxPfXeJA6sufkhUjL+bEqXETQ80mITRpTtt+Thb3MapnHYIGQ
         /JCP2jEscmB4IrK8LKAdKT/mcW9LJq6YEVHUYWfvzl8XatvdAWS/dD5RLA3v8V9dqMDE
         1GQNTIts546qkhRyR3m73qd4cf5XC4s1g8FKQhxpag8ukTlSRwU+PXbbWOkTBKG9DdNG
         V/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRhcb2O8AaJEz9eMxliwlOdPhMhMY6WLI2NsdKxl3ko=;
        b=Gtrw6DlBSApOjGF1Pl+hs8gyaH4zCC8o4gckNnKJFWX0DATPUyG9TKqxkoRj5mpR9C
         0lJpA9ldQJSOt+mp2o3T244jpwyPOozCdWRsrsXJ/0f+r8VpzWFWCDtx0FKjXmXoCDrL
         CifM1lfoUMHdSDW7DOFO4Uma1JVCE01GkzoxuCJaNpsbCwHx4eB20+yfear1KSWZ026q
         rs3BpZOHYzExFG5iaFuH5eDwEUi5k6+WoZT+wifALDQCNpmBZm7HL/Sru3XEIpcBMMyE
         fQzmmHyxrkWYTFBa+F6i5w3bPEckiPeOYi+Z9edLzfMnx9tSHVcFuIiEKC9D1VUsC5AM
         7mRw==
X-Gm-Message-State: AOAM5320v/FUi9Pneq+nXj6+yucjkhAPHQGrIzYMQ1J9eP1q7SIKWBN3
        W7BpQfDNvc+AN4SJV1hEfXDkeDT6PDHaV835RFFVYQ==
X-Google-Smtp-Source: ABdhPJy14QoC914TSoUO33Pg5xyMVBeF3y5yQDrERQdKF3LGceyD4VnVKTeyYFkawCs5uqbWieDtWQWVooUUStxfbeU=
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr10091979ilc.213.1597641724059;
 Sun, 16 Aug 2020 22:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <1597511980-16281-1-git-send-email-jiaxin.yu@mediatek.com> <1597511980-16281-2-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1597511980-16281-2-git-send-email-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 17 Aug 2020 13:21:53 +0800
Message-ID: <CA+Px+wX_L3s0-m8YOwAXa1szN3v8dqaY5OYfAVJb4HLTrAt5nQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: mediatek: mt6359: add codec driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        eason.yen@mediatek.com, shane.chien@mediatek.com,
        bicycle.tasi@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 1:20 AM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> +static int mt6359_platform_driver_probe(struct platform_device *pdev)
[snip]
> +
> +       return devm_snd_soc_register_component(&pdev->dev,
> +                                              &mt6359_soc_component_driver,
> +                                              mt6359_dai_driver,
> +                                              ARRAY_SIZE(mt6359_dai_driver));
> +}
> +
> +static int mt6359_platform_driver_remove(struct platform_device *pdev)
> +{
> +       struct mt6359_priv *priv = dev_get_drvdata(&pdev->dev);
> +       int ret;
> +
> +       dev_dbg(&pdev->dev, "%s(), dev name %s\n",
> +               __func__, dev_name(&pdev->dev));
> +
> +       ret = regulator_disable(priv->avdd_reg);
> +       if (ret) {
> +               dev_err(&pdev->dev, "%s(), failed to disable regulator!\n",
> +                       __func__);
> +               return ret;
> +       }
> +
> +       snd_soc_unregister_component(&pdev->dev);

You don't need to unregister the component which is already delegated to devm.
