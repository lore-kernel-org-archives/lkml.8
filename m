Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E7C206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YedDG0ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440811AbgDNPnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440802AbgDNPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:43:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:43:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g32so46529pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrHc89msdXgi2Y4Q0qH1yTEHGNBhvf5/H8327yK+Ls4=;
        b=YedDG0ZFTRyqyAnKIG8z1JZFuDUEx5ng/hd+NQImZj6HKH3GWoHZv0p4lx3TpGALhZ
         0qQoPEflzIgF6SfYYPStjVZve457G0ZBKn0C4+GyrXP90wjqyuOaWcwOYMJLTN1Kf9IH
         fCwuZd0xvBU0B+dv3VE61SLogfaxzz8/hPw5W/tgGRa6JD5RX1Q1P0nAiUwvIGyIJ+rP
         1v+4mMz2/8PCz8/50zqXGyDQ2VcxWbkl8DmfpVhbio84eoaC9hcIMloYnWqZQjy+IcAz
         xL1P9teLDVAzbR346QhSdbQML5K+vB+crLmnYqhiM2kFg9BTV4/BHo8ERW3n1xxobog0
         pp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrHc89msdXgi2Y4Q0qH1yTEHGNBhvf5/H8327yK+Ls4=;
        b=TgSa8bwb6jwqsPKmqLYaMgf01+sOV8tdmn1AlBZWz3TDaeJda9uFKtep+P0f+UgCnA
         Zj1nPr2CY2L127aM/B+MnveZpW8QlW6jQ31bucVItonZzMzuwsRntoUus5NZkl3Xip2L
         rU+YwMEXIpcVZ/OZisQlcywXmqGPAwhfRS3V635AZUlQhUMoJFz3du2NQnvOc9VGqYE2
         eM/S7vuujaqapF42yzCcja6wiBGvu5ki/cHoypdsoj5rT2CpEkiyT34WR5tBi8FYdkQz
         eZtakdD/6aUle4RVszSpWhxCY5RuD0Arkxkr4pMxZ99TUglongD8ARRc9WagObrDyClA
         4fMg==
X-Gm-Message-State: AGi0PuaUSJlUTRsT6lYMBU+yJhFtfwBZxAvxL1wy8rXCZsXq2Gt8ITmb
        ceX0fvlU8q6i1TjvBmbgFKCDXw==
X-Google-Smtp-Source: APiQypLrT1386zPYBPL87WSGpCvwjpvwKbln64uclI2ODgTX44mVS85T8KsJwkSSsXo6kzAPWf/95g==
X-Received: by 2002:a63:1e0a:: with SMTP id e10mr23094381pge.417.1586878990825;
        Tue, 14 Apr 2020 08:43:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id s9sm11766283pjr.5.2020.04.14.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:43:10 -0700 (PDT)
Date:   Tue, 14 Apr 2020 08:43:07 -0700
From:   Fangrui Song <maskray@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: Delete the space separator in __emit_inst
Message-ID: <20200414154307.2cke3x5ocz3q2as4@google.com>
References: <20200413033811.75074-1-maskray@google.com>
 <20200414095904.GB1278@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200414095904.GB1278@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-04-14, Mark Rutland wrote:
>Hi Fangrui,
>
>On Sun, Apr 12, 2020 at 08:38:11PM -0700, Fangrui Song wrote:
>> Many instances of __emit_inst(x) expand to a directive. In a few places
>> it is used as a macro argument, e.g.
>>
>>   arch/arm64/include/asm/sysreg.h
>>   #define __emit_inst(x)                       .inst (x)
>>
>>   arch/arm64/include/asm/sysreg.h
>>   #define SET_PSTATE_PAN(x)            __emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
>>
>>   arch/arm64/kvm/hyp/entry.S
>>   ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
>>
>> Clang integrated assembler parses `.inst (x)` as two arguments passing
>> to a macro. We delete the space separator so that `.inst(x)` will be
>> parsed as one argument.
>
>I'm a little confused by the above; sorry if the below sounds stupid or
>pedantic, but I just want to make sure I've understood the problem
>correctly.
>
>For the above, ALTERNATIVE() and SET_PSTATE_PAN() are both preprocessor
>macros, so I would expect those to be expanded before either the
>integrated assembler or an external assembler consumes any of the
>assembly (and both would see the same expanded text). Given that, I'm a
>bit confused as to why the integrated assembly would have an impact on
>preprocessing.
>
>Does compiling the pre-processed source using the integrated assembler
>result in the same behaviour? Can we see the expanded text to make that
>clear?
>
>... at what stage exactly does this go wrong?
>
>Thanks,
>Mark.

Hi Mark,

The C preprocessor expands arch/arm64/kvm/hyp/entry.S
    ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)

to:
    alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1

`alternative_insn` is an assembler macro, not handled by the C preprocessor.

Both comma and space are separators, with an exception that content
inside a pair of parentheses/quotes is not split, so clang -cc1as or GNU
as x86 splits arguments this way:

    nop, .inst, (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1

I actually feel that GNU as arm64's behavior is a little bit buggy. It
works just because GNU as has another preprocessing step `do_scrub_chars`
and its arm64 backend deletes the space before '('

    alternative_insn nop,.inst(0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1

The x86 backend keeps the space before the outmost '('

   alternative_insn nop,.inst (0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1

By reading its state machine, I think keeping the spaces will be the
most reasonable behavior.

If .inst were only used as arguments,

    alternative_insn nop, ".inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8))", 4, 1

would be the best to avoid parsing issues.

>>
>> Note, GNU as parsing `.inst (x)` as one argument is unintentional (for
>> example the x86 backend will parse the construct as two arguments).
>> See https://sourceware.org/bugzilla/show_bug.cgi?id=25750#c10
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/939
>> Cc: clang-built-linux@googlegroups.com
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index ebc622432831..af21e2ec5e3e 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -49,7 +49,9 @@
>>  #ifndef CONFIG_BROKEN_GAS_INST
>>
>>  #ifdef __ASSEMBLY__
>> -#define __emit_inst(x)			.inst (x)
>> +// The space separator is omitted so that __emit_inst(x) can be parsed as
>> +// either a directive or a macro argument.
>> +#define __emit_inst(x)			.inst(x)
>>  #else
>>  #define __emit_inst(x)			".inst " __stringify((x)) "\n\t"
>>  #endif
>> --
>> 2.26.0.110.g2183baf09c-goog
>>
