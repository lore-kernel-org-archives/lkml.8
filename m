Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F40C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D22086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cpZ1edWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCTlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:41:39 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40075 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgBCTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:41:38 -0500
Received: by mail-ua1-f68.google.com with SMTP id g13so2409384uab.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCm+aKbpcmsno90SlUdPzAeCBBjBdQJv8DZqSIB3TLc=;
        b=cpZ1edWIsH5TQ+/Zjo96Im+Kyjp+MYJhHErcmWKEaPehX2/4pi0G9wf3IOqyrht4Lb
         HntRYMoY9ItVRobZDa9P+bvjKBGZcgB2uNCsUIl2cYB68qggUCLNhxmm4gncJM6jQ2cm
         csj+AnSNFV4sd79IORgtOu5wfViHItEn+amHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCm+aKbpcmsno90SlUdPzAeCBBjBdQJv8DZqSIB3TLc=;
        b=ccICpucxkJTqCEq1402YTXhurA46Vyo8Ls0xA4Zuj1DSWvvBg+SGPQJMYKkFw3z1mr
         JdFRjeXxAAotkNjzKgX9Fzvlb+/6P4KHc3jP2vJklp5qYhfOpXkc8G9UvzFAVg4LIB6f
         fOcrpAgOz4XfEASB/JP0OC/C35g2/oE8n9RZyJQwLEmcO57IfbUUsQbYqln16Wt38GY1
         ej/YsI5Ru6N4rHcvoHcZMavzTx+zauqWbOGYSDGFST+DGP7qBpXa04zZ1qrNqj4a6frP
         VXYVT875quS0e3HGPZ6AwQW+//7m5Gfe6KKOlGUvPKiIv/09vCMAVZWpeQzNmflzP9w+
         pDIw==
X-Gm-Message-State: APjAAAXWqcNCzQi0kXh0M4+fBewXfNjd9Pq+SBkDHTlOp+hF9iyW2agu
        KWS19I2U+4UqwiftZ3GdyeRHMb91GO4=
X-Google-Smtp-Source: APXvYqxyqXho/EVhkGdVIvuBAmITWLZx+OH9gxZUaStnvPN7w6sRSPqTxEgOwr8wfYfbKJQwDG+LjQ==
X-Received: by 2002:ab0:555e:: with SMTP id u30mr15470736uaa.39.1580758896885;
        Mon, 03 Feb 2020 11:41:36 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 94sm5979627uaw.5.2020.02.03.11.41.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 11:41:36 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id f7so5794524uaa.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:41:35 -0800 (PST)
X-Received: by 2002:ab0:30c2:: with SMTP id c2mr14984867uam.8.1580758895085;
 Mon, 03 Feb 2020 11:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20200203183149.73842-1-dianders@chromium.org> <20200203193027.62BD22080D@mail.kernel.org>
In-Reply-To: <20200203193027.62BD22080D@mail.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Feb 2020 11:41:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X2K-Qr17qXgG1Ng8MpZQogagBqMwWu=D2OpQf+ZskBPw@mail.gmail.com>
Message-ID: <CAD=FV=X2K-Qr17qXgG1Ng8MpZQogagBqMwWu=D2OpQf+ZskBPw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] clk: qcom: Fix parenting for dispcc/gpucc/videocc
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 3, 2020 at 11:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Douglas Anderson (2020-02-03 10:31:33)
> >
> >  .../devicetree/bindings/clock/qcom,gpucc.yaml | 72 --------------
> >  ...om,dispcc.yaml => qcom,msm8998-gpucc.yaml} | 33 +++----
> >  .../bindings/clock/qcom,sc7180-dispcc.yaml    | 84 ++++++++++++++++
> >  .../bindings/clock/qcom,sc7180-gpucc.yaml     | 72 ++++++++++++++
> >  .../bindings/clock/qcom,sc7180-videocc.yaml   | 63 ++++++++++++
> >  .../bindings/clock/qcom,sdm845-dispcc.yaml    | 99 +++++++++++++++++++
> >  .../bindings/clock/qcom,sdm845-gpucc.yaml     | 72 ++++++++++++++
> >  ...,videocc.yaml => qcom,sdm845-videocc.yaml} | 27 ++---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 47 +++++++++
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 28 +++++-
>
> I don't want to take patches touching dts/qcom/. These aren't necessary
> to merge right now, correct? Or at least, they can go via arm-soc tree?

Right.  They can go later.

Specifically for sdm845 until the sdm845 patches lands the old dts
trees will yell about the missing clocks, but it's not like they will
compile fail.  Also the bindings themselves will validate fine.
There's no other way forward, though, and the old bindings caused
similar yells.

For sc7180 there's no usage of any of these clocks and this adds the
first usage, so definitely no problem there.

Once you've landed then Bjorn or Andy can pick up the dts.

-Doug
