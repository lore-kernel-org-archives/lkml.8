Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA46C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D5424672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dWeNqiAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBTSKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:10:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgBTSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H2CFM+ONOQVJ1o9TPPqpS6mF/DQOPmqib25zwUlOs3Q=; b=dWeNqiAlklE/Ciwq7HD9W88fZy
        VwVyp30jn7nfya7GogdzhvT3WyB9lV6YPz52T+kys6/lBFb6kAc6DgqibLU2cNi1injbV5QXNUgJm
        aTDe6hWiYwG9IPlZPkq7yz68shvmmyhHMFCOsURjsRJyW+vrdcwe4NxhisJH0x9NPBkdZ4ttluI56
        4UlCa4qYZAQJyTeUb8rX3NORZRh56YIzY6Pek34H8/2G3oZlT/HmVvZU4FRSVNysYOiWLwYvPSBPa
        aNojkgEWG6CurLhBKOhi8cAAscXcFsAnBIVA0daYNb5b1am4RhvMAW5arqoKp0UUdwpcm0aziOLIo
        kDj4XsWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4qHU-00083d-Fu; Thu, 20 Feb 2020 18:10:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FDBC300606;
        Thu, 20 Feb 2020 19:08:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 825602026E97F; Thu, 20 Feb 2020 19:10:33 +0100 (CET)
Date:   Thu, 20 Feb 2020 19:10:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v2 2/2] lib: make a test module with set/clear bit
Message-ID: <20200220181033.GW14897@hirez.programming.kicks-ass.net>
References: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
 <20200220173722.2034546-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220173722.2034546-2-jesse.brandeburg@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:37:22AM -0800, Jesse Brandeburg wrote:
> Test some bit clears/sets to make sure assembly doesn't change.
> Instruct Kbuild to build this file with extra warning level -Wextra,
> to catch new issues, and also doesn't hurt to build with C=1.
> 
> This was used to test changes to arch/x86/include/asm/bitops.h.
> 
> Recommended usage:
> make defconfig
> scripts/config -m CONFIG_TEST_BITOPS
> make modules_prepare
> make C=1 W=1 lib/test_bitops.ko
> objdump -S -d lib/test_bitops.ko

I only applied this second patch:

# sparse --version
0.6.0 (Debian: 0.6.0-3+b1)

# grep TEST_BITOPS defconfig-build/.config
CONFIG_TEST_BITOPS=m

# make C=1 W=1 O=defconfig-build/ lib/test_bitops.ko
make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
GEN     Makefile
HOSTCC  scripts/basic/fixdep
HOSTCC  arch/x86/tools/relocs_32.o
HOSTCC  arch/x86/tools/relocs_64.o
HOSTCC  arch/x86/tools/relocs_common.o
HOSTLD  arch/x86/tools/relocs
HOSTCC  scripts/selinux/genheaders/genheaders
HOSTCC  scripts/selinux/mdp/mdp
HOSTCC  scripts/kallsyms
HOSTCC  scripts/sorttable
HOSTCC  scripts/asn1_compiler
HOSTCC  scripts/extract-cert
HOSTCC  scripts/mod/mk_elfconfig
CHECK   ../scripts/mod/empty.c
CC      scripts/mod/empty.o
MKELF   scripts/mod/elfconfig.h
HOSTCC  scripts/mod/modpost.o
CC      scripts/mod/devicetable-offsets.s
HOSTCC  scripts/mod/file2alias.o
HOSTCC  scripts/mod/sumversion.o
HOSTLD  scripts/mod/modpost
CC      kernel/bounds.s
CC      arch/x86/kernel/asm-offsets.s
CALL    ../scripts/checksyscalls.sh
CALL    ../scripts/atomic/check-atomics.sh
DESCEND  objtool
HOSTCC   /usr/src/linux-2.6/defconfig-build/tools/objtool/fixdep.o
HOSTLD   /usr/src/linux-2.6/defconfig-build/tools/objtool/fixdep-in.o
LINK     /usr/src/linux-2.6/defconfig-build/tools/objtool/fixdep
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/exec-cmd.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/help.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/pager.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/parse-options.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/run-command.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/sigchain.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/subcmd-config.o
LD       /usr/src/linux-2.6/defconfig-build/tools/objtool/libsubcmd-in.o
AR       /usr/src/linux-2.6/defconfig-build/tools/objtool/libsubcmd.a
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/arch/x86/decode.o
LD       /usr/src/linux-2.6/defconfig-build/tools/objtool/arch/x86/objtool-in.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/builtin-check.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/builtin-orc.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/check.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/orc_gen.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/orc_dump.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/elf.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/special.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/objtool.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/libstring.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/libctype.o
CC       /usr/src/linux-2.6/defconfig-build/tools/objtool/str_error_r.o
LD       /usr/src/linux-2.6/defconfig-build/tools/objtool/objtool-in.o
LINK     /usr/src/linux-2.6/defconfig-build/tools/objtool/objtool
CHECK   ../lib/test_bitops.c
CC [M]  lib/test_bitops.o
MODPOST 1 modules
CC [M]  lib/test_bitops.mod.o
LD [M]  lib/test_bitops.ko
make[1]: Leaving directory '/usr/src/linux-2.6/defconfig-build'


No warnings for me!
