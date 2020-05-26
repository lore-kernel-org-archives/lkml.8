Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C0BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6708C206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hiBEnNOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEZAhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 20:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEZAhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:37:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD69C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:37:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d3so7977976pln.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e0QmqwRh8HAG2Vlx7bh9P7hF+0B2FhgdgqTRYD2VzoE=;
        b=hiBEnNOr6h1Pm4lIfBg3dTFLEu6bcZeu4DoHWFZ5FRJmqrbpYHea1/mCSu6yyPM4n7
         eKhdO9Vu4hfvpi1hmO+Jn3jvjis6yFkltaF9ZvgC8evKNxR1WE2J12k9wjkX6KLMO/yS
         OidjoPPnVBqcKPxQWPzeguo0dB+R2oN8JzApe2tKUn4/NgGZkf1DSoraA9PUe6jMTnHm
         5QIisiCM9xBV/7DoUayEEhwPJlofm14ByDsDMpx/I7V12a55Pn2h1bGA5Z7AYCLN6CmJ
         GPMbYfZ3e0d7cxJEifRtTKVKvEllU7V2dvBfVpxZOTqFduNSllX8dwdpLxhf8SESpH3D
         xdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0QmqwRh8HAG2Vlx7bh9P7hF+0B2FhgdgqTRYD2VzoE=;
        b=mGDiRYXo/ro5h525cWwOl8sv9xuKezjyOhaQrgl1grSm1na4qEyjTmp18Ou19Jyk1Y
         s2gUieeWrGRSjwpkKqTBsR2TrYIu3yw022SYXjHNv8Unv8bsU6cTcSNRxnNBtEr43Qzd
         mu16KhrSIdfHlYASJ6g+YEQ28kTLl5aqUa/a3z3OsTDTdyZAyusodfxFTtDnStvgz3ZG
         ga6jffoPENyU8GwpnZ8G2ECV7bRnFYR54wGR8W0B6lK+tzT3Rdb9uQKrH1KTJhPYZlio
         AR5VsQz1W4MqkEL89hkDkhH81D4LbpQ57rqPRNSXvbnVw1gYBvFXQfQDTeBVXRjJ4zwn
         odUA==
X-Gm-Message-State: AOAM532v8L4L/7TiPQLnA+hcNxFMmYwkrE+Py4Ex1Vux/DwoHGkRfATQ
        dnTTRAcshxHPJJEkESs5s42bOw==
X-Google-Smtp-Source: ABdhPJx2AfGd3Dwb0s2dusTIljpSmtiCpDiYPCxSsAALFRD3Kfg0lYlqbzPAnkkH8zcvNiXUohbewg==
X-Received: by 2002:a17:902:740b:: with SMTP id g11mr26469332pll.158.1590453429992;
        Mon, 25 May 2020 17:37:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id e26sm12470490pgl.27.2020.05.25.17.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 17:37:09 -0700 (PDT)
Date:   Mon, 25 May 2020 17:37:03 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] x86/boot: Remove runtime relocations from compressed
 kernel
Message-ID: <20200526003703.qr2yq6fgxpl6wcua@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524212816.243139-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24, Arvind Sankar wrote:
>The compressed kernel currently contains bogus runtime relocations in
>the startup code in head_{32,64}.S, which are generated by the linker,
>but must not actually be processed at runtime.
>
>This generates warnings when linking with the BFD linker, and errors
>with LLD, which defaults to erroring on runtime relocations in read-only
>sections. It also requires the -z noreloc-overflow hack for the 64-bit
>kernel, which prevents us from linking it as -pie on an older BFD linker
>(<= 2.26) or on LLD, because the locations that are to be apparently
>relocated are only 32-bits in size and so cannot normally have
>R_X86_64_RELATIVE relocations.
>
>This series aims to get rid of these relocations. It is based on
>efi/next (efi-changes-for-v5.8), where the latest patches touch the
>head code to eliminate the global offset table.
>
>The first patch is an independent fix for LLD, to avoid an orphan
>section in arch/x86/boot/setup.elf [0].
>
>The second patch gets rid of almost all the relocations. It uses
>standard PIC addressing technique for 32-bit, i.e. loading a register
>with the address of _GLOBAL_OFFSET_TABLE_ and then using GOTOFF
>references to access variables. For 64-bit, there is 32-bit code that
>cannot use RIP-relative addressing, and also cannot use the 32-bit
>method, since GOTOFF references are 64-bit only. This is instead handled
>using a macro to replace a reference like gdt with (gdt-startup_32)
>instead. The assembler will generate a PC32 relocation entry, with
>addend set to (.-startup_32), and these will be replaced with constants
>at link time. This works as long as all the code using such references
>lives in the same section as startup_32, i.e. in .head.text.
>
>The third patch addresses a remaining issue with the BFD linker, which
>insists on generating runtime relocations for absolute symbols. We use
>z_input_len and z_output_len, defined in the generated piggy.S file, as
>symbols whose absolute "addresses" are actually the size of the
>compressed payload and the size of the decompressed kernel image
>respectively. LLD does not generate relocations for these two symbols,
>but the BFD linker does. To get around this, piggy.S is extended to also
>define two u32 variables (in .rodata) with the lengths, and the head
>code is modified to use those instead of the symbol addresses.
>
>An alternative way to handle z_input_len/z_output_len would be to just
>include piggy.S in head_{32,64}.S instead of as a separate object file,
>since the GNU assembler doesn't generate relocations for symbols set to
>constants.
>
>The last patch adds a check in the linker script to ensure that no
>runtime relocations get reintroduced. Since the GOT has been eliminated
>as well, the compressed kernel has no runtime relocations whatsoever any
>more.
>
>[0] https://lore.kernel.org/lkml/20200521152459.558081-1-nivedita@alum.mit.edu/
>
>Arvind Sankar (4):
>  x86/boot: Add .text.startup to setup.ld
>  x86/boot: Remove runtime relocations from .head.text code
>  x86/boot: Remove runtime relocations from head_{32,64}.S
>  x86/boot: Check that there are no runtime relocations
>
> arch/x86/boot/compressed/Makefile      | 36 +---------
> arch/x86/boot/compressed/head_32.S     | 59 +++++++--------
> arch/x86/boot/compressed/head_64.S     | 99 +++++++++++++++-----------
> arch/x86/boot/compressed/mkpiggy.c     |  6 ++
> arch/x86/boot/compressed/vmlinux.lds.S | 11 +++
> arch/x86/boot/setup.ld                 |  2 +-
> 6 files changed, 109 insertions(+), 104 deletions(-)
>
>-- 
>2.26.2

All 4 commits look good.

Reviewed-by: Fangrui Song <maskray@google.com>
