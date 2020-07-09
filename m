Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB534C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EFA20720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594305176;
	bh=K7UORDDUXzxbxn41jMUoemMN3Ilh3g8bULl90Q1T5CM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qzIv+i8B7bnL3TsHtGsb98R3XH2h0gJlqQjDJHVK7pNpHazM+k8YaNHNqu/k0leTt
	 RFxk07xPrA+7hii1HtiW6ymH0OOWQcJSOIeW2Jr5ZO0jdY3/3ZyNy4vuV85RNf073u
	 pa9S0H7ma6Rhu0mgLwpxiFJzWDNcsnD82a6kY24E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGIOcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:32:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C06E206C3;
        Thu,  9 Jul 2020 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594305174;
        bh=K7UORDDUXzxbxn41jMUoemMN3Ilh3g8bULl90Q1T5CM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u/mI4BYDWSxtKEWTTDNdS1lX1Fnu4EfgXfnSrgXoFpzWHsg4NrFrtHkAjGWxM7MIQ
         bH+i73O4aTDQYpigzwBWogKU2TDjAMmZmGLFtF+cJrw3vhOIBkaqLWCYjoIu8zs5gB
         RDDUFlaKegg+6wb77MPdtgQinMeMZNR3LreMEgVs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4360C3522B7F; Thu,  9 Jul 2020 07:32:54 -0700 (PDT)
Date:   Thu, 9 Jul 2020 07:32:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel/smp: Fix an off by one in csd_lock_wait_toolong()
Message-ID: <20200709143254.GX9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709104818.GC20875@mwanda>
 <20200709105906.GR597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709105906.GR597537@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:59:06PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 09, 2020 at 01:48:18PM +0300, Dan Carpenter wrote:
> > The __per_cpu_offset[] array has "nr_cpu_ids" elements so change the >
> > >= to prevent a read one element beyond the end of the array.
> > 
> > Fixes: 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")

Good catch, will apply, thank you!

> I don't have a copy of that patch in my inbox, even though it says Cc:
> me.

I wasn't going to bother you with it until a bit after v5.9-rc1.
But it appears that this don't-bother-you strategy failed.

> Paul, where do you expect that patch to go? The version I see from my
> next tree needs a _lot_ of work.

I expect it to go nowhere until at least the v5.10 merge window.

							Thanx, Paul

> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  kernel/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 78b602cae6c2..f49966713ac3 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -171,7 +171,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
> >  		*bug_id = atomic_inc_return(&csd_bug_count);
> >  	cpu = csd_lock_wait_getcpu(csd);
> >  	smp_mb(); // No stale cur_csd values!
> > -	if (WARN_ONCE(cpu < 0 || cpu > nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> > +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> >  		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
> >  	else
> >  		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
> > -- 
> > 2.27.0
> > 
