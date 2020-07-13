Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6634C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D30C20C56
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="InUYU/sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGMWTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGMWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:17:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9540CC08C5DF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:34 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j186so7473950vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyzzzEfQ3Uc/t+bUav/3x8lC62pgjGuDPMIXbn4bZbw=;
        b=InUYU/sUXni6t/s3Y0tEzsg6QRkbF8CdHi29QeizGklCp2wPj8fVd34LQ23a0P4iuU
         nDGgnyMb2+gOlkblxRAG3WGfZEczi+XzLqzr3/WSm+8/OTockDZ0K70oggBRR7nwiPQZ
         WlrLXTDfpeFBc2CMm04EkptdN+M89zgyRIiPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyzzzEfQ3Uc/t+bUav/3x8lC62pgjGuDPMIXbn4bZbw=;
        b=LNCD7sDVg6RrmXtuQ6rWAbzzyIRdLpEK+4h8eZPYqYyLZxPmDjNYxH+Vd0TiQGxTMb
         bDM1sQhuFMIS2z5sSbi+9r7E722lpVwm2dyENXAq3LhWm1cF07Y4wxdTTdTxcIZW9M2q
         M3C0aaeOsJldauksEqw8+2y8+nTUe+zg1IyuHzR9+c7wLKz13P6+KLct8d2roBAYzlO+
         /s/2GusBoX6ZljQ3E1T4BQes2Q+paJ98HmZB1MSMPpIjYsTVmZkaIWtLT/XJwDfTqI/j
         Ltjqx5ikt5XLJThEYJBIsZBdmsKTbCAQP8zfUQINWAJWv7Lu7/cEorQVz6Pc1IYxt0W+
         RUog==
X-Gm-Message-State: AOAM531Ws/9Su6yoZTI7B6eFxDyyVHKd9Bg9yCxpFHJ+qDxk4VlwdogU
        vYJHcYrO3szIUFt0Ry2TTtm0RkbnsnM=
X-Google-Smtp-Source: ABdhPJxqoDxujbBZWUTlb6TPkaiSogJD4M/0HwYUgFH4D0pO2Uazueq60ioPs8Kf4rV1Jmvj18CvNQ==
X-Received: by 2002:a67:ce08:: with SMTP id s8mr1241749vsl.103.1594678653618;
        Mon, 13 Jul 2020 15:17:33 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id t67sm2208040vkd.38.2020.07.13.15.17.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 15:17:32 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id j186so7473903vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:31 -0700 (PDT)
X-Received: by 2002:a67:ec0f:: with SMTP id d15mr1113618vso.121.1594678651291;
 Mon, 13 Jul 2020 15:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org> <1592818308-23001-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1592818308-23001-4-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 15:17:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xfi+5ms_pRyGjOG2EhkkGf9jCzXvEt=cHkBQMn1wkU7g@mail.gmail.com>
Message-ID: <CAD=FV=Xfi+5ms_pRyGjOG2EhkkGf9jCzXvEt=cHkBQMn1wkU7g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] pinctrl: qcom: Use return value from irq_set_wake call
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 2:32 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> msmgpio irqchip is not using return value of irq_set_wake call.
> Start using it.
>
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Seems right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
