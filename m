Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C385E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTx98g6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH1XGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgH1XG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 19:06:29 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB7C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 16:06:29 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o184so488120vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTKdXiRCKS6tUmMOhEk7xSRiz3K0QjMIqXKfgOUTwVI=;
        b=DTx98g6eHjR9eWZ8L8pNZvzNzyyoyGJGoCSVzxnwe383QCEf6CiPXBYd7KGVxtcyWM
         imHYSMTzYzDKbP9GdybbwuCc5YWmZJB/nMyEkOnXnO1PMF4GDNLmCJ3JJQnnthHL+c6q
         B4VizqndaVWBqtihAlgf8low/9/yvPUV9bIiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTKdXiRCKS6tUmMOhEk7xSRiz3K0QjMIqXKfgOUTwVI=;
        b=WZxcgFurIlWuQGC6Kq16hw+Xrxc7a/I3lYBy3Mwv9aiwjINcOCotZ5znQkRutq6fCJ
         yUBaxJFvtwtMRhOTrcZoHtVnM6aK4VwUprvbX/bg+/7Qh8PGDU9qHNL8WPmjs88mOWVX
         +1yeQcv09CY21QwUlpVlN6oq8DaTq55hs5SKhL3/S797zMLkS8LLl8RFOH0L2Pal/Ye0
         ypWMH60wbuzR4C04DC9F2Vq5UBgUMuEt5VT8+tyrkqCGI71g0AEodXrMWizXml97W+N+
         W4tpuEdKbNMzVK6zGWhely5cKrKEur/iN2+gI8+dQHugMcqowD3qbTqHW0j5hnjydiRh
         L21Q==
X-Gm-Message-State: AOAM532DnRdYX2xR1k+k2Z7Bfxix6fS4YYdVe1URJiGuMIhUncJS8rSp
        rNuxL++XxKj7dRTpb4H6sMFmNGb/ZCaFpA==
X-Google-Smtp-Source: ABdhPJwzlFI+fdzLLMpNhCTgGH6FBC5ESlKJ7WwlilpvKOBFztJy5W+cEIsXl699BywKT5jCurguEw==
X-Received: by 2002:a67:fd5a:: with SMTP id g26mr765733vsr.57.1598655987667;
        Fri, 28 Aug 2020 16:06:27 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id y17sm118982vky.49.2020.08.28.16.06.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 16:06:26 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id m12so134617vko.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 16:06:26 -0700 (PDT)
X-Received: by 2002:a1f:d6c4:: with SMTP id n187mr874772vkg.65.1598655985575;
 Fri, 28 Aug 2020 16:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110454.1811352-1-cychiang@chromium.org> <20200826110454.1811352-3-cychiang@chromium.org>
In-Reply-To: <20200826110454.1811352-3-cychiang@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Aug 2020 16:06:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaCt6V+VXfk8T+2mS4d5sKQzMC12AcH9a=MNkgguvmjQ@mail.gmail.com>
Message-ID: <CAD=FV=XaCt6V+VXfk8T+2mS4d5sKQzMC12AcH9a=MNkgguvmjQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 26, 2020 at 4:05 AM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> +config SND_SOC_SC7180
> +       tristate "SoC Machine driver for SC7180 boards"
> +       depends on SND_SOC_QCOM
> +       select SND_SOC_QCOM_COMMON
> +       select SND_SOC_LPASS_SC7180
> +       select SND_SOC_MAX98357A
> +       select SND_SOC_RT5682

I haven't done any significant testing / review of your patch (I'm
mostly sound-clueless), but I believe that the above needs to be
"select SND_SOC_RT5682_I2C" atop the current top of the sound tree.
When I fix that I can confirm that I see the rt5682 probe on
sc7180-trogdor with Rob Clark's dts patch.

-Doug
