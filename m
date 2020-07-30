Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741BB20672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgG3IFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:05:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729089AbgG3IFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:05:04 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 961CDC224F8CC23ECA8D;
        Thu, 30 Jul 2020 09:05:02 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.183) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Jul
 2020 09:05:02 +0100
Subject: Re: [PATCH] MAINTAINERS: Include drivers subdirs for ARM PMU
 PROFILING AND DEBUGGING entry
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1592392648-128331-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <20a647e7-a6ab-7cf1-743d-a3173cafe45f@huawei.com>
Date:   Thu, 30 Jul 2020 09:03:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1592392648-128331-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.183]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 12:17, John Garry wrote:
> Ensure that the ARM PMU PROFILING AND DEBUGGING maintainers are included
> for the HiSilicon PMU driver.

Just a reminder in case this minor patch was missed...

> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68f21d46614c..24f377f1d76c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1425,7 +1425,7 @@ F:	arch/arm*/include/asm/perf_event.h
>   F:	arch/arm*/kernel/hw_breakpoint.c
>   F:	arch/arm*/kernel/perf_*
>   F:	arch/arm/oprofile/common.c
> -F:	drivers/perf/*
> +F:	drivers/perf/
>   F:	include/linux/perf/arm_pmu.h
>   
>   ARM PORT
> 

