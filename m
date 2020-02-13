Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3AEC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15F42082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOrMTpvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBMXRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:17:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbgBMXRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581635824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPKc4Qj1zLgWNNEAg/3I0kSh8srrtB1FZBnX9z98lqM=;
        b=dOrMTpvrMFx9VTLoEzw2hfCceaO0qY80E3b42oRcxiBfsdPUuEmYt4LivEGyR7i0lN3bkB
        /hKG2/9vccSHCMzBiOMxMRJ4qzaI3fUT3YdVk44JwAWNKWeiop1YjteAUYXk1wX+womNNI
        kUOAJJhnKlJstWKwSj4UVy8qKSDssq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-mCoTIPOIMBSGaD5vJl8xiA-1; Thu, 13 Feb 2020 18:16:56 -0500
X-MC-Unique: mCoTIPOIMBSGaD5vJl8xiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFB271851FC2;
        Thu, 13 Feb 2020 23:16:54 +0000 (UTC)
Received: from treble (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 155091FD3B;
        Thu, 13 Feb 2020 23:16:53 +0000 (UTC)
Date:   Thu, 13 Feb 2020 17:16:51 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, peterz@infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200213231651.alogip6tupegsbvq@treble>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213221758.i6pchz4gsiy2lsyc@treble>
 <20200213223734.3zjrvhshjyr5ca7p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213223734.3zjrvhshjyr5ca7p@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:37:34PM -0800, Fangrui Song wrote:
> I still consider such a check (tools/objtool/check.c:679) unneeded.
> 
> st_type doesn't have to be STT_FUNC. Either STT_NOTYPE or STT_FUNC is
> ok. If STT_GNU_IFUNC is used, it can be ok as well.
> (My clang patch skips STT_GNU_IFUNC just because rtld typically doesn't
>  cache R_*_IRELATIVE results. Having two STT_GNU_IFUNC symbols with same st_shndx and
>  st_value can create two R_*_IRELATIVE, which need to be resolved twice
>  at runtime.)
> 
> 	} else if (rela->sym->type == STT_SECTION) {
> 		insn->call_dest = find_symbol_by_offset(rela->sym->sec,
> 							rela->addend+4);
> 		if (!insn->call_dest ||
> 		    insn->call_dest->type != STT_FUNC) {
> 			WARN_FUNC("can't find call dest symbol at %s+0x%x",
> 				  insn->sec, insn->offset,
> 				  rela->sym->sec->name,
> 				  rela->addend + 4);
> 			return -1;
> 		}
> 
> 
> 	.section	.init.text,"ax",@progbits
> 	call	printk
> 	call	.Lprintk$local
> 	.text
> 	.globl	printk
> 	.type	printk,@function
> printk:
> .Lprintk$local:
>  ret

Objtool isn't a general ELF validator, it's more of a kernel sanity
validator.  In the kernel we currently have a constraint that you can
only call STT_FUNC.  At the very least it helps keep our asm code clean.

If that constraint ever becomes a problem then we could always
reconsider it.

> % llvm-mc -filetype=obj -triple=riscv64 a.s -mattr=+relax -o a.o
> % readelf -Wr a.o
> 
> Relocation section '.rela.init.text' at offset 0xa0 contains 4 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 0000000000000000  0000000200000012 R_RISCV_CALL           0000000000000000 printk + 0
> 0000000000000000  0000000000000033 R_RISCV_RELAX                             0
> 0000000000000008  0000000100000012 R_RISCV_CALL           0000000000000000 .Lprintk$local + 0
> 0000000000000008  0000000000000033 R_RISCV_RELAX                             0
> 
> 
> On RISC-V, when relaxation is enabled, .L cannot be resolved at assembly
> time because sections can shrink.
> 
> https://sourceware.org/binutils/docs/as/Symbol-Names.html
> 
> > Local symbols are defined and used within the assembler, but they are *normally* not saved in object files.
> 
> I consider the GNU as issue a missed optimization, instead of a bug.
> There is no rigid rule that .L symbols cannot be saved in object files.

I know nothing about RISC-V, but if I understand correctly,
.Lprintk$local is the function's local entry point, similar to ppc64
localentry.  Would it not always be a constant offset from the printk
address, such that the relocation could be "printk + 8" or so?

Regardless, it doesn't really matter for now, objtool is x86-only.

-- 
Josh

