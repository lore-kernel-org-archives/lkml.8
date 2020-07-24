Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B34C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0E7207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXDIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:08:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgGXDIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:08:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D0F2332687CB803A2F32;
        Fri, 24 Jul 2020 11:08:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.56) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 11:08:04 +0800
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Hulk Robot <hulkci@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
Date:   Fri, 24 Jul 2020 11:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+maillist

On 2020/7/24 11:04, Kefeng Wang wrote:
> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
>
> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> __cpu_logical_map to fix build issue.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm64/kernel/setup.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index c793276ec7ad9..3aea05fbb9998 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
>   arch_initcall(reserve_memblock_reserved_regions);
>   
>   u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> +EXPORT_SYMBOL(__cpu_logical_map);
>   
>   void __init setup_arch(char **cmdline_p)
>   {

