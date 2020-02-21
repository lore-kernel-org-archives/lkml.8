Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188CC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35E824682
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DjNFLJXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbgBUIQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:16:37 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43834 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387524AbgBUIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:16:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582272988; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=qRMVh44K5kD9tGiF9DY6h1ZTI5BeEuKfIvbo8KomdCQ=; b=DjNFLJXlPihNvj0Rv6r5ICQti5sZWUWS1nkqmY6MJiRKtTWCWpZulNUh/HsLHew8RFROYa1M
 325zUjPD8rsirJrZYgSTWItCfQSP0UTMYolusdQvroGI+39zbtdtRMRyochsY0so7IipBb6A
 5SNWMrQpvjDw3PE08iKMRGzjQOI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f91c0.7ff8cb8f4458-smtp-out-n02;
 Fri, 21 Feb 2020 08:16:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8AB7C4479F; Fri, 21 Feb 2020 08:15:59 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D1E7C433A2;
        Fri, 21 Feb 2020 08:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D1E7C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 21 Feb 2020 13:45:51 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/rt: fix pushing unfit tasks to a better CPU
Message-ID: <20200221081551.GG28029@codeaurora.org>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-4-qais.yousef@arm.com>
 <20200217092329.GC28029@codeaurora.org>
 <20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com>
 <20200219140243.wfljmupcrwm2jelo@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219140243.wfljmupcrwm2jelo@e107158-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:02:44PM +0000, Qais Yousef wrote:
> On 02/17/20 13:53, Qais Yousef wrote:
> > On 02/17/20 14:53, Pavan Kondeti wrote:
> > > I notice a case where tasks would migrate for no reason (happens without this
> > > patch also). Assuming BIG cores are busy with other RT tasks. Now this RT
> > > task can go to *any* little CPU. There is no bias towards its previous CPU.
> > > I don't know if it makes any difference but I see RT task placement is too
> > > keen on reducing the migrations unless it is absolutely needed.
> > 
> > In find_lowest_rq() there's a check if the task_cpu(p) is in the lowest_mask
> > and prefer it if it is.
> > 
> > But yeah I see it happening too
> > 
> > https://imgur.com/a/FYqLIko
> > 
> > Tasks on CPU 0 and 3 swap. Note that my tasks are periodic but the plots don't
> > show that.
> > 
> > I shouldn't have changed something to affect this bias. Do you think it's
> > something I introduced?
> > 
> > It's something maybe worth digging into though. I'll try to have a look.
> 
> FWIW, I dug a bit into this and I found out we have a thundering herd issue.
> 
> Since I just have a set of periodic task that all start together,
> select_task_rq_rt() ends up selecting the same fitting CPU for all of them
> (CPU1). The end up all waking up on CPU1, only to get pushed back out
> again with only one surviving.
> 
> This reshuffles the task placement ending with some tasks being swapped.
> 
> I don't think this problem is specific to my change and could happen without
> it.
> 
> The problem is caused by the way find_lowest_rq() selects a cpu in the mask
> 
> 1750                         best_cpu = cpumask_first_and(lowest_mask,
> 1751                                                      sched_domain_span(sd));
> 1752                         if (best_cpu < nr_cpu_ids) {
> 1753                                 rcu_read_unlock();
> 1754                                 return best_cpu;
> 1755                         }
> 
> It always returns the first CPU in the mask. Or the mask could only contain
> a single CPU too. The end result is that we most likely end up herding all the
> tasks that wake up simultaneously to the same CPU.
> 
> I'm not sure how to fix this problem yet.
> 

Yes, I have seen this problem too. This is not limited to RT even fair class
(find_energy_efficient_cpu path) also have the same issue. There is a window
where we select a CPU for the task and the task being queued there. Because of
this, we may select the same CPU for two successive waking tasks. Turning off
TTWU_QUEUE sched feature addresses this up to some extent. At least it would
solve the cases like multiple tasks getting woken up from an interrupt handler.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
