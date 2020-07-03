Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87201C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FE20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593783741;
	bh=cToOqdlvOK3QskA5AoImVKSbV3a2bi08lfqB8HxpdMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RqfN304uhpNQh6U/b/7cZ8Dj7+StcaKb7tk5gVIMLjV+XY9wdQ3KkF5/w4ATzyM9m
	 udbwOCB7DeEndN6yRAlJXCXadYSLvW17CXqxXwrfd2a5LnIudiPqx07nEtALuxaUSC
	 I3STh+RjhnRGWyX2Y8Le8ea59u5Z6pcKHnQrAlnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGCNmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgGCNmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:42:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB3220772;
        Fri,  3 Jul 2020 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593783738;
        bh=cToOqdlvOK3QskA5AoImVKSbV3a2bi08lfqB8HxpdMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDtAwYk42WX3U3gEyhndSgHS6/8jDyy3KwJdpIPfKk8iZGKi9Kl9IXfPRU5L1FgIY
         nmi23K+QQUCyFl/1ufWiIVQ/JGpBULwvbJlxwDGAmelesoZYvQzeiRCefWQD13Gjjp
         le6UmPU/+gAzllcUi/0kRykshDoqyr2vo4Ei+yJU=
Date:   Fri, 3 Jul 2020 14:42:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     mark.rutland@arm.com, tuanphan@os.amperecomputing.com,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com, harb@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
Message-ID: <20200703134213.GE18953@willie-the-truck>
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
 <b7d056f7-3a3d-568d-ea6d-24bb30b4761b@arm.com>
 <20200624125045.GC6270@willie-the-truck>
 <dfa3fc60-dc6c-4ede-341e-24645e01b722@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa3fc60-dc6c-4ede-341e-24645e01b722@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:08:30PM +0100, Robin Murphy wrote:
> On 2020-06-24 13:50, Will Deacon wrote:
> > On Wed, Jun 24, 2020 at 12:48:14PM +0100, Robin Murphy wrote:
> > > On 2020-04-08 17:49, Robin Murphy wrote:
> > > > IRQF_SHARED is dangerous, since it allows other agents to retarget the
> > > > IRQ's affinity without migrating PMU contexts to match, breaking the way
> > > > in which perf manages mutual exclusion for accessing events. Although
> > > > this means it's not realistically possible to support PMU IRQs being
> > > > shared with other drivers, we *can* handle sharing between multiple PMU
> > > > instances with some explicit affinity bookkeeping and manual interrupt
> > > > multiplexing.
> > > > 
> > > > RCU helps us handle interrupts efficiently without having to worry about
> > > > fine-grained locking for relatively-theoretical race conditions with the
> > > > probe/remove/CPU hotplug slow paths. The resulting machinery ends up
> > > > looking largely generic, so it should be feasible to factor out with a
> > > > "system PMU" base class for similar multi-instance drivers.
> > > > 
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > > 
> > > > RFC because I don't have the means to test it, and if the general
> > > > approach passes muster then I'd want to tackle the aforementioned
> > > > factoring-out before merging anything anyway.
> > > 
> > > Any comments on whether it's worth pursuing this?
> > 
> > Sorry, I don't really get the problem that it's solving. Is there a crash
> > log somewhere I can look at? If all the users of the IRQ are managed by
> > this driver, why is IRQF_SHARED dangerous?
> 
> Because as-is, multiple PMU instances may make different choices about which
> CPU they associate with, change the shared IRQ affinity behind each others'
> backs, and break the "IRQ handler runs on event->cpu" assumption that perf
> core relies on for correctness. I'm not sure how likely it would be to
> actually crash rather than just lead to subtle nastiness, but wither way
> it's not good, and since people seem to be tempted to wire up system PMU
> instances this way we could do with a general approach for dealing with it.

Ok, thanks for the explanation. If we're just talking about multiple
instances of the same driver, why is it not sufficient to have a static
atomic_t initialised to -1 which tracks the current affinity and then just
CAS that during probe()? Hotplug notifiers can just check whether or not
it points to an online CPU

Will
