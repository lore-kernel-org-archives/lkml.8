Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB5C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15F020873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWPF75kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBMWhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:37:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55181 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBMWhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:37:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so2995322pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LSo1ah5/h9TUr/PTXeSMqWPKGVNPVelfqslM6wp+98E=;
        b=uWPF75kgSXDx07PQ+XEnxy80wgRZ1E9QiB4xDvtq4pwOce9KyrGAjOCygijYV/amdj
         Jsr8yc0nqfVTspuWh1ZFyoJZulG5RBlGhb8ogITTuKwFQujwym2mm96rbChfMSlmMh8g
         uCCxiu3AuloeRwiTeBOgl2UdVcdCbbjEe0aIH1FZOFBih5V6MPuVHtHhf1U9WU6Wqxf4
         q5L7+gpX4OpJ5ugqX6MBy/kQ0ddQZ19nSIgfedyTCMf4YFoFo/t8PfYPc2kWnY+ArcBG
         iKotcNyO8qNy5bBUuEvxfV5bYcQterJZxKlmklJGR/vJ/W9U3ZiagWwFhl2n3IfmGHdv
         6/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LSo1ah5/h9TUr/PTXeSMqWPKGVNPVelfqslM6wp+98E=;
        b=fkG9tV8tiExo8r7s6jePFfkmaMhNk1DUnXYdZTvz9GKwM1u9W/PkXp6xxIrpWCLALI
         2LLQYC5fu6NnWdd0OMjuGd2HiXgUvJGci0TGgEmPU/0y4QnjTl8DJ66Y626B+UoLp7YP
         DBVcMOw+hTxTPYPxiB7Zm5N6mkIw/8yi2Ef+kybwBqFaT+1K5EXE8goTMuraPhw49wTX
         j+OtpyQ64ZeTXucduCi67hfo6NP8amMpbhkadw5CvgtB2CuC6MlwJU87uElEDbyeLSL9
         zXVUPlexhLbgWb8AhDZy1W0TRZTUX1+SGrqc8KgVAwLeVCKYkXSeYYUbtoXUK7ufmtoA
         Q3qQ==
X-Gm-Message-State: APjAAAU883w7uNHl/iHviphI5mrAV/pQrpcsAT77m5AyFvTXeO6uNMF6
        6+aV1Ds53rMw/y4XvDTDq3OVGw==
X-Google-Smtp-Source: APXvYqxJ2B9/JPZeuWU2GfIzm+Xp5nJZOd1mR2GB5KBOOQpO0TFSOuDmkPg2pI9oWXDZi01NMC+jNQ==
X-Received: by 2002:a17:902:8ec6:: with SMTP id x6mr115086plo.247.1581633457449;
        Thu, 13 Feb 2020 14:37:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id r14sm4163006pfh.10.2020.02.13.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 14:37:36 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:37:34 -0800
From:   Fangrui Song <maskray@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, peterz@infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200213223734.3zjrvhshjyr5ca7p@google.com>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213221758.i6pchz4gsiy2lsyc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200213221758.i6pchz4gsiy2lsyc@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-13, Josh Poimboeuf wrote:
>On Thu, Feb 13, 2020 at 10:47:08AM -0800, Nick Desaulniers wrote:
>> Top of tree LLVM has optimizations related to
>> -fno-semantic-interposition to avoid emitting PLT relocations for
>> references to symbols located in the same translation unit, where it
>> will emit "local symbol" references.
>>
>> Clang builds fall back on GNU as for assembling, currently. It appears a
>> bug in GNU as introduced around 2.31 is keeping around local labels in
>> the symbol table, despite the documentation saying:
>>
>> "Local symbols are defined and used within the assembler, but they are
>> normally not saved in object files."
>>
>> When objtool searches for a symbol at a given offset, it's finding the
>> incorrectly kept .L<symbol>$local symbol that should have been discarded
>> by the assembler.
>>
>> A patch for GNU as has been authored.  For now, objtool should not treat
>> local symbols as the expected symbol for a given offset when iterating
>> the symbol table.

R_X86_64_PLT32 was fixed (just now) by
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=292676c15a615b5a95bede9ee91004d3f7ee7dfd
It will be included in binutils 2.35 and probably a bug fix release of 2.34.x

>> commit 644592d32837 ("objtool: Fail the kernel build on fatal errors")
>> exposed this issue.
>
>Since I'm going to be dropping 644592d32837 ("objtool: Fail the kernel
>build on fatal errors") anyway, I wonder if this patch is still needed?
>
>At least the error will be downgraded to a warning.  And while the
>warning could be more user friendly, it still has value because it
>reveals a toolchain bug.

I still consider such a check (tools/objtool/check.c:679) unneeded.

st_type doesn't have to be STT_FUNC. Either STT_NOTYPE or STT_FUNC is
ok. If STT_GNU_IFUNC is used, it can be ok as well.
(My clang patch skips STT_GNU_IFUNC just because rtld typically doesn't
  cache R_*_IRELATIVE results. Having two STT_GNU_IFUNC symbols with same st_shndx and
  st_value can create two R_*_IRELATIVE, which need to be resolved twice
  at runtime.)

	} else if (rela->sym->type == STT_SECTION) {
		insn->call_dest = find_symbol_by_offset(rela->sym->sec,
							rela->addend+4);
		if (!insn->call_dest ||
		    insn->call_dest->type != STT_FUNC) {
			WARN_FUNC("can't find call dest symbol at %s+0x%x",
				  insn->sec, insn->offset,
				  rela->sym->sec->name,
				  rela->addend + 4);
			return -1;
		}


	.section	.init.text,"ax",@progbits
	call	printk
	call	.Lprintk$local
	.text
	.globl	printk
	.type	printk,@function
printk:
.Lprintk$local:
  ret

% llvm-mc -filetype=obj -triple=riscv64 a.s -mattr=+relax -o a.o
% readelf -Wr a.o

Relocation section '.rela.init.text' at offset 0xa0 contains 4 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000012 R_RISCV_CALL           0000000000000000 printk + 0
0000000000000000  0000000000000033 R_RISCV_RELAX                             0
0000000000000008  0000000100000012 R_RISCV_CALL           0000000000000000 .Lprintk$local + 0
0000000000000008  0000000000000033 R_RISCV_RELAX                             0


On RISC-V, when relaxation is enabled, .L cannot be resolved at assembly
time because sections can shrink.

https://sourceware.org/binutils/docs/as/Symbol-Names.html

> Local symbols are defined and used within the assembler, but they are *normally* not saved in object files.

I consider the GNU as issue a missed optimization, instead of a bug.
There is no rigid rule that .L symbols cannot be saved in object files.
