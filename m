Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6448820773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbkRyco2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgGGPVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgGGPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:21:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD99C061755;
        Tue,  7 Jul 2020 08:21:12 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t4so17342843oij.9;
        Tue, 07 Jul 2020 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loC7QORNa6sw/c6QZZ/kzwrFvD1Ot4fbNHIkDfLK6/s=;
        b=XbkRyco23qSUV9A1SJ5iYX7Wk13/g9wL+GzsRKTnPj/6jZbXeNoSLlau57LBJhDxG8
         VoJVNCichUPadtznqbdLRP4jMD21MgajG9gZh0KUc7UKT9bXyra7+HameduAnwiIrnYi
         eoUBd4AXqK3biOxpbTrzH/fm9dK5XtAKwbfUQPOxX40d7mW6FRm2sqYtsOKetwPqr65s
         XSOlGkmBDrKMGVqNG03Ut/PPdanrUCOSwmIyqZ5UNTStdhlpjlqJBhU+6KKKu5pnEkNg
         9xLmE4E6nGBD1tbZAuZnYY6ul4+KepqVNQsargpYklUxTSD/quJLWrL4E3yWRK4cJlvm
         elhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loC7QORNa6sw/c6QZZ/kzwrFvD1Ot4fbNHIkDfLK6/s=;
        b=la2WqVogiy2b7IckwxtDflShCicnKhkygJfvzmvS0kutAnuuwTXPX1TNfmNQH8l5Bh
         2gq1bpWtpZjQWbrgEQF1qGJQ7q4q95k7AMa9oH3Y86z4ZJT/TG9j1COwjAS9Oi9rtjih
         Vsu2EsvYEUntWCemoBwMtZd2zR6kUzb0XpS3OllIm3C/EkC07Vt7vugrOHQVEG+MKD31
         wegTQkM9/P6kIzVLZkuckK3VbiVHIC+WCT21WFeLk2mOybQVY2dGI3tSBLH3cAKk8uVY
         NoFiU9qe7g8ePE4pR2l21PJNu48bivP1Xn+qs8DyPWPwKrRC8KjzWbF902dJ8PXd0ZKx
         EjEg==
X-Gm-Message-State: AOAM531CaK7ufYDf+fkTjckJysLBB3UvFQUV8uZrEnQL++GqqnyPPq2+
        fF2H0J0d2AfREJTdVE/iENjXp952HM8QwmkdBUg=
X-Google-Smtp-Source: ABdhPJxIu94TjN3D/r7CA49DLJo7QyTzVKOQlUajvIFmOd73qvLS16meJ3yJbVXAEPBP7NsSU3nrmrtU2oFWimt9VXI=
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr3534117oih.92.1594135272003;
 Tue, 07 Jul 2020 08:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200702175352.19223-1-TheSven73@gmail.com> <20200702175352.19223-3-TheSven73@gmail.com>
 <CAOMZO5DxUeXH8ZYxmKynA7xO3uF6SP_Kt-g=8MPgsF7tqkRvAA@mail.gmail.com>
 <CAGngYiXGXDqCZeJme026uz5FjU56UojmQFFiJ5_CZ_AywdQiEw@mail.gmail.com>
 <AM6PR0402MB360781DA3F738C2DF445E821FF680@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiWc8rNVEPC-8GK1yH4zXx7tgR9gseYaopu9GWDnSG1oyg@mail.gmail.com>
 <AM6PR0402MB36073F63D2DE2646B4F71081FF690@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5ATv9o197pH4O-7DV-ftsP7gGVuF1+r-sGd2j44x+n-Ug@mail.gmail.com>
 <CAGngYiVeNQits4CXiXmN2ZBWyoN32zqUYtaxKCqwtKztm-Ky8A@mail.gmail.com>
 <CAGngYiX9Hx413BX-rgaaUjD9umS9hGg=gMLbM+QmdyEt2Nut5A@mail.gmail.com> <AM6PR0402MB36078DBF3B7737B1C3F032AAFF660@AM6PR0402MB3607.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB36078DBF3B7737B1C3F032AAFF660@AM6PR0402MB3607.eurprd04.prod.outlook.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 7 Jul 2020 11:21:01 -0400
Message-ID: <CAGngYiU7HEyZXYN4GxM=w83g1O-NVsmSwvPrbeY6=UxSUW8vCg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v5 3/3] ARM: imx6plus: optionally enable
 internal routing of clk_enet_ref
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, Fabio,

Sounds like we now have a solution which makes logical sense, although it
requires changes and additions to drivers/clk/imx/. Before I create a patch,
can you read the plan below and check that it makes sense, please?

Problem
=======
On the imx6q plus, the NXP hw designers introduced an alternative way to clock
the built-in ethernet (FEC). One single customer (archronix) seems to be
currently using this functionality, and would like to add mainline support.

Changing the ethernet (FEC) driver appears illogical, as this change is
unrelated to the FEC itself: fundamentally, it's a clock tree change.

We also need to prevent breaking existing boards with mis-configured FEC
clocking:

Some board designers indicate in the devicetree that ENET_REF_CLK is connected
to the FEC ptp clock, but in reality, they are providing an unrelated external
clock through the pad. This will work in many cases, because the FEC driver
does not really care where its PTP clock comes from, and the enet ref clock is
set up to mirror the external clk frequency by the NXP U-Boot fork.

Proposed changes must not break these cases.

Proposed Solution
=================
On non-plus imx6q there are no changes. On imx6q plus however:

Create two new clocks (mac_gtx and pad) and a new clock mux:

  enet_ref-o--------->pad----->| \
           |                   |  |
           |                   |M1|----mac_gtx --- to FEC
           |                   |  |
           o-------------------|_/

The defaults (indicated with ">") are carefully chosen, so these changes will
not break any existing plus designs.

We then tie the gtx clock to the FEC driver ptp clock, like so:

in imx6qp.dtsi:
&fec {
    clocks = <&clks IMX6QDL_CLK_ENET>,
        <&clks IMX6QDL_CLK_ENET>,
        <&clks IMX6QDL_CLK_MAC_GTX>;
};

Mux M1 is controlled by GPR5[9]. This mux can just write to the GPR5 memory
address. However, the GPR registers are already exposed as a mux controller
compatible = "mmio-mux". This mux does currently not use GPR5.

So we have to make a choice here: write straight to the memory address (easy),
or create a new clock mux type, which uses an underlying mux controller.

When that is done, board designers can choose between:

1. internal clocking (GTX clock routed internally)

&fec {
    assigned-clocks = <&clks IMX6QDL_CLK_MAC_GTX>;
    assigned-clock-parents = <&clks IMX6QDL_CLK_ENET_REF>;
};

2. external clocking (GTX clock from pad, pad connected to enet_ref,
   typically via GPIO_16). This is the default and does not need to be present.

&fec {
    assigned-clocks = <&clks IMX6QDL_CLK_MAC_GTX>;
    assigned-clock-parents = <&clks IMX6QDL_CLK_PAD>;
};


3. external clocking (GTX clock from pad, pad connected to external PHY
   clock or external oscillator).

phy_osc: oscillator {
#clock-cells = <0>;
compatible = "fixed-clock";
clock-frequency = <50000000>;
};

&fec {
    clocks = <&clks IMX6QDL_CLK_ENET>,
        <&clks IMX6QDL_CLK_ENET>,
        <&phy_osc>;
};
