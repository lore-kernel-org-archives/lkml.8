Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C21C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927A422B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Mj+l2GEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgBRTh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:37:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:5911 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgBRTh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:37:27 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48MWMn1qp9z9v2j1;
        Tue, 18 Feb 2020 20:37:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Mj+l2GEo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zQZUrf2UH4df; Tue, 18 Feb 2020 20:37:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48MWMn03Qbz9v2j0;
        Tue, 18 Feb 2020 20:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582054645; bh=rDkFBI9EQ3YlGUxegyfl0jM+87QhL18Ffk+2vHpA/Ls=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mj+l2GEolgrsp5KbT0g9NAKpX9c6SY36I/vGr6g+qWl0H/tWJuwDL1Aw8PLfE+Doh
         lctFGcKZYselqrJ1AJ+524m8CUet+YPbrH9cIozelu/kIOzJIxe+yCCOmvvFwG2V2C
         SjLxqbF8GqKu987psU6WnZrtfBNGsXjajmSR1sB8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E53938B81D;
        Tue, 18 Feb 2020 20:37:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wGrNy4FbrMXz; Tue, 18 Feb 2020 20:37:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 033178B80C;
        Tue, 18 Feb 2020 20:37:23 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/kprobes: Fix trap address when trap happened
 in real mode
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@kernel.vger.org
References: <0cd6647dae57894f77ceb7d5a48d52fac6c10ca5.1582036047.git.christophe.leroy@c-s.fr>
 <1582037375.4mkd6m1m5m.naveen@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <54419d86-3cd9-f20a-4aa0-85aac5bbe846@c-s.fr>
Date:   Tue, 18 Feb 2020 20:37:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582037375.4mkd6m1m5m.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/02/2020 à 15:55, Naveen N. Rao a écrit :
> Christophe Leroy wrote:
>> When a program check exception happens while MMU translation is
>> disabled, following Oops happens in kprobe_handler() in the following
>> code:
>>
>>         } else if (*addr != BREAKPOINT_INSTRUCTION) {
>>
>> [   33.098554] BUG: Unable to handle kernel data access on read at 
>> 0x0000e268
>> [   33.105091] Faulting instruction address: 0xc000ec34
>> [   33.110010] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   33.115348] BE PAGE_SIZE=16K PREEMPT CMPC885
>> [   33.119540] Modules linked in:
>> [   33.122591] CPU: 0 PID: 429 Comm: cat Not tainted 
>> 5.6.0-rc1-s3k-dev-00824-g84195dc6c58a #3267
>> [   33.131005] NIP:  c000ec34 LR: c000ecd8 CTR: c019cab8
>> [   33.136002] REGS: ca4d3b58 TRAP: 0300   Not tainted  
>> (5.6.0-rc1-s3k-dev-00824-g84195dc6c58a)
>> [   33.144324] MSR:  00001032 <ME,IR,DR,RI>  CR: 2a4d3c52  XER: 00000000
>> [   33.150699] DAR: 0000e268 DSISR: c0000000
>> [   33.150699] GPR00: c000b09c ca4d3c10 c66d0620 00000000 ca4d3c60 
>> 00000000 00009032 00000000
>> [   33.150699] GPR08: 00020000 00000000 c087de44 c000afe0 c66d0ad0 
>> 100d3dd6 fffffff3 00000000
>> [   33.150699] GPR16: 00000000 00000041 00000000 ca4d3d70 00000000 
>> 00000000 0000416d 00000000
>> [   33.150699] GPR24: 00000004 c53b6128 00000000 0000e268 00000000 
>> c07c0000 c07bb6fc ca4d3c60
>> [   33.188015] NIP [c000ec34] kprobe_handler+0x128/0x290
>> [   33.192989] LR [c000ecd8] kprobe_handler+0x1cc/0x290
>> [   33.197854] Call Trace:
>> [   33.200340] [ca4d3c30] [c000b09c] program_check_exception+0xbc/0x6fc
>> [   33.206590] [ca4d3c50] [c000e43c] ret_from_except_full+0x0/0x4
>> [   33.212392] --- interrupt: 700 at 0xe268
>> [   33.270401] Instruction dump:
>> [   33.273335] 913e0008 81220000 38600001 3929ffff 91220000 80010024 
>> bb410008 7c0803a6
>> [   33.280992] 38210020 4e800020 38600000 4e800020 <813b0000> 6d2a7fe0 
>> 2f8a0008 419e0154
>> [   33.288841] ---[ end trace 5b9152d4cdadd06d ]---
>>
>> kprobe is not prepared to handle events in real mode and functions
>> running in real mode should have been blacklisted, so kprobe_handler()
>> can safely bail out telling 'this trap is not mine' for any trap that
>> happened while in real-mode.
>>
>> If the trap happened with MSR_IR cleared, return 0 immediately.
>>
>> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Fixes: 6cc89bad60a6 ("powerpc/kprobes: Invoke handlers directly")
>> Cc: stable@vger.kernel.org
>> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> ---
>> v2: bailing out instead of converting real-time address to virtual and 
>> continuing.
>>
>> The bug might have existed even before that commit from Naveen.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/kernel/kprobes.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/kprobes.c 
>> b/arch/powerpc/kernel/kprobes.c
>> index 2d27ec4feee4..673f349662e8 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -264,6 +264,9 @@ int kprobe_handler(struct pt_regs *regs)
>>      if (user_mode(regs))
>>          return 0;
>>
>> +    if (!(regs->msr & MSR_IR))
>> +        return 0;
>> +
> 
> Should we also check for MSR_DR? Are there scenarios with ppc32 where 
> MSR_IR is on, but MSR_DR is off?

Yes indeed.

Christophe
