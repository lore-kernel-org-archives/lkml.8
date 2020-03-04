Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C91C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A7920866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583363741;
	bh=dZaoSwKBx/t67wOLGqICu1GPOu6Nbpsnkqt1hx+hyOY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=B/GIBkhepJa5wgEVK1lgYlEQD23KKjmEnppr+bx8qI8vJ2yYTfICs9St50KeYSPQc
	 KqDxcHzX7qxMSbUZE046nhLChAeP43p1gvlfxIxsLLUiypKsudP7ow0773O+/YiuWa
	 ujERaFp6AWXe7b3phdXOkEcswPrTgPxl23FqMNfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgCDXPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:15:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45948 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388371AbgCDXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:15:40 -0500
Received: by mail-io1-f67.google.com with SMTP id w9so4333200iob.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qnZSwAco/9yGR/2Rk04lTIem1NQkAqUXaZjX8c167Hs=;
        b=PsHjmeO7PXK1y43SbWXSqitm0T7GjrEaE3aOc4VjlDXTiEUoIifBDtonvjPNfMa8NP
         COoFK7dpmzQoxB5Ulbg61zCMdxgVzTE/MATvSVpE9Ix4p2zUC7ugmhlCKNm+dpUVEd7y
         aoDKxbZS2CDeSLEO0pHaRDMiFg60KJV94Rd7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qnZSwAco/9yGR/2Rk04lTIem1NQkAqUXaZjX8c167Hs=;
        b=QoDCNDfCKY++dgp2qhEfeD7HN7QOSKDr/FnsRLAeDU1wmJLkEfsrgykg9ib9xhO22a
         tL+ct2Z2AFQgtBJLAH+KF3OHNwYDIG4QbBsIDDemvLO7J9TsYHmCY5uZWPOPIX2WEmEX
         niyUGVR3VgBD5nMPPs1pqD+sNa2qgVA8IT6/E8XnhwXqBBlgVJQ9RPQIBJKoJfQoejQX
         36yb4wFYVDs9RCz4DQZultMyp9vuIlmadbEfxwjOsE9f3RWED3fyrDo+P9lDvOmoK0di
         4Twxiht46DKRJlIuJpwjpqNCMUx+8sDYWSARJDdVfiV0yZpJon8BixNs13z9O2Xb35nP
         MO6A==
X-Gm-Message-State: ANhLgQ1tdDJ0DDGB30pmSBl/iKvaTrqEV4/rf5oFSH4BWsiNJBQDzJ0+
        gc08I0CNgQKevyFgEWY81GZTnQ==
X-Google-Smtp-Source: ADFU+vuixjh4NH+5iUMDbrsEt1WSbtzQ1aWggmcxwIHK3oaMulCmtb7CWoIrlP5jRRnEdh/VXGUMlg==
X-Received: by 2002:a6b:bd04:: with SMTP id n4mr4147979iof.196.1583363739362;
        Wed, 04 Mar 2020 15:15:39 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m18sm8782876ill.79.2020.03.04.15.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 15:15:38 -0800 (PST)
Subject: Re: [PATCH 2/4] selftests: Fix seccomp to support relocatable build
 (O=objdir)
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <11967e5f164f0cd717921bd382ff9c13ef740146.1583358715.git.skhan@linuxfoundation.org>
 <202003041442.A46000C@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11ffe43f-f777-7881-623d-c93196a44cb6@linuxfoundation.org>
Date:   Wed, 4 Mar 2020 16:15:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202003041442.A46000C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 3:42 PM, Kees Cook wrote:
> On Wed, Mar 04, 2020 at 03:13:33PM -0700, Shuah Khan wrote:
>> Fix seccomp relocatable builds. This is a simple fix to use the
>> right lib.mk variable TEST_GEN_PROGS for objects to leverage
>> lib.mk common framework for relocatable builds.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/seccomp/Makefile | 16 +++-------------
>>   1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
>> index 1760b3e39730..a8a9717fc1be 100644
>> --- a/tools/testing/selftests/seccomp/Makefile
>> +++ b/tools/testing/selftests/seccomp/Makefile
>> @@ -1,17 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -all:
>> -
>> -include ../lib.mk
>> -
>> -.PHONY: all clean
>> -
>> -BINARIES := seccomp_bpf seccomp_benchmark
>>   CFLAGS += -Wl,-no-as-needed -Wall
>> +LDFLAGS += -lpthread
>>   
>> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> 
> How is the ../kselftest_harness.h dependency detected in the resulting
> build rules?
> 
> Otherwise, looks good.

Didn't see any problems. I will look into adding the dependency.

thanks,
-- Shuah

