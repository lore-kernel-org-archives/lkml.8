Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30372C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0478C21556
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A+tPA7UM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgB0FpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:45:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB0FpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=KIVkObLlmMiRC9AZqdu+Irv56TY32GdWpiQAAooZhSY=; b=A+tPA7UMWWwsCKqLs/fVryBfLJ
        tG00d2TTDPrBMtaFz6UTzO9a06nnx9Q1DNUoZ4fzQfPOmxu6GqpwS9YpaaR+gQEGGZKszOXHXJbQE
        vOqkISDbHlzNAhhbz7YUvQ0UNHkKgOCWQm22gCx+xj9jkONvsPDmbf/sm6J6JfUZPOAMvOllS6ZD9
        avhlxcfk4bHm2RDVwkZAPdtcwc7+kTSOybVKLttFjVDTHvv/vlrh8cMEO9IaLPyV4D70Abm2hZ26y
        z4wTwb8MOkuDGEvVUSnrBAAeG2/zJ1fmaGqHbt/D4rvWWNsJ6RwpyJ99VEhN7bSRZG74unVGqQb9C
        gyeZ8EPw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Byr-0008M4-3q; Thu, 27 Feb 2020 05:45:05 +0000
Subject: Re: [PATCH -next] x86/jump_label: Fix old-style declaration
To:     Borislav Petkov <bp@alien8.de>, YueHaibing <yuehaibing@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20191225114500.7712-1-yuehaibing@huawei.com>
 <20200102093627.GB8345@zn.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0df906da-1968-30f7-9819-3bf4de47a36d@infradead.org>
Date:   Wed, 26 Feb 2020 21:45:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200102093627.GB8345@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 1:36 AM, Borislav Petkov wrote:
> On Wed, Dec 25, 2019 at 07:45:00PM +0800, YueHaibing wrote:
>> Fix gcc warning:
>>
>> arch/x86/kernel/jump_label.c:61:1: warning:
>>  inline is not at beginning of declaration [-Wold-style-declaration]
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  arch/x86/kernel/jump_label.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index 9c4498e..5ba8477 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -58,7 +58,7 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type,
>>  	return code;
>>  }
>>  
>> -static void inline __jump_label_transform(struct jump_entry *entry,
>> +static inline void __jump_label_transform(struct jump_entry *entry,
>>  					  enum jump_label_type type,
>>  					  int init)
>>  {
>> -- 
> 
> Looks not needed anymore:

I still see the warning.
Also I wonder what tree you tested the patch against?
Please see below.

> $ test-apply.sh /tmp/yuehaibing.01
> checking file arch/x86/kernel/jump_label.c
> Hunk #1 FAILED at 58.
> 1 out of 1 hunk FAILED
> Apply? (y/n) n
> --merge? (y/n) y
> patching file arch/x86/kernel/jump_label.c
> Hunk #1 NOT MERGED at 67-71.
> $ git diff
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index c1a8b9e71408..0a9e1dc65a3f 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -64,7 +64,11 @@ static void __jump_label_set_jump_code(struct jump_entry *entry,
>                 memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
>  }
>  
> +<<<<<<<
>  static void __ref __jump_label_transform(struct jump_entry *entry,

What tree has __ref in it?  I don't see that in linux-next or in tip.


> +=======
> +static inline void __jump_label_transform(struct jump_entry *entry,
> +>>>>>>>
>                                          enum jump_label_type type,
>                                          int init)
>  {
> 

thanks.
-- 
~Randy

