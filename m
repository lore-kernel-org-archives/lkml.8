Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F618C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F70214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pGR3WMix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgAaQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:15:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1820 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgAaQP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:15:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488Mkw26tmz9vBmL;
        Fri, 31 Jan 2020 17:15:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pGR3WMix; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WdDgEsSDAfbI; Fri, 31 Jan 2020 17:15:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488Mkw10dPz9vBmJ;
        Fri, 31 Jan 2020 17:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580487320; bh=o5yWGjXEXWXnjLbutHUQSZ+G5ebY4nbrRZo8BmI5TZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pGR3WMixkkpS91gWzrasTrWX98G3LrXQa6v5NyT59rI0vfjifEhWnAUX/caZAB9TZ
         yHdYn12Fdl4/hf0LpABTzyaGcxj9QbMhaQV2kh4LKV9cqMfJOrCAyFrA0LXr/xndfS
         KpddG7pYFUmX5Oz937DzgbEVVnQAdbvSCNx9xyCw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ADB908B8B9;
        Fri, 31 Jan 2020 17:15:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SmoWZXSwTTAa; Fri, 31 Jan 2020 17:15:21 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 30D9C8B8B4;
        Fri, 31 Jan 2020 17:15:21 +0100 (CET)
Subject: Re: [PATCH] powerpc/32s: Don't flush all TLBs when flushing one page
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <e31c57eb5308a5a73a5c8232454c0dd9f65f6175.1580485014.git.christophe.leroy@c-s.fr>
 <20200131155150.GD22482@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <27cef66b-df5b-0baa-abac-5532e58bd055@c-s.fr>
Date:   Fri, 31 Jan 2020 17:15:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131155150.GD22482@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/01/2020 à 16:51, Segher Boessenkool a écrit :
> On Fri, Jan 31, 2020 at 03:37:34PM +0000, Christophe Leroy wrote:
>> When the range is a single page, do a page flush instead.
> 
>> +	start &= PAGE_MASK;
>> +	end = (end - 1) | ~PAGE_MASK;
>>   	if (!Hash) {
>> -		_tlbia();
>> +		if (end - start == PAGE_SIZE)
>> +			_tlbie(start);
>> +		else
>> +			_tlbia();
>>   		return;
>>   	}
> 
> For just one page, you get  end - start == 0  actually?
> 
> 

Oops, good catch.

Indeed you don't get PAGE_SIZE but (PAGE_SIZE - 1) for just one page.

Christophe
