Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC46C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DCA2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQllnKXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFHTAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgFHTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:00:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1EC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:00:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so230145pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1g6czJz9uyGSzG+TlXDs+6TvCXn/pRZ6dFmlQhgI+4=;
        b=OQllnKXyQLsac4e6sNpZivEZe2Tcqk3+0VTPyrpp3ygxsr1wjATZuEc5d3SGXI/hGW
         BgpshDbinwQ1cukNWOYQgHhh7JhVERxD0JNu9OjaIfnKIc7zGkzb++vnCDtR+Ek8VJTe
         3VBQPCpZg3O39NOdoKJP1jaegGhT+KYjlmHa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1g6czJz9uyGSzG+TlXDs+6TvCXn/pRZ6dFmlQhgI+4=;
        b=erYxInJCeb3je1lof9ke1cy7VZuzVC0ipuQxgueJEYlZlCkQ2SAkUGS1gUSeaqRTa5
         tj3c2vtRe7KfN4SKA5dv+8CkyQKIY44BmIs/7yCCBmVD3AZf8KDyy1PlW073dJsJOSTj
         jkP1qF1hbIfpGBWgLF149eRbrNuECLt21Gk8KXY64pf0X1BqWdHZz8ORBXKWVmEvsWEl
         o1ofb3i8l2p0fqoKaME6EL1mW0LREQKDBjCUSOPScB7s2uH3D88VIPHy5eR8qnVgECZF
         f2dDwHhBkViqXMg4DmrjV0XYD4ZfOqbNH6nZrHJ68xSamu5RyefBF6Iiyl5g3S/47+T2
         2vOA==
X-Gm-Message-State: AOAM532Urdsi/XUChfd17yLcf+RU7qkzipuT2/O8c0wRUfvDSEM7wS1v
        2sco3hVJDq+IG61fTjOyHI9O7w==
X-Google-Smtp-Source: ABdhPJx9ZLqxNSxTftGyNWQbg1w3mCMhfEnWOhyHRe0pYa4uOtSqzbxIToANYYs0JtYiBWVsUp42rQ==
X-Received: by 2002:a17:90b:310e:: with SMTP id gc14mr690238pjb.35.1591642813749;
        Mon, 08 Jun 2020 12:00:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm7874555pfc.7.2020.06.08.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 12:00:12 -0700 (PDT)
Date:   Mon, 8 Jun 2020 12:00:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     clang-built-linux@googlegroups.com, LKP <lkp@lists.01.org>,
        "Linus, Torvalds," <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 0887a7ebc9 ("ubsan: add trap instrumentation option"): BUG:
 kernel hang in early-boot stage, last printk: early console in setup code
Message-ID: <202006081144.933995E4@keescook>
References: <20200608060407.GX12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608060407.GX12456@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 02:04:08PM +0800, kernel test robot wrote:
> The issue seems due to the lack of "-fsanitize-undefined-trap-on-error" in clang.

Hm? No, that's supported in Clang (at least as far back as Clang 9.)

> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 0887a7ebc97770c7870abf3075a2e8cd502a7f52
> Author:     Kees Cook <keescook@chromium.org>
> AuthorDate: Mon Apr 6 20:12:27 2020 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Tue Apr 7 10:43:44 2020 -0700
> 
>     ubsan: add trap instrumentation option

In the randconfig, I see CONFIG_UBSAN_TRAP is enabled with lots of other
UBSAN options. If you're not expecting the results, it's very likely the
false positives in UBSAN are going to do bad things. :) This is "working
as expected", as noted in the commit log quoted below.

>     
>     Patch series "ubsan: Split out bounds checker", v5.
>     
>     This splits out the bounds checker so it can be individually used.  This
>     is enabled in Android and hopefully for syzbot.  Includes LKDTM tests for
>     behavioral corner-cases (beyond just the bounds checker), and adjusts
>     ubsan and kasan slightly for correct panic handling.
>     
>     This patch (of 6):
>     
>     The Undefined Behavior Sanitizer can operate in two modes: warning
>     reporting mode via lib/ubsan.c handler calls, or trap mode, which uses
>     __builtin_trap() as the handler.  Using lib/ubsan.c means the kernel image
>     is about 5% larger (due to all the debugging text and reporting structures
>     to capture details about the warning conditions).  Using the trap mode,
>     the image size changes are much smaller, though at the loss of the
>     "warning only" mode.
>     
>     In order to give greater flexibility to system builders that want minimal
>     changes to image size and are prepared to deal with kernel code being
>     aborted and potentially destabilizing the system, this introduces
>     CONFIG_UBSAN_TRAP.  The resulting image sizes comparison:
>     
>        text    data     bss       dec       hex     filename
>     19533663   6183037  18554956  44271656  2a38828 vmlinux.stock
>     19991849   7618513  18874448  46484810  2c54d4a vmlinux.ubsan
>     19712181   6284181  18366540  44362902  2a4ec96 vmlinux.ubsan-trap
>     
>     CONFIG_UBSAN=y:      image +4.8% (text +2.3%, data +18.9%)
>     CONFIG_UBSAN_TRAP=y: image +0.2% (text +0.9%, data +1.6%)
>     
>     Additionally adjusts the CONFIG_UBSAN Kconfig help for clarity and removes
>     the mention of non-existing boot param "ubsan_handle".

If you're trying to _boot_ a randconfig, I suspect there are going to be
a lot of surprises with UBSAN (in any mode) enabled. Right now, likely the
least noisy of them all is UBSAN_BOUNDS, which was split out for fuzzers.

FWIW, the dmesg appears to be catching a NULL pointer dereference
(enabled via CONFIG_UBSAN_MISC):

[    0.047646] UBSAN: Undefined behaviour in drivers/acpi/acpica/tbfadt.c:459:37
[    0.047650] member access within null pointer of type 'struct acpi_table_fadt'
[    0.047655] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-11597-g7baf219982281 #1
[    0.047659] Call Trace:
[    0.047676]  dump_stack+0x88/0xb9
[    0.047684]  ? ubsan_prologue+0x21/0x46
[    0.047689]  ? ubsan_type_mismatch_common+0x188/0x19e
[    0.047695]  ? __ubsan_handle_type_mismatch_v1+0x45/0x4a
[    0.047701]  ? acpi_tb_create_local_fadt+0xaa/0x435
[    0.047706]  ? acpi_tb_parse_fadt+0x54/0xd4
[    0.047712]  ? acpi_tb_parse_root_table+0x192/0x1bf
[    0.047717]  ? acpi_table_init+0x3b/0x56
[    0.047721]  ? acpi_boot_table_init+0xf/0x6e
[    0.047726]  ? setup_arch+0x459/0x520
[    0.047732]  ? start_kernel+0x5e/0x3ba
[    0.047737]  ? secondary_startup_64+0xa4/0xb0

I'm not sure how ACPI defines acpi_gbl_FADT though? There's no
dereference...

459:         if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {


BTW, this report only contained 1 actual dmesg. There were two files with
dmesg file names, but one of them was the gzipped reproduction steps again.

-Kees

-- 
Kees Cook
