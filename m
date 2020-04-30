Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977FC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B05208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588268032;
	bh=7OyWguI2rc8GY3pA0j9peooBQlK7C47Glh0LtwePdIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LKcm89iQIP6Z1LAIRvVaG/u4gXEO8o6x+R9BzUZXV5RUi8ODKsAXYIx3B9JEhpNBb
	 3aJMznvGC62vfHpuBQPU93iCBn+YJokIyXEANwGwtBC9vo+tlhml7JPkNyjP4Lnyfr
	 M4FbM6RTyZmo1CxgaUKKuZFuRs6cvrKKIXjCcrBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD3Rdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD3Rdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:33:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5073420731;
        Thu, 30 Apr 2020 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588268030;
        bh=7OyWguI2rc8GY3pA0j9peooBQlK7C47Glh0LtwePdIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uZQ0OiesVFY93yX2EfPV0iDC0FtwkI9adRQbqtcv9aFNMXPHmIlaCF/kJGAX1TUIj
         AFklv3y61RLexW0fOo3TbXxWPuLsoNpc/HsHCj45LEZHK5ssnvfyHEVi/0oWa3vLk1
         KT29VYG7slez9Z2zJI4CTxEsaC9TugxUPaI135NM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jUD4G-0088DI-K4; Thu, 30 Apr 2020 18:33:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Apr 2020 18:33:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
In-Reply-To: <20200430161815.GE25258@willie-the-truck>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
 <20200430160436.GC13575@hirez.programming.kicks-ass.net>
 <20200430161815.GE25258@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <79ba3f5f9af951b2de52b8eb9e1bc25f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, peterz@infradead.org, leo.yan@linaro.org, mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, mike.leach@linaro.org, Al.Grant@arm.com, James.Clark@arm.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-30 17:18, Will Deacon wrote:
> On Thu, Apr 30, 2020 at 06:04:36PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 30, 2020 at 04:29:23PM +0100, Marc Zyngier wrote:
>> 
>> > I wonder if we could/should make __sched_clock_offset available even when
>> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK isn't defined. It feels like it would
>> > help with this particular can or worm...
>> 
>> Errrgh. __sched_clock_offset is only needed on x86 because we 
>> transition
>> from one clock device to another on boot. It really shouldn't exist on
>> anything sane.
> 
> I think we still transition from jiffies on arm64, because we don't 
> register
> with sched_clock until the timer driver probes. Marc, is that right?

Indeed. The clocksource is only available relatively late, as we need to
discover the details of the platform and enable the various workarounds
(because nobody can get a simple 64bit counter right). So it is only at
that stage that we transition to it.

         M.
-- 
Jazz is not dead. It just smells funny...
