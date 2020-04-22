Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04682C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96A020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDVNc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:32:57 -0400
Received: from foss.arm.com ([217.140.110.172]:50018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVNc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:32:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACECA31B;
        Wed, 22 Apr 2020 06:32:55 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 670D73F6CF;
        Wed, 22 Apr 2020 06:32:49 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: add check_wx_pages debugfs for CHECK_WX
To:     Phong Tran <tranmanphong@gmail.com>, mark.rutland@arm.com,
        steve.capper@arm.com, will@kernel.org, keescook@chromium.org,
        greg@kroah.com
Cc:     akpm@linux-foundation.org, alexios.zavras@intel.com,
        broonie@kernel.org, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <20200307093926.27145-1-tranmanphong@gmail.com>
 <20200421173557.10817-1-tranmanphong@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b7db5ad8-385d-8ee6-8e4a-5d64826dae65@arm.com>
Date:   Wed, 22 Apr 2020 14:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421173557.10817-1-tranmanphong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2020 18:35, Phong Tran wrote:
> follow the suggestion from
> https://github.com/KSPP/linux/issues/35
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

I'm fine with this as is, so you can have my

Reviewed-by: Steven Price <steven.price@arm.com>

However, if you have time to look at it then it would be good to look at 
moving the ptdump_check_wx()/debug_checkwx() calls into common code as 
this should be supported on arm/arm64/powerpc/riscv/x86 as far as I can 
see. And it's always best to get these things in common code early on 
rather than letting the architectures diverge.

Also in future it would be good if you include some text in the commit 
message that explains the purpose/intention of the change rather than 
just a link. Having a self-contained commit message helps a lot when 
searching the git history to find out why the code was written the way 
it is.

Steve

> ---
> Change since v1:
> - Update the Kconfig help text
> - Don't check the return value of debugfs_create_file()
> - Tested on QEMU aarch64
> root@qemuarm64:~# zcat /proc/config.gz | grep PTDUMP
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> CONFIG_PTDUMP_DEBUGFS=y
> root@qemuarm64:~# uname -a
> Linux qemuarm64 5.7.0-rc2-00001-g20ddb383c313 #3 SMP PREEMPT Tue Apr 21 23:18:56 +07 2020 aarch64 GNU/Linux
> root@qemuarm64:~# echo 1 > /sys/kernel/debug/check_wx_pages
> [   63.261868] Checked W+X mappings: passed, no W+X pages found
> ---
>   arch/arm64/Kconfig.debug        |  5 ++++-
>   arch/arm64/include/asm/ptdump.h |  2 ++
>   arch/arm64/mm/dump.c            |  1 +
>   arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
>   4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index a1efa246c9ed..cd82c9d3664a 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -48,7 +48,10 @@ config DEBUG_WX
>   	  of other unfixed kernel bugs easier.
>   
>   	  There is no runtime or memory usage effect of this option
> -	  once the kernel has booted up - it's a one time check.
> +	  once the kernel has booted up - it's a one time check at
> +	  boot, and can also be triggered at runtime by echo "1" to
> +	  "check_wx_pages". The "check_wx_pages" is available only with
> +	  CONFIG_PTDUMP_DEBUGFS is enabled.
>   
>   	  If in doubt, say "Y".
>   
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 38187f74e089..c90a6ec6f59b 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -24,9 +24,11 @@ struct ptdump_info {
>   void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
>   #ifdef CONFIG_PTDUMP_DEBUGFS
>   void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +void ptdump_check_wx_init(void);
>   #else
>   static inline void ptdump_debugfs_register(struct ptdump_info *info,
>   					   const char *name) { }
> +static inline void ptdump_check_wx_init(void) { }
>   #endif
>   void ptdump_check_wx(void);
>   #endif /* CONFIG_PTDUMP_CORE */
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 860c00ec8bd3..60c99a047763 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -378,6 +378,7 @@ static int ptdump_init(void)
>   #endif
>   	ptdump_initialize();
>   	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> +	ptdump_check_wx_init();
>   	return 0;
>   }
>   device_initcall(ptdump_init);
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index d29d722ec3ec..6b0aa16cb17b 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -20,3 +20,21 @@ void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
>   	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>   }
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
> +void ptdump_check_wx_init(void)
> +{
> +	debugfs_create_file("check_wx_pages", 0200, NULL,
> +			NULL, &check_wx_fops) ? 0 : -ENOMEM;
> +}
> 

