Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9866AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A93D2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgHDLP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:15:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbgHDLND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:13:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180A830E;
        Tue,  4 Aug 2020 04:13:01 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 173263F6CF;
        Tue,  4 Aug 2020 04:12:59 -0700 (PDT)
References: <20200731115502.12954-1-valentin.schneider@arm.com> <20200731115502.12954-6-valentin.schneider@arm.com> <20200804110840.GF2657@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 05/10] sched/topology: Define and assign sched_domain flag metadata
In-reply-to: <20200804110840.GF2657@hirez.programming.kicks-ass.net>
Date:   Tue, 04 Aug 2020 12:12:57 +0100
Message-ID: <jhjd046is06.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/08/20 12:08, peterz@infradead.org wrote:
> On Fri, Jul 31, 2020 at 12:54:57PM +0100, Valentin Schneider wrote:
>> +/*
>> + * Domain members share CPU capacity (i.e. SMT)
>> + *
>> + * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
>> + * CPU capacity.
>> + */
>> +SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD)
>> +
>> +/*
>> + * Domain members share CPU package resources (i.e. caches)
>> + *
>> + * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
>> + * the same cache(s).
>> + */
>> +SD_FLAG(SD_SHARE_PKG_RESOURCES, 7, SDF_SHARED_CHILD)
>
> We should probably rename these to SD_SHARE_CORE / SD_SHARE_CACHE or
> something,

SD_SHARE_CACHE sounds good, given how it's used (LLC stuff).

> but let me first go through this series (and hopefully apply)
> before we go make more changes.
>
>
> .. onwards!

Thanks!
