Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8338B24684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1JYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:24:30 -0500
Received: from foss.arm.com ([217.140.110.172]:54156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgA1JYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:24:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD23231B;
        Tue, 28 Jan 2020 01:24:29 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91EA43F52E;
        Tue, 28 Jan 2020 01:24:28 -0800 (PST)
Subject: Re: [PATCH v3 0/3] sched/fair: Capacity aware wakeup rework
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <35c18eee-7e92-8a7d-c59d-11dfd2b053ff@arm.com>
Date:   Tue, 28 Jan 2020 10:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126200934.18712-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2020 21:09, Valentin Schneider wrote:

[...]

> v2 -> v3
> --------
> o Added missing sync_entity_load_avg() (Quentin)
> o Added fallback CPU selection (maximize capacity)
> o Added special case for CPU hogs: task_fits_capacity() will always return 'false'
>   for tasks that are simply too big, due to the margin.

v3 fixes the Geekbench multicore regression I saw on Pixel4 (Android 10,
Android Common Kernel v4.14 based, Snapdragon 855) running v1.

I changed the Pixel4 kernel a bit (PELT instead WALT, mainline
select_idle_sibling() instead the csctate aware one), mainline
task_fits_capacity()) for base, v1 & v3.

Since it's not mainline kernel the results have to be taken with a pinch
of salt but they probably show that the new condition:

if (rq->cpu_capacity_orig == READ_ONCE(rq->rd->max_cpu_capacity) && ...
    return cpu;

has an effect when dealing with tasks with util_est values > 0.8 * 1024.
