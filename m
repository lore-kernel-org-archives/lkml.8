Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55ABC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD97020716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgA2JZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:25:58 -0500
Received: from foss.arm.com ([217.140.110.172]:38478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2JZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:25:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 087611FB;
        Wed, 29 Jan 2020 01:25:58 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB513F52E;
        Wed, 29 Jan 2020 01:25:56 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <20200128062245.GA27398@codeaurora.org>
 <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
 <20200129035258.GB27398@codeaurora.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7dd8b850-855c-29e2-8580-357cf1c8ce30@arm.com>
Date:   Wed, 29 Jan 2020 09:25:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129035258.GB27398@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2020 03:52, Pavan Kondeti wrote:
>> No particular reason other than we didn't consider it, I think. I don't see
>> any harm in folding it in, I'll do that for v4. I am curious however; are
>> you folks making use of SCHED_IDLE? AFAIA Android isn't making use of it
>> yet, though Viresh paved the way for that to happen.
>>
> 
> We are not using SCHED_IDLE in product setups. I am told Android may use it
> for background tasks in future. I am not completely sure though. I asked it
> because select_idle_cpu() is using it.
> 

Fair enough! Thanks.
