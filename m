Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D45C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726F8208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SDbhMdBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHIgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:36:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37480 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgEHIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:36:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588926974; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xToEuf7RL5FDW474RM1SPI7R/HT+y5ChXzD5Cb8GZkU=; b=SDbhMdBMa497ONYRlO76OVzE/Rx3rCw5FOw12Rl560bXU6jVoTM03eAOf7+I5ExKFHR+et2U
 ffhaXDfotcC7kiCzNDy5Q344T/+XXrxRJa0apyQ7VDSHqUEEDJOdkTfmygshWBAof5Yf2oiC
 UUwEaw2PTqzgBmGRXyxPWBgGoNU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb519fb.7f54e99aa030-smtp-out-n02;
 Fri, 08 May 2020 08:36:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB89BC432C2; Fri,  8 May 2020 08:36:11 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 261DBC433F2;
        Fri,  8 May 2020 08:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 261DBC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 8 May 2020 14:06:01 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
Subject: Re: [RFC 3/4] sched/idle: Disable idle call on least latency
 requirements
Message-ID: <20200508083601.GJ19464@codeaurora.org>
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-4-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507133723.18325-4-parth@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:07:22PM +0530, Parth Shah wrote:
> Restrict the call to deeper idle states when the given CPU has been set for
> the least latency requirements
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> ---
>  kernel/sched/idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b743bf38f08f..85d72a6e2521 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -262,7 +262,8 @@ static void do_idle(void)
>  		 * broadcast device expired for us, we don't want to go deep
>  		 * idle as we know that the IPI is going to arrive right away.
>  		 */
> -		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> +		if (cpu_idle_force_poll || tick_check_broadcast_expired() ||
> +		    per_cpu(nr_lat_sensitive, cpu)) {
>  			tick_nohz_idle_restart_tick();
>  			cpu_idle_poll();
>  		} else {
> -- 
> 2.17.2
> 

Since nr_lat_sensitive updates can happen remotely (when a latency sensitive
task becomes non-latency sensitive task), we may need to add this condition
in cpu_idle_poll() as well.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
