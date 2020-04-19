Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB8C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 21:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11382145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 21:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="NojelCtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDSVU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:20:55 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C06C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 14:20:55 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8A7D95C2AD6;
        Sun, 19 Apr 2020 23:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1587331250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPJzpM7y8xsutEk9xoRCpyH0Mjw6Ey8nK+iP0TqlfaE=;
        b=NojelCtNh2sieDxsw11fxyIRQs7U1VjKYKwOP712QhxFbnZArTCgBqrqc1zE0uVxzAbHg1
        f39v/wrAGINya/vNYlYGUD48aG5JUAjdBh34MXaifCgAZCsdhuCtI618k7pyD3jhYG4y3g
        Q3gfgdd87+9flCV4rAKvdq8zjerCf6M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Apr 2020 23:20:50 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     clang-built-linux@googlegroups.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, jiancai@google.com,
        yamada.masahiro@socionext.com, manojgupta@google.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ARM: make use of UAL VFP mnemonics when possible
In-Reply-To: <20200419141229.GX25745@shell.armlinux.org.uk>
References: <cover.1587299429.git.stefan@agner.ch>
 <20200419141229.GX25745@shell.armlinux.org.uk>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <7c3bb6fedbb2ff512451fa8e5abe2440@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-19 16:12, Russell King - ARM Linux admin wrote:
> On Sun, Apr 19, 2020 at 02:35:48PM +0200, Stefan Agner wrote:
>> To build the kernel with Clang's integrated assembler the VFP code needs
>> to make use of the unified assembler language (UAL) VFP mnemonics.
>>
>> At first I tried to get rid of the co-processor instructions to access
>> the floating point unit along with the macros completely. However, due
>> to missing FPINST/FPINST2 argument support in older binutils versions we
>> have to keep them around. Once we drop support for binutils 2.24 and
>> older, the move to UAL VFP mnemonics will be straight forward with this
>> changes applied.
>>
>> Tested using Clang with integrated assembler as well as external
>> (binutils assembler), various gcc/binutils version down to 4.7/2.23.
>> Disassembled and compared the object files in arch/arm/vfp/ to make
>> sure this changes leads to the same code. Besides different inlining
>> behavior I was not able to spot a difference.
>>
>> In v2 the check for FPINST argument support is now made in Kconfig.
> 
> Given what I said in the other thread, Clang really _should_ allow
> the MCR/MRC et.al. instructions to access the VFP registers.  There
> is no reason to specifically block them.

I agree, and I am working on changing this.

There have been discussions about co-processor register access a while
back in the LLVM/Clang community [1]. Peter Smith pointed this out in
the ClangBuiltLinux issue tracker [2], which also has some more context.
I did submit a patch [3] to convert use of cp10/cp11 in ARMv7 contexts
to a warning. However it got stale, I'll have to revisit.

There is actually another case where this issue blocks Clang's
integrated assembler: In arch/arm/kernel/perf_event_v7.c, function
venum_read_pmresr mcr/mrc is used to access the performance monitor
registers for Qualcomm's Krait/Scorpion PMU, and in this case there is
no mnemonic available.

> 
> As we have seen with FPA, having that ability when iWMMXT comes along
> is very useful.  In any case:
> 
> 1. The ARM ARM (DDI0406) states that "These instructions are MRC and MCR
> instructions for coprocessors 10 and 11." in section A7.8.
> 
> 2. The ARM ARM (DDI0406) describes the MRC and MCR instructions as
> being able to access _any_ co-processor.

These are good arguments I can use in case my patch stirs up a
discussion, thanks for the hints!

> 
> So, Clang deciding that it's going to block access to coprocessor 10
> and 11 because some version of the architecture _also_ defines these
> as VFP instructions is really not on, and Clang needs to be fixed
> irrespective of these patches - and I want to know that *is* going to
> get fixed before I take these patches into the kernel.

I'll try. We'll see.

[1] https://bugs.llvm.org/show_bug.cgi?id=20025
[2] https://github.com/ClangBuiltLinux/linux/issues/306
[3] https://reviews.llvm.org/D59733

--
Stefan
