Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F9C20684
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIAHYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:24:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24769 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:24:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bgdqf4sSrz9v4j1;
        Tue,  1 Sep 2020 09:24:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Sue7XSqcYqIi; Tue,  1 Sep 2020 09:24:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bgdqf43vxz9v4hy;
        Tue,  1 Sep 2020 09:24:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 84BA98B75E;
        Tue,  1 Sep 2020 09:24:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fN6AmSliq6_W; Tue,  1 Sep 2020 09:24:31 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 203528B774;
        Tue,  1 Sep 2020 09:24:31 +0200 (CEST)
Subject: Re: [PATCH v11] Fixup for "powerpc/vdso: Provide
 __kernel_clock_gettime64() on vdso32"
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <7b3e35bdf93b93f3f1f0dcb4e1f373ce3b8a0035.1598938114.git.christophe.leroy@csgroup.eu>
 <20200901071908.GF29521@kitsune.suse.cz>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f0152154-1edb-a51e-b24e-443b072b8ea0@csgroup.eu>
Date:   Tue, 1 Sep 2020 09:24:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901071908.GF29521@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/09/2020 à 09:19, Michal Suchánek a écrit :
> Hello,
> 
> can you add Fixes: ?

That's a commit which is still in powerpc/next-test.
My intention was to provide something that Michael can squash/fixup into 
the culprit commit.

Christophe


> 
> Thanks
> 
> Michal
> 
> On Tue, Sep 01, 2020 at 05:28:57AM +0000, Christophe Leroy wrote:
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/vdso/gettimeofday.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
>> index 59a609a48b63..8da84722729b 100644
>> --- a/arch/powerpc/include/asm/vdso/gettimeofday.h
>> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
>> @@ -186,6 +186,8 @@ int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
>>   #else
>>   int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
>>   			     const struct vdso_data *vd);
>> +int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
>> +			       const struct vdso_data *vd);
>>   int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
>>   			    const struct vdso_data *vd);
>>   #endif
>> -- 
>> 2.25.0
>>
