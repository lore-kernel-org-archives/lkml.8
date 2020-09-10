Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C4DC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476BA2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0lHLlY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgIJIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:32:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59482 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730085AbgIJIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599726707;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fZGuKxC07VUp0Irvl6Nj323Z7bzMsW/GZh3NECR3ds=;
        b=Q0lHLlY7fQC7P7hA9l1ji8i4pOffxMwt87lk1jZM5PTgfizuoQ6w7QPbMGP8bbbdCCWzzZ
        Qpr6hWj+OAICCWbK4e///u8zTIaa4ei94KjX4knnDa87uUVWUNEvIQ9Jaao+DBoJ9o/1zv
        N6kGgFnoHemoQUIKAeoE0Q4IgN3CYxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-k5TyNAz2OYi7rm-KVdWm5A-1; Thu, 10 Sep 2020 04:31:44 -0400
X-MC-Unique: k5TyNAz2OYi7rm-KVdWm5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3DB21005E5A;
        Thu, 10 Sep 2020 08:31:42 +0000 (UTC)
Received: from [10.64.54.123] (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FFFE10001B3;
        Thu, 10 Sep 2020 08:31:40 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] arm64/mm: Use CONT_SHIFT to define CONT_PTE_SHIFT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
References: <20200908071931.47767-1-gshan@redhat.com>
 <20200908071931.47767-2-gshan@redhat.com>
 <459d0f64-fea9-a060-91a5-17a37834fb1b@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <283283a2-f516-6890-ae25-101d2b1b46a2@redhat.com>
Date:   Thu, 10 Sep 2020 18:31:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <459d0f64-fea9-a060-91a5-17a37834fb1b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/10/20 4:17 PM, Anshuman Khandual wrote:
> On 09/08/2020 12:49 PM, Gavin Shan wrote:
>> The macro CONT_PTE_SHIFT actually depends on CONT_SHIFT, which has
>> been defined in page-def.h, based on CONFIG_ARM64_CONT_SHIFT. Lets
>> reflect the dependency.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/pgtable-hwdef.h | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 8a399e666837..0bd9469f4323 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -81,14 +81,12 @@
>>   /*
>>    * Contiguous page definitions.
>>    */
>> +#define CONT_PTE_SHIFT		(CONT_SHIFT + PAGE_SHIFT)
>>   #ifdef CONFIG_ARM64_64K_PAGES
>> -#define CONT_PTE_SHIFT		(5 + PAGE_SHIFT)
>>   #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
>>   #elif defined(CONFIG_ARM64_16K_PAGES)
>> -#define CONT_PTE_SHIFT		(7 + PAGE_SHIFT)
>>   #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
>>   #else
>> -#define CONT_PTE_SHIFT		(4 + PAGE_SHIFT)
>>   #define CONT_PMD_SHIFT		(4 + PMD_SHIFT)
>>   #endif
> Could not a similar CONT_PMD be created from a new CONFIG_ARM64_CONT_PMD
> config option, which would help unify CONT_PMD_SHIFT here as well ?
> 

I was thinking of it, to have CONFIG_ARM64_CONT_PMD and defined the
following macros in arch/arm64/include/asm/page-def.h:

    #define CONT_PMD_SHIFT	CONFIG_ARM64_CONT_PMD_SHIFT
    #define CONT_PMD_SIZE        (_AC(1, UL) << (CONT_PMD_SHIFT + PMD_SHIFT)
    #define CONT_PMD_MASK        (~(CONT_PMD_SIZE - 1))

PMD_SHIFT is variable because PMD could be folded into PUD or PGD,
depending on the kernel configuration. PMD_SHIFT is declared
in arch/arm64/include/asm/pgtable-types.h, which isn't supposed
to be included in "page-def.h".

So the peroper way to handle this might be drop the continuous page
macros in page-def.h and introduce the following ones into pgtable-hwdef.h.
I will post v2 to do this if it sounds good to you.

    #define CONT_PTE_SHIFT         (CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
    #define CONT_PMD_SHIFT         (CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)

Thanks,
Gavin

