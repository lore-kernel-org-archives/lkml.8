Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8B6C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143402067C
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598907864;
	bh=PmvOQ4QSyhiDx/Cyz45UpviX009W6n9TdDWX6vV48E0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mzrQy34II5e9/aup9nzK9Md9NPcbUmGOaCHhKupdFKi5i7b0rCbza8UFPQmok0RSP
	 iyW0maSxvSjbr3srqmnegdY+O02IT5ChYUM3F/noN5P1tFRZXCNEBxc8kukUP7gFYB
	 1b5ftFCygiOp6IoilGJwq3JIZjOJQsRMglEzKJY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgHaVEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgHaVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:04:20 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 14:04:20 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g13so7510797ioo.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Me0l90lHBcIiWc7V/ZnOYLUZoEWFXUMKq05fR5MgBoI=;
        b=TX4maE3GZYKy+0cHbPXR7wmQYueLPMQhRbMPLA+SMHLhy91uuGkHhQfZdUxQLjaOde
         HbTD/JwxShVg9W5T3VN0xO5HcRCgvnlYoco1ijAzsJLzDVkvNi8gfQVaXUFo1K+1UpyP
         yrP3KMVlxFfJLEYkkXz11j2xpk/IIClE9mmnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Me0l90lHBcIiWc7V/ZnOYLUZoEWFXUMKq05fR5MgBoI=;
        b=DP1oPcReZrqIQYNKPCKKpuOLC8q+Vde+ptpUXIViHj7Xi2x/0dvsKTY27vnUte67Aw
         quAWSxK8NJqrvJYQvZfJB2LmYNYdVh66DdWi7u56pXq8aR6UtuPK8H9aaF9SGSOUplR0
         KaGcgW8NA7e3R0fPD8VxRe+M4yPYUyN3DUY+1IS2qumKVRGjNfCgVSMbhpksrDCS1/b6
         hyobBCoK2gNqpfOEnDLOxLu04rrlS4Fony4SgrKnjSjbj6QZx8+dQ9G0apOu0YzE+0Ma
         r7XDRbhNBvYqPBKPGzRzCsJ5bpXp1bcYv/mKuTsOW+k4zjjIUNy8ubl9ONUGI0BKeEp9
         6y7Q==
X-Gm-Message-State: AOAM530gQIXdlheH/JhaQeT3GvK52u1SUOxh76OI2Y8ggaD2cw1qvUDn
        M979waKM1cgGxJr8ZbphOM52/A==
X-Google-Smtp-Source: ABdhPJyi/O4/QkvK0vdP1ocRmXkb7lxwJC7RNGtV8T+Y+zuP/wovhJwJYeLyTH+iFy9k43M+/CN3AA==
X-Received: by 2002:a5d:824f:: with SMTP id n15mr2710901ioo.95.1598907859727;
        Mon, 31 Aug 2020 14:04:19 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t67sm4685400ill.88.2020.08.31.14.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 14:04:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] kselftests/arm64: add PAuth tests
To:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, amit.kachhap@arm.com,
        boian4o1@gmail.com, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4589c6e-2bf9-1554-4ee7-d04bbe0e9391@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 15:04:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831110450.30188-1-boyan.karatotev@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 5:04 AM, Boyan Karatotev wrote:
> Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
> It introduces instructions to sign addresses and later check for potential
> corruption using a second modifier value and one of a set of keys. The
> signature, in the form of the Pointer Authentication Code (PAC), is stored
> in some of the top unused bits of the virtual address (e.g. [54: 49] if
> TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
> controls are present to enable/disable groups of instructions (which use
> certain keys) for compatibility with libraries that do not utilize the
> feature. PAuth is used to verify the integrity of return addresses on the
> stack with less memory than the stack canary.
> 
> This patchset adds kselftests to verify the kernel's configuration of the
> feature and its runtime behaviour. There are 7 tests which verify that:
> 	* an authentication failure leads to a SIGSEGV
> 	* the data/instruction instruction groups are enabled
> 	* the generic instructions are enabled
> 	* all 5 keys are unique for a single thread
> 	* exec() changes all keys to new unique ones
> 	* context switching preserves the 4 data/instruction keys
> 	* context switching preserves the generic keys
> 
> The tests have been verified to work on qemu without a working PAUTH
> Implementation and on ARM's FVP with a full or partial PAuth
> implementation.
> 
> Changes in v2:
> * remove extra lines at end of files
> * Patch 1: "kselftests: add a basic arm64 Pointer Authentication test"
> 	* add checks for a compatible compiler in Makefile
> * Patch 4: "kselftests: add PAuth tests for single threaded consistency and
> key uniqueness"
> 	* rephrase comment for clarity in pac.c
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> 
> Boyan Karatotev (4):
>    kselftests/arm64: add a basic Pointer Authentication test
>    kselftests/arm64: add nop checks for PAuth tests
>    kselftests/arm64: add PAuth test for whether exec() changes keys
>    kselftests/arm64: add PAuth tests for single threaded consistency and
>      key uniqueness
> 
>   tools/testing/selftests/arm64/Makefile        |   2 +-
>   .../testing/selftests/arm64/pauth/.gitignore  |   2 +
>   tools/testing/selftests/arm64/pauth/Makefile  |  39 ++
>   .../selftests/arm64/pauth/exec_target.c       |  35 ++
>   tools/testing/selftests/arm64/pauth/helper.c  |  40 ++
>   tools/testing/selftests/arm64/pauth/helper.h  |  29 ++
>   tools/testing/selftests/arm64/pauth/pac.c     | 348 ++++++++++++++++++
>   .../selftests/arm64/pauth/pac_corruptor.S     |  35 ++
>   8 files changed, 529 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
>   create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
>   create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
>   create mode 100644 tools/testing/selftests/arm64/pauth/helper.c
>   create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
>   create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
>   create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S
> 
> --
> 2.17.1
> 
> 

Will, Catalin,

Patches look good to me from selftests perspective. My acked by
for these patches to go through arm64.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If you would like me to take these through kselftest tree, give
me your Acks. I can queue these up for 5.10-rc1

thanks,
-- Shuah


