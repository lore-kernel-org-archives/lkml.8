Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85404C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620AB20857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDINXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:23:55 -0400
Received: from foss.arm.com ([217.140.110.172]:50104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgDINXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:23:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A3A130E;
        Thu,  9 Apr 2020 06:23:55 -0700 (PDT)
Received: from [10.37.8.193] (unknown [10.37.8.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F2233F73D;
        Thu,  9 Apr 2020 06:23:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1c1ab662-5475-9d8b-038b-8411b060202a@arm.com>
Date:   Thu, 9 Apr 2020 14:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages and add the logic
> to handle faults on VVAR properly.
> 
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page. That page has vdso_data->seq
> set to 1 to enforce the slow path and vdso_data->clock_mode set to
> VCLOCK_TIMENS to enforce the time namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the VDSO data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 
> v2: Code cleanups suggested by Vincenzo.
> 

Sorry for the delay, I completed this morning the review of your patches and I
do not have anymore comments on them. Thank you for making the effort and
bringing the time namespace support to arm64.

I have though a question on something I encountered during the testing of the
patches: I noticed that all the tests related to CLOCK_BOOTTIME_ALARM fail on
arm64 (please find the results below the scissors). Is this expected?

--->8---

1..4
ok 1 clockid: 1 abs:0
ok 2 clockid: 1 abs:1
not ok 3 # error clock_gettime: Invalid argument
not ok 4 # error clock_gettime: Invalid argument
Bail out!
# Pass 2 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 2
1..1
ok 1 exec
# Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..8
not ok 1 # error Warning: failed to find clock_gettime in vDSO

./timens.sh: line 5: 15382 Segmentation fault      (core dumped) ./gettime_perf
1..1
ok 1 Passed for /proc/uptime
# Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..10
ok 1 Passed for CLOCK_BOOTTIME (syscall)
ok 2 Passed for CLOCK_BOOTTIME (vdso)
not ok 3 # error syscall(SYS_clock_gettime(9)): Invalid argument
not ok 4 # error clock_gettime(9): Invalid argument
ok 5 Passed for CLOCK_MONOTONIC (syscall)
ok 6 Passed for CLOCK_MONOTONIC (vdso)
ok 7 Passed for CLOCK_MONOTONIC_COARSE (syscall)
ok 8 Passed for CLOCK_MONOTONIC_COARSE (vdso)
ok 9 Passed for CLOCK_MONOTONIC_RAW (syscall)
ok 10 Passed for CLOCK_MONOTONIC_RAW (vdso)
Bail out!
# Pass 8 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 2
1..3
ok 1 clockid=7
ok 2 clockid=1
not ok 3 # error timerfd_create: Operation not supported
Bail out!
# Pass 2 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 1
1..3
ok 1 clockid=7
ok 2 clockid=1
ok 3 clockid=9
# Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

[...]

-- 
Regards,
Vincenzo
