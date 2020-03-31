Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE2DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 04:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 04:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgCaENb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 00:13:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbgCaENa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 00:13:30 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 871A1C4B5C0205A3BD76;
        Tue, 31 Mar 2020 12:13:21 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.117) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 12:13:13 +0800
Subject: Re:Re: [PATCH] perf report: Fix arm64 gap between kernel start and
 module end
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ndesaulniers@google.com>,
        <irogers@google.com>, <tmricht@linux.ibm.com>,
        <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
References: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
 <20200330131129.GB31702@kernel.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <24a5c3d0-184c-7606-7e44-a1586c27a6cd@huawei.com>
Date:   Tue, 31 Mar 2020 12:13:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200330131129.GB31702@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.117]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 2020/3/30 21:11, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 30, 2020 at 03:41:11PM +0800, Kemeng Shi escreveu:
>> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
>> index 393b9895c..37cbfa5e9 100644
>> --- a/tools/perf/arch/arm64/util/Build
>> +++ b/tools/perf/arch/arm64/util/Build
>> @@ -2,6 +2,7 @@ libperf-y += header.o
>>  libperf-y += tsc.o
>>  libperf-y += sym-handling.o
>>  libperf-y += kvm-stat.o
>> +libperf-y += machine.o
> 
> You made the patch against an old perf codebase, right? This libperf-y
> above was changed to perf-y here:
>
I'm sorry. I checked the problem in https://github.com/torvalds/linux.git,
but I forget to make patch against it.


> commit 5ff328836dfde0cef9f28c8b8791a90a36d7a183
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Wed Feb 13 13:32:39 2019 +0100
> 
>     perf tools: Rename build libperf to perf
> 
> ----
> 
> I'm fixing this up, please check my perf/core branch later to see that
> all is working as intended.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> 
> Thanks,
> 
> - Arnaldo
> 
I test it and it works fine, thanks for fixing up.

