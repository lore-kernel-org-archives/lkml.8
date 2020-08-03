Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077D4206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHCN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:26:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgHCN0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:26:02 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C220416D292280C7490A;
        Mon,  3 Aug 2020 14:26:00 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 3 Aug 2020
 14:25:59 +0100
Subject: Re: [PATCH v2 2/2] perf pmu: Improve CPU core PMU HW event list
 ordering
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
 <1592384514-119954-3-git-send-email-john.garry@huawei.com>
 <CAM9d7cgqJzQJ7GfL6Q3VgARd1=rrkRYqOqSivZww-LOo+DvKFA@mail.gmail.com>
 <20200617121549.GA31085@kernel.org>
 <74303789-6c06-574d-674b-202cf84a2018@huawei.com>
 <20200803125423.GA3440834@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <27e46a45-9055-dbb7-324e-28a65120091d@huawei.com>
Date:   Mon, 3 Aug 2020 14:23:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200803125423.GA3440834@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.55]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2020 13:54, Arnaldo Carvalho de Melo wrote:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>
>> Please let me know - it would be useful for any dev during the merge window.
> So, I'm now pushing things directly to Linus, but just the tooling part,
> the branch to do development on is:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> 
> At some point I think we'll have a git/perf-tools/perf-tools.git, just
> like tip, but for now, please use the one above.
> 
> My perf/core in the past was rebaseable, I did changes in it after
> publishing, trying to have solid bisectability, since I process patch by
> patch doing tests on it when we noticed problems, prior to pushing to
> Ingo for tip.
> 
> Now I am making perf/core non-rebaseable, I push things there
> periodically, tagging what is there with the test results, see:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-tests-2020-07-17
>    https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-tests-2020-07-02
> 
> I'll try and tag today's state of that tree, which I did tests already
> but since v5.8 was released, I merged it there and will retest and tag
> the test results.
> 
> The tmp.perf/core one is an experiment in making what I have in my local
> tree available for more bleeding edge things that are being done, say in
> that metrics effort, etc, but I think I'll stop that, since, as your
> message shows, it is causing confusion.
> 
> I did this because these tests take quite some time and sometimes I have
> to fix things and restart it, rinse, repeat.
> 
> So please use:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> 

If it makes sense, it could be useful to have this included in the 
MAINTAINERS file. That's for forgetful people like me :)

> I'll further automate all this so that we have a more regular cadence of
> updates to perf/core, say every two days or so.
> 
> If you have changes that touch both the kernel and userspace, the kernel
> bits need to go via tip, the tooling via the perf tree, that for now
> (well, it has been like that for quite a long time) is my tree.

ok, thanks for the detailed response.

> 
> Arch specific kernel bits have been going via the arch trees for quite a
> while, I think.
> 
> - Arnaldo
> .

Cheers,
john

