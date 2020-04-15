Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC27C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5188C206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kzCXjBTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636891AbgDOUGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:06:40 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49818 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406385AbgDOUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:06:35 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A3EE95C07A7;
        Wed, 15 Apr 2020 22:06:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1586981187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18e6r5y/jgXADhhgiX3R6vif1YdVTFwaHH058p3heBc=;
        b=kzCXjBTXYRcKiwbTlcwjtNog8tdHIMY90JOBql07rNRqIMwQCIZoGNCieVInoqLmPhYZwm
        4k8P+IzP+CWSyghxueLPF6FHo9o0Wq/NYnUnX48Qv68wgwdblpR+IsAkpJeT0Xz2uQE46I
        lghJiyJ2GG3Sm5jm1slWnNgNuLwtqOg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Apr 2020 22:06:27 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jian Cai <caij2003@gmail.com>, Manoj Gupta <manojgupta@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: replace the sole use of a symbol with its definition
In-Reply-To: <CAKwvOdk3YG5TFD71E-9vPqssFZW1U3umCR+AWLLp8RZK2zHGsw@mail.gmail.com>
References: <20200407190558.196865-1-caij2003@gmail.com>
 <CAKwvOdk3YG5TFD71E-9vPqssFZW1U3umCR+AWLLp8RZK2zHGsw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <a6964b6f784266838070f434110661f3@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-13 20:29, Nick Desaulniers wrote:
> On Tue, Apr 7, 2020 at 12:09 PM Jian Cai <caij2003@gmail.com> wrote:
>>
>> ALT_UP_B macro sets symbol up_b_offset via .equ to an expression
>> involving another symbol. The macro gets expanded twice when
>> arch/arm/kernel/sleep.S is assembled, creating a scenario where
>> up_b_offset is set to another expression involving symbols while its
>> current value is based on symbols. LLVM integrated assembler does not
>> allow such cases, and based on the documentation of binutils, "Values
>> that are based on expressions involving other symbols are allowed, but
>> some targets may restrict this to only being done once per assembly", so
>> it may be better to avoid such cases as it is not clearly stated which
>> targets should support or disallow them. The fix in this case is simple,
>> as up_b_offset has only one use, so we can replace the use with the
>> definition and get rid of up_b_offset.
>>
>> Signed-off-by: Jian Cai <caij2003@gmail.com>

Thanks for tackling this!

> 
> Probably didn't need the extra parens, but it's fine (unless another
> reviewer would like a v2).  Maybe Stefan has some thoughts?

Since this is a processor macro I actually prefer to have parentheses
here. All use sites of ALT_UP_B pass just a label, but still, just to be
on the safe side.

I was wondering why equ has been used in first place. I don't see an
advantage other than having a symbol which can be checked. But given
that this code is stable and don't really need debugging at this point,
I am fine replacing this to make it work for clang.


> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Please add Link tags if these correspond to issues in our link
> tracker, they help us track when and where patches land.
> Link: https://github.com/ClangBuiltLinux/linux/issues/920

Agreed, please add the link. You can add this when submitting.

With that:
Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
>> ---
>>  arch/arm/include/asm/assembler.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 99929122dad7..adee13126c62 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -269,10 +269,9 @@
>>         .endif                                                  ;\
>>         .popsection
>>  #define ALT_UP_B(label)                                        \
>> -       .equ    up_b_offset, label - 9998b                      ;\
>>         .pushsection ".alt.smp.init", "a"                       ;\
>>         .long   9998b                                           ;\
>> -       W(b)    . + up_b_offset                                 ;\
>> +       W(b)    . + (label - 9998b)                                     ;\
>>         .popsection
>>  #else
>>  #define ALT_SMP(instr...)
>> --
>> 2.26.0.292.g33ef6b2f38-goog
>>
