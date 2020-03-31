Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E647C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F90020784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585673114;
	bh=yXSYjALH9rCfTIG/ITWYBcq2TGtnf7SEGFqz7AohhMc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=an7zbEjwlVn4tOaflaJSoJU0Yd4NHWHeIM2NpPx3ugQnvRwZq5H82kItEhazHnsi7
	 KQbcbRd1tEHnLBNF2LKXXXm+uHiv2t5EkhjUkK4ZdGfERI1TX0dR0xXassCZUvGcM/
	 5WFwrA7Cq8U5mnSxf5fun74Lorjw4W+DfMK5QEQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgCaQpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:45:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46439 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbgCaQpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:45:12 -0400
Received: by mail-io1-f67.google.com with SMTP id i3so13279194ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0JAwdBM8J3oiIGwg0rcW6L9TGV0155fnPxFlRrMlTI=;
        b=L7qA7P4KvyQENUGj3g9qyx+aJQZAMLmOoPzxBh1yA5Bk03Xq2CItkjuVY2OGxqB7CX
         glKa7jDokq1Zp7NBiLnr8nacK9Mf1B0LQn0xxYPN1cn5Blr9LibND/FGW0DRCWqpTqyV
         33RiWiEcuRhHSdbV76m61zgLVSb9MLtdaMOpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0JAwdBM8J3oiIGwg0rcW6L9TGV0155fnPxFlRrMlTI=;
        b=Hzi6aD4SRjJrcn0gqNQ3JsCvifplLK4/8a90wYFijm0gqHskRv4mVP4OEKEba/Luv/
         je4JmKWmClBc+DAlVJ2C6sfE1JpgmRDfT3hvRIZiip3NfTUeK7DG9Ok5GvRNdQ+IpNMa
         rsQR1O3PZoIYQ1LUuw2hqpr+wny6ZYWlw+kEO4k/4GLQeEQBlOstHPfJWr3r91QDZnsX
         c4mL6mrMUQZu1pO0H4RWKp9ill8AtB7+Kz7/O5oYAE9jg25r+za60ROmG0NyKrtbISCI
         bNKz0O5kQYngE0SGrD3rQ47mUZJ1WXsLHkqUCsR0uzslwdSeMf2wmJJGfvLbG4Hi10Ul
         XnWw==
X-Gm-Message-State: ANhLgQ3Vh9qTUkUD7PKsgiKVXjHL3p97dT15fiwsGrQY9MirF987VA2w
        pKUJ9+HwETGoh8GftFGge/2b1A==
X-Google-Smtp-Source: ADFU+vsFQNZKvyoiMkGgxc+G61WBxRHne+j8QME+5vN6bWGQEh3/d60UseRLroe6jIzAPjzFyH+EZQ==
X-Received: by 2002:a6b:5c0d:: with SMTP id z13mr15272201ioh.96.1585673111646;
        Tue, 31 Mar 2020 09:45:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f69sm6011590ilg.10.2020.03.31.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 09:45:10 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Update kselftest help information
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200330180711.14393-1-skhan@linuxfoundation.org>
 <CAK7LNARyVVNo8Ck4=s_bkwfxuFXj7MUFr2E_f-oOZEkjgm5Bmg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b580e8ce-1879-c516-72c8-041b2422ad1d@linuxfoundation.org>
Date:   Tue, 31 Mar 2020 10:45:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARyVVNo8Ck4=s_bkwfxuFXj7MUFr2E_f-oOZEkjgm5Bmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 10:11 AM, Masahiro Yamada wrote:
> On Tue, Mar 31, 2020 at 3:07 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Update kselftest help information.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   Makefile | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index e56bf7ef182d..5e5c770423c7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1470,12 +1470,15 @@ help:
>>          @echo  '  nsdeps          - Generate missing symbol namespace dependencies'
>>          @echo  ''
>>          @echo  'Kernel selftest:'
>> -       @echo  '  kselftest       - Build and run kernel selftest (run as root)'
>> -       @echo  '                    Build, install, and boot kernel before'
>> -       @echo  '                    running kselftest on it'
>> -       @echo  '  kselftest-clean - Remove all generated kselftest files'
>> -       @echo  '  kselftest-merge - Merge all the config dependencies of kselftest to existing'
>> -       @echo  '                    .config.'
>> +       @echo  '  kselftest         - Build and run kernel selftest'
>> +       @echo  '                      Build, install, and boot kernel before'
>> +       @echo  '                      running kselftest on it'
>> +       @echo  '                      Run as root for full coverage'
>> +       @echo  '  kselftest-all     - Build kernel selftest'
>> +       @echo  '  kselftest-install - Build and install kernel selftest'
>> +       @echo  '  kselftest-clean   - Remove all generated kselftest files'
>> +       @echo  '  kselftest-merge   - Merge all the config dependencies of'
>> +       @echo  '                      kselftest to existing .config.'
>>          @echo  ''
>>          @$(if $(dtstree), \
>>                  echo 'Devicetree:'; \
>> --
>> 2.20.1
>>
> 
> 
> Applied to linux-kbuild. Thanks.

Thanks.

> 
> But, if we have more entries in the future,
> we might want to consider to move these
> to tools/testing/selftests/Makefile.
> 
>
Agreed.

thanks,
-- Shuah

