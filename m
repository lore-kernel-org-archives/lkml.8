Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A9C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8184222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="lcwepjZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBSIUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:20:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:46221 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:20:49 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48MqZw693hz9v6Tr;
        Wed, 19 Feb 2020 08:48:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=lcwepjZP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 77g506B4pZUy; Wed, 19 Feb 2020 08:48:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48MqZw4QHkz9v6Tq;
        Wed, 19 Feb 2020 08:48:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582098488; bh=qHw7HSs8FE767P6k4EsiiKkzlSU1+4y80L59F2qTuEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lcwepjZP7ARYfzBVnUEm8aptYTOR/KMHXp3O7whzA41XCjgXWguuUyWf60KNGzYpj
         oROaubwS61tyRrTr71vmEKAZwI/y+1ySOJG4BIV9P7PufstXX6b1dZlxinM9yoNGNy
         pGNDrNmiSSKrtFpc1iZxsmSh/ohtWO6XlK4etj5o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 685F58B827;
        Wed, 19 Feb 2020 08:48:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8fjtfNxb987m; Wed, 19 Feb 2020 08:48:09 +0100 (CET)
Received: from [172.25.230.102] (unknown [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EE6C8B756;
        Wed, 19 Feb 2020 08:48:09 +0100 (CET)
Subject: Re: [PATCH 1/2] powerpc/kprobes: Remove redundant code
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <642c8b4ca59e658be38d8dde00f994e183790a6a.1581687838.git.christophe.leroy@c-s.fr>
 <1582036611.9hm2t8ijhz.naveen@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0fc8e46e-968b-c779-0721-03bb0ba0c33c@c-s.fr>
Date:   Wed, 19 Feb 2020 08:48:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582036611.9hm2t8ijhz.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/02/2020 à 15:39, Naveen N. Rao a écrit :
> Christophe Leroy wrote:
>> At the time being we have something like
>>
>>     if (something) {
>>         p = get();
>>         if (p) {
>>             if (something_wrong)
>>                 goto out;
>>             ...
>>             return;
>>         } else if (a != b) {
>>             if (some_error)
>>                 goto out;
>>             ...
>>         }
>>         goto out;
>>     }
>>     p = get();
>>     if (!p) {
>>         if (a != b) {
>>             if (some_error)
>>                 goto out;
>>             ...
>>         }
>>         goto out;
>>     }
>>
>> This is similar to
>>
>>     p = get();
>>     if (something) {
>>         if (p) {
>>             if (something_wrong)
>>                 goto out;
>>             ...
>>             return;
>>         }
>>     }
>>     if (!p) {
>>         if (a != b) {
>>             if (some_error)
>>                 goto out;
>>             ...
>>         }
>>         goto out;
>>     }
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/kernel/kprobes.c | 15 +--------------
>>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> Good cleanup, thanks.
> 
>>
>> diff --git a/arch/powerpc/kernel/kprobes.c 
>> b/arch/powerpc/kernel/kprobes.c
>> index f8b848aa65bd..7a925eb76ec0 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -276,8 +276,8 @@ int kprobe_handler(struct pt_regs *regs)
>>      kcb = get_kprobe_ctlblk();
>>
>>      /* Check we're not actually recursing */
>> +    p = get_kprobe(addr);
>>      if (kprobe_running()) {
>> -        p = get_kprobe(addr);
>>          if (p) {
>>              kprobe_opcode_t insn = *p->ainsn.insn;
>>              if (kcb->kprobe_status == KPROBE_HIT_SS &&
>> @@ -308,22 +308,9 @@ int kprobe_handler(struct pt_regs *regs)
>>              }
>>              prepare_singlestep(p, regs);
>>              return 1;
>> -        } else if (*addr != BREAKPOINT_INSTRUCTION) {
>> -            /* If trap variant, then it belongs not to us */
>> -            kprobe_opcode_t cur_insn = *addr;
>> -
>> -            if (is_trap(cur_insn))
>> -                goto no_kprobe;
>> -            /* The breakpoint instruction was removed by
>> -             * another cpu right after we hit, no further
>> -             * handling of this interrupt is appropriate
>> -             */
>> -            ret = 1;
>>          }
>> -        goto no_kprobe;
> 
> A minot nit -- removing the above goto makes a slight change to the 
> logic. But, see my comments for the next patch.

All legs of the (p) case are have either a return or a goto, so that 
goto no_kprobe is limited to the !p case, we have to fall_through now.

Christophe
