Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473692087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgHUI5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:57:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbgHUI5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:57:49 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 844336D67F456C21CBF7;
        Fri, 21 Aug 2020 09:57:48 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 21 Aug
 2020 09:57:47 +0100
Subject: Re: [PATCH v2] MAINTAINERS: Add entries for CoreSight and Arm SPE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <acme@kernel.org>
CC:     <will@kernel.org>, <leo.yan@linaro.org>, <jolsa@redhat.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200820175510.3935932-1-mathieu.poirier@linaro.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <938c45cc-e832-e364-6e1d-019356763c54@huawei.com>
Date:   Fri, 21 Aug 2020 09:55:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200820175510.3935932-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2020 18:55, Mathieu Poirier wrote:
> Add entries for perf tools elements related to the support of Arm CoreSight
> and Arm SPE.  Also lump in Arm and Arm64 architecture files to provide
> coverage.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

thanks
Acked-by: John Garry <john.garry@huawei.com>

> ---
> V2:
> - Completed fileset for SPE.
> - Added Arm and Arm64 architecture files.
> 
>   MAINTAINERS | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..e76f7bb014ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13569,12 +13569,18 @@ F:	kernel/events/*
>   F:	tools/lib/perf/
>   F:	tools/perf/
>   
> -PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> +PERFORMANCE EVENTS SUBSYSTEM ARM64
>   R:	John Garry <john.garry@huawei.com>
>   R:	Will Deacon <will@kernel.org>
> +R:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +R:	Leo Yan <leo.yan@linaro.org>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
> +F:	tools/build/feature/test-libopencsd.c
> +F:	tools/perf/arch/arm*/
>   F:	tools/perf/pmu-events/arch/arm64/
> +F:	tools/perf/util/arm-spe*
> +F:	tools/perf/util/cs-etm*
>   
>   PERSONALITY HANDLING
>   M:	Christoph Hellwig <hch@infradead.org>
> 

