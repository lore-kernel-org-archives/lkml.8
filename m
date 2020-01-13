Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C7C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBD924655
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578932217;
	bh=AeGdxtFYv6B45SjFDAyM4c28mlz6pcoolDL44HF+hDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S9g33IEXLAC9pvu7/a+4ehMii2qKgP/Wk1GzsezVmq0X8EgQL92/FPpJpW3WtQG2v
	 0w+ATUVO0B3dHUUPgfMCWqR44cvapd5IfkF66hmFRfI6eKw7QvQ55eI7RYFmZ5K1aZ
	 AHlBj64Liff5KcHh90fbhYigoBOWwdNAsNLRetVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAMQQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:16:56 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1980F21739;
        Mon, 13 Jan 2020 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578932215;
        bh=AeGdxtFYv6B45SjFDAyM4c28mlz6pcoolDL44HF+hDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1nPZwM1JD9cJhZmfTEm7I3y9KfKMRejD2Cl7ChyeNRkVLW9ULezoEJ2wLgpe2wq4j
         9rKeRhFGLi0aos3ofCEpqA9Gy3TP0Vee9NmwORwYEleD9UcDixoUSMitsnIcgeQ5Dc
         1SwvwVFk1pZLSjCt0eeycaZwpSAUDo1C47hH/UXU=
Received: by mail-qk1-f182.google.com with SMTP id z14so8971771qkg.9;
        Mon, 13 Jan 2020 08:16:55 -0800 (PST)
X-Gm-Message-State: APjAAAWVCK8mHGGgYEvCcxWwZLApKBGS8i0dvrTkUClTzDrDkf4n5NSB
        agkKsoUuHyKGHtkHmW7yTmMVvbtJaEQcRhJggw==
X-Google-Smtp-Source: APXvYqzt1b0Fu7JzU4XE0WbY6F3nq42qgTHD8h4dI4vWSjWclkB5P1MZophjyrXiyLG+1Hvm4ULiDbZeKA51r0PL+bg=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr17017668qkg.152.1578932214227;
 Mon, 13 Jan 2020 08:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
 <20200108140333.GA12276@bogus> <3b94b423-ca26-b96f-90fa-2662dbc523d8@linaro.org>
In-Reply-To: <3b94b423-ca26-b96f-90fa-2662dbc523d8@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jan 2020 10:16:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8gu-Ts_aMpcXgtvqW=gWGLTrUvNWDm+8fB7--62FmnQ@mail.gmail.com>
Message-ID: <CAL_JsqK8gu-Ts_aMpcXgtvqW=gWGLTrUvNWDm+8fB7--62FmnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] DT: bindings: Add cooling cells for idle states
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 11:32 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rob,
>
>
> On Wed, 8 Jan 2020 at 15:03, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Dec 19, 2019 at 11:19:27PM +0100, Daniel Lezcano wrote:
> > > Add DT documentation to add an idle state as a cooling device. The CPU
> > > is actually the cooling device but the definition is already used by
> > > frequency capping. As we need to make cpufreq capping and idle
> > > injection to co-exist together on the system in order to mitigate at
> > > different trip points, the CPU can not be used as the cooling device
> > > for idle injection. The idle state can be seen as an hardware feature
> > > and therefore as a component for the passive mitigation.
> > >
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/idle-states.txt | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> >
> > This is now a schema in my tree. Can you rebase on that and I'll pick up
> > the binding change.
>
> Mmh, I'm now having some doubts about this binding because it will
> restrict any improvement of the cooling device for the future.
>
> It looks like adding a node to the CPU for the cooling device is more
> adequate.
> eg:
> CPU0: cpu@300 {
>    device_type = "cpu";
>    compatible = "arm,cortex-a9";
>    reg = <0x300>;
>    /* cpufreq controls */
>    operating-points = <998400 0
>           800000 0
>           400000 0
>           200000 0>;
>    clocks = <&prcmu_clk PRCMU_ARMSS>;
>    clock-names = "cpu";
>    clock-latency = <20000>;
>    #cooling-cells = <2>;
>    thermal-idle {
>       #cooling-cells = <2>;
>    };
> };
>
> [ ... ]
>
> cooling-device = <&{/cpus/cpu@300/thermal-idle}
>                         THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>
> A quick test with different configurations combination shows it is much
> more flexible and it is open for future changes.
>
> What do you think?

Why do you need #cooling-cells in both cpu node and a child node? It's
really only 1 device.

Maybe you could add another cell to contain an idle state node if that helps?

Rob
