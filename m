Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6CAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CEF20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBglIdt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHYVQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:16:43 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA61C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:16:43 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id a6so31030oog.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nv+nHABf+7pKY4zhisehwzpgqw3omZaeWbPdYJaF9h4=;
        b=FBglIdt8odJ/zBvyclcpdTXeqmx/SarwaxcVOuYLB+yIIuX5zIKrVhzvt61NwOEMnB
         AOgzCRxByu2Q4Li6hGpHuPiB3Ye6WIOlaEPciHKvV2SgDmzKrbqlxDA/7ANjx+k9MOlo
         HFB+UiDxu9euZ7ovkn9WF8eReuRebJ6tx/4H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nv+nHABf+7pKY4zhisehwzpgqw3omZaeWbPdYJaF9h4=;
        b=kD5nvFPxvHH8qvx2PyjH2MvssO1igkClVS0H1EN75RLZKpb2AJkVkMZUnABq6QkVtr
         r6JBU1Tfx2h68H2GrIAHMuZbxZGORU+peV4V2gwJ73Xmn11NP4W8aXHmaJm6hxql7JFV
         BOhQvERxe7zUqkRdEqEwx0cJZxo9V7nBCf4FBKdJ59O6M+ar9bjJ/c0theE69OKuvf5v
         oqPbH0cIdPomME7ayryJpd9Hc6Iw5CcWJka3OeYSI4HtHDd956c8skjWexi1iRXb4ofx
         DuRjWQBGDbwOY1oR/ph3BikUWdZAc6EySysLNjt8t6W5rpEVntqnk6F7vtwXWUKcT3Nh
         jEHw==
X-Gm-Message-State: AOAM532013wGr35BA2cGo6Onh3Of8IyZx+c34LVBTdKsZhThwb9+Pv0V
        gwGQlEyG8+5eryOKrp+KUevhQe7h1VEWsw==
X-Google-Smtp-Source: ABdhPJx3bYLDEyNaPfzn+1UyzCWT3sGZ3PMqnsQNfdFJLg1XBgm4RKoJhdKoamQl+B4DP1X9E/KQbg==
X-Received: by 2002:a4a:b28a:: with SMTP id k10mr8036492ooo.93.1598390202539;
        Tue, 25 Aug 2020 14:16:42 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id v4sm14286ool.21.2020.08.25.14.16.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 14:16:42 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id x24so11647702otp.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:16:42 -0700 (PDT)
X-Received: by 2002:a9f:2966:: with SMTP id t93mr7153412uat.90.1598389816754;
 Tue, 25 Aug 2020 14:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200825003341.1797322-1-robdclark@gmail.com>
In-Reply-To: <20200825003341.1797322-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Aug 2020 14:10:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vwa1ffbbQpyi9aHksbweVW-TNkXACc-fJFeyndM0EOvA@mail.gmail.com>
Message-ID: <CAD=FV=Vwa1ffbbQpyi9aHksbweVW-TNkXACc-fJFeyndM0EOvA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: add initial trogdor and
 lazor dt
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Atul Dhudase <adhudase@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Alexandru Stan <amstan@chromium.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 24, 2020 at 5:32 PM Rob Clark <robdclark@gmail.com> wrote:
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
> new file mode 100644
> index 000000000000..2b37113f1e3a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Lazor board device tree source
> + *
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include "sc7180-trogdor-lazor-r1.dts"
> +#include "sc7180-trogdor-lte-sku.dtsi"
> +
> +/ {
> +       model = "Google Lazor (rev1, rev3+) with LTE";

Since we're not handling the currently-being-debugged eMMC problem by
hacking the -rev2 dts, above model should probably just say:

"Google Lazor (rev1+) with LTE";


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
> new file mode 100644
> index 000000000000..c2a8f7d5b336
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Lazor board device tree source
> + *
> + * Copyright 2020 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor-lazor.dtsi"
> +
> +/ {
> +       model = "Google Lazor (rev1, rev3+)";

"Google Lazor (rev1+)";


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
> new file mode 100644
> index 000000000000..1b8bc5a1e625
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
> +&sdhc_1 {
> +       /*
> +        * HACK: due to b/155826689 we are temporarily overriding the
> +        * compatible string which will cause us to restore the DLL config
> +        * at runtime resume.
> +        */
> +       compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
> +
> +       /* HACK: this emmc is also causing us s2r problems, so further hack. */
> +       max-frequency = <100000000>;
> +       /delete-property/mmc-ddr-1_8v;
> +       /delete-property/mmc-hs400-1_8v;
> +       /delete-property/mmc-hs400-enhanced-strobe;
> +};

I'd be inclined to leave the "sdhc_1" hacks out.  Qualcomm's gotta fix
this without hacks.  It means that trogdor boards won't work quite
work right until they do but it needs to be fixed in a saner way.


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> new file mode 100644
> index 000000000000..b04987ab6c22
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -0,0 +1,1364 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Trogdor device tree source (common between revisions)
> + *
> + * Copyright 2019 Google LLC.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +/* PMICs depend on spmi_bus label and so must come after SoC */
> +#include "pm6150.dtsi"
> +#include "pm6150l.dtsi"
> +
> +/*
> + * Reserved memory changes
> + *
> + * Delete all unused memory nodes and define the peripheral memory regions
> + * required by the board dts.
> + *

Get rid of extra blank line?

> + */
> +
> +/delete-node/ &hyp_mem;
> +/delete-node/ &xbl_mem;
> +/delete-node/ &aop_mem;
> +/delete-node/ &sec_apps_mem;
> +/delete-node/ &tz_mem;
> +
> +/* Increase the size from 2MB to 8MB */
> +&rmtfs_mem {
> +       reg = <0x0 0x84400000 0x0 0x800000>;
> +};
> +
> +/ {
> +

Get rid of extra blank line?


> +       /* BOARD-SPECIFIC TOP LEVEL NODES */
> +
> +       backlight: backlight {
> +               compatible = "pwm-backlight";
> +
> +               /* The panels don't seem to like anything below ~ 5% */
> +               brightness-levels = <
> +                       196 256 324 400 484 576 676 784 900 1024 1156 1296
> +                       1444 1600 1764 1936 2116 2304 2500 2704 2916 3136
> +                       3364 3600 3844 4096
> +               >;
> +               num-interpolated-steps = <64>;
> +               default-brightness-level = <951>;

I suspect that this isn't quite right because locally we have the
series from <https://lore.kernel.org/r/20200721042522.2403410-1-amstan@chromium.org>.
From looking at <https://crrev.com/c/2291209> I think you just gotta
drop these properties.


> +&wifi {
> +       status = "okay";
> +       vdd-0.8-cx-mx-supply = <&vdd_cx_wlan>;
> +       vdd-1.8-xo-supply = <&pp1800_l1c>;
> +       vdd-1.3-rfa-supply = <&pp1300_l2c>;
> +
> +       /*
> +        * TODO: Put ch1 supply in its rightful place, rather than in ch0's
> +        * spot. Channel 0 is held open by bluetooth for now.
> +        */
> +       vdd-3.3-ch0-supply = <&pp3300_l11c>;

I'd be tempted to just do this correctly for upstream.  Seems like the
ath10k patch is ready to go anyway?
