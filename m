Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E21C11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852DE206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582239298;
	bh=UCN3PRWRHQlD2w3V7YTc4YmY7FxtTCkk9/yQEUc67FM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Imhk1s9cow5xX4OElcrprkvJEFToaI42KwactiLA5l3/RBh17m8ouaK5Hk8s23Vmv
	 ylfqnlqegLkG+TWEp9ZvA0DmBbT3Hw5nJRCYBbmiBWU9Bucy/9Mmu/HeJSkydvveKr
	 FMZkvLbELH3SoIOKBNhGxhB0jM+6E3yXPKL5rSkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgBTWy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:54:57 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36926 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgBTWy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:54:56 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so301363ioc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8d8NX9dRtfode/mGrNHy098ugTs2zC3Sx5s6Tu/GUkM=;
        b=hNpGYAbWFp3sVXdY4hkAwcoE/2KV6xNSDcTOyu5XbQ7GsjVzgSJHeG7DrnHLw473fn
         M256n+WkFGqHpTdIhWUyKPYgFszh+2hfSTCn3hN7m4iJrViarzV7f1to2bN0DS5JVj/s
         jFX/8SiFWnKmBLn6iwjtDXsOom4oNDnOZpR1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8d8NX9dRtfode/mGrNHy098ugTs2zC3Sx5s6Tu/GUkM=;
        b=Dl01Tk3c17ltf/HOXYT+hAuYJYSqxnLrmKYubeJFOw5DWMKx43lnwe1x9C4LGRf/3s
         G4UXvmxxwsfksZKMjoWMLXaLnT0dCEUlCDG2XsR0NxK89i3/hAZhvAP8OIu1QB+RQNcp
         i7kaCXnA7hvPUJBCg5/O3JotRlE/W5ReH0W+aP0QQg8vM8ppGRUC9OoxtjPyanSFpowK
         gh47bu7E9ckvwANVgT5d/xq9tA0bzzucLIyFKgjb/bsxnvtnr4TG8b1W2Tnj2EQXv6IR
         wUqQ4Hr5nGuZJAPpXDBGG2URbwr6ugwFRX6YvX5UPooYo9DUb663YSuRLte0++VQIr+i
         H3Rw==
X-Gm-Message-State: APjAAAXfTJz2LiQ+ZRenqF6iZSAFk59WgOetMGqsfAY/d0bjVdvSJdWD
        UeGgyzT2SHWGktXqkU3yviU5sWbH01k=
X-Google-Smtp-Source: APXvYqx3Ebt1RtL10Rom31Fq0WYwR61RFsYQmy4rzWq6ozpl1ChMGoNQJGNALu20q/hmu4lEobIjQQ==
X-Received: by 2002:a02:cd12:: with SMTP id g18mr27785187jaq.76.1582239296119;
        Thu, 20 Feb 2020 14:54:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j26sm194064ioj.69.2020.02.20.14.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:54:55 -0800 (PST)
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
 <202002201450.A4BB99421@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fccfcd8b-628b-9b3d-13b1-6dcda49b4df9@linuxfoundation.org>
Date:   Thu, 20 Feb 2020 15:54:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002201450.A4BB99421@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 3:51 PM, Kees Cook wrote:
> On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
>> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>> timeout per test") added a 45 second timeout for tests, and also added
>> a way for tests to customise the timeout via a settings file.
>>
>> For example the ftrace tests take multiple minutes to run, so they
>> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
>> timeout setting").
>>
>> This works when the tests are run from the source tree. However if the
>> tests are installed with "make -C tools/testing/selftests install",
>> the settings files are not copied into the install directory. When the
>> tests are then run from the install directory the longer timeouts are
>> not applied and the tests timeout incorrectly.
> 
> Eek, yes, nice catch.
> 
>> So add the settings files to TEST_FILES of the appropriate Makefiles
>> to cause the settings files to be installed using the existing install
>> logic.
> 
> Instead, shouldn't lib.mk "notice" the settings file and automatically
> include it in TEST_FILES instead of having to do this in each separate
> Makefile?
> 

Let's keep it custom per test for now.

thanks,
-- Shuah

