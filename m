Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B8C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475B520578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pDvSIsk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgC0Gu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:50:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5854 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgC0Gu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:50:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48pXYF0HKqz9txpx;
        Fri, 27 Mar 2020 07:50:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pDvSIsk8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9c3JvdN5GUEC; Fri, 27 Mar 2020 07:50:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48pXYD6KQRz9txpw;
        Fri, 27 Mar 2020 07:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585291824; bh=hAABVY6NqVGKI9aIL19sjFZK5w87U11qF1N1xyDIMOU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pDvSIsk8b/wsU/W/xdQHaHU3X4yZMJUw38gYA4+Vv5rXQaJIFGpiAVlSoCpFhxtcW
         3wqHC/fNrVURiU1MrDudrICkh4dbRM085tn5JZ51PA3UPb06TMzFCJt84BAPL8nM8t
         C+u5t5Rwl8Z+4I7bPftzFeS/HLzjjTjKn6xvG/m4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B503C8B7BC;
        Fri, 27 Mar 2020 07:50:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KttQcZwNJpxx; Fri, 27 Mar 2020 07:50:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA0608B756;
        Fri, 27 Mar 2020 07:50:24 +0100 (CET)
Subject: Re: [PATCH 1/1] ppc/crash: Skip spinlocks during crash
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200326222836.501404-1-leonardo@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <af505ef0-e0df-e0aa-bb83-3ed99841f151@c-s.fr>
Date:   Fri, 27 Mar 2020 07:50:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326222836.501404-1-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/03/2020 à 23:28, Leonardo Bras a écrit :
> During a crash, there is chance that the cpus that handle the NMI IPI
> are holding a spin_lock. If this spin_lock is needed by crashing_cpu it
> will cause a deadlock. (rtas_lock and printk logbuf_log as of today)
> 
> This is a problem if the system has kdump set up, given if it crashes
> for any reason kdump may not be saved for crash analysis.
> 
> Skip spinlocks after NMI IPI is sent to all other cpus.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/spinlock.h | 6 ++++++
>   arch/powerpc/kexec/crash.c          | 3 +++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 860228e917dc..a6381d110795 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -111,6 +111,8 @@ static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
>   static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
>   #endif
>   
> +extern bool crash_skip_spinlock __read_mostly;
> +
>   static inline bool is_shared_processor(void)
>   {
>   #ifdef CONFIG_PPC_SPLPAR
> @@ -142,6 +144,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>   		if (likely(__arch_spin_trylock(lock) == 0))
>   			break;
>   		do {
> +			if (unlikely(crash_skip_spinlock))
> +				return;

You are adding a test that reads a global var in the middle of a so hot 
path ? That must kill performance. Can we do different ?

Christophe
