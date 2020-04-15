Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92797C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7116D20857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rzm5dxhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370902AbgDOOnv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634584AbgDOOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:42:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E69C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:42:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 188so1565364pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TrCr8YaKtrXKuZI1mDLlJ9OwmvLg/1PUlN/6+Ie7Iy0=;
        b=Rzm5dxhTeaUONGsH972GQ1cAaKsulUeSHXueDBEsqI8cmXTh3SCPNcNqjQ5CFDTa5h
         EBQ9soIZStcseclUh0yP5zlUIowfh0ce0sZYGy/PfzX/U+/NGIrjEh3eABab7h+60/hz
         pgsokVn1zTw/hG3mJPqkplXu3r554x7uKaTXB0r0q3T6r1ELTx5v9wViytUbbto8Q8Ip
         dpym/NWKqOLMvWLZOorTFDWkgr536ve61EELqLbC0ALfHW0VWLJHXG9ZAzadzRLExZCW
         X2qP2xQy66PsBltBjdCkqzG3vbqeK2UOlflEoG9zaYgGLAsb6H997UH8MDClWBTP/Uka
         +rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrCr8YaKtrXKuZI1mDLlJ9OwmvLg/1PUlN/6+Ie7Iy0=;
        b=aqJed+NzxvdDqPV2KGI2bsUQnL8O1DJVi6XPlG6jnb91ukKA0bHR0yNX+AwzuR/pMz
         8QMO9whsBjOVIgHlOQwM82eNO4xlBkjnH4tWHIR6P8aOJmTf69LZUBlDwOZiXESCuIy8
         JdI/9sbyG2//BFp5mhQLZihrQwjZRn/8aj2lFmqz7BBEZjaXZ8S+ou36jQevvhRbOQgi
         U5bTI8i5qXKCpv09YYXCjpZR5XtXvSK3NWXHmc6VtAXlAlgV4J74J/DM30XvQUghvO5i
         9wxGH35wi4qTckCqeKvEtWE3iQL9h8Ne4nPnYpudF+hzNyWuDmhczOWe370EK3j3inQp
         OZFg==
X-Gm-Message-State: AGi0PuaXLw/YlnbxL/EzO4XskUOJozoaq9tbv18RCWDXbhkn90D2ca9f
        dQxxqcLdp78xLiBVmacTxWirWw==
X-Google-Smtp-Source: APiQypKrD/31MKHUWmycbWqZm3NAXgiF4vyGNvf1olANylF0PjsMdQ5ZiArHj6E665hYlxTSD05JxQ==
X-Received: by 2002:aa7:8d97:: with SMTP id i23mr27432269pfr.325.1586961741436;
        Wed, 15 Apr 2020 07:42:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id i15sm2199851pfo.195.2020.04.15.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:42:20 -0700 (PDT)
Date:   Wed, 15 Apr 2020 07:42:17 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-riscv@lists.infradead.org,
        Jordan Rupprecht <rupprecht@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mao Han <han_mao@c-sky.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] riscv: fix vdso build with lld
Message-ID: <20200415144217.cxxdfeeepzgikp4n@google.com>
References: <20200415142959.25673-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200415142959.25673-1-ilie.halip@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-15, Ilie Halip wrote:
>When building with the LLVM linker this error occurrs:
>    LD      arch/riscv/kernel/vdso/vdso-syms.o
>  ld.lld: error: no input files
>
>This happens because the lld treats -R as an alias to -rpath, as opposed
>to ld where -R means --just-symbols.
>
>Use the long option name for compatibility between the two.
>
>Link: https://github.com/ClangBuiltLinux/linux/issues/805
>Reported-by: Dmitry Golovin <dima@golovin.in>
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
>
>---
>Changed in v2:
>  * a comment line dropped, another one slightly reworded
>  * added Nick's Reviewed-by
>---
> arch/riscv/kernel/vdso/Makefile | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>index 33b16f4212f7..a4ee3a0e7d20 100644
>--- a/arch/riscv/kernel/vdso/Makefile
>+++ b/arch/riscv/kernel/vdso/Makefile
>@@ -33,15 +33,15 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
> 	$(call if_changed,vdsold)
>
> # We also create a special relocatable object that should mirror the symbol
>-# table and layout of the linked DSO.  With ld -R we can then refer to
>-# these symbols in the kernel code rather than hand-coded addresses.
>+# table and layout of the linked DSO. With ld --just-symbols we can then
>+# refer to these symbols in the kernel code rather than hand-coded addresses.
>
> SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
> 	-Wl,--build-id -Wl,--hash-style=both
> $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
> 	$(call if_changed,vdsold)
>
>-LDFLAGS_vdso-syms.o := -r -R
>+LDFLAGS_vdso-syms.o := -r --just-symbols
> $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
> 	$(call if_changed,ld)
>
>-- 
>2.17.1

https://lore.kernel.org/linux-riscv/20200402175354.pzhzhumlqsjk66nu@google.com/

Reviewed-by: Fangrui Song <maskray@google.com>
