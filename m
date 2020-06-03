Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D480C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B4620772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="oWieoJ9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFCNto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFCNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:49:43 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16156C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:49:43 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x17so512441oog.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=N6v536SMiOWMhGN6JyICuGQTuvhKxJSrwWcgV9sXx+M=;
        b=oWieoJ9Yb6YF7DgNOok4BCXy7VvDS591AErvb2sJOw2Y4EZZHp3kXO1Nz1Vu3E2oQP
         laCxPxEAloWhf7nUTOqujCVaF/7pdSxXVIrZCK+7E1zrzjY2iwZo7vF5THmUgObHGFYw
         as9/bVHCYK1w3GSI/gNLcnWoa8GqVcG57yVAUxMH7vXyTVFliI2bIMAcgJzHIkhZZEnR
         TiZQMtzEM6kCjBcjlY0JpA2+TWLHIswDFwet2V6ZNaY18fo5tVLoLyXfDy781kA+lkPz
         kDW++F0trV0anAgXPJ0X5Hqre5PbWxJL+XNM10Tdae1oYfg7oMJHW7Ywj7GxAZgt9t/Z
         8Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=N6v536SMiOWMhGN6JyICuGQTuvhKxJSrwWcgV9sXx+M=;
        b=tnZpMqMybkOXGDpOSZVCAUwDHgHLTPehlyKytbETwUnB7wrD/hgMZIYvru3hSnXaqX
         +Oz3wndLlxuAJTs8V3+H0GBXuqgJPD2CvaRZ7PHImp/Zy4BAI72TDT3PMxF4+vuGDXyK
         3oMiqOk6xmidekPofxAoDZDFFxHrVYbWcAfWLCo8f3C84ACCtcSdyk+D/mKGv2cYSPrs
         nQ4hRC3/dU1a4cAWqcWG9xJHzXQJzzX1yAmnMCU8T9UhbMbGH4n8iQspI2DOj95jTVNF
         NDzRTs7+lOTJ/75ebPWI3R80wbj/J3o89uqO/6grTpmCXQcVf7EsxAuu9rp+y5XDNcoi
         55QQ==
X-Gm-Message-State: AOAM533CCqdcBpcUt+CuDStj+8KgyzHZip7f5Wz29NNi7DBWBehos1Sn
        B3vE6gSVg5CKd5qYESRt0cOfTYxWAAU=
X-Google-Smtp-Source: ABdhPJwcu+vwfzcby/uBrQ4OuuNvlX/fYoXh9d/p5MlKCAraEPvpNsCT/aazy4zT5GVK5w4qwCVEhg==
X-Received: by 2002:a4a:3559:: with SMTP id w25mr86424oog.6.1591192182142;
        Wed, 03 Jun 2020 06:49:42 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id i10sm588007oie.42.2020.06.03.06.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 06:49:41 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, arnd@arndb.de,
        yamada.masahiro@socionext.com, Rich Felker <dalias@libc.org>
From:   Rob Landley <rob@landley.net>
Subject: headers_install builds break on a lot of targets?
Message-ID: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
Date:   Wed, 3 Jun 2020 08:49:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headers_install_all target got removed last year (commit f3c8d4c7a728 and
would someone like to update Documentation/kbuild/headers_install.txt which
still describes it?)

The musl-libc maintainer is using a forked hand-hacked kernel header package in
his toolchain build project (https://github.com/richfelker/musl-cross-make), and
he said the reason for it is:

  http://lists.landley.net/pipermail/toybox-landley.net/2020-March/011536.html

  Because downloading 100 MB of kernel source and extracting it to a far
  larger tree just to get the headers isn't really fun.

And I thought "that's why headers_install_all existed", and noticed the target
being removed, so I tried my hand at a small shell script vesion:

  for i in $(echo arch/*/ | sed 's@arch/\([^/]*\)/@\1@g')
  do
    echo $i
    X="$PWD/fruitbasket/$i"
    mkdir -p "$X"
    make ARCH=$i distclean defconfig headers_install \
      INSTALL_HDR_PATH="$PWD/fruitbasket/$i" > /dev/null
  done

On the bright side, the resulting fruitbasket.tar.xz is 1.5 megabytes. The
downside is I have no idea how broken the resulting header files are after this
error-fest:

alpha
arc
gcc: error: unrecognized command line option ‘-mmedium-calls’
gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean
‘-fno-stats’?
gcc: error: unrecognized command line option ‘-mmedium-calls’
gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean
‘-fno-stats’?
arm
arm64
c6x
csky
h8300
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mint32’; did you mean ‘-fintfc’?
hexagon
gcc: error: unrecognized command line option ‘-G0’
gcc: error: unrecognized command line option ‘-G0’
gcc: error: unrecognized command line option ‘-G0’
ia64
./arch/ia64/scripts/check-segrel.S: Assembler messages:
./arch/ia64/scripts/check-segrel.S:2: Error: unknown pseudo-op: `.rodata'
./arch/ia64/scripts/check-segrel.S:3: Error: no such instruction: `data4
@segrel(start)'
objdump: '/tmp/out17279': No such file
objdump: section '.rodata' mentioned in a -j option, but not found in any input file
./arch/ia64/scripts/toolchain-flags: 20: [: !=: unexpected operator
./arch/ia64/scripts/check-text-align.S: Assembler messages:
./arch/ia64/scripts/check-text-align.S:2: Error: unknown pseudo-op: `.proc'
./arch/ia64/scripts/check-text-align.S:3: Error: unknown pseudo-op: `.prologue'
./arch/ia64/scripts/check-text-align.S:4: Error: unknown pseudo-op: `.save'
./arch/ia64/scripts/check-text-align.S:7: Error: unknown pseudo-op: `.endp'
readelf: Error: '/tmp/out17279': No such file
./arch/ia64/scripts/check-gas-asm.S: Assembler messages:
./arch/ia64/scripts/check-gas-asm.S:1: Error: junk at end of line, first
unrecognized character is `['
./arch/ia64/scripts/check-gas-asm.S:2: Error: unknown pseudo-op: `.xdata4'
objdump: '/tmp/out17306.o': No such file
objdump: section '.data' mentioned in a -j option, but not found in any input file
./arch/ia64/scripts/check-gas: 11: [: !=: unexpected operator
./arch/ia64/scripts/check-segrel.S: Assembler messages:
./arch/ia64/scripts/check-segrel.S:2: Error: unknown pseudo-op: `.rodata'
./arch/ia64/scripts/check-segrel.S:3: Error: no such instruction: `data4
@segrel(start)'
objdump: '/tmp/out19677': No such file
objdump: section '.rodata' mentioned in a -j option, but not found in any input file
./arch/ia64/scripts/toolchain-flags: 20: [: !=: unexpected operator
./arch/ia64/scripts/check-text-align.S: Assembler messages:
./arch/ia64/scripts/check-text-align.S:2: Error: unknown pseudo-op: `.proc'
./arch/ia64/scripts/check-text-align.S:3: Error: unknown pseudo-op: `.prologue'
./arch/ia64/scripts/check-text-align.S:4: Error: unknown pseudo-op: `.save'
./arch/ia64/scripts/check-text-align.S:7: Error: unknown pseudo-op: `.endp'
readelf: Error: '/tmp/out19677': No such file
./arch/ia64/scripts/check-gas-asm.S: Assembler messages:
./arch/ia64/scripts/check-gas-asm.S:1: Error: junk at end of line, first
unrecognized character is `['
./arch/ia64/scripts/check-gas-asm.S:2: Error: unknown pseudo-op: `.xdata4'
objdump: '/tmp/out19705.o': No such file
objdump: section '.data' mentioned in a -j option, but not found in any input file
./arch/ia64/scripts/check-gas: 11: [: !=: unexpected operator
./arch/ia64/scripts/check-segrel.S: Assembler messages:
./arch/ia64/scripts/check-segrel.S:2: Error: unknown pseudo-op: `.rodata'
./arch/ia64/scripts/check-segrel.S:3: Error: no such instruction: `data4
@segrel(start)'
objdump: '/tmp/out19983': No such file
objdump: section '.rodata' mentioned in a -j option, but not found in any input file
./arch/ia64/scripts/toolchain-flags: 20: [: !=: unexpected operator
./arch/ia64/scripts/check-text-align.S: Assembler messages:
./arch/ia64/scripts/check-text-align.S:2: Error: unknown pseudo-op: `.proc'
./arch/ia64/scripts/check-text-align.S:3: Error: unknown pseudo-op: `.prologue'
./arch/ia64/scripts/check-text-align.S:4: Error: unknown pseudo-op: `.save'
./arch/ia64/scripts/check-text-align.S:7: Error: unknown pseudo-op: `.endp'
readelf: Error: '/tmp/out19983': No such file
./arch/ia64/scripts/check-gas-asm.S: Assembler messages:
./arch/ia64/scripts/check-gas-asm.S:1: Error: junk at end of line, first
unrecognized character is `['
./arch/ia64/scripts/check-gas-asm.S:2: Error: unknown pseudo-op: `.xdata4'
objdump: '/tmp/out20014.o': No such file
objdump: section '.data' mentioned in a -j option, but not found in any input file
./arch/ia64/scripts/check-gas: 11: [: !=: unexpected operator
m68k
microblaze
mips
nds32
nios2
openrisc
parisc
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: unrecognized command line option ‘-mno-space-regs’; did you mean
‘-fno-make-deps’?
gcc: error: unrecognized command line option ‘-mfast-indirect-calls’; did you
mean ‘-fno-indirect-classes’?
gcc: error: unrecognized command line option ‘-mdisable-fpregs’; did you mean
‘-fdisable-’?
powerpc
riscv
s390
sh
sparc
um
gcc: error: missing argument to ‘-Wframe-larger-than=’
Makefile:1230: *** Headers not exportable for the um architecture.  Stop.
make: *** [__build_one_by_one] Error 2
unicore32
gcc: error: missing argument to ‘-Wframe-larger-than=’
gcc: error: missing argument to ‘-Wframe-larger-than=’
x86
xtensa
gcc: error: unrecognized command line option ‘-mlongcalls’
gcc: error: unrecognized command line option ‘-mtext-section-literals’; did you
mean ‘-fext-numeric-literals’?
gcc: error: unrecognized command line option ‘-mlongcalls’
gcc: error: unrecognized command line option ‘-mtext-section-literals’; did you
mean ‘-fext-numeric-literals’?
gcc: error: unrecognized command line option ‘-mlongcalls’
gcc: error: unrecognized command line option ‘-mtext-section-literals’; did you
mean ‘-fext-numeric-literals’?
