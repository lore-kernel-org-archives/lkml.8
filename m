Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2666C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B920E24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580170923;
	bh=1wwJQ6IpTy041XpfEWly60Mf5Uae34giZX3M68RLfls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JzEw3t3G3f7PKF//fw65b8BSDXVUYGUqu6w0mq8TIFKNDRVTpnCmapwaKj4t9zofx
	 +iRrWPlDo17bVFM0Yg8CHLaRZbpnRNUhm4S0efSyNd3m9JGS2a6wTDa4RItURA56eu
	 B0AImVYk8iIMw9SQhWx45ZxTO/QwhKErQg5+zL6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA1AWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA1AWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:22:02 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA3A22527;
        Tue, 28 Jan 2020 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580170921;
        bh=1wwJQ6IpTy041XpfEWly60Mf5Uae34giZX3M68RLfls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IFT5tagljOBGBjyQJmRbszy3jGg75lg7lkYcsrH9eu2F9Kf5ibiLvjEJbYrg8u4bD
         KeTFUq0uTqsBHCzW2ydXgDmSOQF4EZYMmIShkiIw5ZSGfXKFlEWy3wYr+RFr+Y6k6n
         fQ23OTgOd9OEHuYIQmIWujQqLV8VEfpASz47aTIs=
Received: by mail-qk1-f180.google.com with SMTP id x1so11606156qkl.12;
        Mon, 27 Jan 2020 16:22:01 -0800 (PST)
X-Gm-Message-State: APjAAAU7Lp6pOrKfijsIGMIVSNY+Vvooixp16gAeJ69qNpf9AuJQvJ/X
        3ikD3apeBj6jCwGykEmjv1InHmMtqCi7rdMSHA==
X-Google-Smtp-Source: APXvYqwvJYQhT33Rhe7Gc9N3CMiNs9SVC27gww3ieP+79xvo95sTSZ4prtS73fv+XTHI0RIT3dSMXhDM09QHGvgfDY4=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr19922325qkn.254.1580170920875;
 Mon, 27 Jan 2020 16:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
 <20200108140333.GA12276@bogus> <3b94b423-ca26-b96f-90fa-2662dbc523d8@linaro.org>
 <CAL_JsqK8gu-Ts_aMpcXgtvqW=gWGLTrUvNWDm+8fB7--62FmnQ@mail.gmail.com> <5b82ab42-7804-a726-2d42-a63e83626666@linaro.org>
In-Reply-To: <5b82ab42-7804-a726-2d42-a63e83626666@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Jan 2020 18:21:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+cY+L2ty40S0O=jNexzNf9Mpr0nKa85w6JmLBOt6HEgg@mail.gmail.com>
Message-ID: <CAL_Jsq+cY+L2ty40S0O=jNexzNf9Mpr0nKa85w6JmLBOt6HEgg@mail.gmail.com>
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

On Mon, Jan 13, 2020 at 11:52 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/01/2020 17:16, Rob Herring wrote:
> > On Sat, Jan 11, 2020 at 11:32 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Hi Rob,
> >>
> >>
> >> On Wed, 8 Jan 2020 at 15:03, Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> On Thu, Dec 19, 2019 at 11:19:27PM +0100, Daniel Lezcano wrote:
> >>>> Add DT documentation to add an idle state as a cooling device. The CPU
> >>>> is actually the cooling device but the definition is already used by
> >>>> frequency capping. As we need to make cpufreq capping and idle
> >>>> injection to co-exist together on the system in order to mitigate at
> >>>> different trip points, the CPU can not be used as the cooling device
> >>>> for idle injection. The idle state can be seen as an hardware feature
> >>>> and therefore as a component for the passive mitigation.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/arm/idle-states.txt | 11 +++++++++++
> >>>>  1 file changed, 11 insertions(+)
> >>>
> >>> This is now a schema in my tree. Can you rebase on that and I'll pick up
> >>> the binding change.
> >>
> >> Mmh, I'm now having some doubts about this binding because it will
> >> restrict any improvement of the cooling device for the future.
> >>
> >> It looks like adding a node to the CPU for the cooling device is more
> >> adequate.
> >> eg:
> >> CPU0: cpu@300 {
> >>    device_type = "cpu";
> >>    compatible = "arm,cortex-a9";
> >>    reg = <0x300>;
> >>    /* cpufreq controls */
> >>    operating-points = <998400 0
> >>           800000 0
> >>           400000 0
> >>           200000 0>;
> >>    clocks = <&prcmu_clk PRCMU_ARMSS>;
> >>    clock-names = "cpu";
> >>    clock-latency = <20000>;
> >>    #cooling-cells = <2>;
> >>    thermal-idle {
> >>       #cooling-cells = <2>;
> >>    };
> >> };
> >>
> >> [ ... ]
> >>
> >> cooling-device = <&{/cpus/cpu@300/thermal-idle}
> >>                         THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >>
> >> A quick test with different configurations combination shows it is much
> >> more flexible and it is open for future changes.
> >>
> >> What do you think?
> >
> > Why do you need #cooling-cells in both cpu node and a child node?
>
> The cooling-cells in the CPU node is for the cpufreq cooling device and
> the one in the thermal-idle is for the idle cooling device. The first
> one is for backward compatibility. If no cpufreq cooling device exists
> then the first cooling-cells is not needed. May be we can define
> "thermal-dvfs" at the same time, so we do the change for both and
> prevent mixing the old and new bindings?
>
> > It's really only 1 device.
>
> The main problem is how the thermal framework is designed. When we
> register a cooling device we pass the node pointer and the core
> framework checks it has a #cooling-cells. Then cooling-maps must have a
> phandle to the node we registered before as a cooling device. This is
> when the thermal-zone <-> cooling device association is done.
>
> With the cpufreq cooling device, the "CPU slot" is now used and we can't
> point to it without ambiguity as we can have different cooling device
> strategies for the same CPU at different temperatures.

So why can't you have:

cooling-device = <&cpu0 DVFS>;

cooling-device = <&cpu0 IDLE>;

(any additional cells omitted for simplicity)

>
> Is it acceptable the following?
>
> CPU0: cpu@300 {
>    [ ... ]
>    thermal-idle {
>       #cooling-cells = <2>;
>    };
>
>    thermal-dvfs {
>       #cooling-cells = <2>;
>    }
> };
>
> Or alternatively, can we define a passive-cooling node?
>
> thermal-cooling: passive0 {
>    #cooling-cells = <2>;
>    strategy="dvfs" | "idle"
>    cooling-device=<&CPU0>
> };
>
> cooling-device = <&passive0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>
> > Maybe you could add another cell to contain an idle state node if that
> helps?
>
> (Assuming you are referring to a phandle to an idle state) The idle
> states are grouped per cluster because the CPUs belonging to the same
> cluster have the same idle states characteristics. Because of that, the
> phandle will point to the same node and it will be impossible to specify
> a per cpu cooling device, only per cluster.

What I meant was a phandle in the cooling cells, so #cooling-cells == 3:

cooling-device = <&cpu0 0 0 &cpu_idle_state>, <&cpu1 0 0 &cpu_idle_state>;

Phandle args being a phandle is a bit unusual, but certainly possible.

Rob
