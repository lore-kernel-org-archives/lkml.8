Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC11C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF212074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584142691;
	bh=15+Xom9049XPMe1dyPvTmGGQ23Br5pC4ULB+Qzlfqzg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=t+N7GMUu7OfPxtdwObp+qXNZkNteS5UwA7sZubr505Eygm8Qyw5KmfNi6h+rOniyd
	 Nhg1soruk3nVrkQAsCLLB75XiOfWinMUSRq10BT3DWxk3EwsInvCLxV/UHjTmMJ7BE
	 8gCwtJ7f9dxjn0Hfh6iWIXXHmnwLTOzQRAfI1cFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCMXiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:38:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43173 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCMXiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:38:09 -0400
Received: by mail-io1-f66.google.com with SMTP id n21so11250161ioo.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AEYTIWb3PsO0Xiy9lFeTw55fvTUc8SpDmWDxLNij3EI=;
        b=AZBPzEz+sVo8yBM4hg1vSfNVaQSf1ZCEQOzTtCnGyKP6kpCxpgQzMfDZfC/hlumeJB
         H/M+VKrZWOnwvI/ZhAPUue2dmP7rLPTy9/dnLYou2GNQJap+ecCzp7AKH7jDszgNYMpu
         DQrn9zcCvVAol8DWF7NjMxpl6ZaoxSEtS12NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEYTIWb3PsO0Xiy9lFeTw55fvTUc8SpDmWDxLNij3EI=;
        b=VlWzvKDF/zrGo+hCgt0LkYbJzJypU5+B1xa2YikJYihMI0VFZv93H4XVSjP223VUK3
         ChuXVP3VxfbL9cutr+kxCM5SAWvtpCeMwDnhnpnq8fB8FFvhh1XS/Gh7Z7GsN0KoTC/J
         3XIrhvBKvI0rNRLHOClFHTyV3o2YT/ZA4LSSQdULfSzCQXC3h4EG5gz3R6Mhey2t/PNA
         PRFNDqjpjFUKGhiCpg6YaSki8v0AlUUNsUx9msL1tj35RQRzOPM+Kdr8Rq/fyR6Tf/uS
         tpic4GMTKK8eYncLLo0NTrMYm89HSGsfnTW8S7H3B4kQXNuqdmIMmzH96oF+GHq1yXSH
         PQnA==
X-Gm-Message-State: ANhLgQ2AdfFxnezzeTrPgXNfLaqDL9bOh1LzPpD74GJpSXuJNIz83K83
        QScObSUcNyei8MnI1zPQldyblQ==
X-Google-Smtp-Source: ADFU+vvhPkb47WbezsVfdMzGW05L/L+RkHkhr/9KYtdLXeiKp0HMu3qMmn003dqkkH31Sb1bc2QXLA==
X-Received: by 2002:a6b:7504:: with SMTP id l4mr14774812ioh.184.1584142688753;
        Fri, 13 Mar 2020 16:38:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j75sm9067501ilf.86.2020.03.13.16.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 16:38:08 -0700 (PDT)
Subject: Re: [PATCH v3] selftests: Fix seccomp to support relocatable build
 (O=objdir)
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200313212404.24552-1-skhan@linuxfoundation.org>
 <202003131615.D132E9E9@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <85ce71dc-e7f8-74ed-f495-dcb46255908a@linuxfoundation.org>
Date:   Fri, 13 Mar 2020 17:38:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202003131615.D132E9E9@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 5:18 PM, Kees Cook wrote:
> On Fri, Mar 13, 2020 at 03:24:04PM -0600, Shuah Khan wrote:
>> Fix seccomp relocatable builds. This is a simple fix to use the right
>> lib.mk variable TEST_GEN_PROGS with dependency on kselftest_harness.h
>> header, and defining LDFLAGS for pthread lib.
>>
>> Removes custom clean rule which is no longer necessary with the use of
>> TEST_GEN_PROGS.
>>
>> Uses $(OUTPUT) defined in lib.mk to handle build relocation.
>>
>> The following use-cases work with this change:
>>
>> In seccomp directory:
>> make all and make clean
>>
>>  From top level from main Makefile:
>> make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
>>   CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>
>> Changes since v2:
>> -- Using TEST_GEN_PROGS is sufficient to generate objects.
>>     Addresses review comments from Kees Cook.
>>
>>   tools/testing/selftests/seccomp/Makefile | 18 ++++++++----------
>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
>> index 1760b3e39730..a0388fd2c3f2 100644
>> --- a/tools/testing/selftests/seccomp/Makefile
>> +++ b/tools/testing/selftests/seccomp/Makefile
>> @@ -1,17 +1,15 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -all:
>> -
>> -include ../lib.mk
>> +CFLAGS += -Wl,-no-as-needed -Wall
>> +LDFLAGS += -lpthread
>>   
>>   .PHONY: all clean
> 
> Isn't this line redundant to ../lib.mk's?
>
>>   
>> -BINARIES := seccomp_bpf seccomp_benchmark
>> -CFLAGS += -Wl,-no-as-needed -Wall
>> +include ../lib.mk
>> +
>> +# OUTPUT set by lib.mk
>> +TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
>>   
>> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
>> -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
>> +$(TEST_GEN_PROGS): ../kselftest_harness.h
>>   
>> -TEST_PROGS += $(BINARIES)
>> -EXTRA_CLEAN := $(BINARIES)
>> +all: $(TEST_GEN_PROGS)
> 
> And isn't this one too?

make in seccomp directory won't work. lib.mk won't build it.
One reason why I wanted to clearly call this out as CUSTOM
program.

But it does make sense to reduce additional EXTRA_CLEAN by
just using TEST_GEN_PROGS.
> 
> I think if those are removed it should all still work? Regardless:
> 
diff Makefile
diff --git a/tools/testing/selftests/seccomp/Makefile 
b/tools/testing/selftests/seccomp/Makefile
index a0388fd2c3f2..d3d256654cb1 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -2,7 +2,7 @@
  CFLAGS += -Wl,-no-as-needed -Wall
  LDFLAGS += -lpthread

-.PHONY: all clean
+#.PHONY: all clean

  include ../lib.mk

@@ -11,5 +11,5 @@ TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf 
$(OUTPUT)/seccomp_benchmark

  $(TEST_GEN_PROGS): ../kselftest_harness.h

-all: $(TEST_GEN_PROGS)
+#$all: $(TEST_GEN_PROGS)

With this:

make
make: Nothing to be done for 'all'.

> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

I am addressing your comment about other tests that de[end on
kselftest_harness.h. I have a few patches ready to be sent.

thanks,
-- Shuah
