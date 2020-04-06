Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9445EC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A6320672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="slRBn5fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDFSTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:19:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23180 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDFSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:19:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzMb6ZVxz9v0BM;
        Mon,  6 Apr 2020 20:19:23 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=slRBn5fT; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WPQRn9erC4S7; Mon,  6 Apr 2020 20:19:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzMb53Pmz9v0BL;
        Mon,  6 Apr 2020 20:19:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197163; bh=yZgIn2IQa50rMQP6WmsKiaEb+lPusPUrp+Nx/nDnY70=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=slRBn5fT//wm9OLrPXBHGltusxm9LC0swUDaHARxkWwQj9hvtfZPNC/5jxkuC01F8
         CUSf3zEDTK8xLLy+0ZWmXxsCpneAedlzp/9AcRr0qW47bUrTd5aHoe2Mipju9Fdxw1
         vMWAVmp5/MXf/hwOEVFNiRfoMv6BivHGuXJqCNbU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A3FB38B784;
        Mon,  6 Apr 2020 20:19:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G779_yM4ui7G; Mon,  6 Apr 2020 20:19:23 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B2C78B775;
        Mon,  6 Apr 2020 20:19:23 +0200 (CEST)
Subject: Re: [RFC PATCH v2 11/13] powerpc/syscall: Avoid stack frame in likely
 part of syscall_call_exception()
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
 <fc0109635dbca7464d13451ce648ee49893711df.1586108649.git.christophe.leroy@c-s.fr>
 <1586136357.atgut3zasc.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2447d216-1948-c121-4843-6ae5cac6f377@c-s.fr>
Date:   Mon, 6 Apr 2020 20:19:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586136357.atgut3zasc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/04/2020 à 03:29, Nicholas Piggin a écrit :
> Christophe Leroy's on April 6, 2020 3:44 am:
>> When r3 is not modified, reload it from regs->orig_r3 to free
>> volatile registers. This avoids a stack frame for the likely part
>> of syscall_call_exception()
>>
>> Before : 353 cycles on null_syscall
>> After  : 347 cycles on null_syscall
>>

[...]

>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/syscall.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
>> index 69d75fc4a5eb..630c423e089a 100644
>> --- a/arch/powerpc/kernel/syscall.c
>> +++ b/arch/powerpc/kernel/syscall.c
>> @@ -91,6 +91,8 @@ notrace long system_call_exception(long r3, long r4, long r5,
>>   
>>   	} else if (unlikely(r0 >= NR_syscalls)) {
>>   		return -ENOSYS;
>> +	} else {
>> +		r3 = regs->orig_gpr3;
>>   	}
> 
> So this just gives enough volatiles to avoid spilling to stack? I wonder
> about other various options here if they would cause a spill anyway.
> 
> Interesting optimisation, it would definitely need a comment. Would be
> nice if we had a way to tell the compiler that a local can be reloaded
> from a particular address.

Ok, comment added.

Christophe
