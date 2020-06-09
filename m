Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA85C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B536B20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591730449;
	bh=Q/dtPICulvYlxpWbwwWmKXgrJcZy3f+gcklthv+L1Ls=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=gm+w3JXX0gyROookQjtzZfrrFD7cBqalQ2WxYkrWIrryNMlsK60Xvnlv7wYbPeBAR
	 tPgoUrd5vZEeSIDnHfPBxqvNUoPCqDWU/YGiRvBfqAmapYmsEr73ZmQna8lsAQNw1p
	 +Eh9mY1V5Guehy63dS5L6llXwiVw86YwqLw9LVPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgFITUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgFITUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:20:46 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40971C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:20:46 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t6so8326684otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M95b7XN4hxzBNl14aeyijOA1TLpQdEQ5Lw81DxthS4g=;
        b=AqVKgw5OmjZwe8FdhvKuAo97EM6BGpfVOHcD/pomOM53XUm2tmiwmsHVn/X4iqwBtd
         mTlOQvqinoKZ4IuWrVUam1GSemrxCt89yxfMe3NKDzxIN2UK2myQ1ffluCvj2ESpxx2E
         lLfYFZvbm9ncZRIDCRdrz7shaFd9AVkLh4E38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M95b7XN4hxzBNl14aeyijOA1TLpQdEQ5Lw81DxthS4g=;
        b=ppVigdKamPx/tB48JgbLFXoutzaBexRYMl5uLoiqLH1qfZ9JQirhd3yNIQBJqbGLdo
         oYOv+wimszauHzL/Dpz/UKepI8y6ZuvqnTv9T5kGu3JRVCN+sRegLA8kvNNdSa5zFcL6
         M6AlsDtov9AoA1XJZd777Twdp8dkP30rR6IiJ76DZX8IOtJbH8dG1jIkjUb34dv+3nhk
         fPZwKa4JeHVDu8YpkOW0ZXFx8npqBj5P5cx++i5Nq3H2G8pf7wKzSTiPo4p7ObPvyzaO
         s1bBs09RH/x6OrSn0O6GUWz0mya26KmF+Mpoc8s1qM10S2uP+5a1jgW/bpKOdHPYGrEE
         2FiA==
X-Gm-Message-State: AOAM530wZmQ3rbr2j3DC1Ojrj8451viWfehp/0yATvtXkH/B9jOwcOiJ
        0cwYiX2H037n2p2RBhJdU0w5Ng==
X-Google-Smtp-Source: ABdhPJyvqpPLkk3Glj/sIR4NsLuwQTZIO1SiVknhZdOrAlpSkLhRN7IBqFlLbTMAadHJ5kX7mFEMeQ==
X-Received: by 2002:a9d:1727:: with SMTP id i39mr22381541ota.367.1591730445387;
        Tue, 09 Jun 2020 12:20:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l196sm3368505oih.25.2020.06.09.12.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:20:44 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/25] 4.19.128-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200609174048.576094775@linuxfoundation.org>
 <CA+G9fYsxjJpM-bw_VamAH0Beri66aC+-kqZ-RiCWVqm4N=t4gA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f5429b08-e3d8-f6fb-79bc-3868bf8a2816@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 13:20:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYsxjJpM-bw_VamAH0Beri66aC+-kqZ-RiCWVqm4N=t4gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 1:01 PM, Naresh Kamboju wrote:
> On Tue, 9 Jun 2020 at 23:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 4.19.128 release.
>> There are 25 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 11 Jun 2020 17:40:24 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.128-rc1.gz
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
>> -------------
>> Pseudo-Shortlog of commits:
>>
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Linux 4.19.128-rc1
>>
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Revert "net/mlx5: Annotate mutex destroy for root ns"
>>
>> Oleg Nesterov <oleg@redhat.com>
>>      uprobes: ensure that uprobe->offset and ->ref_ctr_offset are properly aligned
> 
> stable-rc 4.19 build failure for x86_64, i386 and arm.
> 
>   make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=x86 HOSTCC=gcc
> CC="sccache gcc" O=build
> 75 #
> 76 In file included from ../kernel/events/uprobes.c:25:
> 77 ../kernel/events/uprobes.c: In function ‘__uprobe_register’:
> 78 ../kernel/events/uprobes.c:916:18: error: ‘ref_ctr_offset’
> undeclared (first use in this function); did you mean
> ‘per_cpu_offset’?
> 79  916 | if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> 80  | ^~~~~~~~~~~~~~
> 81 ../include/linux/kernel.h:62:30: note: in definition of macro ‘IS_ALIGNED’
> 82  62 | #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
> 83  | ^
> 84 ../kernel/events/uprobes.c:916:18: note: each undeclared identifier
> is reported only once for each function it appears in
> 85  916 | if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> 86  | ^~~~~~~~~~~~~~
> 87 ../include/linux/kernel.h:62:30: note: in definition of macro ‘IS_ALIGNED’
> 88  62 | #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
> 89  | ^
> 90 make[3]: *** [../scripts/Makefile.build:304: kernel/events/uprobes.o] Error 1
> 
> kernel config:
> https://builds.tuxbuild.com/I3PT6_HS4PTt7EFgJUIPxA/kernel.config
> 

I am seeing the same problem on x86_64

CONFIG_UPROBES is enabled in my config.

thanks,
-- Shuah

