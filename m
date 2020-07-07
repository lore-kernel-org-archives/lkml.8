Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F43C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4615020708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFqebrYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgGGMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:53:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B62C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:53:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so42908367iox.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/YoIMP8c0HJJ+S49WYxsGpiCi+NvL2ww5EeAkEmXVI=;
        b=QFqebrYRDiE5dakUbLufOg818o7Ardt+uJugcI+HpLGySh/41S/8TV1nwhSvhjJHxB
         fTXUp6ton6DMP73OMpTlt1paFI/tftk2v57nIYzrWiXqr/kgOcTawXr0fhF5l/f7cXjt
         0EMSwLaZZMeAml961G+ZnI41KTQleHHP2Zftc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/YoIMP8c0HJJ+S49WYxsGpiCi+NvL2ww5EeAkEmXVI=;
        b=KOT2JYc2sjlOKK+WMA+4Q2VKayGqUJDo97ho1qsGOCSK83BQDr9inMY8QFr09YlNbD
         /kXuhSQG3zwPa5VQ3Oaux6lQ4X5h2NKVaVbFX6+Tir6P7wXgK4urHPzzUgigltAIlitN
         N8J5mcnwnsxLbaBTmmAWCNmJtCEw8q7icE0J4gREZAuwL5YN56JquZJn+aiYgeqjrQ94
         YAWcvNVZJco0MKNps7FkUXFTr7KOeXt1uY/Uk/PHpmNSDuycqgMouJSFJp8WhBG562TI
         ofgbs3arAkdGKJ0ZqvmOdvZhjFyXZJIXxU0elkvM7OnTuiFghrZibJKJ7lwb4xL4irFc
         zV+g==
X-Gm-Message-State: AOAM533j1wSt2v9xsORCJCLOuU3rAkfBRvuucHNGCBsmb94tkOZ/mMUE
        mDL8kJDmEa+TJGUELn/QXSvY/i6bUtw=
X-Google-Smtp-Source: ABdhPJxkwFWLpsJqICrN+mZ/NqzzrIl9QbrrzIoiD4lxIe/LsOqvPGSOqBZPMu8gRKOTXimTKMXLZQ==
X-Received: by 2002:a6b:2b12:: with SMTP id r18mr29646292ior.88.1594126395649;
        Tue, 07 Jul 2020 05:53:15 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id a24sm11604791ioe.46.2020.07.07.05.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 05:53:15 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id o5so42899901iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:53:14 -0700 (PDT)
X-Received: by 2002:a6b:5c07:: with SMTP id z7mr31742004ioh.140.1594126394129;
 Tue, 07 Jul 2020 05:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid> <20200707120812.GA22129@sirena.org.uk>
In-Reply-To: <20200707120812.GA22129@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Jul 2020 05:53:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
Message-ID: <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        ctheegal@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 7, 2020 at 5:08 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 01, 2020 at 05:45:07PM -0700, Douglas Anderson wrote:
> > Every SPI transfer could have a different clock rate.  The
> > spi-geni-qcom controller code to deal with this was never very well
> > optimized and has always had a lot of code plus some calls into the
>
> This doesn't apply against current code, please check and resend.

As mentioned in the cover letter, I posted this series against the
Qualcomm tree.  The commit that it is fixing landed there with your
Ack so I was hoping this series could land in the Qualcomm tree with
your Ack as well.  Would that be OK?

-Doug
