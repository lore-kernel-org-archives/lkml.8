Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F973C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204D20722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXOUpHvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCTEdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:33:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39720 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgCTEdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:33:06 -0400
Received: by mail-il1-f195.google.com with SMTP id w15so4433071ilq.6;
        Thu, 19 Mar 2020 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ro5OadTTl3oAqQ/6no0uJfVHWvcAkSf0Yfq3aWJWa6g=;
        b=fXOUpHvBPwDbnC68taQsc1k3pAGc2pwxjBqO/zc0oYzSgAmhaulpGsGTwsbBjWIFS/
         SOyDc1vQ9hmjGCa/uiMZubIdICOei4he1mcycDYXSsTNGnw9F/yc70+pF6njq0cF7MZW
         fMxe5L41GdcDzxqPoVJK4W9YOnfMUpN4XXA95sVo1KDYrHU5w5FeIGfbpUjhc5/f0HDl
         9f0GpD/+Scynia4pKTyOuqYi+hPQw4KG3XKl5aWKab6SzNzYEpa+rkVV42c1HrVgEQBJ
         H1eYxTubgoYzDmhbDyKVs2HOnUl9nyECytr1jkLscawh5SRjgvgvLNPfqI2G4ps3DhCo
         2njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ro5OadTTl3oAqQ/6no0uJfVHWvcAkSf0Yfq3aWJWa6g=;
        b=hUKM4acv1xaAKfHBL/l9a2o2n8luJzdNRPpq9lEPsQjqHr2G/e+ujkOX51LHBZXEiR
         IVE1mzZcF3x1C3N6OhtnLoJv/4oQheV7hWMFeDEJmgOzJIDN0x6mpK2z7TCxXk+9x/fb
         A0tNA5JMMHN9ZLHwdax8HVV1XzNGrAr3LoGZUfGRj1ihWfkFxeyIykckIHyhxYnpkvJ8
         8FbAoankPj1ReIWIBXrkdNxQmeo3IpDxC67NWVAdVm8lLCk7QnK/PDNmgkGyvnlQP9fV
         orCt4BIoQ9FHNcVIuBCIVQY44q+OQZUx2tyeMVhQMiYAwwiIQCAGfxq1qIaYa5M3pZOg
         h6wg==
X-Gm-Message-State: ANhLgQ2hZfaDoFkBQ0Zpr275ybaWKGfYsfvREn3XPSVbkc1OUWFemMkF
        nSOe7V9g9mzijs0sPt7woaITDEIWLLFKNXFZcB4=
X-Google-Smtp-Source: ADFU+vtbcC/xcbQhZMdEZ8Lc2LQUNOxiprDZuV7nqcfWnoZVxekI/Le/jXYa4uUo/aA2/Cnk3NEIJhDfMdgceFlmw+c=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr6142269ili.217.1584678785668;
 Thu, 19 Mar 2020 21:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
 <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com>
 <CAGWqDJ4yA4ikz5MwQQwW8CAvE_dt16iuvN6cKRL2DdAuw8QWww@mail.gmail.com>
 <CAL_JsqLU4kEmRnXhQ5+gP-ZisS2Za+s6mNFg4RnMdpDtDRQB3g@mail.gmail.com> <CAGWqDJ5O2Lw-=5gHMja0SWVG1ttc_+7ieo-aEf7BRq+W8DGOnA@mail.gmail.com>
In-Reply-To: <CAGWqDJ5O2Lw-=5gHMja0SWVG1ttc_+7ieo-aEf7BRq+W8DGOnA@mail.gmail.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Fri, 20 Mar 2020 10:02:54 +0530
Message-ID: <CAGWqDJ6MyLVVqfZvO4VY5NQ9ESz8vL1BE7j_pHrpe4X_LLwMJQ@mail.gmail.com>
Subject: Re: graph connection to node is not bidirectional kernel-5.6.0-rc6
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rob,

issue got resolved. the problem was end node of the panel had the label.

- panel2: eppendorf {
+ lvds-out {

https://github.com/vinaysimhabn/kernel-msm/commit/a7bf9ccd0b61cb355fe7fa768e65b6f04cfa686f

thanks.

On Thu, Mar 19, 2020 at 10:46 PM Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> On Thu, Mar 19, 2020 at 10:36 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Mar 19, 2020 at 9:56 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
> > >
> > > On Thu, Mar 19, 2020 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 19, 2020 at 1:31 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
> > > > >
> > > > > hi,
> > > > >
> > > > > I am getting the endpoint' is not bidirectional(d2l_in, dsi0_out)
> > > > > warning in compilation, built boot image works on qcom apq8016-ifc6309
> > > > > board with the dsi->bridge->lvds panel.
> > > > > Because of this warning i cannot create a .yaml documentation examples.
> > > > > Please suggest.
> > > > >
> > > > > tc_bridge: bridge@f {
> > > >
> > > >              ^^^^^^^^
> > > >
> > > > > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:253.28-255.9: Warning
> > > > > (graph_endpoint): /soc/i2c@78b8000/bridge@39/ports/port@0/endpoint:
> > > >
> > > >                                      ^^^^^^^^^
> > > >
> > > > Looks like you have 2 different bridges.
> > > >
> > > i had two bridges, if we disable one bridge also we get the warning
> > >
> > > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:333.53-335.35: Warning
> > > (graph_endpoint): /soc/auo,b101xtn01/port/endpoint: graph connection
> > > to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
> > > bidirectional
> >
> > You can't just disable nodes. To switch which bridge is enabled, you
> > already have to modify remote-endpoint at the other end. So the
> > requirement is you have to modify both 'remote-endpoint' properties
> > (or really all 3).
> >
> > The other options is if you want both connections described, then you
> > need 2 'endpoint' nodes to connect both bridges.
> even after removing one bridge(dsi2hdmi) in the device tree, currently
> using only one bridge(dsi2lvds), i do still get the compilation warning.
>
>  graph connection
>  to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
> bidirectional
>
> This compilation warning does not cause any problem with the boot image created
> dsi -> dsi2lvds bridge-> lvds panel . Able to get the display properly.
>
> https://github.com/vinaysimhabn/kernel-msm/blob/08e4821646b5c128559c506a5777d8782f1ff79e/Documentation/devicetree/bindings/display/bridge/toshiba%2Ctc358775.yaml
>
> But while creating documentation yaml, it is not allowing to add this examples.
> --
> regards,
> vinaysimha



-- 
regards,
vinaysimha
