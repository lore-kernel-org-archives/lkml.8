Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11708C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2622078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk6c4pcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgFIOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:15:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F44C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:15:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so10110890pfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KkxDiQa68qKNvgLwM3rURPXoQaUSZ7141ZuwiD11WYc=;
        b=Yk6c4pcGbmHyRUevGDDZBeLK6qmgNGHVmzO/bdb8Zyxag7C6ENwravk4Xb7HLrytk9
         dCANF4U1J4HnwGdqpuTynXyF8iOZx9DztBCAel5qC91qmRXvYqa4aW7wGD7yOMlNsURU
         dtqNNUrCLzNwS9PrWFkPDolyiBNzozk9AsV3w5+9Z6Sd6XvXiFDT0WK2ORCdZAN00b3m
         bi/RMchFdWaKkFLhPL2cJ8K4CKkL0YkRl0ZQ5M2pVl7q2gLAvpNnEr/bz6ctwCrrIXp9
         dcLuHpnIml4vTsIe9qtsY3MD4iXrl0iFyuhkuxMKRM/kcWfSC/WRQttmtDFmw65va9Qo
         Riyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KkxDiQa68qKNvgLwM3rURPXoQaUSZ7141ZuwiD11WYc=;
        b=kv9J7fPfP8nt51Rum0VJRdo73k8m23IVB4/xr+IKtJp1c9zwnLuWKksdEoWAHLI7Ba
         Gd77AFj991kpW8CMZtBBq7GqA1HAYO0yQhwAMMKrHTce6LmommCxevzgtef3OJ9yey35
         eJhuA8pmzwuNifUQKA0S2EXASrByh3p/7vWKPwRcdPTPbUFyrBBpzDSRnGRynEXIfsqK
         f7xj+YAX8NYkqehxeUyahY2RP5MsRj9VGz2Jr48JJGMPp+XttvmSXMpilyJxQK3ZEakQ
         5S/sr6JOYrZs3Q0wW/HiGJc9RYyowxeplIJHZ0r0VBmL3vKlkBYAdywpef7tMeuQa74t
         5OeQ==
X-Gm-Message-State: AOAM5330eDVfCYcxxCaXgW0uIl7KKXc+rKHe1uD96xdYDcvnsr3r7oRs
        GA3FYIvLhGPAZn++73euVzbEvBsG
X-Google-Smtp-Source: ABdhPJw6NRk+LgfeM91W3mBCEvHkIRY9lv5nSH2hNWeSThSXhGG12WuNo3b1sN/jKUBn/pPJUeMgVQ==
X-Received: by 2002:a05:6a00:78b:: with SMTP id g11mr24543789pfu.86.1591712145202;
        Tue, 09 Jun 2020 07:15:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hv15sm2613981pjb.17.2020.06.09.07.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:15:43 -0700 (PDT)
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
To:     Joerg Roedel <jroedel@suse.de>, Mike Rapoport <rppt@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de> <20200605100059.GB7524@linux.ibm.com>
 <20200609121056.GB3871@suse.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c11fd19b-e5b6-1bc9-6392-04dbab358b67@roeck-us.net>
Date:   Tue, 9 Jun 2020 07:15:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200609121056.GB3871@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 5:10 AM, Joerg Roedel wrote:
> Hi Mike,
> 
> On Fri, Jun 05, 2020 at 01:00:59PM +0300, Mike Rapoport wrote:
>> We already have include/asm-generic/pgalloc.h, so maybe something like
>> that patch below would fork. This is not even compile tested.
>>
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> 
> I experimented a bit with your diff, but it turned out that moving the
> page-table allocation functions/macros to asm-generic/pgalloc.h does not
> work on all architectures.
> 
> The reason is that some archs don't use that header at all (e.g. ARC)
> and have their own version of the functions defined there. That could
> all be made working, but I decided to no open this can of worms for now.
> 
> So I sent out a patch which moves the p?d_alloc_track() functions/macros
> to a separate header and include it only in mm/vmalloc.c and
> lib/ioremap.c. That compiles on all architectures where current Linus'
> master also builds (it does not for Alpha, CSky, Mips and Mips64), and
> as usual Hexagon and Unicore32 are not tested because I have no working
> compiler for those.
> 

To build csky images, you have to disable CONFIG_FRAME_POINTER or use a
non-upstream compiler. To build any images reliably, you have to disable
CONFIG_GCC_PLUGIN_RANDSTRUCT or use a version of gcc old enough to not
support it (gcc 6.x is fine). For mips, you have to specify ARCH and
CROSS_COMPILE as environment variables.

alpha is a lost case. The offending commit is 0f1c9688a19 ("tty/sysrq:
alpha: export and use __sysrq_get_key_op()"); it looks like that wasn't
build tested. It can not be reverted easily because of subsequent changes.

I have stopped building unicore32 images since v4.19 since there is
no available compiler that is still supported by the kernel. I am
surprised that support for it has not been removed from the kernel.

I am told that hexagon only supports llvm/clang, and the only version
of gcc that supports it is v4.6.1 (from Sourcery CodeBench Lite
2012.03-66). The minimum version of gcc will be raised to v4.8;
that has already happened in linux-next and will presumably be applied
to mainline shortly. With that, I'll stop build testing hexagon images
as well until I find the time to build a llvm/clang hexagon toolchain.

So you are in good company, and thanks for testing everything else.

Guenter
