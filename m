Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63904C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5DD206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WD0Vdo9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD1EnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgD1EnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:43:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B6C03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:43:19 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u12so19959035uau.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MzIVWZpSVCHDb5pf6WQNcJ/ckZ7Y5e/ESVb+fFzIZA=;
        b=WD0Vdo9P4/N4GSEpKAhopNTQVyTrPiPKK3hWvrtsiHMzebOMrruO2aJX9wZe95BGHj
         XGk8c62wFBqDPwNbo61yYZGaWDExozBcGqaTvzvhgue/6PH25ZdF3jIcE9D0iv7XULGu
         hc0qeug7S/R/21XHC27bLSFzxUVEnjHArDV38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MzIVWZpSVCHDb5pf6WQNcJ/ckZ7Y5e/ESVb+fFzIZA=;
        b=BJ+4AK8bzJVfq86tKxgF5smXrAjTVHcY0286ZuiuofkyVbB1H5nWM5E3UVi0Ob0a9l
         e8otCV+NVhbFzgj0EDH4RwFL67jlqeXIl+k0j5ypCpBQuQU11rPvgITRxH/AlFt9qUG/
         90lNg+5tU2qjqh9q64+FkSnw3fSiyCrkus1tG0NY8QtEXZxjKxKGprUsFeV053WggutC
         C6vQIlkCXWgHcdVfcBbJSmG+HXV0EX199bY4KWbpfGoz3QIK6iNnSZvdkhdjwgo/4dNv
         iLq5gz0wH3GHiCH3gNPUeP2tJMqECSqdcB9NPRDfhe7NphPaWnFdHjh9Wyfuazk/yh2I
         XnTQ==
X-Gm-Message-State: AGi0PuYwSZVZoNFcR/z6xxb1nqRSuQYiy05+DFNHgoLnWxrP9SAsWmIJ
        mDCugfJeJD2AbRXnVVjzXCHo+QH65z8=
X-Google-Smtp-Source: APiQypLVOF3S7GFVwHfOFJIYQDTxC07WZfVHzHXEHlftUcrNw+TpOo0oVQjbncwfK1QDWnlnX8MKNw==
X-Received: by 2002:a67:79cb:: with SMTP id u194mr19823639vsc.233.1588048998893;
        Mon, 27 Apr 2020 21:43:18 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id o9sm2652251vko.18.2020.04.27.21.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:43:17 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id m9so6360559uaq.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:43:17 -0700 (PDT)
X-Received: by 2002:a67:f9d0:: with SMTP id c16mr19912596vsq.53.1588048997072;
 Mon, 27 Apr 2020 21:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044036.234578-1-evanbenn@chromium.org>
 <20200423143945.v5.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid> <CAODwPW9-c8EcZh_zB6SwohzvHtCQasaNLQM0fj2bj5O5KuVPfg@mail.gmail.com>
In-Reply-To: <CAODwPW9-c8EcZh_zB6SwohzvHtCQasaNLQM0fj2bj5O5KuVPfg@mail.gmail.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Tue, 28 Apr 2020 14:42:50 +1000
X-Gmail-Original-Message-ID: <CAKz_xw0nQL2t1a-ofosLVb72JwSAGXCea5wOuddstOMrULNygg@mail.gmail.com>
Message-ID: <CAKz_xw0nQL2t1a-ofosLVb72JwSAGXCea5wOuddstOMrULNygg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Julius Werner <jwerner@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 8:17 AM Julius Werner <jwerner@chromium.org> wrote:
>
> > +       err = of_property_read_u32(pdev->dev.of_node, "arm,smc-id",
> > +                                  &smc_func_id);
> > +       if (err < 0)
> > +               return err;
> > +       watchdog_set_drvdata(wdd, (void *)(uintptr_t)smc_func_id);
>
> Your device tree binding says there's a default and this is optional.
> I think you need to change the code so that that's actually true.

I think I have misunderstood the device tree json-schema spec.
My intention was for the device tree to fill in a default value in the dtb for
arm,smc-id if it was omitted in the dts. But now I see that does not seem to
happen, I cannot really find any documentation of `default`, so I will just put
a documentation string in instead and force the default in the driver.
