Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F656C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21152075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pjjGmhj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgELKSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:18:32 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51672 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgELKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:18:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589278710; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=XpSWmPr/qK4eBW8Zmfv7U30yMO2iaRYmM9x7v044+fU=; b=pjjGmhj8Krl8PXbUBwDRbZl/mOWgnd0pnI95aPNJ2nwAv4s8Jmp47EeXE8Yokyhbn9bRc3jp
 nUn4V52Mox3mrn+EvFLbpLQ/Q++GlesQ0k3iOiQC1BT578BEhmehxs58Sd8iPhFkq7A2XBFN
 kWuwCN7xY5rXbnz+mYYtlE9aNro=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba77e6.7f619c578308-smtp-out-n04;
 Tue, 12 May 2020 10:18:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F909C433F2; Tue, 12 May 2020 10:18:14 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A176C433CB;
        Tue, 12 May 2020 10:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A176C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 12 May 2020 15:48:05 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        ouwen210@hotmail.com
Subject: Re: [PATCH] sched/fair: enqueue_task_fair optimization
Message-ID: <20200512101805.GB31725@codeaurora.org>
References: <20200511192301.1009-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511192301.1009-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:23:01PM +0200, Vincent Guittot wrote:
> enqueue_task_fair() jumps to enqueue_throttle when cfs_rq_of(se) is
> throttled, which means that se can't be NULL and we can skip the test.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4b73518aa25c..910bbbe50365 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5512,7 +5512,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                         list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  
> -enqueue_throttle:
>  	if (!se) {
>  		add_nr_running(rq, 1);
>  		/*
> @@ -5534,6 +5533,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>  	}
>  
> +enqueue_throttle:
>  	if (cfs_bandwidth_used()) {
>  		/*
>  		 * When bandwidth control is enabled; the cfs_rq_throttled()

Right, se can't be NULL when we break upon throttling. Looks good to me.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
