Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E82074A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/lq7oiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGIOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGIOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:35:51 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C0C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:35:50 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id e10so481867vkm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWCCqzwkXNQwDDVnRS5QJrwRcFWWrsGrXxrBs0AKBWA=;
        b=j/lq7oiV1czXOm0Xrjg7hTWHdeePe+OVN/IIAHVSKiamx2KDcqCkRHYjp6E0mM/gKU
         suaKSwpDx7MTtFVPDMEYpPQVr4wnjIkYW0k8taTSLmplQVkI+4EnVMTc4Rr1n3YsoZSQ
         JeyQkzbK1Gdlt9tb5cmaMJzwg0Uf5gXVTMrZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWCCqzwkXNQwDDVnRS5QJrwRcFWWrsGrXxrBs0AKBWA=;
        b=UwI5RS8+Z/i/5s3R6vMiIR0uXNi5Zp2RdcjmFfXe3HT2y/hsbXoQoI2nxnZc7CgvNP
         DUgFuGh/9eCymDWiYCcjb09ts6HAwYCrCVHG/u/p09MNEemj7r4MfBZw7aRhLt4FgUO3
         w1WQd3kjG/BBdaT86pK7FadEhOusnICeUOzY2Y2EvaXNJlcI1jWf11gOTcWTc9PGhtG7
         nOODtunbxmNugOAbsyki59mvxTz+t3p/ZqfOgJJtvP4zS2fpoXMMdF2TmHknEOysVq/G
         nECWKriixIhKNd6lKqkXymKIb/z6wJvMmxo+fLF8YX0xPrV90gafJb2PJbq7pYsvv0c+
         sBdg==
X-Gm-Message-State: AOAM5308pfDTPqkv8NcHvtdZ+/HQVt3gJC9vtrfuGe3LPNGvxHYBxRzb
        ZaPl1KgWyJir++MLAFytByfDp42GLEE=
X-Google-Smtp-Source: ABdhPJz/dRikOQmjj/oWPQhqwjy9hRF6NyPuplbWHGiJQYr+pxeMhXmHUeKfSOxLGhx7i1i2RXsfxg==
X-Received: by 2002:a1f:a14f:: with SMTP id k76mr16762701vke.0.1594305349581;
        Thu, 09 Jul 2020 07:35:49 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id e14sm345400vsa.33.2020.07.09.07.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:35:48 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id p6so778419uaq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:35:48 -0700 (PDT)
X-Received: by 2002:ab0:186d:: with SMTP id j45mr47636182uag.104.1594305347655;
 Thu, 09 Jul 2020 07:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
 <c7956e65-d21b-8844-45d7-de06b8d3d4f0@codeaurora.org>
In-Reply-To: <c7956e65-d21b-8844-45d7-de06b8d3d4f0@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 07:35:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vpw0VeSucRBDdkT5g6N5DrJeecBuDT3fMhhzF8adVpGQ@mail.gmail.com>
Message-ID: <CAD=FV=Vpw0VeSucRBDdkT5g6N5DrJeecBuDT3fMhhzF8adVpGQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime resume
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>, ctheegal@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 12:30 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Doug,
>
> >
> > @@ -670,7 +674,13 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
> >       if (ret)
> >               return ret;
> >
> > -     return geni_se_resources_on(&mas->se);
> > +     ret = geni_se_resources_on(&mas->se);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
> > +
> > +     return 0;
> >   }
>
> Should we fail to resume if error is returned from 'opp_set_rate'?
>
> 'spi_geni_prepare_message' use to fail for any error from
> 'opp_set_rate'  before patch series "Avoid clock setting if not needed".
>
> But now it's possible that 'prepare_message' can return success even
> when opp are not at desired state(from previous resume call).

I can.  I was following the spi_geni_runtime_suspend() example and
just calling it, but I suppose it makes sense that setting the clock
to 0 failing isn't as important as setting it to something non-zero.

I'll post a v2 real quick and keep Acks / Reviews.

-Doug
