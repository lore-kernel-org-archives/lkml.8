Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE0B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590578900;
	bh=stCGAA1ed0nu7Y5QVUWfc3X+iqcwiKMoONgp2zgDIbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pfw8OuJgyszNvp8M+nNS96V9BOCMbQPR90GEjJT0o83OT4hD79DifjWRIdtbdpmEK
	 pxM9tiVWlSyXBHny2Mnccv/7qvwSUQodUq6gI6x5yb8nCHEeREXu2VdDBrQP+fJorR
	 NM50WVhuIb0aQTHirvspIwvSm2pW9pG8uc0dst8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgE0L2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgE0L2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:28:18 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33010206DF;
        Wed, 27 May 2020 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590578898;
        bh=stCGAA1ed0nu7Y5QVUWfc3X+iqcwiKMoONgp2zgDIbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Tj86PypBDcNx+ibeq2mRILawkLPq+Jts2feIamq+JYrVliEJYfWQnSaavr3Me3C4
         JOiVlxqU6BnbW1pYwjZ428nTA33A2jSAqKWFZksdF292Bo/15IvRY9wARdpko2m+HY
         RmBm57bXLiTe45wmPSk0c8KgoWadFKdQEl9wOR7E=
Date:   Wed, 27 May 2020 13:28:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC][PATCH 1/7] sched: Fix smp_call_function_single_async()
 usage for ILB
Message-ID: <20200527112815.GB8942@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.778543557@infradead.org>
 <CAKfTPtA6t5=Gc6cWR3iS9QL+Vy=jhUkP345V9q2xqyhHx=rGNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA6t5=Gc6cWR3iS9QL+Vy=jhUkP345V9q2xqyhHx=rGNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:23:23PM +0200, Vincent Guittot wrote:
> > -static void nohz_csd_func(void *info)
> > -{
> > -       struct rq *rq = info;
> > +       flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
> 
> Why can't this be done in nohz_idle_balance() instead ?
> 
> you are not using flags in nohz_csd_func() and SCHED_SOFTIRQ which
> calls nohz_idle_balance(), happens after nohz_csd_func(), isn't it ?
> 
> In this case, you don't have to use the intermediate variable
> this_rq->nohz_idle_balance

That's in fact to fix the original issue. The softirq was clearing
the nohz_flags but the softirq could be issued from two sources:
the tick and the IPI. And the tick source softirq could then clear
the flags set from the IPI sender before the IPI itself, resulting
in races such as described there: https://lore.kernel.org/lkml/20200521004035.GA15455@lenoir/

Thanks.
