Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C8C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4A52070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INK5FY4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgCSRRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:17:12 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41472 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgCSRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:17:12 -0400
Received: by mail-il1-f194.google.com with SMTP id l14so2955559ilj.8;
        Thu, 19 Mar 2020 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2puVLEy6afSLzUcb87vcVA5fc3TX3nJUf9e0Okyxfw=;
        b=INK5FY4JU9WZQN7v0WeMyVSF0VrQk4T1gnKH7Z7eZE/CF5pIMmhnuF5ojjvw0l/4DI
         /sE+czy0eVQGHT4WtOqHFcQkqMevU0FM5PUQitLidNvtV6KAnM9NiWKLo010JYNQU5Qh
         epaszkvezxUIi/XfSxWz0hyv40PCy/UNB4hPTLNLFVSqSLU7K65FLrU68coL0Mno9Srn
         79hv5y77/B0YdwIuxFdTZk8/OwkjTI8EfFwPl4ErBh9rY9C34BuyXgq77K79d+Lszgtb
         LWg0NM/Q2iz0yTSCpn7zo8VNiAJ7HNPuz/CXSzK+9b70ExbetZWf+JWrzYfJKgYjFFmq
         Y5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2puVLEy6afSLzUcb87vcVA5fc3TX3nJUf9e0Okyxfw=;
        b=mccjPG3eSncwAUaDRC/gF1A7k0QmTNRjktaP8iMIufoKHWQQo21cFPMdizlLbjy98O
         ZhduN5/kLZvE8+AA0px4+AaF9uLZ74aSz7JxPU6dugWPC57wHka70BFWpey+sm6xXn6k
         7yCwrxdynZ0ux8kg5lPqe8Z1kt2P8SpO+WVcqi9nnbUaTw0S1RS4MbcmC+DZQmg7rjwy
         Pzr8lWATXMnAgQQ77US8O4No6sLf4VgCOGfmIg07nZ2VAZs/I9KtVjVVRXdz+9z6YIZn
         t02erKqQrgp+7pF54Kxo7WfjijLIawIE/KfmCsrbnMiWYNP0rEHrYCKCOtoS2XdbY2Sb
         yutQ==
X-Gm-Message-State: ANhLgQ3I95a9ITGNJCq7FAvuuzYAHrDyBVpxEybMJjwj1AUK6wRESkeD
        FNTh1i6swYV5trhX6KKW9/6bWSVJPToerWuAC1W8NU57
X-Google-Smtp-Source: ADFU+vsFrtCl3nw/cH8PE23Zz0zaNQwxsOKGrtz5qBN+qCE1goDUCx0XmoX0cDrtI52kS3KiPy/h3nANlAzO8mJsV0s=
X-Received: by 2002:a92:8f53:: with SMTP id j80mr4322003ild.171.1584638230705;
 Thu, 19 Mar 2020 10:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
 <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com>
 <CAGWqDJ4yA4ikz5MwQQwW8CAvE_dt16iuvN6cKRL2DdAuw8QWww@mail.gmail.com> <CAL_JsqLU4kEmRnXhQ5+gP-ZisS2Za+s6mNFg4RnMdpDtDRQB3g@mail.gmail.com>
In-Reply-To: <CAL_JsqLU4kEmRnXhQ5+gP-ZisS2Za+s6mNFg4RnMdpDtDRQB3g@mail.gmail.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Thu, 19 Mar 2020 22:46:59 +0530
Message-ID: <CAGWqDJ5O2Lw-=5gHMja0SWVG1ttc_+7ieo-aEf7BRq+W8DGOnA@mail.gmail.com>
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

On Thu, Mar 19, 2020 at 10:36 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 9:56 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
> >
> > On Thu, Mar 19, 2020 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Mar 19, 2020 at 1:31 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
> > > >
> > > > hi,
> > > >
> > > > I am getting the endpoint' is not bidirectional(d2l_in, dsi0_out)
> > > > warning in compilation, built boot image works on qcom apq8016-ifc6309
> > > > board with the dsi->bridge->lvds panel.
> > > > Because of this warning i cannot create a .yaml documentation examples.
> > > > Please suggest.
> > > >
> > > > tc_bridge: bridge@f {
> > >
> > >              ^^^^^^^^
> > >
> > > > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:253.28-255.9: Warning
> > > > (graph_endpoint): /soc/i2c@78b8000/bridge@39/ports/port@0/endpoint:
> > >
> > >                                      ^^^^^^^^^
> > >
> > > Looks like you have 2 different bridges.
> > >
> > i had two bridges, if we disable one bridge also we get the warning
> >
> > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:333.53-335.35: Warning
> > (graph_endpoint): /soc/auo,b101xtn01/port/endpoint: graph connection
> > to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
> > bidirectional
>
> You can't just disable nodes. To switch which bridge is enabled, you
> already have to modify remote-endpoint at the other end. So the
> requirement is you have to modify both 'remote-endpoint' properties
> (or really all 3).
>
> The other options is if you want both connections described, then you
> need 2 'endpoint' nodes to connect both bridges.
even after removing one bridge(dsi2hdmi) in the device tree, currently
using only one bridge(dsi2lvds), i do still get the compilation warning.

 graph connection
 to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
bidirectional

This compilation warning does not cause any problem with the boot image created
dsi -> dsi2lvds bridge-> lvds panel . Able to get the display properly.

https://github.com/vinaysimhabn/kernel-msm/blob/08e4821646b5c128559c506a5777d8782f1ff79e/Documentation/devicetree/bindings/display/bridge/toshiba%2Ctc358775.yaml

But while creating documentation yaml, it is not allowing to add this examples.
-- 
regards,
vinaysimha
