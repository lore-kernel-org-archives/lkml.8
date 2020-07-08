Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA348C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3B3206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9+4sBCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGHR7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgGHR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:59:34 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B0CC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:59:34 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b77so1186442vsd.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiompu44sJmWIX0VHQ2p43N5hGspvrVdRKwV2/c7PTg=;
        b=P9+4sBCXeroD/gl9lFaX0m06xjtx10agKSYwDQ+/NbcOaSqY89NkXRbgqBPgQRcOVj
         2sE/15k5UksYrS6NLHG1qzC0R1PFVEXJFB/IoQuFPz8kRo7ozYT8rfPO1xJegBPdj20k
         dgvGQbI7VTNxqtWycqUuFvVewZCIYxRbrTVJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiompu44sJmWIX0VHQ2p43N5hGspvrVdRKwV2/c7PTg=;
        b=HWbH7T6YAxZbFw1/04ndpqq7v6L+S5OZns5d6OmKtuARfCvy55r9xCFEORuF8ZANbA
         gUSfIseAoX4U9VhoULTtXCyywjPZrbRoiy1ZJXgI6qI+Z9L7XYiIH1ygjCHaROm2L/3x
         rxJsZgefn/V9C9EbOHTKlghcNCZuI8duWjJyIrg48Zc4upiTw+v6Dctxe29Jvm5cfbeU
         mntxm1K2v/Zhy1Osd1i+7/bKBRG7qMlAxG98NNg2yQNmt0qRg1mXeDss4rxH2eO4kcVC
         b3qxUyfj6Oe7pI8qhumeT1ZcHkGdUb/hvfkeOdJmcge6lkU1gLl8FYc+33RXpoOgddDI
         XNcA==
X-Gm-Message-State: AOAM53042f2Mt9wFqAX/fhZxKD6iPc2dTJ3ATdvcHqV29U5AN5siS71o
        1RtMHXbq3OYBqcPgR2N/6W7WoguZ+UE=
X-Google-Smtp-Source: ABdhPJzp+M42wmbKggKbCvfnnfk7MPt2Eb86ZUMOPIoGnSmzxIeTuHFywSrlDFhAcxAbHKLKgFFKeQ==
X-Received: by 2002:a67:ea84:: with SMTP id f4mr44586847vso.113.1594231173372;
        Wed, 08 Jul 2020 10:59:33 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 8sm67131uat.0.2020.07.08.10.59.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 10:59:32 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id e10so3652032vkm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:59:32 -0700 (PDT)
X-Received: by 2002:a1f:3f05:: with SMTP id m5mr18475983vka.92.1594231171733;
 Wed, 08 Jul 2020 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200630081938.8131-1-sibis@codeaurora.org>
In-Reply-To: <20200630081938.8131-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jul 2020 10:59:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2JyYaNBjkFgiKEuWpvNSyt+GP_kAbAtOkNizt136EFA@mail.gmail.com>
Message-ID: <CAD=FV=V2JyYaNBjkFgiKEuWpvNSyt+GP_kAbAtOkNizt136EFA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Drop the unused non-MSA SID
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 30, 2020 at 1:20 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Having a non-MSA (Modem Self-Authentication) SID bypassed breaks modem
> sandboxing i.e if a transaction were to originate from it, the hardware
> memory protections units (XPUs) would fail to flag them (any transaction
> originating from modem are historically termed as an MSA transaction).
> Drop the unused non-MSA modem SID on SC7180 SoCs and cheza so that SMMU
> continues to block them.
>
> Fixes: bec71ba243e95 ("arm64: dts: qcom: sc7180: Update Q6V5 MSS node")
> Fixes: 68aee4af5f620 ("arm64: dts: qcom: sdm845-cheza: Add iommus property")
> Cc: stable@vger.kernel.org
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts    | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'm not sure if my review is worth all that much since it's not my
area of expertise, but as far as I can tell this is good / ready to go
in.  I've confirmed that a similar on my sc7180 board doesn't seem to
break anything for me so restricting things like this seems sane.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
