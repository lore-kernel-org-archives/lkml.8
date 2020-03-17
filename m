Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB2EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6C920663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="XVkIrOVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgCQHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:55:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37848 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:55:48 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 989095C0103;
        Tue, 17 Mar 2020 08:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1584431745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3KVNi+Ory+PQWNhNehyp69k/05vP43IyXekB0qsnHY=;
        b=XVkIrOVEZKLTLr/TEn5jiDgZkGpH+kf+fDq2LuXJxf4Wu19ollYOy7FNTptWdotjlo0Bnl
        9J7hiQ/PzatQP9rX1qfsxfaj24Enfe708N68CAl5Z0v3QhE8gGgVWQSvqbUvbnoUdzUAQe
        jCrsMwbWP3q2cGDo9rYIUlzWfPEFsqU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Mar 2020 08:55:45 +0100
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
In-Reply-To: <CAKwvOdneF5nXgx3Rh6=NhPK+q93VRhs7mDCcK2eGY0e2rOqqnQ@mail.gmail.com>
References: <cd74f11eaee5d8fe3599280eb1e3812ce577c835.1582849064.git.stefan@agner.ch>
 <CAKwvOdneF5nXgx3Rh6=NhPK+q93VRhs7mDCcK2eGY0e2rOqqnQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <dc6a2492b5d7726ccda09ae69543f62f@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-17 01:00, Nick Desaulniers wrote:
> Revert "ARM: 8846/1: warn if divided syntax assembler is used"On Thu,
> Feb 27, 2020 at 4:19 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> Remove the -mno-warn-deprecated assembler flag for GCC versions newer
>> than 5.1 to make sure the GNU assembler warns in case non-unified
>> syntax is used.
> 
> Hi Stefan, sorry for the late reply from me; digging out my backlog.
> Do you happen to have a godbolt link perhaps that demonstrates this?
> It sounds like GCC itself is emitting pre-UAL?

Yes, that is what Russell observed and caused the revert:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b752bb405a13

I do not have a godbolt link at hand, I just built the complete kernel
using some GCC toolchains I had locally available and noticed that the
problem persists up to and including GCC 5.0. I did not track down what
exactly is causing GCC to emit pre-UAL.

> 
>>
>> This also prevents a warning when building with Clang and enabling
>> its integrated assembler:
>> clang-10: error: unsupported argument '-mno-warn-deprecated' to option 'Wa,'
>>
>> This is a second attempt of commit e8c24bbda7d5 ("ARM: 8846/1: warn if
>> divided syntax assembler is used").
> 
> Would it be helpful to also make note of
> commit b752bb405a13 ("Revert "ARM: 8846/1: warn if divided syntax
> assembler is used"")?

Sure, I can do that.

> 
> 
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/Makefile | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index db857d07114f..a6c8c9f39185 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -119,21 +119,25 @@ ifeq ($(CONFIG_CC_IS_CLANG),y)
>>  CFLAGS_ABI     += -meabi gnu
>>  endif
>>
>> -# Accept old syntax despite ".syntax unified"
>> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> 
> This existing code is quite bad for Clang, which doesn't support
> `-Wa,-mno-warn-deprecated`, so this falls back to `-Wa,-W`, which
> disables all warnings from the assembler, which we definitely do not
> want.  That alone is worth putting in the GCC guard.  But I would like
> more info about GCC above before signing off.

FWIW, I submitted this to the patch tracker already, but I don't think
it got merged already.

--
Stefan

> 
>> -
>>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>> -CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
>> +CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always
>>  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb
>>  # Work around buggy relocation from gas if requested:
>>  ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
>>  KBUILD_CFLAGS_MODULE   +=-fno-optimize-sibling-calls
>>  endif
>>  else
>> -CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
>> +CFLAGS_ISA     :=$(call cc-option,-marm,)
>>  AFLAGS_ISA     :=$(CFLAGS_ISA)
>>  endif
>>
>> +ifeq ($(CONFIG_CC_IS_GCC),y)
>> +ifeq ($(call cc-ifversion, -lt, 0501, y), y)
>> +# GCC <5.1 emits pre-UAL code and causes assembler warnings, suppress them
>> +CFLAGS_ISA     +=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>> +endif
>> +endif
>> +
>>  # Need -Uarm for gcc < 3.x
>>  KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
>>  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
>> --
