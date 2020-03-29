Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA0AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CAA20714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="C/RqPRCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgC2SCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:02:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33778 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgC2SCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:02:42 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1322D5C4E62;
        Sun, 29 Mar 2020 20:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1585504960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9KjmaInreQ1tydeO4+d2Tu0zpyS1eiXjbaSxIllgiU=;
        b=C/RqPRCXjLhWk84XCkxEpAz6C6eU8DoWZh5HF/QbiE6W8nT6MBPglT9ScEq3JaK3lLMdmn
        OYd1TygqS5m+8smVmpFAHoHcE0Rsc6DLUzTyvL4vNAwFF1Q2oC8Mv3jUhHZN5ob+r/SlyJ
        ECL4k0WAP4ORh9Na8akRL7LN8oix/o0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 29 Mar 2020 20:02:40 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: warn if pre-UAL assembler syntax is used
In-Reply-To: <dc6a2492b5d7726ccda09ae69543f62f@agner.ch>
References: <cd74f11eaee5d8fe3599280eb1e3812ce577c835.1582849064.git.stefan@agner.ch>
 <CAKwvOdneF5nXgx3Rh6=NhPK+q93VRhs7mDCcK2eGY0e2rOqqnQ@mail.gmail.com>
 <dc6a2492b5d7726ccda09ae69543f62f@agner.ch>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <b981bc51076bc1abe13ef85041677a78@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-17 08:55, Stefan Agner wrote:
> On 2020-03-17 01:00, Nick Desaulniers wrote:
>> Revert "ARM: 8846/1: warn if divided syntax assembler is used"On Thu,
>> Feb 27, 2020 at 4:19 PM Stefan Agner <stefan@agner.ch> wrote:
>>>
>>> Remove the -mno-warn-deprecated assembler flag for GCC versions newer
>>> than 5.1 to make sure the GNU assembler warns in case non-unified
>>> syntax is used.
>>
>> Hi Stefan, sorry for the late reply from me; digging out my backlog.
>> Do you happen to have a godbolt link perhaps that demonstrates this?
>> It sounds like GCC itself is emitting pre-UAL?
> 
> Yes, that is what Russell observed and caused the revert:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b752bb405a13
> 
> I do not have a godbolt link at hand, I just built the complete kernel
> using some GCC toolchains I had locally available and noticed that the
> problem persists up to and including GCC 5.0. I did not track down what
> exactly is causing GCC to emit pre-UAL.

Godbolt link:
https://godbolt.org/z/fxYq_s

However, the warning does not appear on godbolt.org, presumably because
the compiler is started such that it does not invoke the assembler (at
least that is what I understand when using -v). However, on my end this
leads to:

$ arm-linux-gnueabihf-gcc -marm -march=armv7-a -O2  -c  test.c -o test
--save-temps
test.s: Assembler messages:
test.s:33: Warning: conditional infixes are deprecated in unified syntax
$ arm-linux-gnueabihf-gcc --version
arm-linux-gnueabihf-gcc (Linaro GCC 4.9-2016.02) 4.9.4 20151028
(prerelease)

And line 33 contains a non-unified assembler mnemonic:
        strneb  r2, [r3]

Note: I do have to explicitly use .syntax unified. It seems that gcc is
not explicitly doing this, but if any inline assembly is changing the
assembler mode (e.g. what including arch/arm/include/asm/unified.h is
doing) then the assembler warnings start to appear.

--
Stefan


> 
>>
>>>
>>> This also prevents a warning when building with Clang and enabling
>>> its integrated assembler:
>>> clang-10: error: unsupported argument '-mno-warn-deprecated' to option 'Wa,'
>>>
>>> This is a second attempt of commit e8c24bbda7d5 ("ARM: 8846/1: warn if
>>> divided syntax assembler is used").
>>
>> Would it be helpful to also make note of
>> commit b752bb405a13 ("Revert "ARM: 8846/1: warn if divided syntax
>> assembler is used"")?
> 
> Sure, I can do that.
> 
>>
>>
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>  arch/arm/Makefile | 14 +++++++++-----
>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>>> index db857d07114f..a6c8c9f39185 100644
>>> --- a/arch/arm/Makefile
>>> +++ b/arch/arm/Makefile
>>> @@ -119,21 +119,25 @@ ifeq ($(CONFIG_CC_IS_CLANG),y)
>>>  CFLAGS_ABI     += -meabi gnu
>>>  endif
>>>
>>> -# Accept old syntax despite ".syntax unified"
>>> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>>
>> This existing code is quite bad for Clang, which doesn't support
>> `-Wa,-mno-warn-deprecated`, so this falls back to `-Wa,-W`, which
>> disables all warnings from the assembler, which we definitely do not
>> want.  That alone is worth putting in the GCC guard.  But I would like
>> more info about GCC above before signing off.
> 
> FWIW, I submitted this to the patch tracker already, but I don't think
> it got merged already.
> 
> --
> Stefan
> 
>>
>>> -
>>>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>>> -CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
>>> +CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always
>>>  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb
>>>  # Work around buggy relocation from gas if requested:
>>>  ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
>>>  KBUILD_CFLAGS_MODULE   +=-fno-optimize-sibling-calls
>>>  endif
>>>  else
>>> -CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
>>> +CFLAGS_ISA     :=$(call cc-option,-marm,)
>>>  AFLAGS_ISA     :=$(CFLAGS_ISA)
>>>  endif
>>>
>>> +ifeq ($(CONFIG_CC_IS_GCC),y)
>>> +ifeq ($(call cc-ifversion, -lt, 0501, y), y)
>>> +# GCC <5.1 emits pre-UAL code and causes assembler warnings, suppress them
>>> +CFLAGS_ISA     +=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>>> +endif
>>> +endif
>>> +
>>>  # Need -Uarm for gcc < 3.x
>>>  KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
>>>  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
>>> --
