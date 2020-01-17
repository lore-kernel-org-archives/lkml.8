Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2055C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F4020684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OgEpF7a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAQOzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:55:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7zwwz+4wo1PNFwWKmp+ufp43NtNubm/NKjA95ifXVlQ=; b=OgEpF7a/jjp2RTq8C8AAVnfZS
        Tmvovj94SbG0K/2Wrla/d7NgHkPl4ZJOo2+vM3DqZvl4akfN2BTyG4QL14mq2NC9SEt/H/W469UKZ
        wgjNldxUStW0ejemU6aUHubBY848wTI+H/7WRP55tURybaKpdWvsH7mmQwEWDTudh1Y608M9zWVR4
        kh7me8dpa8KGtanYKKrqU21YrFD4rxgJ3VK5SLzetkJSW3lDQBMlqNo1v9gXl4hzfPZ2PQ/q3Fwdz
        JUU+o6H0kg1ZhIszm3YHagdclKuIANQy8b7Ar9cwqHPkCdrYQ2Y8AdCWMv9N7CT9Hx42yeL53qIiH
        zGSgANIaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isT2J-0000gl-7L; Fri, 17 Jan 2020 14:55:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFBB3300F4B;
        Fri, 17 Jan 2020 15:54:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 065B32020D8FC; Fri, 17 Jan 2020 15:55:45 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:55:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20200117145544.GE14879@hirez.programming.kicks-ass.net>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
 <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
> On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:

> >
> > That there indentation trainwreck is a reason to rename the function.
> >
> >         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> >                   update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
> >                   update_irq_load_avg(rq, 0);
> >
> > Is much better.
> >
> > But now that you made me look at that, I noticed it's using a different
> > clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
> > in sync with the other averages.
> >
> > Is there a good reason for that?
> 
> We don't need to apply frequency and cpu capacity invariance on the
> thermal capping signal which is  what rq_clock_pelt does

Hmm, I suppose that is true, and that really could've done with a
comment. Now clock_pelt is sort-of in sync with clock_task, but won't it
still give weird artifacts by having it on a slightly different basis?

Anyway, looking at this, would it make sense to remove the @now argument
from update_*_load_avg()? All those functions already take @rq, and
rq_clock_*() are fairly trivial inlines.
