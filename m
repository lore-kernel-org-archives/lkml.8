Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7142C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D7320772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="I6/Plgav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbgDAJMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:12:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37749 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgDAJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:12:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sgSK4qdgz9txmR;
        Wed,  1 Apr 2020 11:12:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=I6/Plgav; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3OuDUj6fhu3g; Wed,  1 Apr 2020 11:12:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sgSK2RwQz9txmQ;
        Wed,  1 Apr 2020 11:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585732321; bh=v/M1qlUNLZHKi5q5xeuGllGSHSgakulgXfO0VNVJ6NY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I6/Plgav0YcsyHzBZIlcsCiKkXb7KabxBRp0Jp3jQFBwOEM+fOfsRAX3nCboA+rpE
         3fpsluZTKTbRqBDY/IOHQzgSugq9xvAG5h3kt13sXWyKYMrkwrDf+e8Qid3gGRdO1U
         R9bUe8NNCmVxOAocY/ypEEnw7AqpnU4R8pRA+r5c=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 748458B778;
        Wed,  1 Apr 2020 11:12:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id a3-4XKS6Ledk; Wed,  1 Apr 2020 11:12:02 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62FD68B752;
        Wed,  1 Apr 2020 11:12:01 +0200 (CEST)
Subject: Re: [PATCH v2 06/16] powerpc/watchpoint: Provide DAWR number to
 __set_breakpoint
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-7-ravi.bangoria@linux.ibm.com>
 <89f43001-0fa4-1394-4158-878fca4962e3@c-s.fr>
 <cb9ccaa1-9ea2-c3d7-4724-f75ebff4b66d@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d62efd40-4aa6-01e5-a669-3590b121c0f8@c-s.fr>
Date:   Wed, 1 Apr 2020 11:11:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cb9ccaa1-9ea2-c3d7-4724-f75ebff4b66d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 10:57, Ravi Bangoria a écrit :
> 
> 
> On 4/1/20 12:33 PM, Christophe Leroy wrote:
>>
>>
>> Le 01/04/2020 à 08:12, Ravi Bangoria a écrit :
>>> Introduce new parameter 'nr' to __set_breakpoint() which indicates
>>> which DAWR should be programed. Also convert current_brk variable
>>> to an array.
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/debug.h         |  2 +-
>>>   arch/powerpc/include/asm/hw_breakpoint.h |  2 +-
>>>   arch/powerpc/kernel/hw_breakpoint.c      |  8 ++++----
>>>   arch/powerpc/kernel/process.c            | 14 +++++++-------
>>>   arch/powerpc/kernel/signal.c             |  2 +-
>>>   arch/powerpc/xmon/xmon.c                 |  2 +-
>>>   6 files changed, 15 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/debug.h 
>>> b/arch/powerpc/include/asm/debug.h
>>> index 7756026b95ca..6228935a8b64 100644
>>> --- a/arch/powerpc/include/asm/debug.h
>>> +++ b/arch/powerpc/include/asm/debug.h
>>> @@ -45,7 +45,7 @@ static inline int debugger_break_match(struct 
>>> pt_regs *regs) { return 0; }
>>>   static inline int debugger_fault_handler(struct pt_regs *regs) { 
>>> return 0; }
>>>   #endif
>>> -void __set_breakpoint(struct arch_hw_breakpoint *brk);
>>> +void __set_breakpoint(struct arch_hw_breakpoint *brk, int nr);
>>
>> Same, I think it would make more sense to have nr as first argument.
> 
> Sorry, didn't get your point. How will that help?
> 

Well, it is a tiny detail but for me it is more natural to first tel 
which element you modify before telling how you modify it.

Christophe
