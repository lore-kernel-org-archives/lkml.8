Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3953FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CC8206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGXJa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgGXJa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:30:59 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2195320663;
        Fri, 24 Jul 2020 09:30:56 +0000 (UTC)
Date:   Fri, 24 Jul 2020 10:30:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
Message-ID: <20200724093054.GA23388@gaia>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:46:18PM +0530, Anshuman Khandual wrote:
> On 07/24/2020 08:38 AM, Kefeng Wang wrote:
> > On 2020/7/24 11:04, Kefeng Wang wrote:
> >> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
> >>
> >> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> >> __cpu_logical_map to fix build issue.
> 
> Commit 887d5fc82cb4 ("cpufreq: Add Tegra194 cpufreq driver") which adds
> this particular driver is present just on linux-next. But as expected,
> the driver does not use __cpu_logical_map directly but instead accesses
> it via cpu_logical_map() wrapper. Wondering, how did you even trigger
> the modpost error ?

Since the wrapper is a macro, it just expands to __cpu_logical_map[].

> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>   arch/arm64/kernel/setup.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >> index c793276ec7ad9..3aea05fbb9998 100644
> >> --- a/arch/arm64/kernel/setup.c
> >> +++ b/arch/arm64/kernel/setup.c
> >> @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
> >>   arch_initcall(reserve_memblock_reserved_regions);
> >>     u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> >> +EXPORT_SYMBOL(__cpu_logical_map);
> >>     void __init setup_arch(char **cmdline_p)
> >>   {

I can see the Tegra cpuidle also using cpu_logical_map(), though it
can't be built as a module, unlike the cpufreq one. I think the patch
makes sense.

-- 
Catalin
