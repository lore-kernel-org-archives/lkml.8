Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA96BC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kcDnCbCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAMHI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:08:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35711 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMHIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:08:25 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so7625189qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 23:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li93yx3mVpdyk7CJK6HDbuJvR+euWoOVK8hS+mAbZms=;
        b=kcDnCbCuetwq8A/q63qeQ4jlC3PQiMbt+cpgN4GqEKafeNFliKhFMJ77TQBfNM+uMZ
         GxLi2SFn3qZC0mWbqPvE/PEQhABJA3O7117XpPYMuoOfLQavmLT39YopEgBs/IEFEsCL
         YLeEodBlNKuV+NJxnyI4smhWZr8oxmFTdGnLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li93yx3mVpdyk7CJK6HDbuJvR+euWoOVK8hS+mAbZms=;
        b=Oml6Bxe7wmpIeOJ3e7EI0/AqHdQWvDYaa4H+in+pizPricCgD9vcXh0S2LRlmSbyOt
         sm9m3wJ9c5hQnFl0mHbBLX3DSphyOVaGiAt5tR3v5SBeGRyCC7/O9EPAZisKseEZwfWw
         2iHfRMUx2Gt/lDLSzOch3MhSYER2yHsuM8b18iXfLAIlXKPk5+sX/ghxdpGi/tgoDqhG
         4mRfnruIPP1PS+4m1IeJtWVvbhiQYE1qN8xRbWVShuY/svEbImfn1Oa0fHY6RJ4lUZHW
         Lh6BGrtN8mFx8DJqaJliUUqamJ060tggzAbC3i4lHvlJy2+29tOYpIWo5gff/Oo8aeiL
         KrMw==
X-Gm-Message-State: APjAAAXWgRXe+0uc6TioW50l2w3mj/K+hRV/AOMC/GqR40+RnFu/JlL/
        SBBqizeJ4d7871JgzVQidZ1qbpVydofBk+DE1iarOA==
X-Google-Smtp-Source: APXvYqy6PyadEbexQKem912USX21lARZeie9Bf+dUuy9LQm4s9hBnBrf7pNLiJG+vj+X6NMNYB/L+81jzgTCFcCmYQw=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr10243195qkg.457.1578899305001;
 Sun, 12 Jan 2020 23:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20200110145952.9720-1-matthias.bgg@kernel.org>
In-Reply-To: <20200110145952.9720-1-matthias.bgg@kernel.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 13 Jan 2020 15:08:14 +0800
Message-ID: <CANMq1KCnLb04O3HWv_9HbkiDufN9_Kcapkg1wpT9ra28nJ6WFw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add MT6397 Pin Controller
To:     matthias.bgg@kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:00 PM <matthias.bgg@kernel.org> wrote:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> The MT6397 mfd includes a pin controller. Add binding
> a description for it.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

>
> ---
>
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index a9b105ac00a8..ce22fca9d48b 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -54,6 +54,11 @@ Optional subnodes:
>                 - compatible: "mediatek,mt6323-pwrc"
>         For details, see ../power/reset/mt6323-poweroff.txt
>
> +- pin-controller
> +       Required properties:
> +               - compatible: "mediatek,mt6397-pinctrl"
> +       For details, see ../pinctrl/pinctrl-mt65xx.txt
> +
>  Example:
>         pwrap: pwrap@1000f000 {
>                 compatible = "mediatek,mt8135-pwrap";
> --
> 2.24.0
>
