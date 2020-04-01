Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B55C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3688206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uKCtURhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgDAGwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:52:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60353 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730426AbgDAGwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:52:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48scM75K1Yz9v9vR;
        Wed,  1 Apr 2020 08:52:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uKCtURhk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pkk-w7syNar8; Wed,  1 Apr 2020 08:52:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48scM74Dztz9v9vQ;
        Wed,  1 Apr 2020 08:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585723939; bh=7IkbZ0/SJ5cqCbVKE4dlHc2ETYKSRoSACmPbMq5apUI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uKCtURhk9VySMoUKC7IdGaSLslnuD04Hc/f1wvirLysE+LofPSqG4Ru+oy1X584OA
         Ho5LjEXmoS9Iy/7OhPK0b6FtP4ICffUTwbPdBj1pxzeSbKS4puywcwgMLUTDUz5tpQ
         zJJWxoiAP6KGUeKkQHvQ+9eJpJk3GWKXL8OZz9AU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A7C58B7B5;
        Wed,  1 Apr 2020 08:52:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Kh4vKqmamd0L; Wed,  1 Apr 2020 08:52:20 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A21438B778;
        Wed,  1 Apr 2020 08:52:18 +0200 (CEST)
Subject: Re: [PATCH v2 14/16] powerpc/watchpoint: Don't allow concurrent perf
 and ptrace events
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-15-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ecd8e941-11b8-1769-e16a-0b91fd9ae2de@c-s.fr>
Date:   Wed, 1 Apr 2020 08:52:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401061309.92442-15-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
> With Book3s DAWR, ptrace and perf watchpoints on powerpc behaves
> differently. Ptrace watchpoint works in one-shot mode and generates
> signal before executing instruction. It's ptrace user's job to
> single-step the instruction and re-enable the watchpoint. OTOH, in
> case of perf watchpoint, kernel emulates/single-steps the instruction
> and then generates event. If perf and ptrace creates two events with
> same or overlapping address ranges, it's ambiguous to decide who
> should single-step the instruction. Because of this issue, don't
> allow perf and ptrace watchpoint at the same time if their address
> range overlaps.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h |   2 +
>   arch/powerpc/kernel/hw_breakpoint.c      | 222 +++++++++++++++++++++++
>   kernel/events/hw_breakpoint.c            |  16 ++
>   3 files changed, 240 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index abc4603c0efe..9d3bd1169591 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -70,6 +70,8 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>   						unsigned long val, void *data);
>   int arch_install_hw_breakpoint(struct perf_event *bp);
>   void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> +int arch_reserve_bp_slot(struct perf_event *bp);
> +void arch_release_bp_slot(struct perf_event *bp);
>   void arch_unregister_hw_breakpoint(struct perf_event *bp);
>   void hw_breakpoint_pmu_read(struct perf_event *bp);
>   extern void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 07a6cdea84ed..f813acb0d9f0 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -123,6 +123,228 @@ static bool is_ptrace_bp(struct perf_event *bp)
>   	return bp->overflow_handler == ptrace_triggered;
>   }
>   
> +struct breakpoint {
> +	struct list_head list;
> +	struct perf_event *bp;
> +	bool ptrace_bp;
> +};
> +
> +static DEFINE_PER_CPU(struct breakpoint *, cpu_bps[HBP_NUM_MAX]);
> +static LIST_HEAD(task_bps);
> +
> +static struct breakpoint *alloc_breakpoint(struct perf_event *bp)
> +{
> +	struct breakpoint *tmp;
> +
> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp)
> +		return ERR_PTR(-ENOMEM);
> +	tmp->bp = bp;
> +	tmp->ptrace_bp = is_ptrace_bp(bp);
> +	return tmp;
> +}
> +
> +static bool bp_addr_range_overlap(struct perf_event *bp1, struct perf_event *bp2)
> +{
> +	__u64 bp1_saddr, bp1_eaddr, bp2_saddr, bp2_eaddr;
> +
> +	bp1_saddr = ALIGN_DOWN(bp1->attr.bp_addr, HW_BREAKPOINT_SIZE);
> +	bp1_eaddr = ALIGN(bp1->attr.bp_addr + bp1->attr.bp_len, HW_BREAKPOINT_SIZE) - 1;
> +	bp2_saddr = ALIGN_DOWN(bp2->attr.bp_addr, HW_BREAKPOINT_SIZE);
> +	bp2_eaddr = ALIGN(bp2->attr.bp_addr + bp2->attr.bp_len, HW_BREAKPOINT_SIZE) - 1;
> +
> +	return (bp1_saddr <= bp2_eaddr && bp1_eaddr >= bp2_saddr);

Could avoid the - 1 on bp1_eaddr and bp2_eaddr by doing:

	return (bp1_saddr < bp2_eaddr && bp1_eaddr > bp2_saddr);


Christophe
