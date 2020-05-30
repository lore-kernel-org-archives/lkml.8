Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7F20C09
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgE3MqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:46:05 -0400
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:36998 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgE3MqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:46:04 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from 88-109-182-220.dynamic.dsl.as9105.com ([88.109.182.220]:44144 helo=[192.168.1.219])
        by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1jf0rw-000HK8-MS (Exim 4.92.3)
        (return-path <amc96@hermes.cam.ac.uk>); Sat, 30 May 2020 13:45:45 +0100
Subject: Re: [PATCH 02/14] x86/hw_breakpoint: Prevent data breakpoints on
 direct GDT
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        luto@amacapital.net
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, daniel.thompson@linaro.org,
        a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
References: <20200529212728.795169701@infradead.org>
 <20200529213320.840953950@infradead.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <582d9136-8f8b-fa07-862e-9ea5d440c09f@citrix.com>
Date:   Sat, 30 May 2020 13:45:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529213320.840953950@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2020 22:27, Peter Zijlstra wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> A data breakpoint on the GDT is terrifying and should be avoided.
> The GDT on CPU entry area is already protected. The direct GDT
> should be also protected, although it is seldom used and only
> used for short time.

While I agree with the sentiment...

>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200526014221.2119-3-laijs@linux.alibaba.com
> ---
>  arch/x86/kernel/hw_breakpoint.c |   30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -32,6 +32,7 @@
>  #include <asm/processor.h>
>  #include <asm/debugreg.h>
>  #include <asm/user.h>
> +#include <asm/desc.h>
>  
>  /* Per cpu debug control register value */
>  DEFINE_PER_CPU(unsigned long, cpu_dr7);
> @@ -237,13 +238,26 @@ static inline bool within_area(unsigned
>  }
>  
>  /*
> - * Checks whether the range from addr to end, inclusive, overlaps the CPU
> - * entry area range.
> + * Checks whether the range from addr to end, inclusive, overlaps the fixed
> + * mapped CPU entry area range or other ranges used for CPU entry.
>   */
> -static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
> +static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
>  {
> -	return within_area(addr, end, CPU_ENTRY_AREA_BASE,
> -			   CPU_ENTRY_AREA_TOTAL_SIZE);
> +	int cpu;
> +
> +	/* CPU entry erea is always used for CPU entry */
> +	if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
> +			CPU_ENTRY_AREA_TOTAL_SIZE))
> +		return true;
> +
> +	for_each_possible_cpu(cpu) {
> +		/* The original rw GDT is being used after load_direct_gdt() */
> +		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
> +				GDT_SIZE))

... why the O(n) loop over the system?

It is only GDTs which might ever be active on this local CPU(/thread)
which are a problem, because the breakpoint registers are similarly local.

Nothing is going to go wrong If I put a breakpoint on someone else's
live GDT, because they wont interact in the "fun" ways we're trying to
avoid.

~Andrew
