Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC860C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD24E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ueHpjbBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgFOGy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgFOGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:54:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E546EC061A0E;
        Sun, 14 Jun 2020 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=dQJCGP6VA9gdVTj0ppUWQ7WVo1jk9/p7fOrW4EfMtEQ=; b=ueHpjbBWg0Bg2UOx/7VbJOyfsP
        BLXvhNkYxRkcHjRpz7UAlhaR89wynVLbnIHp59+/RI3Wa+aiL1ZfVu8vn+Wl+jGpXGn2i8WE4a9+Y
        Dp01s+PiLh97Zn7MnqE5tqpnWPctnIvaYs9XwhMUXS0doDqxSGu3ynh+aRM7CadWfvVQQb02+NizJ
        AyAddiitg23NN2Ze7cYwtQmV6MKcghPgd/f4mma3kK5zocvy8R+/E0TQKDLeslyNAkAeu0SJ/Bp2E
        DgtGfZd/IpfrcBBFaiz7OC1qE+7s7p7+NxT7pG8lAD0gB+pnLtwHVx+WU/w/D0M9CNE2RQAx2xnbz
        SLlXdFvA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkj0l-0007G0-KI; Mon, 15 Jun 2020 06:54:27 +0000
Subject: Re: [PATCH] Documentation: fix malformed table in
 filesystems/proc.rst
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
 <20200615085305.275a7b24@coco.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9634ff3-fc33-0d2b-959b-bd3dd79600bf@infradead.org>
Date:   Sun, 14 Jun 2020 23:54:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615085305.275a7b24@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/20 11:53 PM, Mauro Carvalho Chehab wrote:
> Em Sun, 14 Jun 2020 20:33:22 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix malformed table in "proc.rst" by dropping a needless hyphen ('-').
>>
>> Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
>> Text in column margin in table line 29.
>>
>> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Daniel Kiss <daniel.kiss@arm.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> I submitted an identical patch on Jan, 3. 

OK. Well, that's disappointing IMHO.

Thanks.

> 
>> ---
>>  Documentation/filesystems/proc.rst |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-58-rc1.orig/Documentation/filesystems/proc.rst
>> +++ lnx-58-rc1/Documentation/filesystems/proc.rst
>> @@ -545,7 +545,7 @@ encoded manner. The codes are the follow
>>      hg    huge page advise flag
>>      nh    no huge page advise flag
>>      mg    mergable advise flag
>> -    bt  - arm64 BTI guarded page
>> +    bt    arm64 BTI guarded page
>>      ==    =======================================
>>  
>>  Note that there is no guarantee that every flag and associated mnemonic will
>>
> 
> 
> 
> Thanks,
> Mauro
> 


-- 
~Randy

