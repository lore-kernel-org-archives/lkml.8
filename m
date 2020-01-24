Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDFDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64D02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbgAXMsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:48:02 -0500
Received: from foss.arm.com ([217.140.110.172]:51330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbgAXMsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 07:48:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A43A1007;
        Fri, 24 Jan 2020 04:48:01 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5F93F68E;
        Fri, 24 Jan 2020 04:47:59 -0800 (PST)
Subject: Re: [PATCH 1/3] sched/fair: Add asymmetric CPU capacity wakeup scan
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
References: <20200124124255.1095-1-valentin.schneider@arm.com>
 <20200124124255.1095-2-valentin.schneider@arm.com>
Message-ID: <be0bf60c-c1dd-f5ed-54cf-e7f89e04c0a8@arm.com>
Date:   Fri, 24 Jan 2020 12:47:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124124255.1095-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2020 12:42, Valentin Schneider wrote:
> @@ -5772,7 +5772,7 @@ void __update_idle_core(struct rq *rq)
>   */
>  static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> -	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	struct cpumask *cpus;

ARGH, this is rebase damage and wants to be in select_idle_capacity().
Apologies, let me resend.
