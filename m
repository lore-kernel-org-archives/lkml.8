Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7134EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481CD2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hx5uX0GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFHTcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:32:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC0C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:32:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h185so8989925pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=323ec8Wj5TktrH3HGRGVoazp/PSpRZRCk45QTvCE1Pc=;
        b=hx5uX0GO9TsPXBreFbcyt71DjtdqXgzqKEWw4DFKVKiurOk4V/Q6ClU3H8DXkVJhJC
         V1rD/XWudACAvWwfnlvuZl+Vxd9bBSesNhYf9Hq6V/1tXt5DgUZqiWYlvcdfdFgXjXdD
         qqGZ41JMncT7yDLVnD7DQxl4pu+cnMSVYct07ISfk67IwqyR1l6MUv/Rp16AXHdcOVjJ
         IKoTZEdA0i519862zweQhI/KKY5ailfcka1+cb3nmbuaZpbJV5nfmpauqPmcCvz7jwwp
         OsvO4/kmB3/ILQWq8d7HhidVlq2T1Q1KYXkmXGQhVCKujo6b3skKEQJPoQvFzfkIbqH1
         4g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=323ec8Wj5TktrH3HGRGVoazp/PSpRZRCk45QTvCE1Pc=;
        b=tbyptNm/D3pNWyLd7EP0Ct+CQYgVpktT6gm3HhSlprlSubRd09irQAlfaPUGljy8Uu
         mz8Opg7MfRysxNrbDISMqv7d/2LAP2NhR1Ce7EP11dkPCnFQ37I/n2pne8doJuguIekT
         b5OBS8fuKhSCEf5VRc+QZsXPRSpFWtzzQv0P979ot8n00uZq7A/tR20P+08PmvkeMjWu
         2EoCsIv8KjDsfL7o7YiMVgc+V+5PEbyGjleolgKslV1IyD9nN6vfuvJlGT/QoLBAUahW
         JOTtzBD/MR4dwlnzYdQTxJYqJqs7o3em8lJ9pyhOZGfeBEjOasXqwrtpTYZlJcOTf4mm
         58Iw==
X-Gm-Message-State: AOAM533jiWJ9/OgJA+uxlQNakHpwzfgRZJQpSR5Y3J7/4MUrqSYRTeVX
        fjfpLBvvqWxiaIlGMNG70pRFmj3gTQlDo2xyzSEnBA==
X-Google-Smtp-Source: ABdhPJwcHbl1945c/Fd7yCHDqFkInugHCHbbrTiP6w820XQx1nnG4fHBc03WAGkFl52rDe6ErArd/UTy8TrcLzhSLYk=
X-Received: by 2002:a63:4f09:: with SMTP id d9mr20996380pgb.10.1591644748212;
 Mon, 08 Jun 2020 12:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200608060407.GX12456@shao2-debian> <202006081144.933995E4@keescook>
 <20200608192828.GB987@lca.pw>
In-Reply-To: <20200608192828.GB987@lca.pw>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Jun 2020 12:32:17 -0700
Message-ID: <CAKwvOdn6EVkYkjgsg6VOamR-QUQGAiL6=LwvrxHZsQ3Oj+SyoQ@mail.gmail.com>
Subject: Re: 0887a7ebc9 ("ubsan: add trap instrumentation option"): BUG:
 kernel hang in early-boot stage, last printk: early console in setup code
To:     Qian Cai <cai@lca.pw>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <rong.a.chen@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKP <lkp@lists.01.org>,
        "Linus, Torvalds," <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 12:28 PM Qian Cai <cai@lca.pw> wrote:
>
> On Mon, Jun 08, 2020 at 12:00:11PM -0700, Kees Cook wrote:
> > On Mon, Jun 08, 2020 at 02:04:08PM +0800, kernel test robot wrote:
> > > The issue seems due to the lack of "-fsanitize-undefined-trap-on-error" in clang.
> >
> > Hm? No, that's supported in Clang (at least as far back as Clang 9.)
> >
> > > Greetings,
> > >
> > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >
> > > commit 0887a7ebc97770c7870abf3075a2e8cd502a7f52
> > > Author:     Kees Cook <keescook@chromium.org>
> > > AuthorDate: Mon Apr 6 20:12:27 2020 -0700
> > > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > > CommitDate: Tue Apr 7 10:43:44 2020 -0700
> > >
> > >     ubsan: add trap instrumentation option
> >
> > In the randconfig, I see CONFIG_UBSAN_TRAP is enabled with lots of other
> > UBSAN options. If you're not expecting the results, it's very likely the
> > false positives in UBSAN are going to do bad things. :) This is "working
> > as expected", as noted in the commit log quoted below.
> >
> > >
> > >     Patch series "ubsan: Split out bounds checker", v5.
> > >
> > >     This splits out the bounds checker so it can be individually used.  This
> > >     is enabled in Android and hopefully for syzbot.  Includes LKDTM tests for
> > >     behavioral corner-cases (beyond just the bounds checker), and adjusts
> > >     ubsan and kasan slightly for correct panic handling.
> > >
> > >     This patch (of 6):
> > >
> > >     The Undefined Behavior Sanitizer can operate in two modes: warning
> > >     reporting mode via lib/ubsan.c handler calls, or trap mode, which uses
> > >     __builtin_trap() as the handler.  Using lib/ubsan.c means the kernel image
> > >     is about 5% larger (due to all the debugging text and reporting structures
> > >     to capture details about the warning conditions).  Using the trap mode,
> > >     the image size changes are much smaller, though at the loss of the
> > >     "warning only" mode.
> > >
> > >     In order to give greater flexibility to system builders that want minimal
> > >     changes to image size and are prepared to deal with kernel code being
> > >     aborted and potentially destabilizing the system, this introduces
> > >     CONFIG_UBSAN_TRAP.  The resulting image sizes comparison:
> > >
> > >        text    data     bss       dec       hex     filename
> > >     19533663   6183037  18554956  44271656  2a38828 vmlinux.stock
> > >     19991849   7618513  18874448  46484810  2c54d4a vmlinux.ubsan
> > >     19712181   6284181  18366540  44362902  2a4ec96 vmlinux.ubsan-trap
> > >
> > >     CONFIG_UBSAN=y:      image +4.8% (text +2.3%, data +18.9%)
> > >     CONFIG_UBSAN_TRAP=y: image +0.2% (text +0.9%, data +1.6%)
> > >
> > >     Additionally adjusts the CONFIG_UBSAN Kconfig help for clarity and removes
> > >     the mention of non-existing boot param "ubsan_handle".
> >
> > If you're trying to _boot_ a randconfig, I suspect there are going to be
> > a lot of surprises with UBSAN (in any mode) enabled. Right now, likely the
> > least noisy of them all is UBSAN_BOUNDS, which was split out for fuzzers.
> >
> > FWIW, the dmesg appears to be catching a NULL pointer dereference
> > (enabled via CONFIG_UBSAN_MISC):
> >
> > [    0.047646] UBSAN: Undefined behaviour in drivers/acpi/acpica/tbfadt.c:459:37
> > [    0.047650] member access within null pointer of type 'struct acpi_table_fadt'
> > [    0.047655] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-11597-g7baf219982281 #1
> > [    0.047659] Call Trace:
> > [    0.047676]  dump_stack+0x88/0xb9
> > [    0.047684]  ? ubsan_prologue+0x21/0x46
> > [    0.047689]  ? ubsan_type_mismatch_common+0x188/0x19e
> > [    0.047695]  ? __ubsan_handle_type_mismatch_v1+0x45/0x4a
> > [    0.047701]  ? acpi_tb_create_local_fadt+0xaa/0x435
> > [    0.047706]  ? acpi_tb_parse_fadt+0x54/0xd4
> > [    0.047712]  ? acpi_tb_parse_root_table+0x192/0x1bf
> > [    0.047717]  ? acpi_table_init+0x3b/0x56
> > [    0.047721]  ? acpi_boot_table_init+0xf/0x6e
> > [    0.047726]  ? setup_arch+0x459/0x520
> > [    0.047732]  ? start_kernel+0x5e/0x3ba
> > [    0.047737]  ? secondary_startup_64+0xa4/0xb0
> >
> > I'm not sure how ACPI defines acpi_gbl_FADT though? There's no
> > dereference...
> >
> > 459:         if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {
> >
> >
> > BTW, this report only contained 1 actual dmesg. There were two files with
> > dmesg file names, but one of them was the gzipped reproduction steps again.
>
> No, it does not complain about a NULL pointer dereference but rather a
> member access within NULL pointer.
>
> # ./scripts/faddr2line vmlinux acpi_tb_create_local_fadt+0x104/0x6ec
> acpi_tb_create_local_fadt+0x104/0x6ec:
> acpi_tb_convert_fadt at drivers/acpi/acpica/tbfadt.c:459
> (inlined by) acpi_tb_create_local_fadt at drivers/acpi/acpica/tbfadt.c:388

There's an issue with the use of ACPI_OFFSET w/ UBSAN (member access
within NULL) that was previously reported; I'm working on patches now.
(replacing the use of ACPI_OFFSET w/ offsetof from linux/stddef.h).
Not sure if it's precisely the same issue, but looks quite like it.
https://lore.kernel.org/lkml/20200601231805.207441-1-ndesaulniers@google.com/



>
> Clang would report several of those,
>
> https://lore.kernel.org/lkml/CA6078C3-3489-40E4-B756-A0AF6DB3A3A5@lca.pw/
>
> There are many examples how to "fix" those.
>
> $ git log  --oneline --grep='member access within null pointer'
>
> Anyway, this line,
>
>         if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {
>
> acpi_gbl_FADT was defined in,
>
> .//include/acpi/acpixf.h:266:ACPI_GLOBAL(struct acpi_table_fadt, acpi_gbl_FADT);
>
> #ifdef DEFINE_ACPI_GLOBALS
> #define ACPI_GLOBAL(type,name) \
>         extern type name; \
>         type name
>
>
>
> #define ACPI_INIT_GLOBAL(type,name,value) \
>         type name=value
>
>
>
> #else
> #ifndef ACPI_GLOBAL
> #define ACPI_GLOBAL(type,name) \
>         extern type name
> #endif
>
>
>
> #ifndef ACPI_INIT_GLOBAL
> #define ACPI_INIT_GLOBAL(type,name,value) \
>         extern type name
> #endif
> #endif
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200608192828.GB987%40lca.pw.



--
Thanks,
~Nick Desaulniers
