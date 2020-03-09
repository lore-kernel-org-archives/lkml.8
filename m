Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D4C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4370120409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCIKcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:32:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgCIKcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E7D1FB;
        Mon,  9 Mar 2020 03:32:31 -0700 (PDT)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E5F3F67D;
        Mon,  9 Mar 2020 03:32:29 -0700 (PDT)
Subject: Re: [PATCH] arm64: add check_wx_pages debugfs for CHECK_WX
To:     Phong Tran <tranmanphong@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
References: <20200307093926.27145-1-tranmanphong@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <34739c99-3436-e88f-769b-43c48caa8817@arm.com>
Date:   Mon, 9 Mar 2020 10:32:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307093926.27145-1-tranmanphong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2020 09:39, Phong Tran wrote:
> follow the suggestion from
> https://github.com/KSPP/linux/issues/35
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm64/Kconfig.debug        |  3 ++-
>  arch/arm64/include/asm/ptdump.h |  2 ++
>  arch/arm64/mm/dump.c            |  1 +
>  arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 1c906d932d6b..be552fa351e2 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -48,7 +48,8 @@ config DEBUG_WX
>  	  of other unfixed kernel bugs easier.
>  
>  	  There is no runtime or memory usage effect of this option
> -	  once the kernel has booted up - it's a one time check.
> +	  once the kernel has booted up - it's a one time check and
> +	  can be checked by echo "1" to "check_wx_pages" debugfs in runtime.

I would suggest it may be better spelling this out a bit more, because
at the moment it's a little confusing when the config option is "Warn on
W+X mappings at boot", but your change makes it sound like it only
happens when you do the echo. Perhaps something like:

	  There is no runtime or memory usage effect of this option
	  once the kernel has booted up - it's a one time check at
	  boot, and can also be triggered at runtime by echo "1" to
	  "check_wx_pages".

>  
>  	  If in doubt, say "Y".
>  
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 38187f74e089..b80d6b4fc508 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -24,9 +24,11 @@ struct ptdump_info {
>  void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
>  #ifdef CONFIG_PTDUMP_DEBUGFS
>  void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +int ptdump_check_wx_init(void);
>  #else
>  static inline void ptdump_debugfs_register(struct ptdump_info *info,
>  					   const char *name) { }
> +static inline int ptdump_check_wx_init(void) { return 0; }
>  #endif
>  void ptdump_check_wx(void);
>  #endif /* CONFIG_PTDUMP_CORE */

This is a confusing! Why have you made it dependent on
CONFIG_PTDUMP_DEBUGFS?

Well actually I can see why - it's because you've put the new functions
in ptdump_debugfs.c which is (currently) only built when
CONFIG_PTDUMP_DBEUGFS is enabled.

So you need to either:

 a) Ensure the new code is built when CONFIG_PTDUMP_DEBUGFS isn't enabled.

 b) Update the Kconfig help text to say that the debugfs file for
triggering a runtime W+X check is only available if
CONFIG_PTDUMP_DEBUGFS is also enabled.

Other than the confusion over config symbols this looks good.

Thanks,

Steve

> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 860c00ec8bd3..60c99a047763 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -378,6 +378,7 @@ static int ptdump_init(void)
>  #endif
>  	ptdump_initialize();
>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> +	ptdump_check_wx_init();
>  	return 0;
>  }
>  device_initcall(ptdump_init);
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index 1f2eae3e988b..73cddc12c3c2 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -16,3 +16,21 @@ void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>  {
>  	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>  }
> +
> +static int check_wx_debugfs_set(void *data, u64 val)
> +{
> +	if (val != 1ULL)
> +		return -EINVAL;
> +
> +	ptdump_check_wx();
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
> +
> +int ptdump_check_wx_init(void)
> +{
> +	return debugfs_create_file("check_wx_pages", 0200, NULL,
> +				   NULL, &check_wx_fops) ? 0 : -ENOMEM;
> +}
> 

