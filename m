Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D47FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC3C20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763343;
	bh=yROXLlCMLv+sOW0wbFIyIu+dEz5r2mBCipSPwcN18dw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=m+ZuhLLLc2LtpFLOmaI6DzJpXAJ1JKpj2gckoIdQzCklmHp8tLxWPyyitITXm2nX3
	 vc2VKFn9Om5aJEk2gOXG302cdO7xR9D0aIIVZDIOr9HrhfeLpGrO8pMVX97ZWI1xgX
	 j4HFVYipxwdsiSRwW+RpLKyH0T2RVQ4JhZl7kueo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgE2OmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgE2OmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:42:19 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40259C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:42:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g25so2052332otp.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UVh1wWR/DjeVa+n2Yl0/3Yn24xlDJaPDKYgL0WddAm4=;
        b=G8N0uur1m61O3mamR+hb4TsSXS3hF/3ShqBe7V7tEliLJlUc4kahzOlZmmhFxfKHGG
         4fYHT9FxHwGhE1xpermoQXlrk3/URjzoazklnz/CeRAljnAJ4KgepvvHXhbNHpX1LlQO
         SJkQYGQX+1Ea7ekF31osINpOoS0ck3uowitr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UVh1wWR/DjeVa+n2Yl0/3Yn24xlDJaPDKYgL0WddAm4=;
        b=dbedxj7rRfmA/rfqyxfOfz0mbCyXbiciUmd+jbK9XSN0+VCvJuv8oXjnmuDNlxyfrm
         y1GbBrjf896DhinRDUJPepXPkhdJNlLZqwobYTc4XXkIxi07ZG+Bf3CLdbvBPec687O2
         cViU2w+bILvrRrbTmDFzt2Z7pmILhtTCY80dDe56W7rUliHHuVqYn9aSfEDkYCGPhANX
         U2/EXTVvZtR5SNNODXhyEcmJYjUXQWs/p2F2swX4WZG1adaKMkZRi1k9wIdMbMSMbgNj
         7dpt2zpXqiBR6h3Jv1lA/Xg/CeS1cybpdofy3m961hXi5vysLYOEyUhZCoasn+QTwm1L
         ChQA==
X-Gm-Message-State: AOAM533Ipf31kG6b5KT3hL9bReBOUhFugxDnCWnD/xhnkOrfKKIxv+Z6
        Tybg/CvvCkNhkENFm8h5Zr2xwQ==
X-Google-Smtp-Source: ABdhPJy/ZY/ChiBwAlX4ASJn0XDIM6BygbwnQls2DZCmVsAqRJASYNEQHZh4iXC02Ru7IE4lX+wVMw==
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr6642949ota.170.1590763338637;
        Fri, 29 May 2020 07:42:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a7sm2491827otf.38.2020.05.29.07.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 07:42:18 -0700 (PDT)
Subject: Re: [PATCH v13 16/16] selftests/x86/fsgsbase: Test ptracer-induced GS
 base write with FSGSBASE
To:     Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
 <20200528201402.1708239-17-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de05c6c8-1139-cc40-8908-86c0dd645417@linuxfoundation.org>
Date:   Fri, 29 May 2020 08:42:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528201402.1708239-17-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 2:14 PM, Sasha Levin wrote:
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
> 
> This validates that GS selector and base are independently preserved in
> ptrace commands.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/testing/selftests/x86/fsgsbase.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
> index 950a48b2e366..9a4349813a30 100644
> --- a/tools/testing/selftests/x86/fsgsbase.c
> +++ b/tools/testing/selftests/x86/fsgsbase.c
> @@ -465,7 +465,7 @@ static void test_ptrace_write_gsbase(void)
>   	wait(&status);
>   
>   	if (WSTOPSIG(status) == SIGTRAP) {
> -		unsigned long gs;
> +		unsigned long gs, base;
>   		unsigned long gs_offset = USER_REGS_OFFSET(gs);
>   		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
>   
> @@ -481,6 +481,7 @@ static void test_ptrace_write_gsbase(void)
>   			err(1, "PTRACE_POKEUSER");
>   
>   		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
> +		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
>   
>   		/*
>   		 * In a non-FSGSBASE system, the nonzero selector will load
> @@ -501,8 +502,14 @@ static void test_ptrace_write_gsbase(void)
>   			 */
>   			if (gs == 0)
>   				printf("\tNote: this is expected behavior on older kernels.\n");

I know this hasn't changed. Please clarify what is "this" in this
message.

> +		} else if (have_fsgsbase && (base != 0xFF)) {
> +			nerrs++;
> +			printf("[FAIL]\tGSBASE changed to %lx\n", base);
>   		} else {
> -			printf("[OK]\tGS remained 0x%hx\n", *shared_scratch);
> +			printf("[OK]\tGS remained 0x%hx", *shared_scratch);
> +			if (have_fsgsbase)
> +				printf(" and GSBASE changed to 0xFF");
> +			printf("\n");
>   		}
>   	}
>   
> 

thanks,
-- Shuah
