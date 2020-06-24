Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98298C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7088A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="V5NJJ3ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390251AbgFXOTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:19:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15769 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388115AbgFXOTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:19:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593008340; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=A4b2D748cWipzvKRfVN086pFwlukr+c2oii9h7uumRw=; b=V5NJJ3exuQSLAlq9jNYovTxEauinXwnN9uzvFHZMtEVNMWK9UIz3ck57n4mXpPT7nTFxBKLb
 XO8XWflbtCcbypI3TMBNy7V6iSLX7toh3YtiC0Z+8Z4H4TzneYlGCuDwr9Cw+8lCU0qw0EC9
 K/8+Th5D+isF+VZZj/5FYM05eB8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ef360cb117610c7ff66da94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 14:18:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF198C433C6; Wed, 24 Jun 2020 14:18:50 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44B0CC433C8;
        Wed, 24 Jun 2020 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44B0CC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 24 Jun 2020 19:48:44 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Lei Wen <leiwen@marvell.com>
Subject: Re: Looping more in detach_tasks() when RT and CFS tasks are present
Message-ID: <20200624141844.GB25985@codeaurora.org>
References: <CAEU1=PkNtyznCms3jjp-oZHW=UAinnNKqG144VuzO5M7MLkO3Q@mail.gmail.com>
 <CAKfTPtCVF-pw0cjuivuirNpBHRXZNJLihhJtGgkuTi7VdFpWbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCVF-pw0cjuivuirNpBHRXZNJLihhJtGgkuTi7VdFpWbQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, Jun 24, 2020 at 02:39:25PM +0200, Vincent Guittot wrote:
> Hi Pavan,
> 
> On Wed, 24 Jun 2020 at 13:42, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
> >
> > Hi Vincent/Peter,
> >
> > in load_balance(), we derive env->loop_max based on rq->nr_running.
> > When the busiest rq has both RT and CFS tasks, we do more loops in
> > detach_tasks(). Is there any reason for not using
> > rq->cfs.h_nr_running?
> 
> Using cfs.h_nr_running seems fine for loop_max
> 

Thanks for taking a look.

> >
> > Lei Wen attempted to fix this before.
> > https://lore.kernel.org/lkml/1376814322-7320-2-git-send-email-leiwen@marvell.com/
> 
> The 1st part of the patch is wrong because even if h_nr_running == 1
> but nr_running > 1, we can pull the cfs thread without using active
> balance
> 

Right. When a RT and CFS tasks are packed, I have seen CFS task getting pulled
via load balancer without waking migration/X.

I was using the below patch along with some prints in detach_tasks() loop.
I will update Lei Wen's patch and resend it.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b..f042016 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9509,7 +9509,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * correctly treated as an imbalance.
 		 */
 		env.flags |= LBF_ALL_PINNED;
-		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
+		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->cfs.h_nr_running);
 
 more_balance:
 		rq_lock_irqsave(busiest, &rf);

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

