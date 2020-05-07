Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66273C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED152083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878258;
	bh=hTz0dipNuyUD7uC8YDkAZ4F7wSW/EI6YqHHWgcYeyEU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Fzqc8h8Y4luHmPPFEB5rdh2q2oeXBUq90qT229fHKWv3DJA4/Q3O4IqJiwM1fpjWf
	 Fgy4kwJZ75aBnoqTGl2A0mhEktqNXD6eBf7/UQOdxblri+oev/LBvzycX2z69rb2IT
	 CxUS6Bcbc+EtX9ZesCPUJRivyHUcp67UFRNedBmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEGTER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgEGTEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:04:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75316C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:04:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u11so7428987iow.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3pqxVey+OpLP2Bd4SNRaSG1BkaFq4VbJOs0rt4HQddo=;
        b=gjcJAVkP4QIWorSEpDgbJkla5yA2OQ+73EvwbD1hpKkYsiLRkc2/DORutpA5dLKFyG
         ED5oRfQ5flpIt0TQKs0cqe1mx6aj4bcp0rL0SqdbUPeL4umAPqbcDEt1jgo2vq42J5yZ
         59SAeMEmtJeBFrq42klJ0Hny+A0ztCq9Wi7bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pqxVey+OpLP2Bd4SNRaSG1BkaFq4VbJOs0rt4HQddo=;
        b=ZqNqu+XU5W5dUydy6ZSXi2R3Ih9hYP3RNeL7bCus/dYmcNnM5+zk7zAKpX0FfLLJTW
         Q7GHuXgmsg0SS5EmbAenfNiouPCHZwktJ3+dE6nodbCPcNOWdU/h/BQLZ+M8xOb0ZJM1
         KC1prUq+B1meD9AKh9C6yDWmtyFjP8UvttluqgnhNEoIhtlUJ2prTHP2S8/gkRz9cb4r
         1By9Lrt3aN4OKnRVDyIZJ1H9WnDpT4ZMAJdBxChAchbx4e+nzvVOlGq1XTxtmwVXr10s
         D9k2BEL45fmoVJwG6kMF6SZTY0LphJjvtaLtZMqJwyKbzyq1chY15+DuqHLy1zPE49OR
         zUiw==
X-Gm-Message-State: AGi0PuZALw3BXdXfWVKzt7BkISHCIWoPk+jrhcR5NxPMURfAVRT0RXCZ
        spynW/AC9oSVhQ49e6D4+1SlMQ==
X-Google-Smtp-Source: APiQypKAmsWHJ9r4kPgM/xipjiM5IY3/ett50IEt8gHhzgxgys03OYoPt0tQU/FkMuKkNI0xy0z9LQ==
X-Received: by 2002:a5d:8e0d:: with SMTP id e13mr15555692iod.132.1588878255676;
        Thu, 07 May 2020 12:04:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm3087269ilb.86.2020.05.07.12.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 12:04:14 -0700 (PDT)
Subject: Re: [PATCH] tools/testing: Replace zero-length array with
 flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200507185608.GA14779@embeddedor>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <94b19470-9ade-5fcc-00c7-324056d049de@linuxfoundation.org>
Date:   Thu, 7 May 2020 13:04:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507185608.GA14779@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 12:56 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>          int stuff;
>          struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   tools/testing/selftests/nsfs/pidns.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
> index e0d86e1668c0..e3c772c6a7c7 100644
> --- a/tools/testing/selftests/nsfs/pidns.c
> +++ b/tools/testing/selftests/nsfs/pidns.c
> @@ -27,7 +27,7 @@
>   #define __stack_aligned__	__attribute__((aligned(16)))
>   struct cr_clone_arg {
>   	char stack[128] __stack_aligned__;
> -	char stack_ptr[0];
> +	char stack_ptr[];
>   };
>   
>   static int child(void *args)
> 

Thanks for the patch. I will pull this in for 5.7-rc6

thanks,
-- Shuah
