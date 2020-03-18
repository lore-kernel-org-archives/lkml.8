Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA7DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3076020767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qfioq/o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCRI4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:56:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32845 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCRI4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:56:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48j3nJ1xJdz9v3FT;
        Wed, 18 Mar 2020 09:56:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qfioq/o2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jkE56YeCrxXm; Wed, 18 Mar 2020 09:56:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48j3nJ0r7yz9v3FS;
        Wed, 18 Mar 2020 09:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584521812; bh=TTKZhsZFwGWKIzyh7cjl+exKyfzWXw6/Oq2wOs8T6ho=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qfioq/o22DjMq3HuuebXzIl1NT172uX70zXt9nvbsy+PZssJqdqNLfN7fBM+MihMn
         2XMt/ib1niqofGYwBavKZZQZw2JwDgSAeVcj5oa4nhfHn9VBsPSgEHAXoQkyikd4pR
         EZJnkuJewEVlN2hgVypxzzXK+cgbkUH17EEdGmGc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24A108B776;
        Wed, 18 Mar 2020 09:56:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id I-Mbg_A4jZho; Wed, 18 Mar 2020 09:56:53 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 412F18B75B;
        Wed, 18 Mar 2020 09:56:52 +0100 (CET)
Subject: Re: [PATCH 09/15] powerpc/watchpoint: Convert thread_struct->hw_brk
 to an array
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-10-ravi.bangoria@linux.ibm.com>
 <0fc9489d-9955-f649-9007-ce6f5da345be@c-s.fr>
 <5efe2f41-2bf3-6927-aa6a-dcedb672c69d@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a1794506-ada3-7b1e-2fa7-bcebf6ec9d68@c-s.fr>
Date:   Wed, 18 Mar 2020 09:56:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5efe2f41-2bf3-6927-aa6a-dcedb672c69d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/03/2020 à 09:36, Ravi Bangoria a écrit :
> 
> 
> On 3/17/20 4:07 PM, Christophe Leroy wrote:
>>
>>
>> Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
>>> So far powerpc hw supported only one watchpoint. But Future Power
>>> architecture is introducing 2nd DAWR. Convert thread_struct->hw_brk
>>> into an array.
>>
>> Looks like you are doing a lot more than that in this patch.
>>
>> Should this patch be splitted in two parts ?
> 
> So far thread_struct->hw_brk was a normal variable so accessing it was 
> simple.
> Once it gets converted into an array, loop needs to be used to access 
> it. So
> all misc changes are basically converting simple access into loops.
> 
> I don't see how this can be splitted.
> 

You could first change all thread_struct->hw_brk to 
thread_struct->hw_brk[0] or thread_struct->hw_brk[i] when you know that 
i can only be 0 for now. Then add the loops and new functions in a 
second patch.

Christophe
