Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74017C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236C92080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgIFSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:47:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42508 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgIFSrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:47:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bl0l2679Hz9v1YS;
        Sun,  6 Sep 2020 20:47:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ylojAXSPUtYv; Sun,  6 Sep 2020 20:47:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bl0l25B0mz9v1YR;
        Sun,  6 Sep 2020 20:47:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B16218B778;
        Sun,  6 Sep 2020 20:47:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NvuMSJnOgbvh; Sun,  6 Sep 2020 20:47:14 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 660888B75B;
        Sun,  6 Sep 2020 20:47:13 +0200 (CEST)
Subject: Re: [PATCH] /dev/zero: also implement ->read
To:     Pavel Machek <pavel@denx.de>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
 <20200906182122.GA12295@amd>
 <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
 <20200906183820.GA13290@amd>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3cae5587-0843-83a9-bf4a-9c1426d499e4@csgroup.eu>
Date:   Sun, 6 Sep 2020 20:47:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200906183820.GA13290@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/09/2020 à 20:38, Pavel Machek a écrit :
> On Sun 2020-09-06 20:35:38, Christophe Leroy wrote:
>> Hi,
>>
>> Le 06/09/2020 à 20:21, Pavel Machek a écrit :
>>> Hi!
>>>
>>>>>> Christophe reported a major speedup due to avoiding the iov_iter
>>>>>> overhead, so just add this trivial function.  Note that /dev/zero
>>>>>> already implements both an iter and non-iter writes so this just
>>>>>> makes it more symmetric.
>>>>>>
>>>>>> Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>
>>>>> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>
>>>> Any idea what has happened to make the 'iter' version so bad?
>>>
>>> Exactly. Also it would be nice to note how the speedup was measured
>>> and what the speedup is.
>>>
>>
>> Was measured on an 8xx powerpc running at 132MHz with:

Oops. That was not on an 8xx but on an 8321 running at 333MHz, sorry.

>>
>> 	dd if=/dev/zero of=/dev/null count=1M
>>
>> With the patch, dd displays a throughput of 113.5MB/s
>> Without the patch it is 99.9MB/s
> 
> Actually... that does not seem like a huge deal. read(/dev/zero) is
> not that common operation.

That's 14% more. It is not negligeable.

I think I need to measure the /dev/zero read standalone. I guess the 
write to /dev/null flatters the result.

> 
> Are you getting similar speedups on normal hardware?
> 

Do you regard powerpc embedded devices as abnormal ?
AFAIK the 832x is embedded in millions of ADSL boxes.
What processor do you have in mind as normal hardware ?

Christophe
