Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F10C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6BD20888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595500750;
	bh=apvuZXcE3NwSq8Rub1Rf3Pf5mgh3zdcbbQk5pgSXCaw=;
	h=Reply-To:Subject:To:References:From:Date:In-Reply-To:List-ID:
	 From;
	b=pPE20oD5+4noqp3ark5kO8yO8cdV6nHMkpcLFXYIWnJUmHvaMioNfKnMme0zaJ9LL
	 KE5R27OzOfLacSaFC5cllPURFKIX4kFkNTHB/gBK8de9w4wpyhJHYvYnAqX2eWaLTV
	 ZnplBmHe8n+xgade9jTC82PCJ9bY+5hNI44V/Amc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgGWKjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWKjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:39:08 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F7620737;
        Thu, 23 Jul 2020 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595500747;
        bh=apvuZXcE3NwSq8Rub1Rf3Pf5mgh3zdcbbQk5pgSXCaw=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To:From;
        b=N0iuaU+lyfIjjT31c9L8+skrMoJzTO/uESoDm2zeYCONnGxJXS7h6ETI5ZlMTtTZC
         0PLJ+Na7DWHdRB4OXtLgVWQKMMHVq218SkhHgV5n/giKOXfDb2+m3mZZBKGLxsTHfF
         LyvF2cxcLBrp1AHR0EukcQS9Z1X1JEGiADe+d1qM=
Reply-To: kbingham@kernel.org
Subject: Re: [PATCH] scripts/gdb: fix lx-symbols 'gdb.error' while loading
 modules
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200722102239.313231-1-sgarzare@redhat.com>
 <418f0953-1815-1844-e3f5-a11f2a5eaf33@siemens.com>
From:   Kieran Bingham <kbingham@kernel.org>
Autocrypt: addr=kbingham@kernel.org; keydata=
 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
Message-ID: <e04efb70-d29d-677b-4359-49b638eef3d0@kernel.org>
Date:   Thu, 23 Jul 2020 11:39:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <418f0953-1815-1844-e3f5-a11f2a5eaf33@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 23/07/2020 11:25, Jan Kiszka wrote:
> On 22.07.20 12:22, Stefano Garzarella wrote:
>> Commit ed66f991bb19 ("module: Refactor section attr into bin
>> attribute") removed the 'name' field from 'struct module_sect_attr'
>> triggering the following error when invoking lx-symbols:
>>
>>    (gdb) lx-symbols
>>    loading vmlinux
>>    scanning for modules in linux/build
>>    loading @0xffffffffc014f000: linux/build/drivers/net/tun.ko
>>    Python Exception <class 'gdb.error'> There is no member named name.:
>>    Error occurred in Python: There is no member named name.
>>
>> This patch fixes the issue taking the module name from the 'struct
>> attribute'.
>>

It might not be needed if this gets in to v5.8 in time, but perhaps:

Fixes: ed66f991bb19 ("module: Refactor section attr into bin attribute")

>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Otherwise, also looks fine to me.

Reviewed-by: Kieran Bingham <kbingham@kernel.org>

>> ---
>>   scripts/gdb/linux/symbols.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
>> index be984aa29b75..1be9763cf8bb 100644
>> --- a/scripts/gdb/linux/symbols.py
>> +++ b/scripts/gdb/linux/symbols.py
>> @@ -96,7 +96,7 @@ lx-symbols command."""
>>               return ""
>>           attrs = sect_attrs['attrs']
>>           section_name_to_address = {
>> -            attrs[n]['name'].string(): attrs[n]['address']
>> +            attrs[n]['battr']['attr']['name'].string():
>> attrs[n]['address']
>>               for n in range(int(sect_attrs['nsections']))}
>>           args = []
>>           for section_name in [".data", ".data..read_mostly",
>> ".rodata", ".bss",
>>
> 
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Thanks,
> Jan
> 


-- 
--
Kieran
