Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1224C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20B1214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCEDPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 22:15:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgCEDPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:15:14 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B11B318CE46A3B88F89C;
        Thu,  5 Mar 2020 11:15:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Mar 2020
 11:14:59 +0800
Subject: Re: [PATCH v3 4/6] powerpc/fsl_booke/64: do not clear the BSS for the
 second pass
To:     Scott Wood <oss@buserror.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <20200206025825.22934-5-yanaijie@huawei.com>
 <feda5c76f134b415d2f43b99b8d6880b9b4b1750.camel@buserror.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <cc95e27e-fe40-9dfb-bed0-079ae38c1357@huawei.com>
Date:   Thu, 5 Mar 2020 11:14:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <feda5c76f134b415d2f43b99b8d6880b9b4b1750.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/5 5:49, Scott Wood 写道:
> On Thu, 2020-02-06 at 10:58 +0800, Jason Yan wrote:
>> The BSS section has already cleared out in the first pass. No need to
>> clear it again. This can save some time when booting with KASLR
>> enabled.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Scott Wood <oss@buserror.net>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/powerpc/kernel/head_64.S | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>> index 744624140fb8..8c644e7c3eaf 100644
>> --- a/arch/powerpc/kernel/head_64.S
>> +++ b/arch/powerpc/kernel/head_64.S
>> @@ -914,6 +914,13 @@ start_here_multiplatform:
>>   	bl      relative_toc
>>   	tovirt(r2,r2)
>>   
>> +	/* Do not clear the BSS for the second pass if randomized */
>> +	LOAD_REG_ADDR(r3, kernstart_virt_addr)
>> +	lwz     r3,0(r3)
>> +	LOAD_REG_IMMEDIATE(r4, KERNELBASE)
>> +	cmpw	r3,r4
>> +	bne	4f
> 
> These are 64-bit values.
> 

Oh yes, will fix. Thanks.

> -Scott
> 
> 
> 
> .
> 

