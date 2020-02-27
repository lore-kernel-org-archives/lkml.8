Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1FC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8724699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgB0LEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:04:15 -0500
Received: from foss.arm.com ([217.140.110.172]:48622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbgB0LEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:04:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383881FB;
        Thu, 27 Feb 2020 03:04:14 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1653F73B;
        Thu, 27 Feb 2020 03:04:13 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores()
 for !SMT NUMA
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, mgorman@techsingularity.net
References: <20200227110053.2514-1-lukasz.luba@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d2e0fe2d-5891-a2bf-a4c5-2a1f14754c1d@arm.com>
Date:   Thu, 27 Feb 2020 11:04:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227110053.2514-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2/27/20 11:00 AM, Lukasz Luba wrote:
> Fix kernel build warning in kernel/sched/fair.c when CONFIG_SCHED_SMT is
> not set and CONFIG_NUMA_BALANCING is set.
> 
> kernel/sched/fair.c:1524:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
> 

I've sent a similar fix yesterday at:

https://lore.kernel.org/lkml/20200226121244.7524-1-valentin.schneider@arm.com/
