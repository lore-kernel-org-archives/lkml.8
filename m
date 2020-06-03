Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2B6206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591179173;
	bh=dzxakD5Qs6xUHCcVDK8PS7kM6wuAZyUCmRV4IYykOeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oyUWXOgWjizZ4E/CLqO/YNlzUTqxRl1madYjlz1FCfAyspMO37MBSNkPmpodvUwe8
	 E1aZpNLYofP37A+lMJO3DON+uxIj9VkV0wyxv/R+QskhCQup+lm5x1N74TZYSir1u0
	 UbcWNsnQDbR82GTyMHcqFGpiOrhInbk/NrsWDg5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgFCKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgFCKMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:12:52 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6FCD2067B;
        Wed,  3 Jun 2020 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591179171;
        bh=dzxakD5Qs6xUHCcVDK8PS7kM6wuAZyUCmRV4IYykOeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=THY3g1j2rRmwdyve4LDrl/GACpfAvanR80oIBx8tI/5P09gf9Kzoe0W0vAhH4f4ha
         ZSRKxRDNHxbm/3ecaI9paMweJDZZY4Y/UTnzXH+v17Wx3pNsgX2bBjnppu88ApBwMq
         qRI2plDsO49X2FSpTyVhC23hFMJK+KmGbiI4AVQw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgQO9-00HPhH-PA; Wed, 03 Jun 2020 11:12:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jun 2020 11:12:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper
 macros
In-Reply-To: <CAGETcx9kYKOEAmLbJzmOucR2Z4qy9PCY2=UCYdYTJWTL=BeZNQ@mail.gmail.com>
References: <20200411045918.179455-1-saravanak@google.com>
 <86sghas7so.wl-maz@kernel.org>
 <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
 <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
 <20200429102832.4eee22b4@why>
 <CAGETcx_d0aM+MdeOFDaXDnTEs85rVY=H7zvhZf7NNB4w-t_CGg@mail.gmail.com>
 <5b605bd46d3ef213c7ec82d02967e4bb@kernel.org>
 <CAGETcx9kYKOEAmLbJzmOucR2Z4qy9PCY2=UCYdYTJWTL=BeZNQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d17908a4313ed0f5ccfa8265611738b2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, john.stultz@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 2020-05-01 21:23, Saravana Kannan wrote:
> On Fri, May 1, 2020 at 1:48 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-04-29 20:04, Saravana Kannan wrote:
>> > On Wed, Apr 29, 2020 at 2:28 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> [...]
>> 
>> >> One thing though: this seems to be exclusively DT driven. Have you
>> >> looked into how that would look like for other firmware types such as
>> >> ACPI?
>> >
>> > I'm not very familiar with ACPI at all. I've just started to learn
>> > about how it works in the past few months poking at code when I have
>> > some time. So I haven't tried to get this to work with ACPI nor do I
>> > think I'll be able to do that anytime in the near future. I hope that
>> > doesn't block this from being used for DT based platforms.
>> 
>> As long as you don't try to modularise a driver that does both DT and
>> ACPI, you'll be safe. I'm also actively trying to discourage people
>> from inventing custom irqchips on ACPI platforms (the spec almost
>> forbids them, but not quite).
>> 
>> >> Another thing is the handling of dependencies. Statically built
>> >> irqchips are initialized in the right order based on the topology
>> >> described in DT, and are initialized early enough that client devices
>> >> will find their irqchip This doesn't work here, obviously.
>> >
>> > Yeah, I read that code thoroughly :)
>> >
>> >> How do you
>> >> propose we handle these dependencies, both between irqchip drivers and
>> >> client drivers?
>> >
>> > For client drivers, we don't need to do anything. The IRQ apis seem to
>> > already handle -EPROBE_DEFER correctly in this case.
>> >
>> > For irqchip drivers, the easy answer can be: Load the IRQ modules
>> > early if you make them modules.
>> 
>> Uhuh. I'm afraid that's not a practical solution. We need to offer the
>> same behaviour for both and not rely on the user to understand the
>> topology of the SoC.
>> 
>> > But in my case, I've been testing this with fw_devlink=on. The TL;DR
>> > of "fw_devlink=on" in this context is that the IRQ devices will get
>> > device links created based on "interrupt-parent" property. So, with
>> > the magic of device links, these IRQ devices will probe in the right
>> > topological order without any wasted deferred probe attempts. For
>> > cases without fw_devlink=on, I think I can improve
>> > platform_irqchip_probe() in my patch to check if the parent device has
>> > probed and defer if it hasn't.
>> 
>> Seems like an interesting option. Two things then:
>> 
>> - Can we enforce the use of fw_devlink for modularized irqchips?
> 
> fw_devlink doesn't have any config and it's a command line option. So
> not sure how you can enforce that.

By having a config option that forces it on if that option is selected
by modular irqchips? More importantly, what is the drawback of having
fw_devlink on at all times? It definitely looks like the best thing
since sliced bread (with cheese), so what is the catch?

> 
>> - For those irqchips that can be modularized, it is apparent that they
>>    should have been written as platform devices the first place. Maybe
>>    we should just do that (long term, though).
> 
> I agree. If they can be platform devices, they should be. But when
> those platform device drivers are built in, you'll either need:
> 1) fw_devlink=on to enforce the topological init order

That would have my preference, provided that there is no drawbacks.

> Or
> 2) have a generic irqchip probe helper function that ensures that.
> My patch with some additional checks added to platform_irqchip_probe()
> can provide (2).
> 
> In the short term, my patch series also makes it easier to convert
> existing non-platform drivers into platform drivers.
> 
> So if I fix up platform_irqchip_probe() to also do -EPROBE_DEFER to
> enforce topology, will that make this patch acceptable?

That'd be a lot better. We also need some guards for things that
cannot be a driver (primary interrupt controllers don't have a struct
device).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
