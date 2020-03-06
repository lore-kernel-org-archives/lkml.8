Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6915BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BA920714
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+5Hc2Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFCnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:43:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39465 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCFCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:43:48 -0500
Received: by mail-vs1-f66.google.com with SMTP id a19so610199vsp.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 18:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J7QUZ3c6oiJJHOCislF9UdZETLylotw3HiKvwmAMXw=;
        b=E+5Hc2RoJaRGHZP8HBhUfdRXIeqRGN8m1mX+ZoYWKE5rFmO3rqVE3tD2ahZFs+pdHi
         /4HyvgWRRhRjVfxlEvKX9ZPO9o/jWmDyGVazqEkLQNal6+cTur8SCs2MkknKUJJlpzN5
         DZe43h++B4igVoAiSlhNUnAYvsmvti3qQYbV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J7QUZ3c6oiJJHOCislF9UdZETLylotw3HiKvwmAMXw=;
        b=DIElQgLgiM8YTpKHearhx1emaI9Wm/NyPuATkgBQgOj7IZN2AcmW42+PanoIDkNPd/
         6lA50y/iCjsrblIAVJss/Qb/c4gKkmhvOJ3f70cuVZDtGQzCR2sMe8la9HQ76aTXYXyl
         43wmKONHevx2PYnPmaIjBdIVpjKIRWbGsqrYHted5k1lWqpBspZc4157ozI59Y5hKlBy
         54ymLg2bZWDnL1CjngGz7raps+v/PbOKgq27NQQ0Q1JxRhGa5dghDyhaLEKagEc0F7fz
         PmTyMGrv85lLurRQNExC/jIIKTHRPabd0rk/dAzK9CyGTDq3wEg37Kca1knd+XqWVR8K
         cAEA==
X-Gm-Message-State: ANhLgQ23JSM+ouWmDVkkN/Nm7drGwz01Pb9D1MtXegxE+xxlEk7A/m1a
        0zdyUx6Y44iv+TS8yUFNd8Xv0zPLpA9DA0Ce4QMGzA==
X-Google-Smtp-Source: ADFU+vv6/yy6QpFMc26UByJ8foEiCd0tx3UtqsQqGWflBPyiIzZovmd5yFBvcuNwqosvDrUuX+XkrYPkCEaxbPFJbJY=
X-Received: by 2002:a67:d81b:: with SMTP id e27mr927920vsj.79.1583462626960;
 Thu, 05 Mar 2020 18:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-2-drinkcat@chromium.org> <20200225171613.GA7063@bogus>
 <CANMq1KAVX4o5yC7c_88Wq_O=F+MaSN_V4uNcs1nzS3wBS6A5AA@mail.gmail.com> <1583462055.4947.6.camel@mtksdaap41>
In-Reply-To: <1583462055.4947.6.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 6 Mar 2020 10:43:35 +0800
Message-ID: <CANMq1KCi1ee87zz6cEWaB04=vEhkTdtW7C+UKW5EFn+1j6Cf3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
To:     Nick Fan <nick.fan@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, Sj Huang <sj.huang@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Fri, Mar 6, 2020 at 10:34 AM Nick Fan <nick.fan@mediatek.com> wrote:
>
> Sorry for my late reply.
> I have checked internally.
> The MT8183_POWER_DOMAIN_MFG_2D is just a legacy name, not really 2D
> domain.
>
> If the naming too confusing, we can change this name to
> MT8183_POWER_DOMAIN_MFG_CORE2 for consistency.

Thanks! I think I'll keep MT8183_POWER_DOMAIN_MFG_2D (that's fine if
that's the domain name you use internally in your HW design), but I'll
modify power-domain-names to core0/1/2 in the binding.

> Thanks
>
> Nick Fan
>
> On Wed, 2020-02-26 at 08:55 +0800, Nicolas Boichat wrote:
>
> > +Nick Fan +Sj Huang @ MTK
> >
> > On Wed, Feb 26, 2020 at 1:16 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Feb 07, 2020 at 01:26:21PM +0800, Nicolas Boichat wrote:
> > > > Define a compatible string for the Mali Bifrost GPU found in
> > > > Mediatek's MT8183 SoCs.
> > > >
> > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> > > > ---
> > > >
> > > > v4:
> > > >  - Add power-domain-names description
> > > >    (kept Alyssa's reviewed-by as the change is minor)
> > > > v3:
> > > >  - No change
> > > >
> > > >  .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > > > index 4ea6a8789699709..0d93b3981445977 100644
> > > > --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > > > @@ -17,6 +17,7 @@ properties:
> > > >      items:
> > > >        - enum:
> > > >            - amlogic,meson-g12a-mali
> > > > +          - mediatek,mt8183-mali
> > > >            - realtek,rtd1619-mali
> > > >            - rockchip,px30-mali
> > > >        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> > > > @@ -62,6 +63,30 @@ allOf:
> > > >            minItems: 2
> > > >        required:
> > > >          - resets
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: mediatek,mt8183-mali
> > > > +    then:
> > > > +      properties:
> > > > +        sram-supply: true
> > > > +        power-domains:
> > > > +          description:
> > > > +            List of phandle and PM domain specifier as documented in
> > > > +            Documentation/devicetree/bindings/power/power_domain.txt
> > > > +          minItems: 3
> > > > +          maxItems: 3
> > > > +        power-domain-names:
> > > > +          items:
> > > > +            - const: core0
> > > > +            - const: core1
> > > > +            - const: 2d
> > >
> > > AFAIK, there's no '2d' block in bifrost GPUs. A power domain for each
> > > core group is correct though.
> >
> > Good question... Hopefully Nick/SJ@MTK can comment, the non-upstream DTS has:
> > gpu: mali@13040000 {
> > compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
> > power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>;
> > ...
> > }
> >
> > gpu_core1: mali_gpu_core1 {
> > compatible = "mediatek,gpu_core1";
> > power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>;
> > };
> >
> > gpu_core2: mali_gpu_core2 {
> > compatible = "mediatek,gpu_core2";
> > power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> > };
> >
> > So I picked core0/core1/2d as names, but looking at this, it's likely
> > core2 is more appropriate (and MT8183_POWER_DOMAIN_MFG_2D might just
> > be a internal/legacy name, if there is no real 2d domain).
> >
> > Thanks.
> >
> > > Rob
>
