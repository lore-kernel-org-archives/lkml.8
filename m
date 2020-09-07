Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69FDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F52E2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgIGRPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:15:16 -0400
Received: from foss.arm.com ([217.140.110.172]:36604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgIGOGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:06:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B78F91045;
        Mon,  7 Sep 2020 07:05:57 -0700 (PDT)
Received: from [10.57.6.175] (unknown [10.57.6.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9023F73C;
        Mon,  7 Sep 2020 07:05:54 -0700 (PDT)
Subject: Re: [PATCH v7] perf test: Introduce script for Arm CoreSight testing
To:     leo.yan@linaro.org, acme@kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
References: <20200907130154.9601-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6333f002-1213-0e20-0fcc-b3bfc0723b97@arm.com>
Date:   Mon, 7 Sep 2020 15:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200907130154.9601-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 02:01 PM, Leo Yan wrote:
> We need a simple method to test Perf with Arm CoreSight drivers, this
> could be used for smoke testing when new patch is coming for perf or
> CoreSight drivers, and we also can use the test to confirm if the
> CoreSight has been enabled successfully on new platforms.
> 
> This patch introduces the shell script test_arm_coresight.sh which is
> under the 'pert test' framework.  This script provides three testing
> scenarios:

...

> Below is detailed usage for it:
> 
>    # cd $linux/tools/perf  -> This is important so can use shell script
>    # perf test list
>      [...]
>      70: probe libc's inet_pton & backtrace it with ping
>      71: Check Arm CoreSight trace data recording and synthesized samples
>      72: Check open filename arg using perf trace + vfs_getname
>      73: Zstd perf.data compression/decompression
>      74: Add vfs_getname probe to get syscall args filenames
>      75: Use vfs_getname probe to get syscall args filenames
> 
>    # perf test 71
>      71: Check Arm CoreSight trace data recording and branch samples: Ok
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Leo,

Thank you so much for testcase !

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
