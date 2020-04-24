Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E47FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F03F2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NTI2QR7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDXFsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:48:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55582 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgDXFsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:48:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 497js06b8qz9txyr;
        Fri, 24 Apr 2020 07:48:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NTI2QR7T; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4X1lg0f7G_A7; Fri, 24 Apr 2020 07:48:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 497js05Cywz9txyq;
        Fri, 24 Apr 2020 07:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587707316; bh=cZQkW+Y58ZRO8tjt7cTqj1sSHFk5R4wVIsrFQWlKZIw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NTI2QR7TKfBvduozSqg2+d+f4DNwrWZfpSe2WaF9uBhapSa2TTOtwtg5+P9IUtA6/
         o/i9Q7f2weg4R6Uzvh/lVwM3KAH7iCBdkRol0NOCPUOWmDmDmzOUuptd040xt3cLHw
         PQKKiKLOP9Mv7IEGE5og9jB5UpliTIoljouq0bgk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F5708B775;
        Fri, 24 Apr 2020 07:48:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JHr5gnaN85CB; Fri, 24 Apr 2020 07:48:37 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC91D8B75E;
        Fri, 24 Apr 2020 07:48:34 +0200 (CEST)
Subject: Re: [PATCH v3 13/16] powerpc/watchpoint: Prepare handler to handle
 more than one watcnhpoint
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
 <20200414031659.58875-14-ravi.bangoria@linux.ibm.com>
 <67349339-03df-091a-47f0-78c1b14c5981@c-s.fr>
 <f571127c-89b0-a333-be71-18f411dc6586@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <10ce2343-7fab-8cf8-488b-9768dbc8889a@c-s.fr>
Date:   Fri, 24 Apr 2020 07:48:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f571127c-89b0-a333-be71-18f411dc6586@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

Le 24/04/2020 à 05:32, Ravi Bangoria a écrit :
> Hi Christophe,
> 
>>> @@ -101,14 +129,20 @@ static bool is_ptrace_bp(struct perf_event *bp)
>>>    */
>>>   void arch_unregister_hw_breakpoint(struct perf_event *bp)
>>>   {
>>> +    int i;
>>> +
>>
>> This declaration should be in the block using it.
>>
>>>       /*
>>>        * If the breakpoint is unregistered between a 
>>> hw_breakpoint_handler()
>>>        * and the single_step_dabr_instruction(), then cleanup the 
>>> breakpoint
>>>        * restoration variables to prevent dangling pointers.
>>>        * FIXME, this should not be using bp->ctx at all! Sayeth peterz.
>>>        */
>>> -    if (bp->ctx && bp->ctx->task && bp->ctx->task != ((void *)-1L))
>>> -        bp->ctx->task->thread.last_hit_ubp = NULL;
>>> +    if (bp->ctx && bp->ctx->task && bp->ctx->task != ((void *)-1L)) {
>>
>> Add declaration of 'int i' here.
> 
> How will that help? Keeping declaration at the start of function is also
> common practice and I don't see any recommendation to move them inside
> conditional block.

Reducing the scope of local variables increases readability, you don't 
have to scroll all up to the top of the function to see the declaration 
of the variable.

common practice ? Are you sure ? Just have a look at fs/io_uring.c or 
many other files in the kernel to see how uncommon your practice is.

Christophe
