Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9885C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00CE20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Pgtv+SSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgFHT2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgFHT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:28:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D92BC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:28:33 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c14so18442762qka.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k9wukxxtlg/uismwI/UMnm3Bx/cnmFE7m1b5ib9kprU=;
        b=Pgtv+SSciXljqnf+92jyUjHCiyePaXchSbLnisVnEOScpkJatv+yERrrZBYCZLd3ow
         DuA7ZKiHaU0yDaZtzunN/nmNAjL3urizirZBy9BGfZ3CAPNb1YtSZhG/oUR3KfQ0p4vF
         oX+BdvugIk5A8V/0bC69OJ24MW08RyoiXiP+6YepB1RI+98wRikGIXMAe1t3zKNr9m2h
         32v+hPahc8twDVp+By9KbcG/Yg+BCvsfoGU6vITHJyXAxVBbQHP/320Hwu/2lXiKI9/+
         Ui1mD/c9x52pYPBNSU6flJ7dOff61qwSDLOrrXISQ/8+ZSRr11LX8PATxqJWCZkZvh4M
         bV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9wukxxtlg/uismwI/UMnm3Bx/cnmFE7m1b5ib9kprU=;
        b=Lzm0ET3+zm7d45lnas+fLTM44f9u8PeYX5KO9u0knwuHjCHbeoqSaHwSIG31MLhgvJ
         r7bNMimtrytbkB8J6iTAIHJBc3t2VvwTV1Se9pbr7jGQHSgAkQrdnrbEGESzBEVnr1a1
         3OuYpfr28ZKpNnrIBOiaXfA3997mdTThf8kihrfuHz+faA0QQiq2rgzGR9Gm2PZlzx5H
         ITfo6cW5SIpKpB0yLrPKUyISLbUmwDRUmyCSFjGLbWV5rZ+S/GrmZR5n489BL0sluO29
         EzhAsBCz+3TzvoFbL0iCNkfdLHc2YtKE4CIdam9vzS8Q2BnvbNlrQpAL750XH9TABIR2
         jC/g==
X-Gm-Message-State: AOAM5339/wMpvjR0uJvBC98Eq3dK/JcXUeP0nbNW77DVEEeD6qCuuy11
        pYB7aEsG4pqgHCyo9xrpmcl9iA==
X-Google-Smtp-Source: ABdhPJz+Arj7Rd047gQ/TSazKm79Nf89ldxGO7ovHCUa3TI33gR3dVoHNtdcrf9U3W0goX/uDHjWoQ==
X-Received: by 2002:a37:9f0b:: with SMTP id i11mr23180985qke.481.1591644512610;
        Mon, 08 Jun 2020 12:28:32 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k10sm7475862qkh.47.2020.06.08.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 12:28:31 -0700 (PDT)
Date:   Mon, 8 Jun 2020 15:28:28 -0400
From:   Qian Cai <cai@lca.pw>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        clang-built-linux@googlegroups.com, LKP <lkp@lists.01.org>,
        "Linus, Torvalds," <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 0887a7ebc9 ("ubsan: add trap instrumentation option"): BUG:
 kernel hang in early-boot stage, last printk: early console in setup code
Message-ID: <20200608192828.GB987@lca.pw>
References: <20200608060407.GX12456@shao2-debian>
 <202006081144.933995E4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006081144.933995E4@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 12:00:11PM -0700, Kees Cook wrote:
> On Mon, Jun 08, 2020 at 02:04:08PM +0800, kernel test robot wrote:
> > The issue seems due to the lack of "-fsanitize-undefined-trap-on-error" in clang.
> 
> Hm? No, that's supported in Clang (at least as far back as Clang 9.)
> 
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > commit 0887a7ebc97770c7870abf3075a2e8cd502a7f52
> > Author:     Kees Cook <keescook@chromium.org>
> > AuthorDate: Mon Apr 6 20:12:27 2020 -0700
> > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > CommitDate: Tue Apr 7 10:43:44 2020 -0700
> > 
> >     ubsan: add trap instrumentation option
> 
> In the randconfig, I see CONFIG_UBSAN_TRAP is enabled with lots of other
> UBSAN options. If you're not expecting the results, it's very likely the
> false positives in UBSAN are going to do bad things. :) This is "working
> as expected", as noted in the commit log quoted below.
> 
> >     
> >     Patch series "ubsan: Split out bounds checker", v5.
> >     
> >     This splits out the bounds checker so it can be individually used.  This
> >     is enabled in Android and hopefully for syzbot.  Includes LKDTM tests for
> >     behavioral corner-cases (beyond just the bounds checker), and adjusts
> >     ubsan and kasan slightly for correct panic handling.
> >     
> >     This patch (of 6):
> >     
> >     The Undefined Behavior Sanitizer can operate in two modes: warning
> >     reporting mode via lib/ubsan.c handler calls, or trap mode, which uses
> >     __builtin_trap() as the handler.  Using lib/ubsan.c means the kernel image
> >     is about 5% larger (due to all the debugging text and reporting structures
> >     to capture details about the warning conditions).  Using the trap mode,
> >     the image size changes are much smaller, though at the loss of the
> >     "warning only" mode.
> >     
> >     In order to give greater flexibility to system builders that want minimal
> >     changes to image size and are prepared to deal with kernel code being
> >     aborted and potentially destabilizing the system, this introduces
> >     CONFIG_UBSAN_TRAP.  The resulting image sizes comparison:
> >     
> >        text    data     bss       dec       hex     filename
> >     19533663   6183037  18554956  44271656  2a38828 vmlinux.stock
> >     19991849   7618513  18874448  46484810  2c54d4a vmlinux.ubsan
> >     19712181   6284181  18366540  44362902  2a4ec96 vmlinux.ubsan-trap
> >     
> >     CONFIG_UBSAN=y:      image +4.8% (text +2.3%, data +18.9%)
> >     CONFIG_UBSAN_TRAP=y: image +0.2% (text +0.9%, data +1.6%)
> >     
> >     Additionally adjusts the CONFIG_UBSAN Kconfig help for clarity and removes
> >     the mention of non-existing boot param "ubsan_handle".
> 
> If you're trying to _boot_ a randconfig, I suspect there are going to be
> a lot of surprises with UBSAN (in any mode) enabled. Right now, likely the
> least noisy of them all is UBSAN_BOUNDS, which was split out for fuzzers.
> 
> FWIW, the dmesg appears to be catching a NULL pointer dereference
> (enabled via CONFIG_UBSAN_MISC):
> 
> [    0.047646] UBSAN: Undefined behaviour in drivers/acpi/acpica/tbfadt.c:459:37
> [    0.047650] member access within null pointer of type 'struct acpi_table_fadt'
> [    0.047655] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-11597-g7baf219982281 #1
> [    0.047659] Call Trace:
> [    0.047676]  dump_stack+0x88/0xb9
> [    0.047684]  ? ubsan_prologue+0x21/0x46
> [    0.047689]  ? ubsan_type_mismatch_common+0x188/0x19e
> [    0.047695]  ? __ubsan_handle_type_mismatch_v1+0x45/0x4a
> [    0.047701]  ? acpi_tb_create_local_fadt+0xaa/0x435
> [    0.047706]  ? acpi_tb_parse_fadt+0x54/0xd4
> [    0.047712]  ? acpi_tb_parse_root_table+0x192/0x1bf
> [    0.047717]  ? acpi_table_init+0x3b/0x56
> [    0.047721]  ? acpi_boot_table_init+0xf/0x6e
> [    0.047726]  ? setup_arch+0x459/0x520
> [    0.047732]  ? start_kernel+0x5e/0x3ba
> [    0.047737]  ? secondary_startup_64+0xa4/0xb0
> 
> I'm not sure how ACPI defines acpi_gbl_FADT though? There's no
> dereference...
> 
> 459:         if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {
> 
> 
> BTW, this report only contained 1 actual dmesg. There were two files with
> dmesg file names, but one of them was the gzipped reproduction steps again.

No, it does not complain about a NULL pointer dereference but rather a
member access within NULL pointer.

# ./scripts/faddr2line vmlinux acpi_tb_create_local_fadt+0x104/0x6ec
acpi_tb_create_local_fadt+0x104/0x6ec:
acpi_tb_convert_fadt at drivers/acpi/acpica/tbfadt.c:459
(inlined by) acpi_tb_create_local_fadt at drivers/acpi/acpica/tbfadt.c:388

Clang would report several of those,

https://lore.kernel.org/lkml/CA6078C3-3489-40E4-B756-A0AF6DB3A3A5@lca.pw/

There are many examples how to "fix" those.

$ git log  --oneline --grep='member access within null pointer'

Anyway, this line,

        if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {

acpi_gbl_FADT was defined in,

.//include/acpi/acpixf.h:266:ACPI_GLOBAL(struct acpi_table_fadt, acpi_gbl_FADT);

#ifdef DEFINE_ACPI_GLOBALS
#define ACPI_GLOBAL(type,name) \
	extern type name; \
	type name



#define ACPI_INIT_GLOBAL(type,name,value) \
	type name=value



#else
#ifndef ACPI_GLOBAL
#define ACPI_GLOBAL(type,name) \
	extern type name
#endif



#ifndef ACPI_INIT_GLOBAL
#define ACPI_INIT_GLOBAL(type,name,value) \
	extern type name
#endif
#endif
