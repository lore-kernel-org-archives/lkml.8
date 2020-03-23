Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1B32074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCWRKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:10:08 -0400
Received: from foss.arm.com ([217.140.110.172]:52208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgCWRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C381FB;
        Mon, 23 Mar 2020 10:10:07 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456F53F7C3;
        Mon, 23 Mar 2020 10:10:06 -0700 (PDT)
References: <20200311183320.19186-1-valentin.schneider@arm.com> <20200311183320.19186-2-valentin.schneider@arm.com> <20200323134234.GD6103@e123083-lin>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 1/3] sched/topology: Split out SD_* flags declaration to its own file
In-reply-to: <20200323134234.GD6103@e123083-lin>
Date:   Mon, 23 Mar 2020 17:10:00 +0000
Message-ID: <jhjy2rrknfb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Morten,

Just as a heads-up, I think those changes would better fit 2/3, or be
in their own patch. 1/3 is just a straight up code move, with no changes
to the existing comments.

On Mon, Mar 23 2020, Morten Rasmussen wrote:
> On Wed, Mar 11, 2020 at 06:33:18PM +0000, Valentin Schneider wrote:
>> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
>> new file mode 100644
>> index 000000000000..685bbe736945
>> --- /dev/null
>> +++ b/include/linux/sched/sd_flags.h
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * sched-domains (multiprocessor balancing) flag declarations.
>> + */
>> +
>> +/* Balance when about to become idle */
>> +SD_FLAG(SD_BALANCE_NEWIDLE,     0)
>> +/* Balance on exec */
>> +SD_FLAG(SD_BALANCE_EXEC,        1)
>> +/* Balance on fork, clone */
>> +SD_FLAG(SD_BALANCE_FORK,        2)
>> +/* Balance on wakeup */
>> +SD_FLAG(SD_BALANCE_WAKE,        3)
>> +/* Wake task to waking CPU */
>> +SD_FLAG(SD_WAKE_AFFINE,         4)
>
> Isn't it more like: "Consider waking task on waking CPU"?
>
> IIRC, with this flag set the wake-up can happen either near prev_cpu or
> this_cpu.
>

Right, it's not a hard guarantee.

>> +/* Domain members have different CPU capacities */
>> +SD_FLAG(SD_ASYM_CPUCAPACITY,    5)
>> +/* Domain members share CPU capacity */
>> +SD_FLAG(SD_SHARE_CPUCAPACITY,   6)
>
> Perhaps add +" (SMT)" to the comment to help the uninitiated
> understanding it a bit easier?
>

Sounds good.

>> +/* Domain members share power domain */
>> +SD_FLAG(SD_SHARE_POWERDOMAIN,   7)
>
> This flag is set only by 32-bit arm and has never had any effect. I
> think it was the beginning of something years ago that hasn't
> progressed. Perhaps we can remove it now?
>

Right, I don't think I've seen anything recent that uses that flag.

>> +/* Domain members share CPU pkg resources */
>> +SD_FLAG(SD_SHARE_PKG_RESOURCES, 8)
>
> +" (e.g. caches)" ?
>

Agreed! I actually already have that one in 2/3.

>> +/* Only a single load balancing instance */
>> +SD_FLAG(SD_SERIALIZE,           9)
>> +/* Place busy groups earlier in the domain */
>> +SD_FLAG(SD_ASYM_PACKING,        10)
>
> Place busy _tasks_ earlier in the domain?
>

Ack.

> It is a bit unclear what 'earlier' means here but since the packing
> ordering can actually be defined by the architecture, we can't be much
> more specific I guess.
>

This probably dates back to when ASYM_PACKING was really just for
bubbling tasks up to the first CPU of each core, and hasn't been changed
when the asym_priority thing was introduced. I can add a pointer to that.

> Morten
