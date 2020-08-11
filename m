Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0612A2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHKOGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:06:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17274 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgHKOGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:06:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BQvlX2VjCz9vCqh;
        Tue, 11 Aug 2020 16:06:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uyiEbRNZdcYa; Tue, 11 Aug 2020 16:06:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BQvlX0t4Fz9vCqm;
        Tue, 11 Aug 2020 16:06:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B6608BB80;
        Tue, 11 Aug 2020 16:06:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LEGyWSBRNps0; Tue, 11 Aug 2020 16:06:49 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3238A8BB86;
        Tue, 11 Aug 2020 16:06:49 +0200 (CEST)
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH v1] power: don't manage floating point regs when no
 FPU
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <95c00a811897f6d9176d30bf2ac92dab8c9c8e95.1596816789.git.christophe.leroy@csgroup.eu>
 <87o8nh9yjd.fsf@mpe.ellerman.id.au>
Message-ID: <da699207-b172-cf12-a04f-4444313e3e27@csgroup.eu>
Date:   Tue, 11 Aug 2020 16:06:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87o8nh9yjd.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/08/2020 à 14:07, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>   10 files changed, 44 insertions(+), 1 deletion(-)
> 
> In general this looks fine.
> 
> It's a bit #ifdef heavy. Maybe some of those can be cleaned up a bit
> with some wrapper inlines?

Looking at it once more, looks like more or less the same level of 
#ifdefs as things like CONFIG_ALTIVEC for instance. I can't really see 
much opportunities to clean it up.

> 
>> diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> index b2dc4e92d11a..8f87a11f3f8c 100644
>> --- a/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> +++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> @@ -28,6 +29,9 @@ int fpr_get(struct task_struct *target, const struct user_regset *regset,
>>   
>>   	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>>   				   &target->thread.fp_state, 0, -1);
>> +#else
>> +	return 0;
>> +#endif
> 
> Should we return -ENODEV/EIO here? Wonder if another arch can give us a clue.
> 

Looks like we have to do another way  ... another #ifdef ... in the 
definition of native_regsets[] in ptrace-view.c . And then we should be 
able to not build ptrace-novsx.c at all. Will try that.

Christophe
