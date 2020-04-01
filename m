Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179032071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ByQw6/Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgDAHDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:03:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40884 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731792AbgDAHDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:03:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48scbc6RWHz9v9vX;
        Wed,  1 Apr 2020 09:03:08 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ByQw6/Ki; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id t9A2mRb1pC0D; Wed,  1 Apr 2020 09:03:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48scbc5MZ5z9v9vV;
        Wed,  1 Apr 2020 09:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585724588; bh=1hN7fWH9bflW8Oly7EONXyVEhViF+NoTYgwdw34COUE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ByQw6/KiSQBLfzb7djqMEFTO+OMnpJzlWeo0Xy8P5DzWUwH+ToO5AnrAyBm15lfbz
         R8AayQvayxZjzMil7QjnyMtCNCVO5gID3gwU5AlssWc+QE9BaaCgZE+H8LjQvQbo3K
         1u9Y/3/dAQU9/okS6p2ah4QAu5lpSDvYgl/T03ag=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1339F8B7B3;
        Wed,  1 Apr 2020 09:03:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id t_yg-fQeSe3x; Wed,  1 Apr 2020 09:03:08 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B85B68B778;
        Wed,  1 Apr 2020 09:03:05 +0200 (CEST)
Subject: Re: [PATCH v2 05/16] powerpc/watchpoint: Provide DAWR number to
 set_dawr
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-6-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2e7ac5a6-744e-0962-bc84-3005bda229d1@c-s.fr>
Date:   Wed, 1 Apr 2020 09:03:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401061309.92442-6-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 08:12, Ravi Bangoria a écrit :
> Introduce new parameter 'nr' to set_dawr() which indicates which DAWR
> should be programed.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h |  4 ++--
>   arch/powerpc/kernel/dawr.c               | 15 ++++++++++-----
>   arch/powerpc/kernel/process.c            |  2 +-
>   3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index 518b41eef924..62549007c87a 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -104,10 +104,10 @@ static inline bool dawr_enabled(void)
>   {
>   	return dawr_force_enable;
>   }
> -int set_dawr(struct arch_hw_breakpoint *brk);
> +int set_dawr(struct arch_hw_breakpoint *brk, int nr);

Wondering if it wouldn't make more sense to have nr as first argument.

Christophe

>   #else
>   static inline bool dawr_enabled(void) { return false; }
> -static inline int set_dawr(struct arch_hw_breakpoint *brk) { return -1; }
> +static inline int set_dawr(struct arch_hw_breakpoint *brk, int nr) { return -1; }
>   #endif
>   
>   #endif	/* __KERNEL__ */
> diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
> index e91b613bf137..311e51ee09f4 100644
> --- a/arch/powerpc/kernel/dawr.c
> +++ b/arch/powerpc/kernel/dawr.c
> @@ -16,7 +16,7 @@
>   bool dawr_force_enable;
>   EXPORT_SYMBOL_GPL(dawr_force_enable);
>   
> -int set_dawr(struct arch_hw_breakpoint *brk)
> +int set_dawr(struct arch_hw_breakpoint *brk, int nr)
>   {
>   	unsigned long dawr, dawrx, mrd;
>   
> @@ -39,15 +39,20 @@ int set_dawr(struct arch_hw_breakpoint *brk)
>   	if (ppc_md.set_dawr)
>   		return ppc_md.set_dawr(dawr, dawrx);
>   
> -	mtspr(SPRN_DAWR0, dawr);
> -	mtspr(SPRN_DAWRX0, dawrx);
> +	if (nr == 0) {
> +		mtspr(SPRN_DAWR0, dawr);
> +		mtspr(SPRN_DAWRX0, dawrx);
> +	} else {
> +		mtspr(SPRN_DAWR1, dawr);
> +		mtspr(SPRN_DAWRX1, dawrx);
> +	}
>   
>   	return 0;
>   }
>   
>   static void set_dawr_cb(void *info)
>   {
> -	set_dawr(info);
> +	set_dawr(info, 0);
>   }
>   
>   static ssize_t dawr_write_file_bool(struct file *file,
> @@ -60,7 +65,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
>   	/* Send error to user if they hypervisor won't allow us to write DAWR */
>   	if (!dawr_force_enable &&
>   	    firmware_has_feature(FW_FEATURE_LPAR) &&
> -	    set_dawr(&null_brk) != H_SUCCESS)
> +	    set_dawr(&null_brk, 0) != H_SUCCESS)
>   		return -ENODEV;
>   
>   	rc = debugfs_write_file_bool(file, user_buf, count, ppos);
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 110db94cdf3c..b548a584e465 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -799,7 +799,7 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
>   
>   	if (dawr_enabled())
>   		// Power8 or later
> -		set_dawr(brk);
> +		set_dawr(brk, 0);
>   	else if (IS_ENABLED(CONFIG_PPC_8xx))
>   		set_breakpoint_8xx(brk);
>   	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
> 
