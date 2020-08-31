Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906CDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E6320866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598906996;
	bh=1PN8WQU4Q/rGpX1x5xvJOD6uO9iIoxtDne+ONOWMDu0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=H3Nq3ECe2A1tyrm1O3UH79xT9CYsjBS2TF5GG9WsCcnxyajGfWjt94qX7S1HfvyTs
	 2FRXvsjqBjCHnYo8NlqJBBln9s+5mbEO6crNZgy7qaqYe+mRPfwIowRcHXie/UEHO7
	 pRP6btXvyAQcM7Vk6Z1b7EMeue9evv1nKr4geuaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHaUtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHaUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:49:53 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:49:52 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d189so2166192oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXLdw2EqWHhI2TwwrM4XKt/5YHttNOrLrhTDhUQWFAg=;
        b=a58amqfO6WuUD4Noh1GsIb+tsswivJ0nu660wqYL5R2D7jdZaR8vqDpVk+wS5iFLgi
         BvReR4oTMyY5KUix15VtUCRDn7a3xjKWJX20qftFOJHCWEvuD0QQXkwAnPqfFR9LonOZ
         W7j1IXgpoeLq1x355d/+O+Ub8UcWA1QtCuF54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXLdw2EqWHhI2TwwrM4XKt/5YHttNOrLrhTDhUQWFAg=;
        b=YdvXZfRgNdiDBSTkAG/ByrfPAjJHWXh56VImpTuQCS7aLr2QqpM/zairCdnDW440+l
         yiXEg8yg4giCPOLQjNJTx7ir8TJ0dmE5eftmuJw/c5pAFkSJ6ES+01zLh5T+hBAxM0fh
         HobEnr0/Yuj3Xmn4GclCx9QqEx4qLVMNcjmxH5ToMiCqd0k4yejP+AGSBmXsOAagMejg
         8d8vqAFJql1EubxEXsFfFaFaOwTyXAVwvshGNbtglF59eXNaAAGUJrU8vvoQXee2heox
         qaGDTkkiDNnRP0e8vqsBLRumgzgBiYzBnjzxc+J8Ay3bZoAJQmoCnyMnbTaGY7ZdkixK
         GzIw==
X-Gm-Message-State: AOAM533grsn56ndJFqVUEyrZhdsfmTa/z68lzF7N9QwdJ6okY3sWkAFX
        hOfz+hmhk+rAJaERNqLId6Klrg==
X-Google-Smtp-Source: ABdhPJyZnOHiWoW/j0WJMwcoA5h8XCMzg98FexYAoM57h/Zd3reUKXgNajigD561Ru00ls+Vhnee+A==
X-Received: by 2002:aca:ccd3:: with SMTP id c202mr695607oig.146.1598906992242;
        Mon, 31 Aug 2020 13:49:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm1983694otp.8.2020.08.31.13.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 13:49:51 -0700 (PDT)
Subject: Re: [PATCH] selftests: use "$(MAKE)" instead of "make" for
 headers_install
To:     Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200817150946.21477-1-dvlasenk@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8ea61655-c4b3-0fa9-ec70-b63adbbe5c84@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 14:49:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817150946.21477-1-dvlasenk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 9:09 AM, Denys Vlasenko wrote:
> If top make invocation uses -j4 or larger, this patch reduces
> "make headers_install" subtask run time from 30 to 7 seconds.
> 
> CC: Shuah Khan <shuah@kernel.org>
> CC: Shuah Khan <skhan@linuxfoundation.org>
> CC: linux-kselftest@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> ---
>   tools/testing/selftests/lib.mk | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 7a17ea815736..51124b962d56 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -47,9 +47,9 @@ ARCH		?= $(SUBARCH)
>   khdr:
>   ifndef KSFT_KHDR_INSTALL_DONE
>   ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
> -	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
> +	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   else
> -	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
> +	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
>   		ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   endif
>   endif
> 

Thanks for the patch. Applied to linux-kselftest next for 5.10

thanks,
-- Shuah
