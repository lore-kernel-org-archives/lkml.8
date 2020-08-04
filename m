Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992D120792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n0tp/hA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgHDCNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgHDCNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:13:01 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C5C061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 19:13:00 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id n2so5018669uan.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 19:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ek5IwSL+ashZL9KTOZdz56TvgUVWfpkvY3pBa7EzP2A=;
        b=n0tp/hA48FqUCnJQSr6N0Wcwa/cJmyK+gKVLEMeh/2VJb5aP7fHr3/7KKZjGS8Ipad
         cqhcBps/kGqgbW1ttxwbhSgAoFgq9fppfYPqf0fGv+DyPKHd/w6YwgZUB7CTKqTISkN1
         nRX+PT8O2EH1LOoXschOC9MaFkSn35tNphz5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ek5IwSL+ashZL9KTOZdz56TvgUVWfpkvY3pBa7EzP2A=;
        b=VmJ4OlVldNgwymVBfgubbfTbrKz5POsdkEWQZTiLsQz+dU4fUbdvmJIIxktRxqhIsn
         UY1JygBpkJNSOFJaiGIqnTGxVIf38pCsLGCVw8+9LtCAqg7C5y+squnUk5TqdIOfKPLX
         tDRQQH6zTIjqsJk5ANSXThXl05XoLR/a/N3EzASybtjNLux0MUE2NpYmLRwfEwa9zj4g
         E3CmgCe1vrrPUGLX8fGWWmpthple+HrUAUy/qm9BR1ybxmLqy2oxlPNEZGWJWZTxsYig
         9pLiiyk0jvQ7oFNar21l27voGs2TwbHpo+9wa4F6/59jwj+dLza/RxTtmV7eM1M4pYRF
         wtIg==
X-Gm-Message-State: AOAM532+AL9rl1AjYScK9j2FbfmTuyz+CCFRn9Ev9D6hhQc1vndBl7Xf
        OP2coeUYGXWuVtfnYLPJPGsmWNm3IY0Jo4cT9zesew==
X-Google-Smtp-Source: ABdhPJwghGSLbe8ZU4D96mdziHWtR9hqw1MkwSUkRpmFW/D404GQmjvXpH25/+Xs6ReDM3GKg6kZtrzus7DmgAVTxUk=
X-Received: by 2002:ab0:20b6:: with SMTP id y22mr13153458ual.77.1596507180138;
 Mon, 03 Aug 2020 19:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1596445047-2975-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1596445047-2975-3-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1596445047-2975-3-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 4 Aug 2020 10:12:49 +0800
Message-ID: <CANMq1KDDbPBsnxPHvPTcTreW7OrTwC_=8GyM=rrU2QOLPKp2Bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] regulator: bindings: Add document for MT6315 regulator
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fei Shao <fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Hsiung,

On Mon, Aug 3, 2020 at 4:57 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> Add device tree binding information for mt6315 regulator driver.
> Example bindings for mt6315 are added.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6315-regulator.txt        | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.txt
>
> diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6315-regulator.txt
> new file mode 100644
> index 0000000..1c14537
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.txt
> @@ -0,0 +1,45 @@
> +Mediatek MT6315 Regulator
> +
> +Required properties:
> +- compatible: Must be one of the following.
> +       "mediatek,mt6315_3-regulator"
> +       "mediatek,mt6315_6-regulator"
> +       "mediatek,mt6315_7-regulator"

As highlighted on Gerrit [1], I think this is wrong. The device tree
compatible should focus on actual hardware differences, _not_ the way
the device is used.

So I looked at the datasheet, and there are 5 variants of the MT6315.
They all have the same number of VBUCKs, just with different _default_
voltages, Imax, and sequencing. Since the regulator range is the same,
I don't think you need to care about any of this, so I'd have a single
compatible "mediatek,mt6315-regulator".

The one thing that is special here, though, is that you want to
combine regulators for BUCK1, right?

That is, for MT6315PP (id 6), you want to combine BUCK1/2/4 to power
the big cores (hence 0xb = "1011" in patch 3/3), and for MT6315SP (id
7), you want to combine BUCK1/2 (hence 0x3 = 0011).

So, instead of a table here, what I'd do is to figure out a way to
indicate, in the device tree, that bucks 1, 2, 4 need to be combined.

I think the correct way to handle this is to add a
`regulator-coupled-with` property. That is you'd have a device tree
that looks like this:

mt6315_6: mt6315@6 {
    compatible = "mediatek,mt6315-regulator";
    reg = <0x6 0 0xb 1>;
    mt6315_6_vbuck1: vbuck1 {
        regulator-compatible = "vbuck1";
        ...
        regulator-coupled-with = <&mt6315_6_vbuck2, mt6315_6_vbuck4>;
    };

    mt6315_6_vbuck2: vbuck2 {
        regulator-compatible = "vbuck2";
        ...
    };

    mt6315_6_vbuck3: vbuck3 {
        regulator-compatible = "vbuck3";
        ...
    };

    mt6315_6_vbuck4: vbuck4 {
        regulator-compatible = "vbuck4";
        ...
    };
};

Then, at probe time, you can figure out which regulators are coupled
with another one, and only provide controls for the first regulator in
the list (with the proper mask).

Another, simpler way, may look like this:

mt6315_6: mt6315@6 {
    compatible = "mediatek,mt6315-regulator";
    reg = <0x6 0 0xb 1>;
    mt6315_6_vbuck1: vbuck1 {
        regulator-compatible = "vbuck1";
        regulator-mask = <0xb>;
    };
    mt6315_6_vbuck3: vbuck3 {
        regulator-compatible = "vbuck3";
        regulator-mask = <0x8>;
    };
};

But then it's a bit weird, because 0x8 = 1 << 3, which we can already
infer from "vbuck3" compatible...

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2229019/13/drivers/regulator/mt6315-regulator.c#283


> +- reg: SPMI slave id.
> +- regulators: List of regulators provided by this controller.
> +  The definition for each of these nodes is defined using the standard binding
> +  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +The valid names for regulators are:
> +BUCK:
> +  vbuck1, vbuck3, vbuck4
> +
> +Example:
> +       mt6315_3: mt6315@3 {
> +               compatible = "mediatek,mt6315_3-regulator";
> +               reg = <0x3 0 0xb 1>;
> +
> +               mt6315_3_vbuck1: vbuck1 {
> +                       regulator-compatible = "vbuck1";
> +                       regulator-min-microvolt = <300000>;
> +                       regulator-max-microvolt = <1193750>;
> +                       regulator-enable-ramp-delay = <256>;
> +                       regulator-allowed-modes = <0 1 2 4>;
> +               };
> +
> +               mt6315_3_vbuck3: vbuck3 {
> +                       regulator-compatible = "vbuck3";
> +                       regulator-min-microvolt = <300000>;
> +                       regulator-max-microvolt = <1193750>;
> +                       regulator-enable-ramp-delay = <256>;
> +                       regulator-allowed-modes = <0 1 2 4>;
> +               };
> +
> +               mt6315_3_vbuck3: vbuck3 {
> +                       regulator-compatible = "vbuck3";
> +                       regulator-min-microvolt = <300000>;
> +                       regulator-max-microvolt = <1193750>;
> +                       regulator-enable-ramp-delay = <256>;
> +                       regulator-allowed-modes = <0 1 2 4>;
> +               };
> +       };
> --
> 2.6.4
