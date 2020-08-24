Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1CFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8AA2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viaSbKYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgHXJvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgHXJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:51:21 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D86C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:20 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p186so1357312vsa.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQVuDdH8Zvj1M8HLAuvz5oG4f0c+4DnopFb9nohLKXM=;
        b=viaSbKYkt3Ve8bKIQEqECLhqvB8aKO+ihxIs+NH5lCkzHixhocn/PB4nGT/XA599s/
         Q+TA0g/qbcuLiUHw6XpMggqiZ1vdsV8KqQaft0CEheeblOkjGrWAGw+6CJ8Qr8bOtMpW
         FpZQzLT3i1eRllSVw3osF8yeNE1P/B8EHnKLB0O/JY0ljpRogF6Uj1k8GDipwqxAcmpZ
         qlBCpsL22zcCK7Eb6u7eF6tRgtS15PT/bP57r1LCYR6ZgYWa164KtOyT3Begp5KvRos1
         TDzO2DlrGkkQS83WnUyDpS7uLvPh+tpXuFD6EY9i2Kf4tyvEIrahvH+dCXW2jDpa/8MQ
         LX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQVuDdH8Zvj1M8HLAuvz5oG4f0c+4DnopFb9nohLKXM=;
        b=kRrn/djkTXvbNn7t5oe1KMGsToJXjVkRW2ivxWnnt4Azk8YWwWU6ZJKyTVBlp0uyuk
         zXnKp+37ygphs/NOkceok3xJO5tqIKbG2ui0NoRzy1/S9KSAUOmGoNchZQYjnmrHckat
         Fh4ZfYwQAmhURMmH5RnT4zSni3i1euNNt6MljXqGIWacRkz/Ps0sRumkf+H2m9pFrSSi
         avFLL8Dd0+PxEn1Jd1uOua91NqOchcJTSx0tBxhg4jjpQUT6PihiNrHEFMRXYEqt4Ymb
         JP6ykPub8v+TQzdDRI810AfgyzRkgAJ4B1U3fn/212gEX4MJ00kF5OmOYnTUQJhS1XNN
         nQoQ==
X-Gm-Message-State: AOAM533ebG8o9AseNYHrqKvUq+Nitoyf2NO3CPFNB36aqjMdhWFoP2Ih
        TFlmA9+58E3AYP0e7K0JqEmZeUL5dX/NmqHT3Mw4uw==
X-Google-Smtp-Source: ABdhPJz1ej/yqCDXyFjyLy7ZlP1cm49cSWXutwlzE1D8OKP6S+DBPfEDkJzgXFbDyWrfWa93Ar32IMcM2cb1jLVp9Zs=
X-Received: by 2002:a67:2f06:: with SMTP id v6mr1293230vsv.34.1598262680151;
 Mon, 24 Aug 2020 02:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200814014346.6496-1-wenbin.mei@mediatek.com> <20200814014346.6496-3-wenbin.mei@mediatek.com>
In-Reply-To: <20200814014346.6496-3-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:50:43 +0200
Message-ID: <CAPDyKFpt6-a+pkTXb2RZdx=yTONetugSCKbtSsRD2xQ3PRPhDQ@mail.gmail.com>
Subject: Re: [v5,2/3] arm64: dts: mt7622: add reset node for mmc device
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 03:44, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> This commit adds reset node for mmc device.
>
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>

I can pick this for my fixes branch, together with the other changes,
however deferring that until Matthias acks it.

Kind regards
Uffe



> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 1a39e0ef776b..5b9ec032ce8d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -686,6 +686,8 @@
>                 clocks = <&pericfg CLK_PERI_MSDC30_0_PD>,
>                          <&topckgen CLK_TOP_MSDC50_0_SEL>;
>                 clock-names = "source", "hclk";
> +               resets = <&pericfg MT7622_PERI_MSDC0_SW_RST>;
> +               reset-names = "hrst";
>                 status = "disabled";
>         };
>
> --
> 2.18.0
