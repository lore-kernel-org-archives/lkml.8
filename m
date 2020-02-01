Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C5C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774C206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EX2Udq8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgBAH1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:27:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1168 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgBAH1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:27:08 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488lyy42tcz9txXQ;
        Sat,  1 Feb 2020 08:27:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EX2Udq8y; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 70CcpBS5VEwM; Sat,  1 Feb 2020 08:27:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488lyy2ptBz9txXN;
        Sat,  1 Feb 2020 08:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580542026; bh=9l9PsBwIB/NYkRjEMFn4Ks/uI+7ROcMFBYo9P9qvCmw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EX2Udq8yH+9nfUQ150awGDI4kbu47uUcdR/iQ13e34KUPLEXEDPAr3L301v56h+uz
         J3AkG7HZNLNNQPtS6j8KLjNdcvWjGYUJGnEaIgnu4UVPT/tR4dh4O0mU/tgBLgnPmO
         n2+xG/HNbDeNxGI7q9PQtkBGsLKVmxoRlop+74Wo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E75D8B785;
        Sat,  1 Feb 2020 08:27:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UknSbPvdziV1; Sat,  1 Feb 2020 08:27:07 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C7FAB8B752;
        Sat,  1 Feb 2020 08:27:06 +0100 (CET)
Subject: Re: [PATCH] powerpc/32s: Don't flush all TLBs when flushing one page
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <e31c57eb5308a5a73a5c8232454c0dd9f65f6175.1580485014.git.christophe.leroy@c-s.fr>
 <20200131155150.GD22482@gate.crashing.org>
 <27cef66b-df5b-0baa-abac-5532e58bd055@c-s.fr>
 <20200131193833.GF22482@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <248a3cf3-1b5e-a6e1-ceec-0e3904d1cf51@c-s.fr>
Date:   Sat, 1 Feb 2020 08:27:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131193833.GF22482@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/01/2020 à 20:38, Segher Boessenkool a écrit :
> On Fri, Jan 31, 2020 at 05:15:20PM +0100, Christophe Leroy wrote:
>> Le 31/01/2020 à 16:51, Segher Boessenkool a écrit :
>>> On Fri, Jan 31, 2020 at 03:37:34PM +0000, Christophe Leroy wrote:
>>>> When the range is a single page, do a page flush instead.
>>>
>>>> +	start &= PAGE_MASK;
>>>> +	end = (end - 1) | ~PAGE_MASK;
>>>>   	if (!Hash) {
>>>> -		_tlbia();
>>>> +		if (end - start == PAGE_SIZE)
>>>> +			_tlbie(start);
>>>> +		else
>>>> +			_tlbia();
>>>>   		return;
>>>>   	}
>>>
>>> For just one page, you get  end - start == 0  actually?
>>
>> Oops, good catch.
>>
>> Indeed you don't get PAGE_SIZE but (PAGE_SIZE - 1) for just one page.
> 
> You have all low bits masked off in both start and end, so you get zero.
> You could make the condion read "if (start == end)?

No, in end the low bits are set, that's a BIT OR with ~PAGE_MASK, so it 
sets all low bits to 1.

Christophe
