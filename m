Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13939C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC73420738
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cRTjp+t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgH2HsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgH2HsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:48:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD65C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YAahagjuFW3GJ48qjAgqdEDaO/Mu7SdJDTxXCJMml4g=; b=cRTjp+t541APFVTGgDNVgd0rNL
        0xXIuXF75g2A4qUHrkn9XsNzTWho5xZz7KxHWSdxs+lEadmBDRJgnwp5BvedTpdbm8p/YhHwD5u8S
        VepPalCkS94U3q+xmbZYWdh7bFgDfMfbAn+4gYkeNZN/b6EKVxKKukoeJypaWmc5axcpt09osqQqe
        lJWtbF9a50reYLkEcJpjp3nF22cNCRM+JLJ05ilVToKJ9QouHrRUX8SDa7M6gkNjJ0bZGaNFBBBwk
        trhkXpwirLM4g4IXdRoDNLixtGeyHXkfoSDJ/P8x7Jr0PGxc2Vj2KawGVIEULpNdgFO375yOV9V7j
        Lm2gDKSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBva8-00038N-Th; Sat, 29 Aug 2020 07:47:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C973D3011F0;
        Sat, 29 Aug 2020 09:47:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A39DC22B8F14A; Sat, 29 Aug 2020 09:47:19 +0200 (CEST)
Date:   Sat, 29 Aug 2020 09:47:19 +0200
From:   peterz@infradead.org
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:02:25PM -0400, Vineeth Pillai wrote:
> On 8/28/20 4:51 PM, Peter Zijlstra wrote:

> > So where do things go side-ways?

> During hotplug stress test, we have noticed that while a sibling is in
> pick_next_task, another sibling can go offline or come online. What
> we have observed is smt_mask get updated underneath us even if
> we hold the lock. From reading the code, looks like we don't hold the
> rq lock when the mask is updated. This extra logic was to take care of that.

Sure, the mask is updated async, but _where_ is the actual problem with
that?

On Fri, Aug 28, 2020 at 06:23:55PM -0400, Joel Fernandes wrote:
> Thanks Vineeth. Peter, also the "v6+" series (which were some addons on v6)
> detail the individual hotplug changes squashed into this patch:
> https://lore.kernel.org/lkml/20200815031908.1015049-9-joel@joelfernandes.org/
> https://lore.kernel.org/lkml/20200815031908.1015049-11-joel@joelfernandes.org/

That one looks fishy, the pick is core wide, making that pick_seq per rq
just doesn't make sense.

> https://lore.kernel.org/lkml/20200815031908.1015049-12-joel@joelfernandes.org/

This one reads like tinkering, there is no description of the actual
problem just some code that makes a symptom go away.

Sure, on hotplug the smt mask can change, but only for a CPU that isn't
actually scheduling, so who cares.

/me re-reads the hotplug code...

..ooOO is the problem that we clear the cpumasks on take_cpu_down()
instead of play_dead() ?! That should be fixable.

> https://lore.kernel.org/lkml/20200815031908.1015049-13-joel@joelfernandes.org/

This is the only one that makes some sense, it makes rq->core consistent
over hotplug.

> Agreed we can split the patches for the next series, however for final
> upstream merge, I suggest we fix hotplug issues in this patch itself so that
> we don't break bisectability.

Meh, who sodding cares about hotplug :-). Also you can 'fix' such things
by making sure you can't actually enable core-sched until after
everything is in place.


