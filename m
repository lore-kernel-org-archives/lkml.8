Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9881C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96101206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgA2Q1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:27:03 -0500
Received: from foss.arm.com ([217.140.110.172]:43278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgA2Q1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:27:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E532A1045;
        Wed, 29 Jan 2020 08:27:02 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E083F52E;
        Wed, 29 Jan 2020 08:27:01 -0800 (PST)
Subject: Re: [PATCH v3 2/3] sched/topology: Remove SD_BALANCE_WAKE on
 asymmetric capacity systems
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-3-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <92f38645-c6ae-0e15-fac9-8c6064b5d4cf@arm.com>
Date:   Wed, 29 Jan 2020 17:27:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126200934.18712-3-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2020 21:09, Valentin Schneider wrote:
> From: Morten Rasmussen <morten.rasmussen@arm.com>

[...]

> @@ -1374,18 +1374,9 @@ sd_init(struct sched_domain_topology_level *tl,
>  	 * Convert topological properties into behaviour.
>  	 */
>  
> -	if (sd->flags & SD_ASYM_CPUCAPACITY) {
> -		struct sched_domain *t = sd;
> -
> -		/*
> -		 * Don't attempt to spread across CPUs of different capacities.
> -		 */
> -		if (sd->child)
> -			sd->child->flags &= ~SD_PREFER_SIBLING;
> -
> -		for_each_lower_domain(t)

It seems that with this goes the last use of for_each_lower_domain().

[...]
