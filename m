Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D030C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B5C2465E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592682194;
	bh=QoPrfo+jLKO3qYiEQC1P1UqfyJC0pvWPUjhRLr0xTb4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uYxDuih/BTsoRtD7V/nbX2ehexWCPpMWl1imSVdQosyy5QK3RC5tJvz44eNm6TBAH
	 mN5pEjiGsw16ZhF+yv4XJzM/vQjmoceMzalhI8UaF1PoGV/5Rddh4wxhJZrE3cymKB
	 /y16m6u63CEuV4S7XxHD3fA5cHdAZkYK/z+wdsr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgFTTnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 15:43:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34986 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgFTTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:43:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id k4so11799346oik.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RIOWaf+Y/IC5IumUTbHcSIUTmqTytf9U6a9ZMZVX/+Q=;
        b=Wpx/PkwpJVA62h/yxyifXguo4B/vp+ds5FY6STQtzt3IrEUZDal3eWPC15g36cIsN3
         cTB+9LrsQJKtvM149vYr9V8ax9fR/J3nJKhpLFZpxlB3e7SGABvbaLgqxqFNB7cMxAq3
         UxW2jF7aF6FlMJx0fm+iIOeBdDZXsPsipIgvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIOWaf+Y/IC5IumUTbHcSIUTmqTytf9U6a9ZMZVX/+Q=;
        b=hxTIQ65jcU96BmzfbEUnxon27xiKjTh9K5Lt/6TG8eSHw9jLmrPz87QHKI3YBB24p9
         TqTXHanNN5eV3LL/65IQR57dn+4iCKc546JWgyly35BgVWlxn4Kp75RUDeV/R4Jw9HzP
         U0RdddXR53T+OQuNXk57FPQSB6lkyr4AHU1+Nyn7YcBA/b3rexPxoDjnL5Irt0JYP84y
         ZDatw7xRVI4Rf2xTvoEfbcnw5XXP14tuEbqMFrD5cvaM2KBwvOaxhgSIccd1gQxsOr7m
         X8lNmaBQz3wMiC51JfJ5c+wdtgdTvXrJIRTrILeVzGK4pNbl1stnvagXhTQABAhBKHkD
         Dr4g==
X-Gm-Message-State: AOAM530ghWa+ChK+MR7oYA4zaAmgN19vczQe/St6OlgZZR4eAWJzRrRy
        VPc2b1u4IPENE7T+WO2XehFc5w==
X-Google-Smtp-Source: ABdhPJxSV8Jgwn1cwyHWNGyEuh4iDUv8Y2FKY83QDPvntIZ3lecCGJUm3uRCRVWBzKrXFG6eQRUylQ==
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr7621939oiy.62.1592682130143;
        Sat, 20 Jun 2020 12:42:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v132sm2054176oif.6.2020.06.20.12.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 12:42:09 -0700 (PDT)
Subject: Re: [GIT PULL] Kunit update for Linux 5.8-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, skhan@linuxfoundation.org
References: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
 <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e9f0a460-5ff1-371f-a597-877751f76948@linuxfoundation.org>
Date:   Sat, 20 Jun 2020 13:42:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/20 1:13 PM, Linus Torvalds wrote:
> On Fri, Jun 19, 2020 at 10:28 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Please pull the Kunit update for Linux 5.8-rc12.
> 
> This doesn't sound like a fix for after the merge window. Explain.
> 
>                Linus
> 

I should have added a note like I usually do.

"KUnit resources are now refcounted to avoid passed in resources being
released while in use by kunit." is the reason why I made a call on
sending this request.

You are right that the second patch "Add support for named resources"
is a merge window content. However, my thinking is this could enable
writing more tests during 5.8 and these two patches are scoped
to just kunit.

Please feel free to delay it if you like. I will include them in for
next release.

thanks,
-- Shuah

