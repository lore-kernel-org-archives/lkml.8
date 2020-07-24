Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B3206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGXJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:14:03 -0400
Received: from foss.arm.com ([217.140.110.172]:58236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgGXJOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:14:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE71D6E;
        Fri, 24 Jul 2020 02:14:02 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.5.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43EF53F66E;
        Fri, 24 Jul 2020 02:14:00 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:13:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
Message-ID: <20200724091308.GA44746@C02TD0UTHF1T.local>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:46:18PM +0530, Anshuman Khandual wrote:
> 
> On 07/24/2020 08:38 AM, Kefeng Wang wrote:
> > +maillist
> 
> This does not seem to be a correct method of posting any patch.
> 
> > 
> > On 2020/7/24 11:04, Kefeng Wang wrote:
> >> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
> 
> 
> >>
> >> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> >> __cpu_logical_map to fix build issue.
> 
> Commit 887d5fc82cb4 ("cpufreq: Add Tegra194 cpufreq driver") which adds
> this particular driver is present just on linux-next. But as expected,
> the driver does not use __cpu_logical_map directly but instead accesses
> it via cpu_logical_map() wrapper. Wondering, how did you even trigger
> the modpost error ?

The wrapper in <asm/smp.h> is:

| /*
|  * Logical CPU mapping.
|  */
| extern u64 __cpu_logical_map[NR_CPUS];
| #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]

... and use of that would blow up as described.

> >>
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

If modules are using cpu_logical_map(), this looks sane ot me, but I
wonder if we should instead turn cpu_logical_map() into a C wrapper in
smp.c, or at least mark __cpu_logical_map as __ro_after_init lest
someone have the bright idea to fiddle with it.

Mark.
