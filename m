Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D0C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FDC20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBCI7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:59:38 -0500
Received: from foss.arm.com ([217.140.110.172]:50776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbgBCI7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:59:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85E5030E;
        Mon,  3 Feb 2020 00:59:37 -0800 (PST)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7D63F6CF;
        Mon,  3 Feb 2020 01:03:13 -0800 (PST)
Subject: Re: [Patch v9 8/8] arm64: Enable averaging of thermal pressure for
 arm64 based SoCs
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-9-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cc04a135-a0b8-29ce-c8fc-603304723784@arm.com>
Date:   Mon, 3 Feb 2020 09:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580250967-4386-9-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.20 23:36, Thara Gopinath wrote:
> Enable CONFIG_HAVE_SCHED_THERMAL_PRESSURE in arm64 defconfig.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0565a61..7a8145b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -5,6 +5,7 @@ CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_PREEMPT=y
>  CONFIG_IRQ_TIME_ACCOUNTING=y
> +CONFIG_HAVE_SCHED_THERMAL_PRESSURE=y

I thought about this a bit more and maybe it's not a good idea to enable
this by default. An erroneous thermal setup could have bad influence on
the CPU capacities and hence on the performance without people
understanding the cause of it.
If they have to actively enable it, chances are higher that they also
try to understand how higher thermal-cpufreq-X cooling states lead to
CPU capacity reduction and possibly inversion (big-LITTLE swap).

So if the thermal pressure feature is guarded by
CONFIG_HAVE_SCHED_THERMAL_PRESSURE the thermal pressure related code in
arch_topology.c (thermal_pressure, arch_set_thermal_pressure,
topology_get_thermal_pressure) should too. Saves some text and data of
arch_topology.o. Moreover Arm32 and Arm64 will be handled equally.
