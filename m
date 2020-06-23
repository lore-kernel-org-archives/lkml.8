Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3C1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BE6206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O1nSICvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgFWGVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:21:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24907 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730406AbgFWGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:21:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592893314; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5ZAFSKQuOxtflxXUrt8WGXtwebbL5g0a4E24JJ4kqw8=; b=O1nSICvstKHhWb8qi8tYy4wP7Q5uYlzyWZUslwoisC9XzgzS45VPt2zx29bf3fToyxC4Ti4W
 D36uStuVYoR03bF2C8o6tJlt4x7qr3L4VIIHka3YaW25t2OJtegxPb/HT6sQFEZP5EP9An/i
 JcBWdhY8TLqTlJNgoYepAA83eUQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ef19f81bfb34e631ca52f12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 06:21:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6900C43395; Tue, 23 Jun 2020 06:21:52 +0000 (UTC)
Received: from [192.168.0.100] (unknown [124.123.165.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4CADC433C6;
        Tue, 23 Jun 2020 06:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4CADC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1592849223-17774-1-git-send-email-neeraju@codeaurora.org>
 <20200622231829.GV9247@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <b30ee288-7a84-1ecd-b2dd-776f810b9ddc@codeaurora.org>
Date:   Tue, 23 Jun 2020 11:51:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622231829.GV9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 6/23/2020 4:48 AM, Paul E. McKenney wrote:
> On Mon, Jun 22, 2020 at 11:37:03PM +0530, Neeraj Upadhyay wrote:
>> Remove CONFIG_PREMPT_RCU check in force_qs_rnp(). Originally,
>> this check was required to skip executing fqs failsafe
>> for rcu-sched, which was added in commit a77da14ce9af ("rcu:
>> Yet another fix for preemption and CPU hotplug"). However,
>> this failsafe has been removed, since then. So, cleanup the
>> code to avoid any confusion around the need for boosting,
>> for !CONFIG_PREMPT_RCU.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> Good point, there is a !PREEMPT definition of the function
> rcu_preempt_blocked_readers_cgp() that unconditionally returns zero.
> And if !PREEMPT kernels, the same things happens in the "if"
> body as after it, so behavior is not changed.
> 
> I have queued and pushed this with an upgraded commit log as
> shown below.
> 
> 						Thanx, Paul
> 

Thanks! patch looks good to me!

Thanks
Neeraj

>> ---
>>   kernel/rcu/tree.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 6226bfb..57c904b 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2514,8 +2514,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>   		rcu_state.cbovldnext |= !!rnp->cbovldmask;
>>   		if (rnp->qsmask == 0) {
>> -			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
>> -			    rcu_preempt_blocked_readers_cgp(rnp)) {
>> +			if (rcu_preempt_blocked_readers_cgp(rnp)) {
>>   				/*
>>   				 * No point in scanning bits because they
>>   				 * are all zero.  But we might need to
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
> 
> ------------------------------------------------------------------------
> 
> commit a4600389c35010aef414b89e2817d4a527e751b5
> Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> Date:   Mon Jun 22 23:37:03 2020 +0530
> 
>      rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()
>      
>      Originally, the call to rcu_preempt_blocked_readers_cgp() from
>      force_qs_rnp() had to be conditioned on CONFIG_PREEMPT_RCU=y, as in
>      commit a77da14ce9af ("rcu: Yet another fix for preemption and CPU
>      hotplug").  However, there is now a CONFIG_PREEMPT_RCU=n definition of
>      rcu_preempt_blocked_readers_cgp() that unconditionally returns zero, so
>      invoking it is now safe.  In addition, the CONFIG_PREEMPT_RCU=n definition
>      of rcu_initiate_boost() simply releases the rcu_node structure's ->lock,
>      which is what happens when the "if" condition evaluates to false.
>      
>      This commit therefore drops the IS_ENABLED(CONFIG_PREEMPT_RCU) check,
>      so that rcu_initiate_boost() is called only in CONFIG_PREEMPT_RCU=y
>      kernels when there are readers blocking the current grace period.
>      This does not change the behavior, but reduces code-reader confusion by
>      eliminating non-CONFIG_PREEMPT_RCU=y calls to rcu_initiate_boost().
>      
>      Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6226bfb..57c904b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2514,8 +2514,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>   		rcu_state.cbovldnext |= !!rnp->cbovldmask;
>   		if (rnp->qsmask == 0) {
> -			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
> -			    rcu_preempt_blocked_readers_cgp(rnp)) {
> +			if (rcu_preempt_blocked_readers_cgp(rnp)) {
>   				/*
>   				 * No point in scanning bits because they
>   				 * are all zero.  But we might need to
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
