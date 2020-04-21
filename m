Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D87C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111E62071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479307;
	bh=Xr2aHCVPREjxYqnUK45weJ1M8pScDICNbeHtjVJ7HW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PSJuPUo+ymt9lfoBZSANbwI0V9fOXQMD9XDiDL/UfCRxSTV5FYEFSIo+ZOGkkhjjb
	 ueWSV1YJOqOGtZxWNQkYE5NAeP7uF7kXTy7+eI084BlByT3qwe8vCUeWs8wuMGzt+e
	 99mSMFjCyqOYGGubt0WF7BQcIIwiJeIrFUPrxyFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDUO20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUO2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:28:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE732070B;
        Tue, 21 Apr 2020 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479305;
        bh=Xr2aHCVPREjxYqnUK45weJ1M8pScDICNbeHtjVJ7HW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Rks/Hcb8IQM75c8pfMxGWS5IZRVIKSpGk1wjdcLlVh3LTzjhpoATd1EmkhNx42Tr
         7f3QJe2RuJRnD1RXTtH91re/zBQI/ujoZhqdQJnN+vK5xSqou1IxWGrSGi8SWu13qM
         0m8a0DZmkN1cNv4UYDoWU1v//pyd9oIf1v4RsBlo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jQtst-005DDg-DF; Tue, 21 Apr 2020 15:28:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Apr 2020 15:28:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
In-Reply-To: <20200421142243.lea26mnmxnjpynlf@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
 <jhjv9ltkmel.mognet@arm.com> <dda160a8d78b44dbc310759502a49afc@kernel.org>
 <20200421142243.lea26mnmxnjpynlf@e107158-lin.cambridge.arm.com>
Message-ID: <1c21b8e7b08e6db7fb97dc46d1246d9a@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qais.yousef@arm.com, valentin.schneider@arm.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, akpm@linux-foundation.org, tglx@linutronix.de, yury.norov@gmail.com, pjt@google.com, adobriyan@gmail.com, joshdon@google.com, pkondeti@codeaurora.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-21 15:22, Qais Yousef wrote:
> On 04/21/20 15:09, Marc Zyngier wrote:
>> On 2020-04-21 14:18, Valentin Schneider wrote:
>> > On 21/04/20 13:13, Qais Yousef wrote:
>> 
>> [...]
>> 
>> > > I CCed Marc who's the maintainer of this file who can clarify better
>> > > if this
>> > > really breaks anything.
>> > >
>> > > If any interrupt expects to be affined to a specific CPU then this
>> > > must be
>> > > described in DT/driver. I think the GIC controller is free to
>> > > distribute them
>> > > to any cpu otherwise if !force. Which is usually done by
>> > > irq_balancer anyway
>> > > in userspace, IIUC.
>> > >
>> > > I don't see how cpumask_any_and() break anything here too. I
>> > > actually think it
>> > > improves on things by better distribute the irqs on the system by
>> > > default.
>> 
>> That's a pretty bold statement. Unfortunately, it isn't universally 
>> true.
>> Some workload will be very happy with interrupts spread all over the 
>> map,
>> and some others will suffer from it because, well, it interrupts 
>> userspace.
>> 
>> > As you say, if someone wants smarter IRQ affinity they can do
>> > irq_balancer
>> > and whatnot. The default kernel policy for now has been to shove
>> > everything
>> > on the lowest-numbered CPU, and I see no valid reason to change that.
>> 
>> Exactly. I would like to keep the kernel policy as simple as possible 
>> for
>> non-managed interrupts (managed interrupts are another kettle of fish
>> entirely).
>> Userpace is in control to place things "intelligently", so let's not 
>> try and
>> make the kernel smarter than it strictly needs to be.
> 
> Fair enough. But why is it asking for cpumask_any() in the first place?

Implementation detail. Turn it into cpumask_first_and() if you want.

         M.
-- 
Jazz is not dead. It just smells funny...
