Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4820B207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VA+FvPCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHMDbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMDby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:31:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=z1xWvaAvbcuEB26ko8GuVSncG0nEsKM2kbQPdS0rNHA=; b=VA+FvPCqtRzhRQ6iMVaOl9Rmvs
        SKqAhT4qAmv2DEYiqTVWNXYYrA/TNfs+r8mTUf238yozMQ9TzWgMFgxAb7/MUlVEwP0SmnECKMTB0
        jJlJQWEXDyUqXFe0iLfAgsJhqgbzC/ho+lxy+FdmcgkJ7hn/GKVaJUNTGLke7cT6kdWZCfBBZ7iCB
        CYQOBUSRAWpGJ0qJ4OQutYOWhB5hMGShcj2Ls8hyGcOiW6FEUYWiiyWD3AXRpc8xlONdOz1WhCq2m
        1px9L+3spyhkSsoDLz+U/VZEwwV17VB+2hk/2WTINHBgqaaUR148gjVbn0hWba838su4LMjHazoO9
        KcUB0bxQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k63y0-0000um-6R; Thu, 13 Aug 2020 03:31:48 +0000
Subject: Re: [PATCH v2] lib/cmdline: prevent unintented access to address
To:     Seungil Kang <sil.kang@samsung.com>,
        andriy.shevchenko@linux.intel.com
Cc:     bhe@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <CGME20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac@epcas1p3.samsung.com>
 <20200813030741.6896-1-sil.kang@samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1bd1fefa-9fd5-b76a-a181-fca289b4aa67@infradead.org>
Date:   Wed, 12 Aug 2020 20:31:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813030741.6896-1-sil.kang@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/20 8:07 PM, Seungil Kang wrote:
> When args = "\"\0", "i" will be 0 and args[i-1] is used. (*lib/cmdline.c +238)
> Because of "i" is an unsigned int type, the function will access at args[0xFFFFFFFF].
> It can make a crash.
> 
> Signed-off-by: Seungil Kang <sil.kang@samsung.com>
> ---
> 
> Thanks for your review, my comments below
> 
>> Can you be less ambiguous with the args value? (Perhaps provide a hexdump of it
> for better understanding)
> 
>  This kind of args as hexdump below can cause crash.
>  
>  00000000: 736f 6d65 7468 696e 6731 3d73 6f6d 655f  something1=some_
>  00000010: 7661 6c75 6573 2022 0000 0000 0000 0000  values "        
>  
>  The args end with "\"\0".
> 
>> Please, use proper punctuation, I'm lost where is the sentence and what are the
> logical parts of them.
> 
>  I'm sorry to confuse you. I fix the commit msg
> 
>> Can you point out to the code that calls this and leads to a crash?
> 
>  *lib/cmdlinc + 201 ~, next_arg function with args = "\"\0"
>  
>  char *next_arg(char *args, char **param, char **val) <-- args = "\"\0".
>  {
>         unsigned int i, equals = 0;
>         int in_quote = 0, quoted = 0;
>         char *next;
> 
>         if (*args == '"') {   <-- *args == '"' is a true condition,
>                 args++;       <-- args++, so *args = '\0'.
>                 in_quote = 1;
>                 quoted = 1;   <-- quoted also set 1.
>         }
> 
>         for (i = 0; args[i]; i++) { <-- when reached this point, i = 0, and arg[0] == '\0',
>                                         so for loop is skipped.
>                 if (isspace(args[i]) && !in_quote)
>                         break;
>                 if (equals == 0) {
>                         if (args[i] == '=')
>                                 equals = i;
>                 }
>                 if (args[i] == '"')
>                         in_quote = !in_quote;
>         }
> 
>         *param = args;
>         if (!equals)
>                 *val = NULL;
>         else {
>                 args[equals] = '\0';
>                 *val = args + equals + 1;
> 
>         /* Don't include quotes in value. */
>         if (**val == '"') {
>                 (*val)++;
>                 if (args[i-1] == '"')
>                         args[i-1] = '\0';
>                 }
>         }
>         if (quoted && args[i-1] == '"') <-- When reached this point, quoted is still set 1, 
>                                             "i" is still 0, and "i" is unsigned int type,
>                                             so address will be {address of args} + 0xFFFFFFFF.
>                                             It can make a crash.
>                 args[i-1] = '\0';
> 
>         if (args[i]) {
>                 args[i] = '\0';
>                 next = args + i + 1;
>         } else
>                 next = args + i;
> 
>         /* Chew up trailing spaces. */
>         return skip_spaces(next);
>  }
> 
> 
>> Can you provide a KUnit test module which can check the case?
> 
>  If necessary, I will make it and share it.

Hi,
Have you tested this patch?
If so, how?


> 
>  lib/cmdline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index fbb9981a04a4..2fd29d7723b2 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -200,7 +200,7 @@ bool parse_option_str(const char *str, const char *option)
>   */
>  char *next_arg(char *args, char **param, char **val)
>  {
> -	unsigned int i, equals = 0;
> +	int i, equals = 0;
>  	int in_quote = 0, quoted = 0;
>  	char *next;
>  
> 

thanks.
-- 
~Randy

