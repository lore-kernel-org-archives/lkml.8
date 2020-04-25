Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640E3C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B7A20728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQn26i5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgDYUIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgDYUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:08:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD92C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=y0IGL0wQnsioL4agn4c4DRS773a5YjBvAsL0n8C1Fp0=; b=AQn26i5m9yZrqnZxVm5g7UUOnt
        gj9iCN5/Tqc1H1bKfJVw5pZWEPkAQCCgoOemKas9Fy3lwaZGam9op0rB3PQDHAoo+ZIrrI/kYrZyF
        q6x7R/Zd6FvwY47PfMQxPm4gR0awJ1ZkgYNq5vXwGxuG6h8Nr/AWU7iTQYlhiSPA07HBQKRuYSe2Z
        0VgFcQxV3bvzwBx2VGN4473EHhBPehKY/+w8opWaTBAAl6zmCxIk16p9BqHS39upGZhGwNAp1xaUF
        cmHYHdByqZh8tp0qqEvPUBQAVgcBBcylvFuUvZPH4a7L2enC0Kb7PA5mT24ursmP67vLy1ca5FXjT
        sCEESHhA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSR5h-0003au-EZ; Sat, 25 Apr 2020 20:07:57 +0000
Subject: Re: [PATCH] objtool: Fix infinite loop in for_offset_range()
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
References: <02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com>
 <844c4770-5e33-d02c-32d9-200dc7bc4146@infradead.org>
Message-ID: <ef00c23a-294d-5fea-d7ab-7f2834ec9beb@infradead.org>
Date:   Sat, 25 Apr 2020 13:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <844c4770-5e33-d02c-32d9-200dc7bc4146@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/20 1:04 PM, Randy Dunlap wrote:
> On 4/25/20 12:19 PM, Josh Poimboeuf wrote:
>> Randy reported that objtool got stuck in an infinite loop when
>> processing drivers/i2c/busses/i2c-parport.o.  It was caused by the
>> following code:
>>
>>   00000000000001fd <line_set>:
>>    1fd:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
>>    204:	00 00 00
>>   			1ff: R_X86_64_64	.rodata-0x8
>>    207:	41 55                	push   %r13
>>    209:	41 89 f5             	mov    %esi,%r13d
>>    20c:	41 54                	push   %r12
>>    20e:	49 89 fc             	mov    %rdi,%r12
>>    211:	55                   	push   %rbp
>>    212:	48 89 d5             	mov    %rdx,%rbp
>>    215:	53                   	push   %rbx
>>    216:	0f b6 5a 01          	movzbl 0x1(%rdx),%ebx
>>    21a:	48 8d 34 dd 00 00 00 	lea    0x0(,%rbx,8),%rsi
>>    221:	00
>>   			21e: R_X86_64_32S	.rodata
>>    222:	48 89 f1             	mov    %rsi,%rcx
>>    225:	48 29 c1             	sub    %rax,%rcx
>>
>> find_jump_table() saw the .rodata reference and tried to find a jump
>> table associated with it (though there wasn't one).  The -0x8 rela
>> addend is unusual.  It caused find_jump_table() to send a negative
>> table_offset (unsigned 0xfffffffffffffff8) to find_rela_by_dest().
>>
>> The negative offset should have been harmless, but it actually threw
>> for_offset_range() for a loop... literally.  When the mask value got
>> incremented past the end value, it also wrapped to zero, causing the
>> loop exit condition to remain true forever.
>>
>> Prevent this scenario from happening by ensuring the incremented value
>> is always >= the starting value.
>>
>> Fixes: 74b873e49d92 ("objtool: Optimize find_rela_by_dest_range()")
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Hi Josh,
> 
> When applied to linux-next 20200414 (where it was reported) and using
> config-r2092, objtool still loops (I killed it after 6 minutes of CPU time).

Nope, scratch that. Operator error. Sorry.

> When applied to linux-next 20200424 and using the same config-r2092 file,
> objtool appears to terminate normally and the entire build does also.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> thanks.
> 
>> ---


-- 
~Randy

