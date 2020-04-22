Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFCC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAFC21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587577542;
	bh=nEcJGhVrMRMwG+mEHh2HXvocEI715xDZ9gNYItXLhlk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RdzDaUXzsi4rq6kduUuuL2xFjn8zB8mfhIazFpEiAqvfhGqtfcZXuY7sT/n17/5AR
	 mLQ308BGVt+jdA033oXHm6XT61VYZ/+2zDVhh8DTX+heTGF3hO0vuyA4JHSMk+B6iH
	 4oT8kqQrr86m8OK/dAnJPPsBKE2u1qDVZUzqrsp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgDVRpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDVRpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:45:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F8B20882;
        Wed, 22 Apr 2020 17:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587577540;
        bh=nEcJGhVrMRMwG+mEHh2HXvocEI715xDZ9gNYItXLhlk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=duX+Jwrv+jgB/ZlRcb5UeOEIsPfkh/p2+NrQ76JCKEwPY4mu/wwRh8HzhxHbzG/p4
         1CZlx5IVVH2IHZMB8Pq04vK6oMCdLn8JmE8KenImalJ+nhTjP5I8mSZ73A0HUYrDpX
         wPqOytDMKxWHsFCZdhpAshcocOROe2ISMCUqwtBk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1F5E3520480; Wed, 22 Apr 2020 10:45:40 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:45:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH 01/23] sched: Provide sched_set_fifo()
Message-ID: <20200422174540.GB17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112831.266499893@infradead.org>
 <20200422131138.GL17661@paulmck-ThinkPad-P72>
 <20200422132648.GJ20730@hirez.programming.kicks-ass.net>
 <20200422155006.GR17661@paulmck-ThinkPad-P72>
 <20200422123331.30b00018@gandalf.local.home>
 <20200422164030.GA17661@paulmck-ThinkPad-P72>
 <20200422124651.6199790d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422124651.6199790d@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:46:51PM -0400, Steven Rostedt wrote:
> On Wed, 22 Apr 2020 09:40:30 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Not saying it is not insane, mind you!  ;-)
> 
> I sometimes wonder about your sanity ;-)

;-) ;-) ;-)

							Thanx, Paul
