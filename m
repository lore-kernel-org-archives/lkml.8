Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF5FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDAF20825
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591303642;
	bh=KFodmG5dxLwi01xoHP3XvvFF9k/ifovAv20CD/RAbqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QwkfCce8V/bfjTPGTfrPOd/sGNtTygM7HWnmiLju5bKPJngSP5dcyc55DsB8j/yT5
	 JQDT6te0c0hauZ6Jt6Xn/7L/fefhM22+5RsyeyhfsKdT60r/bAux6DCjz6uwoLO1ke
	 hMMO+uRCDSylPznwZ5CKSrqUV1Ka0NM2jhdyqXz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgFDUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730101AbgFDUrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:47:15 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91390207F9;
        Thu,  4 Jun 2020 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591303633;
        bh=KFodmG5dxLwi01xoHP3XvvFF9k/ifovAv20CD/RAbqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k7PE0miyDMbeR8z6yic0GzwJHBc4BnWOuy+uL5PUFHy26zjLx2c7DrAUiWE/dVFDH
         7HEjNWZWuIzljvHpDgOzFd1//3dVtoLjgsJiP49dP3iJaDk1Ue8EzPwNL0p3YWhvgb
         /IYet3YsBRn9V4Ll3IT9POl3Aw+S19y36dNyj1yg=
Received: by mail-oo1-f54.google.com with SMTP id h7so1512372ooc.9;
        Thu, 04 Jun 2020 13:47:13 -0700 (PDT)
X-Gm-Message-State: AOAM533liRkyXqGM0J69dbeBl7mUs6bAkO4SaRXaIZnhx/x8s+qHGJUz
        JiLTBwRY0vz7fyiFKK7H4QOQ/OgfVmq3F0eJTQ==
X-Google-Smtp-Source: ABdhPJwwaaT3W3YLSJDqZR+blejzcilkUVb+CLjXx9zxnhQgu0H5S8pzGVf0fGb0K342AwgdZ/YgUMdqmCyiyHTPhzI=
X-Received: by 2002:a4a:2c88:: with SMTP id o130mr5106020ooo.81.1591303632915;
 Thu, 04 Jun 2020 13:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-13-lkundrak@v3.sk>
In-Reply-To: <20200519224151.2074597-13-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 4 Jun 2020 14:47:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxP8-0amAEW7-zB_QRvXSmmTfgMDj7UOuDX-6z9me0Hw@mail.gmail.com>
Message-ID: <CAL_JsqJxP8-0amAEW7-zB_QRvXSmmTfgMDj7UOuDX-6z9me0Hw@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] dt-bindings: clock: Add Marvell MMP Audio Clock
 Controller binding
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 4:42 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> This describes the bindings for a controller that generates master and bit
> clocks for the I2S interface.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - Fix commit message wording
> - Define MMP2_CLK_AUDIO_NR_CLKS
> - Make clock ids start at 0, not 1
> - Fix dt-bindings/clock/marvell,mmp2-audio.h file name
> - Rename node from "clocks" to "clock-controller"
>
>  .../clock/marvell,mmp2-audio-clock.yaml       | 74 +++++++++++++++++++
>  .../dt-bindings/clock/marvell,mmp2-audio.h    | 10 +++
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
>  create mode 100644 include/dt-bindings/clock/marvell,mmp2-audio.h
>
> diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
> new file mode 100644
> index 000000000000..ab6e82d1d3a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/marvell,mmp2-audio-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MMP2 Audio Clock Controller
> +
> +maintainers:
> +  - Lubomir Rintel <lkundrak@v3.sk>
> +
> +description: |
> +  The audio clock controller generates and supplies the clocks to the audio
> +  codec.
> +
> +  Each clock is assigned an identifier and client nodes use this identifier
> +  to specify the clock which they consume.
> +
> +  All these identifiers could be found in
> +  <dt-bindings/clock/marvell,mmp2-audio.h>.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,mmp2-audio-clock
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Audio subsystem clock
> +      - description: The crystal oscillator clock
> +      - description: First I2S clock
> +      - description: Second I2S clock
> +
> +  clock-names:
> +    items:
> +      - const: audio
> +      - const: vctcxo
> +      - const: i2s0
> +      - const: i2s1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/marvell,mmp2-audio.h>
> +    #include <dt-bindings/power/marvell,mmp2.h>
> +
> +    clock-controller@d42a0c30 {
> +      compatible = "marvell,mmp2-audio-clock";
> +      reg = <0xd42a0c30 0x10>;
> +      clock-names = "audio", "vctcxo", "i2s0", "i2s1";
> +      clocks = <&soc_clocks MMP2_CLK_AUDIO>,
> +               <&soc_clocks MMP2_CLK_VCTCXO>,
> +               <&soc_clocks MMP2_CLK_I2S0>,
> +               <&soc_clocks MMP2_CLK_I2S1>;

This now breaks linux-next. I think the above defines are missing
their include.

My testing wasn't happy either because it couldn't find
marvell,mmp2.h. I guess that's somewhere in linux-next and now we're
on to the secondary issue. Once that's fixed, then the schema checks
will actually run (hint: make sure they pass).

Please get this fixed or revert before it is sent to Linus. Maybe we
can have an rc1 without the schema broken.

Rob
