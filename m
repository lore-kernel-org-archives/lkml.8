Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F77C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AEE2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588322923;
	bh=s7p+LO9j4KJ1A6bMFQW3AQzimPpkK8R+GwfnVNdaQkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kec+162bvfaOt3NUoe7rdyHxj5vCw/XXJDvFupOoiN9GlPKPCUMV6uCHmkMfnRYk5
	 uIl9Iu5j/Bp1qrQc4KaDxPpugSgrZvxGqeJiERk+7xHlOcnWqCh8k/5Zi/b+zyBB/O
	 QLEG1+OA9BryWUJNjzqdzYDbu7OKuY7YmerUbXU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEAIsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 04:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgEAIsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:48:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7045F2076D;
        Fri,  1 May 2020 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588322921;
        bh=s7p+LO9j4KJ1A6bMFQW3AQzimPpkK8R+GwfnVNdaQkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=plJY6EY6KB+Vql7RUWNO7v7+xm2zjEou5hyAnf8hjJXT98CITB5cSA/1xawapxM+e
         C1wShILufb+Qq15zsrXekbvMBlgB4htIJgg/5x8wkHZJho0CiPcInbuCOMgwt1ggcE
         OpDPe0de5jTQuoEqxsiEZycQTpFVSV3E2xvNXRkU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jURLb-008IE5-TD; Fri, 01 May 2020 09:48:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 May 2020 09:48:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper
 macros
In-Reply-To: <CAGETcx_d0aM+MdeOFDaXDnTEs85rVY=H7zvhZf7NNB4w-t_CGg@mail.gmail.com>
References: <20200411045918.179455-1-saravanak@google.com>
 <86sghas7so.wl-maz@kernel.org>
 <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
 <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
 <20200429102832.4eee22b4@why>
 <CAGETcx_d0aM+MdeOFDaXDnTEs85rVY=H7zvhZf7NNB4w-t_CGg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <5b605bd46d3ef213c7ec82d02967e4bb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, john.stultz@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-29 20:04, Saravana Kannan wrote:
> On Wed, Apr 29, 2020 at 2:28 AM Marc Zyngier <maz@kernel.org> wrote:

[...]

>> One thing though: this seems to be exclusively DT driven. Have you
>> looked into how that would look like for other firmware types such as
>> ACPI?
> 
> I'm not very familiar with ACPI at all. I've just started to learn
> about how it works in the past few months poking at code when I have
> some time. So I haven't tried to get this to work with ACPI nor do I
> think I'll be able to do that anytime in the near future. I hope that
> doesn't block this from being used for DT based platforms.

As long as you don't try to modularise a driver that does both DT and
ACPI, you'll be safe. I'm also actively trying to discourage people
from inventing custom irqchips on ACPI platforms (the spec almost
forbids them, but not quite).

>> Another thing is the handling of dependencies. Statically built
>> irqchips are initialized in the right order based on the topology
>> described in DT, and are initialized early enough that client devices
>> will find their irqchip This doesn't work here, obviously.
> 
> Yeah, I read that code thoroughly :)
> 
>> How do you
>> propose we handle these dependencies, both between irqchip drivers and
>> client drivers?
> 
> For client drivers, we don't need to do anything. The IRQ apis seem to
> already handle -EPROBE_DEFER correctly in this case.
> 
> For irqchip drivers, the easy answer can be: Load the IRQ modules
> early if you make them modules.

Uhuh. I'm afraid that's not a practical solution. We need to offer the
same behaviour for both and not rely on the user to understand the
topology of the SoC.

> But in my case, I've been testing this with fw_devlink=on. The TL;DR
> of "fw_devlink=on" in this context is that the IRQ devices will get
> device links created based on "interrupt-parent" property. So, with
> the magic of device links, these IRQ devices will probe in the right
> topological order without any wasted deferred probe attempts. For
> cases without fw_devlink=on, I think I can improve
> platform_irqchip_probe() in my patch to check if the parent device has
> probed and defer if it hasn't.

Seems like an interesting option. Two things then:

- Can we enforce the use of fw_devlink for modularized irqchips?
- For those irqchips that can be modularized, it is apparent that they
   should have been written as platform devices the first place. Maybe
   we should just do that (long term, though).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
