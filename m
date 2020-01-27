Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613DC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4B724679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MExhXoMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgA0XLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:11:49 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42602 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA0XLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:11:49 -0500
Received: by mail-vk1-f196.google.com with SMTP id c8so1905516vkn.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFyx78bNfJdYMQzj2ScVwGzqFx4mrb1379eblt0uZNc=;
        b=MExhXoMfg02P9/yakWtP+xXn+J78PWEh1A07lSTu8IFkOejgP+WOYPIyheYzf6eLtu
         J5w7nBlZfZxOCI3mxIChwse1+GITAFMvG477NTCPRAtYItZNJPE/8YIQu60aTd4kzXzQ
         3/X5Fge0czKgktZJYTIKeA4OhcprssE8bc1Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFyx78bNfJdYMQzj2ScVwGzqFx4mrb1379eblt0uZNc=;
        b=cMbQrqFOTlshrDa/3JWAcx2s0G6EGcqk0U///CZQh8xGV1dt0K83igCZ0GKTxd/SHT
         B0cYzlnYiFCSSPwteJBi2O3oijMmLbwLRLa5zKjdBuNCQ64Ib4Egs+jmoCqnbOpFikGd
         CDVc48kx1oAEkrM70O7h9GNV7+YJFx3HfzsX6uFXyezK2bXv8/gK1QKKgOFzfniSuzEA
         Z8juimUhQQzRTa0BrH5eFI7P4Wkt8flbMnB/E8C/8VXc/oKn2cPHrVCSg1XH1NaIN66x
         ockIDqo588NQFgyIQqwpneT3jlw3wcdZSuj4zlxiDYj9E905ESU2edAf3udOE3Q/a3fV
         gpfQ==
X-Gm-Message-State: APjAAAWvrVk4GV0uG9hi9FneHrKt7MEgHbo+DYP7gJLWHFzIB2CBAI9q
        0KHQBiemdjWcQixjXHT8oQS0wz8o/1o=
X-Google-Smtp-Source: APXvYqzKt6MJPDgEisIIk7wm6SsCw3np3iLs1fhi0rSrrjrfxZtE4GZwCVfQNj20wyfM6rMBwUmH8w==
X-Received: by 2002:a1f:fe45:: with SMTP id l66mr11938401vki.9.1580166706865;
        Mon, 27 Jan 2020 15:11:46 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id v68sm4789779vkf.20.2020.01.27.15.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 15:11:46 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id i78so3197667vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:11:45 -0800 (PST)
X-Received: by 2002:ac5:c807:: with SMTP id y7mr5333526vkl.92.1580166704728;
 Mon, 27 Jan 2020 15:11:44 -0800 (PST)
MIME-Version: 1.0
References: <1577435867-32254-1-git-send-email-tdas@codeaurora.org> <CAD=FV=X4gW3cpFPTL7KmocP1z7fK1fSRjg7BYjA7D_Uu7p5gnQ@mail.gmail.com>
In-Reply-To: <CAD=FV=X4gW3cpFPTL7KmocP1z7fK1fSRjg7BYjA7D_Uu7p5gnQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jan 2020 15:11:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UGSN8YRtbEsbHOF6DRvi5=hUTeV+Aam4QKKVL99L4uBA@mail.gmail.com>
Message-ID: <CAD=FV=UGSN8YRtbEsbHOF6DRvi5=hUTeV+Aam4QKKVL99L4uBA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sc7180: Add clock controller nodes
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 22, 2020 at 4:46 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Dec 27, 2019 at 12:38 AM Taniya Das <tdas@codeaurora.org> wrote:
> >
> > Add the display, video & graphics clock controller nodes supported on
> > SC7180.
> >
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
>
> Can you add these to your patch?
>
> #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
> #include <dt-bindings/clock/qcom,gpucc-sc7180.h>
>
> ...otherwise the first user of each of the clocks will need to add the
> #include and depending on what order patches landed things can get
> weird.  I think it's cleaner to assume that there will soon be a user
> and proactively add the #includes.
>
> NOTE: at least one user of your patch can be found at
> <https://lore.kernel.org/r/1579621928-18619-1-git-send-email-harigovi@codeaurora.org>.
> They don't add the #includes which means they don't compile atop your
> patch.

Breadcrumbs that I addressed my own feedback because I wanted to
include Taniya's patch atop my series.  See:

https://lore.kernel.org/r/20200124144154.v2.10.I1a4b93fb005791e29a9dcf288fc8bd459a555a59@changeid

-Doug
