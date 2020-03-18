Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D4C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D278C2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="esUinrc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCRLo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:44:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28754 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgCRLo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:44:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48j7WC0C0mz9ty2j;
        Wed, 18 Mar 2020 12:44:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=esUinrc0; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8uLqouGGgVFQ; Wed, 18 Mar 2020 12:44:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48j7WB5nk2zB09Zs;
        Wed, 18 Mar 2020 12:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584531894; bh=i9/g7S7vCeFnTbt92JfSyh0tklUAjkcV+vcz9GQlJLE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=esUinrc0CYXh5iVrqAAh4vbUTRmAaN6sx8GwlpVfFD8C3S1NXIIXXpHImrV86V06a
         Wiwu8CV7Ulf3sBc68gS/OxjJ49ewarVB3vuzQj7QjpnK99HLEwfFEjf85Vx/tZ3t/l
         5uXxdFhsR0ToRU7BSyuHr8sHQFwyi1mEvrhdPl9s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DA218B78B;
        Wed, 18 Mar 2020 12:44:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7BX-2czHO79Y; Wed, 18 Mar 2020 12:44:55 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F4CA8B75B;
        Wed, 18 Mar 2020 12:44:55 +0100 (CET)
Subject: Re: [PATCH 12/15] powerpc/watchpoint: Prepare handler to handle more
 than one watcnhpoint
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-13-ravi.bangoria@linux.ibm.com>
 <3ba94856-0d87-5046-eca9-b5c3d99ec654@c-s.fr>
 <87zhcdevz7.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a7829a23-9b4d-0248-415e-85409f17dd77@c-s.fr>
Date:   Wed, 18 Mar 2020 12:44:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zhcdevz7.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/03/2020 à 12:35, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
>>> Currently we assume that we have only one watchpoint supported by hw.
>>> Get rid of that assumption and use dynamic loop instead. This should
>>> make supporting more watchpoints very easy.
>>
>> I think using 'we' is to be avoided in commit message.
> 
> Hmm, is it?
> 
> I use 'we' all the time. Which doesn't mean it's correct, but I think it
> reads OK.
> 
> cheers
> 

 From 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html :

Describe your changes in imperative mood, e.g. “make xyzzy do frotz” 
instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to 
do frotz”, as if you are giving orders to the codebase to change its 
behaviour.

Christophe
