Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0539C4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EF821927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7BmXd6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgBZA4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:56:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42251 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgBZA4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:56:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so1063513qtt.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 16:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTr07x+ZuW+Wkx10CmLSTlKU+6ax9EaUyaBXKAF3OqM=;
        b=Y7BmXd6Mfp+6AZ5v7tzuyEct+NldmkDhFbkaCIoOl6/SfR059Z2NK44rQkbVc+4j7t
         n0RrGob1lJqy4jSvVTBHC3x7e53bCvZCs0af4K9zwmRDwcKU3x3vY+Goiu220sgiSxhg
         LkPCOLYG0N6aE3fNLH+xw2IiIErd9z+gBVRxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTr07x+ZuW+Wkx10CmLSTlKU+6ax9EaUyaBXKAF3OqM=;
        b=EvH2a2WamY9TlgTTqEaFKYdVo59zE4RhTJflNoG+oLDCDBBPNVfKnRXfa01Z+zC9tR
         clqJMhXnOyQfnM9ovHIbWLUfTasfIreVLJyqXy5GBiSW/Kj4QaPQxhuHBdl3XTAdL6Uj
         qKudUaHJENqXFKTtuwTnU3rptQDCvfjYgrgz+kwDkPgAjjSSRNftq59r+qed0MqPjts9
         AN6h2c7x5R8ZXuOjmMKQirU3bVFrtnqwUWeZphY6FjlI3ZVMZjBlzS2VhP9UyK3HkT+O
         Xk2qPRcNyMOyCatRhK5OngCmdVOmRg5Kkbwus8N2s2ym59YplvwLc9B57sRIP0b75PNt
         3bSA==
X-Gm-Message-State: APjAAAXUjV3Dr699m7gXYK6abs9VYz3oCNPu/TLTMpJ6tyvqyo0vHZhm
        8uMavS9HzDrzMLQTwDsjmvQ9tQXhgGnRtuk3Q5VxbQ==
X-Google-Smtp-Source: APXvYqwn/doZ3Sl5MivNf7aeBY0i9IjKThPIXnCkYsjm6+vHV5atNhFSLqXf91LmG+mgvcdhqR+658LdmJfFTgy7fYc=
X-Received: by 2002:ac8:72d6:: with SMTP id o22mr1774873qtp.174.1582678561028;
 Tue, 25 Feb 2020 16:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-2-drinkcat@chromium.org> <20200225171613.GA7063@bogus>
In-Reply-To: <20200225171613.GA7063@bogus>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 26 Feb 2020 08:55:50 +0800
Message-ID: <CANMq1KAVX4o5yC7c_88Wq_O=F+MaSN_V4uNcs1nzS3wBS6A5AA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
To:     Rob Herring <robh@kernel.org>, Nick Fan <nick.fan@mediatek.com>,
        Sj Huang <sj.huang@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Nick Fan +Sj Huang @ MTK

On Wed, Feb 26, 2020 at 1:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 07, 2020 at 01:26:21PM +0800, Nicolas Boichat wrote:
> > Define a compatible string for the Mali Bifrost GPU found in
> > Mediatek's MT8183 SoCs.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> > ---
> >
> > v4:
> >  - Add power-domain-names description
> >    (kept Alyssa's reviewed-by as the change is minor)
> > v3:
> >  - No change
> >
> >  .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > index 4ea6a8789699709..0d93b3981445977 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > @@ -17,6 +17,7 @@ properties:
> >      items:
> >        - enum:
> >            - amlogic,meson-g12a-mali
> > +          - mediatek,mt8183-mali
> >            - realtek,rtd1619-mali
> >            - rockchip,px30-mali
> >        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> > @@ -62,6 +63,30 @@ allOf:
> >            minItems: 2
> >        required:
> >          - resets
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: mediatek,mt8183-mali
> > +    then:
> > +      properties:
> > +        sram-supply: true
> > +        power-domains:
> > +          description:
> > +            List of phandle and PM domain specifier as documented in
> > +            Documentation/devicetree/bindings/power/power_domain.txt
> > +          minItems: 3
> > +          maxItems: 3
> > +        power-domain-names:
> > +          items:
> > +            - const: core0
> > +            - const: core1
> > +            - const: 2d
>
> AFAIK, there's no '2d' block in bifrost GPUs. A power domain for each
> core group is correct though.

Good question... Hopefully Nick/SJ@MTK can comment, the non-upstream DTS has:
gpu: mali@13040000 {
compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>;
...
}

gpu_core1: mali_gpu_core1 {
compatible = "mediatek,gpu_core1";
power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>;
};

gpu_core2: mali_gpu_core2 {
compatible = "mediatek,gpu_core2";
power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
};

So I picked core0/core1/2d as names, but looking at this, it's likely
core2 is more appropriate (and MT8183_POWER_DOMAIN_MFG_2D might just
be a internal/legacy name, if there is no real 2d domain).

Thanks.

> Rob
