Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0147C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6592137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588238007;
	bh=JNYY/lIhM+KmdtUid3oVijBTFJzmnGX8VYYWh0ljOVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fz5mRv4N0fid0Fs4lolXo5Poop4O/V3VMpvBcE0Frkjy6q0CuYcQVgnMciiIWZLWc
	 sXBXVD3L+JE8bPWUiQaOo/lVE7kGWvWC46LXI0LyqYuQ+xeUqKzRYx2Tnn7OPpdLky
	 6psAVamCc1I+ytGwdBV/WuqdcU9vbVrgGqGNy4as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD3JN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgD3JN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:13:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6447E2082E;
        Thu, 30 Apr 2020 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588238005;
        bh=JNYY/lIhM+KmdtUid3oVijBTFJzmnGX8VYYWh0ljOVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=amam8/YRxVFOJY0P8cbDGOng2efgsO4eZKRsGMKz1P1/NT9yf/O8TivOn/9sMmHx5
         wUCMkApwmRepMAyqdrzEuaRIDxKqEMl3Rk3vHoTxrEpjk1gIbdIuUtnTGLbW0iIRJE
         hsQRCHqD3dsrNODE12FNE6mysH5j7dnRabx6Tw64=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jU5Fz-007yZV-OB; Thu, 30 Apr 2020 10:13:23 +0100
Date:   Thu, 30 Apr 2020 10:13:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, julien.thierry.kdev@gmail.com
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
Message-ID: <20200430101322.420e4052@why>
In-Reply-To: <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
        <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
        <20200425112950.3a4815b6@why>
        <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
        <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
        <ac57cb4bbb6507ee98f199d68a514503@kernel.org>
        <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, daniel.thompson@linaro.org, jason@lakedaemon.net, catalin.marinas@arm.com, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, tglx@linutronix.de, will@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 12:50:28 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> Hi Marc,
> 
> On Wed, 29 Apr 2020 at 13:53, Marc Zyngier <maz@kernel.org> wrote:

[...]

> > What I would like is for the arch code to request these interrupts as
> > normal interrupts, for which there is one problem to solve: how do you
> > find out about the Linux IRQ number for a given IPI. Or rather, how
> > do you get rid of the requirement to have IPI numbers at all and just
> > say "give me a per-cpu interrupt that I can use as an IPI, and by the
> > way here's the handler you can call".  
> 
> I think what you are looking for here is something that could be
> sufficed via enabling "CONFIG_GENERIC_IRQ_IPI" framework for arm64/arm
> architectures. It's currently used for mips architecture. Looking at
> its implementation, I think it should be possible to hook up SGIs
> under new IPI irq_domain for GICv2/v3.
> 
> So with this framework we should be able to dynamically allocate IPIs
> and use common APIs such as request_irq()/request_nmi() to tell IPI
> specific handlers.
> 
> If this approach looks sane to you then I can start working on a PoC
> implementation for arm64.

I can't say I'm keen. This IPI framework doesn't really work for the
GIC:

- it requires a separate irqdomain to be able to guarantee that you
  allocate the hwirq in the SGI range. What is the point?
- it creates yet another level of indirection on IPI injection

This framework was created to deal with two cases:
- systems that can't represent their IPI with a single hwirq spanning
  all the CPUs
- "accelerator cores" that don't run Linux

The GIC architecture avoids the first point, and I don't even want to
think of the second one.

Also, it doesn't solve the initial problem, which is to bootstrap the
whole thing. The IPI framework relies on an irqdomain to be created the
first place. This would mean teaching the arch code about the
intricacies of irqdomains, FW nodes and other terrible things. All
things which are better hidden in the GIC drivers (not to mention the
other horror stories that are the RPi-2/3 irqchip and the Huawei GIC
knock-off).

What I have in mind is to replace the set_smp_cross_call() with
something that passes the required set of information (interrupt range,
at the very least). The only thing that I plan to reuse from the IPI
framework is the chip->ipi_send_mask() callback.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
