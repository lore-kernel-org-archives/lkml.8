Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E5C20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgVLpYxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGWSrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:47:22 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D8C0619DC;
        Thu, 23 Jul 2020 11:47:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i4so7319185iov.11;
        Thu, 23 Jul 2020 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i26RyORzgcGhTDDr0Yskb0jorGpqOlxgU0nNXEtj6pQ=;
        b=qgVLpYxk5vJuma06OtQAPe9aQ9tEQZtCqrhWUEGb2poYmc917waO4ve8gZ+2gsK4w5
         OEQW7m0eoqCi7WbqBLoyw7d6ZUXXNb/FTTVudun4oFPSDbzrAb8S7yD/p9zjZ/0wLSu4
         HRFetF83/4iGRJFq9rakRw586ArBkMEzXf49fu4OHnPuHb3fvM/DSkikO/dms+AJVT2J
         43l2owtl2CHo+4Zz2D4ZHoJIq+K71+Tgfstfq9A1Q8cF7lSUuvLhxUfIdBQGEe4vA9K3
         D46P6x2Cl/7ktiNeUDqvl5oer7Zv4ZNc4S7NxAnx5ljOtWTQPrlZn459/qyKuN2zjGTU
         kf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i26RyORzgcGhTDDr0Yskb0jorGpqOlxgU0nNXEtj6pQ=;
        b=q6cdOAI8ermBUpFQX1y6a2hnyYdkP47eh/uZO88s8Xxlj5syG+wSGiw37lNLVqgsGg
         g6PogfSVzPcLvS+O6l9p5NbfYVgkJjsJsoU+zBlwqHr8sD4n+wHMu20DZO/eJtv14naX
         gmRAYa0EMI6l54GGS5MJlGu+6CnxvjDpp4fdjN6nNOMYhkQJWUB9Qg3GfI5UGM9fcbZj
         wz1yuorgcLLlwlysAngcyl7QpU+6R4rm71zzC+TxgAunDK1/CoGHY1OHqcDIi6jZ8otb
         v1epdHZzVJCLyUi01LYWilYQ3X24dO0kmOki0CnJpS2ceNEFQ/IhXsBqnrc5iquTf1kF
         ghuA==
X-Gm-Message-State: AOAM531MJIHxo5LWJw8GmHe09J7lAe0/nv75sFmxFIJ8JshWx4EWr0tK
        MWzhrYXT3Lwnz4qcrqBxyiw02SVuKQXFcb3o3zw=
X-Google-Smtp-Source: ABdhPJxduA29adOXUyM6/Q9lweE3woxGK3YJquEBfY6GPmJuab33msEmJGBpk0vqAyyH/COvSSFEgGJDUfldHaJP0sA=
X-Received: by 2002:a5d:9c0e:: with SMTP id 14mr6370304ioe.109.1595530041579;
 Thu, 23 Jul 2020 11:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
 <20200721185317.208722-3-marcin.sloniewski@gmail.com> <73077407-e008-1ae2-266d-1045a73620ba@st.com>
In-Reply-To: <73077407-e008-1ae2-266d-1045a73620ba@st.com>
From:   =?UTF-8?Q?Marcin_S=C5=82oniewski?= <marcin.sloniewski@gmail.com>
Date:   Thu, 23 Jul 2020 20:47:09 +0200
Message-ID: <CALa5TyyMxzhwkt_S=xYfYk1MRe2C8DL5Eoeiax0bdxdNm42Hfw@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH v3 3/3] ARM: dts: stm32: add initial support
 for stm32mp157-odyssey board
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> > +     pinctrl-names = "default", "opendrain", "sleep";
> > +     pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> > +     pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> > +     pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
> > +     non-removable;
> > +     no-sd;
> > +     no-sdio;
> > +     st,neg-edge;
> > +     bus-width = <4>;
> > +     vmmc-supply = <&v3v3>;
> > +     vqmmc-supply = <&v3v3>;
> > +     mmc-ddr-3_3v;
> > +     status = "okay";
> > +};
>
> Based on the pins muxed, 8 data lines are configured, but the bus width
> is set to 4. What is the reason of not setting this property to 8?

Yes, it was workaround, because sdmmc2 interface was working only
with width set to 4. It turned out there was one wrong pin used in
sdmmc2_d47_pins_a.
It will be fixed in v4.

Regards,
Marcin Sloniewski
