Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD06C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14B82078B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:55:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12515 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgIKJzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:55:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bnrhf3d4Qz9v1Z1;
        Fri, 11 Sep 2020 11:54:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1uQtGWb0214J; Fri, 11 Sep 2020 11:54:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bnrhf2VxJz9v1Yd;
        Fri, 11 Sep 2020 11:54:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D49728B83B;
        Fri, 11 Sep 2020 11:54:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 71B-b_lCudje; Fri, 11 Sep 2020 11:54:58 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF0128B838;
        Fri, 11 Sep 2020 11:54:55 +0200 (CEST)
Subject: Re: [PATCH] powerpc/traps: fix recoverability of machine check
 handling on book3s/32
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
 <20200911091542.GE29521@kitsune.suse.cz>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <69e1863a-468d-55d7-f2b2-e700b22609a3@csgroup.eu>
Date:   Fri, 11 Sep 2020 11:54:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911091542.GE29521@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Le 11/09/2020 à 11:15, Michal Suchánek a écrit :
> Hello,
> 
> does this logic apply to "Unrecoverable System Reset" as well?

I don't know, I don't think I have any way the generate a System Reset 
on my board to check it.

Christophe

> 
> Thanks
> 
> Michal
> 
> On Tue, Jan 22, 2019 at 02:11:24PM +0000, Christophe Leroy wrote:
>> Looks like book3s/32 doesn't set RI on machine check, so
>> checking RI before calling die() will always be fatal
>> allthought this is not an issue in most cases.
>>
>> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
>> Fixes: daf00ae71dad ("powerpc/traps: restore recoverability of machine_check interrupts")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: stable@vger.kernel.org
>> ---
>>   arch/powerpc/kernel/traps.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 64936b60d521..c740f8bfccc9 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -763,15 +763,15 @@ void machine_check_exception(struct pt_regs *regs)
>>   	if (check_io_access(regs))
>>   		goto bail;
>>   
>> -	/* Must die if the interrupt is not recoverable */
>> -	if (!(regs->msr & MSR_RI))
>> -		nmi_panic(regs, "Unrecoverable Machine check");
>> -
>>   	if (!nested)
>>   		nmi_exit();
>>   
>>   	die("Machine check", regs, SIGBUS);
>>   
>> +	/* Must die if the interrupt is not recoverable */
>> +	if (!(regs->msr & MSR_RI))
>> +		nmi_panic(regs, "Unrecoverable Machine check");
>> +
>>   	return;
>>   
>>   bail:
>> -- 
>> 2.13.3
>>
