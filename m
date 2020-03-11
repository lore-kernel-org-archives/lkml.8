Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309BEC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CAF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CO6/GNd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgCKKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:54:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49331 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgCKKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:54:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583924049; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=NmT/A86crWcHVCwgwTmJ3cYXNLDKm0Jw38Fg/SociCc=; b=CO6/GNd/H6fyizyoixtv9CD7k8o3CsHH7g+WMwXeh/Fe2R2eL9Gs9zW1CHYVqnjd+5QeY7aF
 znbxnnywYuB6qeU7uNaaZelzskBud7ghEnnmJUOTRRJ0wLIFTDXTh+YNDB0qF4hdvnRfXjRW
 7eZX/j+O3F/Fq2n1MhDWvfkBpEM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e68c34f.7f2df93a09d0-smtp-out-n05;
 Wed, 11 Mar 2020 10:54:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1667C43637; Wed, 11 Mar 2020 10:54:05 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4C5FC433CB;
        Wed, 11 Mar 2020 10:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4C5FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 11 Mar 2020 16:23:58 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] sched/rt: Fix pushing unfit tasks to a better CPU
Message-ID: <20200311105358.GO28029@codeaurora.org>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-7-qais.yousef@arm.com>
 <20200306175112.vkpeouec2c47yujl@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306175112.vkpeouec2c47yujl@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 05:51:13PM +0000, Qais Yousef wrote:
> Hi Pavan
> 
> On 03/02/20 13:27, Qais Yousef wrote:
> > If a task was running on unfit CPU we could ignore migrating if the
> > priority level of the new fitting CPU is the *same* as the unfit one.
> > 
> > Add an extra check to select_task_rq_rt() to allow the push in case:
> > 
> > 	* p->prio == new_cpu.highest_priority
> > 	* task_fits(p, new_cpu)
> > 
> > Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> 
> Can you please confirm if you have any objection to this patch? Without it
> I see large delays in the 2 tasks test like I outlined in [1]. It wasn't clear
> from [2] whether you are in agreement now or not.
> 
> [1] https://lore.kernel.org/lkml/20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com/
> [2] https://lore.kernel.org/lkml/20200227033608.GN28029@codeaurora.org/
> 

I am not very sure about this. Like we discussed, this patch is addressing a
specific scenario i.e two equal prio tasks waking at the same time. We allow
the packing so that task_woken_rt() spread the tasks. The enqueue operation
is waste here.

At the same time, I can't think of a better alternative. Retrying
find_lowest_rq() may still give the same result until the previous task
is fully woken on the CPU.

btw, the commit description does not talk about the race at all. If there is
no race, we won't even end up in this scenario i.e find_lowest_rq() may simply
return -1.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
