Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB2C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE8820882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuCRn09G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgIJKAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:00:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730493AbgIJJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599731809;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKrok+4G3YivlFdtR5hJYqXNeCQUSOlGeu6cAcn1/oI=;
        b=QuCRn09GMDhMLLllkX6rzVv9419j03dE5xKQXe5LCS8+6ECv06BWPD2WqFtTimTkQOGewI
        Q3/15ctsmjOC9zkItHwhqNfuS3+0H34F6s3ZVNXIcPdzkrV7tGDvH7oVMybw/Ry2ETyPx0
        5dOfeGLgKtZvW3cOH03UCm2hgK/dwGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-BCBpAEiXO12tezHLeO3ZkA-1; Thu, 10 Sep 2020 05:56:45 -0400
X-MC-Unique: BCBpAEiXO12tezHLeO3ZkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C870C2FD00;
        Thu, 10 Sep 2020 09:56:43 +0000 (UTC)
Received: from [10.64.54.123] (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E6C81F44;
        Thu, 10 Sep 2020 09:56:41 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] arm64/mm: Use CONT_SHIFT to define CONT_PTE_SHIFT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
References: <20200908071931.47767-1-gshan@redhat.com>
 <20200908071931.47767-2-gshan@redhat.com>
 <459d0f64-fea9-a060-91a5-17a37834fb1b@arm.com>
 <283283a2-f516-6890-ae25-101d2b1b46a2@redhat.com>
 <966505a6-16f6-8129-804b-fcf890429fb8@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <b253e307-eec4-3cd9-b921-2c6672120e9b@redhat.com>
Date:   Thu, 10 Sep 2020 19:56:35 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <966505a6-16f6-8129-804b-fcf890429fb8@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/10/20 7:28 PM, Anshuman Khandual wrote:
> On 09/10/2020 02:01 PM, Gavin Shan wrote:
>> On 9/10/20 4:17 PM, Anshuman Khandual wrote:
>>> On 09/08/2020 12:49 PM, Gavin Shan wrote:
>>>> The macro CONT_PTE_SHIFT actually depends on CONT_SHIFT, which has
>>>> been defined in page-def.h, based on CONFIG_ARM64_CONT_SHIFT. Lets
>>>> reflect the dependency.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    arch/arm64/include/asm/pgtable-hwdef.h | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>>>> index 8a399e666837..0bd9469f4323 100644
>>>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>>>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>>>> @@ -81,14 +81,12 @@
>>>>    /*
>>>>     * Contiguous page definitions.
>>>>     */
>>>> +#define CONT_PTE_SHIFT        (CONT_SHIFT + PAGE_SHIFT)
>>>>    #ifdef CONFIG_ARM64_64K_PAGES
>>>> -#define CONT_PTE_SHIFT        (5 + PAGE_SHIFT)
>>>>    #define CONT_PMD_SHIFT        (5 + PMD_SHIFT)
>>>>    #elif defined(CONFIG_ARM64_16K_PAGES)
>>>> -#define CONT_PTE_SHIFT        (7 + PAGE_SHIFT)
>>>>    #define CONT_PMD_SHIFT        (5 + PMD_SHIFT)
>>>>    #else
>>>> -#define CONT_PTE_SHIFT        (4 + PAGE_SHIFT)
>>>>    #define CONT_PMD_SHIFT        (4 + PMD_SHIFT)
>>>>    #endif
>>> Could not a similar CONT_PMD be created from a new CONFIG_ARM64_CONT_PMD
>>> config option, which would help unify CONT_PMD_SHIFT here as well ?
>>>
>>
>> I was thinking of it, to have CONFIG_ARM64_CONT_PMD and defined the
>> following macros in arch/arm64/include/asm/page-def.h:
>>
>>     #define CONT_PMD_SHIFT    CONFIG_ARM64_CONT_PMD_SHIFT
>>     #define CONT_PMD_SIZE        (_AC(1, UL) << (CONT_PMD_SHIFT + PMD_SHIFT)
>>     #define CONT_PMD_MASK        (~(CONT_PMD_SIZE - 1))
>>
>> PMD_SHIFT is variable because PMD could be folded into PUD or PGD,
>> depending on the kernel configuration. PMD_SHIFT is declared
> 
> Even CONT_PMD_SHIFT via the new CONFIG_ARM64_CONT_PMD_SHIFT will
> be a variable as well depending on page size.
> 

Yes, it depends on the variable PMD_SHIFT.

>> in arch/arm64/include/asm/pgtable-types.h, which isn't supposed
>> to be included in "page-def.h".
> 
> Are there build failures if <pgtable-types.h> is included from <page-def.h> ?
> 

Yes, something like this:

   AS      arch/arm64/kernel/head.o
In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8,
                  from ./arch/arm64/include/asm/page-def.h:12,
                  from ./arch/arm64/include/asm/page.h:11,
                  from ./arch/arm64/include/asm/proc-fns.h:14,
                  from ./arch/arm64/include/asm/pgtable.h:9,
                  from ./include/linux/pgtable.h:6,
                  from ./arch/arm64/include/asm/io.h:12,
                  from ./include/linux/io.h:13,
                  from drivers/bus/vexpress-config.c:9:
./arch/arm64/include/asm/memory.h:91:55: warning: "PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
  #if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
                                                        ^~~~~~~~~~
./arch/arm64/include/asm/memory.h:97:21: warning: "PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
  #if THREAD_SHIFT >= PAGE_SHIFT
                      ^~~~~~~~~~


>>
>> So the peroper way to handle this might be drop the continuous page
>> macros in page-def.h and introduce the following ones into pgtable-hwdef.h.
>> I will post v2 to do this if it sounds good to you.
> 
> Sure, go ahead if that builds. But unifying both these macros seems cleaner.
> 

Thanks for your confirmation. v2 is on the way :)

>>
>>     #define CONT_PTE_SHIFT         (CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
>>     #define CONT_PMD_SHIFT         (CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
>>

Thanks,
Gavin

