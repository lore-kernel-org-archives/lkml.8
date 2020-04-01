Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF70C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DFF2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TxtpxE0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgDAHFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:05:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52706 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731792AbgDAHFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:05:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48scfX1Flxz9v9vW;
        Wed,  1 Apr 2020 09:05:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TxtpxE0O; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oUWU8ClbUtFF; Wed,  1 Apr 2020 09:05:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48scfX00mTz9v9vV;
        Wed,  1 Apr 2020 09:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585724740; bh=5Fr6a41jwvLb6f6snVAMPm05DPoHZ6HdhWE6bi2fA4Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TxtpxE0OLS+oPjGQ+Iz3BgbbyKg98h5fUHYliby0DBphyPCEbalxpn3JVkXrUIYgw
         bSzgVSh3F7ZLcwZ2Jn5/z7ssu1qqQzfdRvfhB4ahQVRTNYyukPkxMXADRPQakrdCIm
         8kFRkarwSwmqcyX3ZppnB/6v4biWYs97cd+49gQE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 993748B7B3;
        Wed,  1 Apr 2020 09:05:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ltQB2BylwNYc; Wed,  1 Apr 2020 09:05:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FB718B778;
        Wed,  1 Apr 2020 09:05:37 +0200 (CEST)
Subject: Re: [PATCH v2 03/16] powerpc/watchpoint: Introduce function to get nr
 watchpoints dynamically
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-4-ravi.bangoria@linux.ibm.com>
 <7851b702-8a93-11a8-6553-e0a51967dfc0@c-s.fr>
 <b6ff59ce-8251-c50f-1c0e-b1f54fccb09f@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <589df2d6-8fd0-8dab-9197-497610f0873b@c-s.fr>
Date:   Wed, 1 Apr 2020 09:05:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b6ff59ce-8251-c50f-1c0e-b1f54fccb09f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 08:50, Ravi Bangoria a écrit :
> 
> 
> On 4/1/20 11:59 AM, Christophe Leroy wrote:
>>
>>
>> Le 01/04/2020 à 08:12, Ravi Bangoria a écrit :
>>> So far we had only one watchpoint, so we have hardcoded HBP_NUM to 1.
>>> But future Power architecture is introducing 2nd DAWR and thus kernel
>>> should be able to dynamically find actual number of watchpoints
>>> supported by hw it's running on. Introduce function for the same.
>>> Also convert HBP_NUM macro to HBP_NUM_MAX, which will now represent
>>> maximum number of watchpoints supported by Powerpc.
>>
>>
>> Everywhere else in the code, it is called 'breakpoint', not 'watchpoint'.
>>
>> Wouldn't it be more consistent to call the function nr_bp_slots() 
>> instead of nr_wp_slots() ?
>>
>> Especially as we are likely going to extend your changes to support 
>> DABR2 in addition to DABR on BOOK3S/32.
> 
> Sure. I don't have strong onion for nr_wp_slots() and I can rename it to
> nr_bp_slots(). but...
> 
> Even though existing code uses breakpoint and watchpoint interchangeably,
> I'm using wp/watchpoint to represent data-breakpoint, to distinguish it
> from instruction-breakpoint (CIABR). So IMHO, nr_wp_slots() should return
> number DAWRs/DABRs and nr_bp_slots() should return number of CIABRs. Is
> that okay?
> 


Yes that makes sense too. Up to you.

Christophe
