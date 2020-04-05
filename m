Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F5C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9D020659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eJQ3oG1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDESxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 14:53:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23813 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDESxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 14:53:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wN9T41YPz9tx5x;
        Sun,  5 Apr 2020 20:53:33 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eJQ3oG1e; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rPwFmN31zfvx; Sun,  5 Apr 2020 20:53:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wN9T2t7Vz9tx5w;
        Sun,  5 Apr 2020 20:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586112813; bh=90bPcvM3Kr4KjzMKiGYjpWqCbKmKJ+xpkekjY3cVUhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eJQ3oG1ebDmiDGHzDikOxVWGvPigmsoEYiiyN/LJjcvcAHCs4LnhNB82kOiD64ME5
         Elaf5u+hqdwsLi6oguAVkE6PJtJeYrWZSxeAUWZxYNWo3NcWi/U05qkcI+PI32sk9N
         gW96UdqFlzinI2CilHJOhz7SUFwqZOxYC/XBEvE4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11BA08B783;
        Sun,  5 Apr 2020 20:53:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QxPOLoXO54EU; Sun,  5 Apr 2020 20:53:37 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 200BC8B774;
        Sun,  5 Apr 2020 20:53:36 +0200 (CEST)
Subject: Re: [RFC WIP PATCH] powerpc/32: system call implement entry/exit
 logic in C
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <bbc0a09cfaf523bc00893253a7101362c98b31eb.1585667934.git.christophe.leroy@c-s.fr>
 <059c1abd-6be2-25ea-83e0-dcd411b7951b@c-s.fr>
 <1585898897.1jwur86s6a.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fa79eac6-49e6-bbb0-5faa-7d52662a0cbe@c-s.fr>
Date:   Sun, 5 Apr 2020 20:53:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585898897.1jwur86s6a.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/04/2020 à 09:33, Nicholas Piggin a écrit :
> Christophe Leroy's on April 1, 2020 9:48 pm:
>>
>>
>> Le 31/03/2020 à 17:22, Christophe Leroy a écrit :
>>> That's first try to port PPC64 syscall entry/exit logic in C to PPC32.
>>> I've do the minimum to get it work. I have not reworked calls
>>> to sys_fork() and friends for instance.
>>>
>>> For the time being, it seems to work more or less but:
>>> - ping reports EINVAL on recvfrom
>>> - strace shows NULL instead of strings in call like open() for instance.
>>
>> For the two above problems, that's because system_call_exception()
>> doesn't set orig_gpr3 whereas DoSycall() does in entry_32.S . Is that
>> only done on PPC32 ?
>>
>> With the following line at the begining of system_call_exception(), it
>> works perfectly:
>>
>> 	regs->orig_gpr3 = r3;
> 
> Oh great, nice work. We should be able to make some simple helpers or
> move some things a bit to reduce the amount of ifdefs in the C code.
> It doesn't look too bad though.
> 
>> I will now focus on performance to see if we can do something about it.
> 
> What's the performance difference between current asm code just with
> always saving NVGPRS vs C?

Done new measurement and sent a series. lower values now because the 
time accounting was done twice as it was still in the ASM part.

Before the series, 311 cycles for a null_syscall
If adding SAVE_NVGPRS to the entry macro, 335 cycles

First patch: 353 cycles ie +13,5%

After a few changes, including conditional saving of non volatile 
registers, I get 325 cycles that is only +4,5%. I thing that's acceptable.

Do you see a problem with still saving non volatile registers only when 
required ?

Christophe
