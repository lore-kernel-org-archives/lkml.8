Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B3C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C675E207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgIGKG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgIGKG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:06:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02BB3AF93;
        Mon,  7 Sep 2020 10:06:56 +0000 (UTC)
Date:   Mon, 7 Sep 2020 12:06:47 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200907100647.GB10657@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907094843.1949-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Srinivas.
+ kitsunyan.

On Mon, Sep 07, 2020 at 11:48:43AM +0200, Jason A. Donenfeld wrote:
> Popular tools, like intel-undervolt, use MSR 0x150 to control the CPU
> voltage offset. In fact, evidently the intel_turbo_max_3 driver in-tree
> also uses this MSR. So, teach the kernel's MSR list about this, so that
> intel-undervolt and other such tools don't spew warnings to dmesg, while
> unifying the constant used throughout the kernel.
> 
> Fixes: a7e1f67ed29f ("x86/msr: Filter MSR writes")
> Cc: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/include/asm/msr-index.h         | 2 ++
>  arch/x86/kernel/msr.c                    | 5 ++++-
>  drivers/platform/x86/intel_turbo_max_3.c | 6 +++---
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 2859ee4f39a8..0bcb3604d0e2 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -132,6 +132,8 @@
>  #define MSR_IA32_MCU_OPT_CTRL		0x00000123
>  #define RNGDS_MITG_DIS			BIT(0)
>  
> +#define MSR_IA32_OC_MAILBOX		0x00000150
> +
>  #define MSR_IA32_SYSENTER_CS		0x00000174
>  #define MSR_IA32_SYSENTER_ESP		0x00000175
>  #define MSR_IA32_SYSENTER_EIP		0x00000176
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 49dcfb85e773..64f6200681e3 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -86,8 +86,11 @@ static int filter_write(u32 reg)
>  	default: break;
>  	}
>  
> -	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> +	switch (reg) {
> +	case MSR_IA32_ENERGY_PERF_BIAS:
> +	case MSR_IA32_OC_MAILBOX:
>  		return 0;
> +	}
>  
>  	pr_err_ratelimited("Write to unrecognized MSR 0x%x by %s\n"
>  			   "Please report to x86@kernel.org\n",
> diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel_turbo_max_3.c
> index 892140b62898..991cdbc3295b 100644
> --- a/drivers/platform/x86/intel_turbo_max_3.c
> +++ b/drivers/platform/x86/intel_turbo_max_3.c
> @@ -17,8 +17,8 @@
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> +#include <asm/msr.h>
>  
> -#define MSR_OC_MAILBOX			0x150
>  #define MSR_OC_MAILBOX_CMD_OFFSET	32
>  #define MSR_OC_MAILBOX_RSP_OFFSET	32
>  #define MSR_OC_MAILBOX_BUSY_BIT		63
> @@ -41,14 +41,14 @@ static int get_oc_core_priority(unsigned int cpu)
>  	value = cmd << MSR_OC_MAILBOX_CMD_OFFSET;
>  	/* Set the busy bit to indicate OS is trying to issue command */
>  	value |=  BIT_ULL(MSR_OC_MAILBOX_BUSY_BIT);
> -	ret = wrmsrl_safe(MSR_OC_MAILBOX, value);
> +	ret = wrmsrl_safe(MSR_IA32_OC_MAILBOX, value);
>  	if (ret) {
>  		pr_debug("cpu %d OC mailbox write failed\n", cpu);
>  		return ret;
>  	}
>  
>  	for (i = 0; i < OC_MAILBOX_RETRY_COUNT; ++i) {
> -		ret = rdmsrl_safe(MSR_OC_MAILBOX, &value);
> +		ret = rdmsrl_safe(MSR_IA32_OC_MAILBOX, &value);
>  		if (ret) {
>  			pr_debug("cpu %d OC mailbox read failed\n", cpu);
>  			break;
> -- 

Actually, we added the filtering to catch exactly such misuses and,
lemme check what is the proper word now... /me checks, aha, adding new
MSRs to the "passlist" is the wrong thing to do.

Srinivas, can you pls convert this in-tree driver to use a proper sysfs
interface for that mailbox MSR and also work with the intel-undervolt
author - I hope I have the right person CCed from the git repo on github
- to come up with a proper interface so that we can drop this MSR use
too.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
