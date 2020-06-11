Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84994C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563AC2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e/gtYKTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFKO2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFKO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:28:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=veEoCUcIkaZEO/Qd1GN5y9WKpi7LCLgfeW+AZ30hNVY=; b=e/gtYKTOShBi8mkaJqoOURjwWJ
        XTpY03rSSHDfAFJDIr1YIAjHBh7FFYyKkhMdFQKdE8zoVMy6mEP3IrA0cf6OfR5Ru+wppavDi86ah
        lSmOo+tu4Lv97x7gYuFsIdFIScJDLhaztevDi6GOHrHHQ6KyEcQVvuQGOj0bMD3behSSZ6nRxhrqV
        mejQvXqSeOD+dtGGMtAo1m0TyniM8kJ1WyfvScQ3aVx5DBJAKdvSwSxBejcNDiaF3clQS2TRVtI8A
        HJoXxsNrX0A2Y9qgRLEe/M2rrFMIvUMbwn3+ECuszRtsayE9GtXeaVxxuOWQzBU8h14zMYN/9TqAQ
        IihkAxJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjOBc-0002L0-1b; Thu, 11 Jun 2020 14:28:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D035301A7A;
        Thu, 11 Jun 2020 16:28:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B9F0220F9FA4; Thu, 11 Jun 2020 16:28:06 +0200 (CEST)
Date:   Thu, 11 Jun 2020 16:28:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, iwtbavbm@gmail.com
Subject: Re: [PATCH v2] sched/fair: fix nohz next idle balance
Message-ID: <20200611142806.GJ2531@hirez.programming.kicks-ass.net>
References: <20200609123748.18636-1-vincent.guittot@linaro.org>
 <jhjpna53d50.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjpna53d50.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:12:11PM +0100, Valentin Schneider wrote:
> 
> On 09/06/20 13:37, Vincent Guittot wrote:
> > With commit:
> >   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> > rebalance_domains of the local cfs_rq happens before others idle cpus have
> > updated nohz.next_balance and its value is overwritten.
> >
> > Move the update of nohz.next_balance for other idles cpus before balancing
> > and updating the next_balance of local cfs_rq.
> >
> > Also, the nohz.next_balance is now updated only if all idle cpus got a
> > chance to rebalance their domains and the idle balance has not been aborted
> > because of new activities on the CPU. In case of need_resched, the idle
> > load balance will be kick the next jiffie in order to address remaining
> > ilb.
> >
> > Reported-by: Peng Liu <iwtbavbm@gmail.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> FWIW:
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> Do we want a Fixes: tag for this? I'm thinking
> b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")

Done, thanks!
