Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB3C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2742187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgAOK7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:59:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOK7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7858131B;
        Wed, 15 Jan 2020 02:59:16 -0800 (PST)
Received: from e112479-lin.warwick.arm.com (e112479-lin.warwick.arm.com [10.32.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 308D83F6C4;
        Wed, 15 Jan 2020 02:59:13 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     nd@arm.com, James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Return EINVAL when precise_ip perf events are requested on Arm
Date:   Wed, 15 Jan 2020 10:58:54 +0000
Message-Id: <20200115105855.13395-1-james.clark@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since we're adding support for SPE in user space Perf, we've encountered an issue
where we would like some more feedback if SPE isn't available for an event.

At the moment there is a patch for perf where you can enable SPE by doing this:

    perf record -r branch-misses:p ...

Perf will have a hard coded list of events that can use SPE when ":p" is specified
and open the SPE PMU instead of the specified one. But if the event isn't in that
list, then Perf will attempt to open the normal event with precise_ip = 1.
That will succeed at the moment, but we'd like the kernel to say it's not supported
so there is a chance of showing a warning to the user.

This isn't just relevant to Perf though, there may be other tools that are already
setting this.

Therefore I'm looking for feedback on whether this would break backwards
compatibility with user space tools that are already setting precise_ip and
expecting it to not error out on Arm.

This change would also be beneficial for the case where if in the (distant) future
we do add some kind of precise support, there will be a chance of userspace
determining what is supported and what isn't.

Thanks
James

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

James Clark (1):
  Return EINVAL when precise_ip perf events are requested on Arm

 drivers/perf/arm_pmu.c          | 3 +++
 include/uapi/linux/perf_event.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.24.0

