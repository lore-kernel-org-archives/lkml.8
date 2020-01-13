Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111AC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BBB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMM2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:28:15 -0500
Received: from foss.arm.com ([217.140.110.172]:38818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgAMM2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:28:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727B413D5;
        Mon, 13 Jan 2020 04:28:14 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15A53F68E;
        Mon, 13 Jan 2020 04:28:12 -0800 (PST)
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
References: <20191220110525.30131-1-james.clark@arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <14418955-57a8-5e1d-5a42-2d9923b813b6@arm.com>
Date:   Mon, 13 Jan 2020 12:28:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220110525.30131-1-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2019 11:05, James Clark wrote:
> This patch fixes an issue when non Arm SPE events are specified after an
> Arm SPE event. In that case, perf will exit with an error code and not
> produce a record file. This is because a loop index is used to store the
> location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> index will be overwritten. Fix this issue by saving the PMU into a
> variable instead of using the index, and also add an error message.
> 
> Before the fix:
>      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>      237
> 
> After the fix:
>      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>      ...
>      0
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Igor Lubashev <ilubashe@akamai.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
