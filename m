Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776092076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHRR4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:56:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbgHRR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:56:50 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 41A6913A95D71BCC9E35;
        Tue, 18 Aug 2020 18:56:49 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.123) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 18 Aug
 2020 18:56:48 +0100
Subject: Re: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <acme@kernel.org>,
        <will@kernel.org>, <leo.yan@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
Date:   Tue, 18 Aug 2020 18:54:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.123]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 20:31, Mathieu Poirier wrote:
> Add entries for perf tools elements related to the support of
> Arm CoreSight and Arm SPE.

Thanks for doing this...

> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e2698cc7e23..f9bb76baeec9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13427,8 +13427,18 @@ F:	tools/perf/
>   PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
>   R:	John Garry <john.garry@huawei.com>
>   R:	Will Deacon <will@kernel.org>
> +R:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +R:	Leo Yan <leo.yan@linaro.org>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
> +F:	tools/build/feature/test-libopencsd.c
> +F:	tools/perf/arch/arm/util/auxtrace.c
> +F:	tools/perf/arch/arm/util/cs-etm.*
> +F:	tools/perf/arch/arm/util/pmu.c
> +F:	tools/perf/arch/arm64/util/arm-spe.c
> +F:	tools/perf/util/arm-spe.h
> +F:	tools/perf/util/cs-etm-decoder/*
> +F:	tools/perf/util/cs-etm.*

But from the previous discussion, I thought that we wanted an entry to 
cover all tools/perf/arch/arm64/ and other related folders. Or was it 
just put all special interest parts (like SPE support) under one entry 
and leave the other arm/arm64 parts to be caught by "PERFORMANCE EVENTS 
SUBSYSTEM" entry?

Cheers,
John

>   F:	tools/perf/pmu-events/arch/arm64/
>   
>   PERSONALITY HANDLING
> 

