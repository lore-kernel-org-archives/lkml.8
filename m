Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB69C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07FA206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgGMN0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:26:04 -0400
Received: from foss.arm.com ([217.140.110.172]:34636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgGMN0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:26:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 973A930E;
        Mon, 13 Jul 2020 06:26:03 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07D83F887;
        Mon, 13 Jul 2020 06:26:02 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-7-valentin.schneider@arm.com> <20200713123959.GI10769@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 6/7] sched/topology: Introduce SD metaflag for flags needing > 1 groups
In-reply-to: <20200713123959.GI10769@hirez.programming.kicks-ass.net>
Date:   Mon, 13 Jul 2020 14:25:56 +0100
Message-ID: <jhjk0z7lf6j.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/07/20 13:39, Peter Zijlstra wrote:
> On Wed, Jul 01, 2020 at 08:06:54PM +0100, Valentin Schneider wrote:
>> +/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
>> +#define SD_FLAG(name, idx, mflags) (BIT(idx) * (((mflags) & SDF_NEEDS_GROUPS) / SDF_NEEDS_GROUPS)) |
>
> #define SD_FLAGS(name, idx, mflags) (!!((mflags) & SDF_NEEDS_GROUPS) * BIT(idx))
>

Was paranoid about really getting a 1 or a 0, but AFAICT the standard
does agree with you!

>> +static const int SD_DEGENERATE_GROUPS_MASK =
>> +#include<linux/sched/sd_flags.h>
>> +0;
>> +#undef SD_FLAG
>> +
>>  #ifdef CONFIG_SCHED_DEBUG
>>  #define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},
>>  static const struct {
>> --
>> 2.27.0
>>
