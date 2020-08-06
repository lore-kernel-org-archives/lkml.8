Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981AB221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PX7vfq6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFVmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFVmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:42:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C918C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 14:42:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so46449702qka.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpAWxyK9tlB1NXZqSpDU40Yy2PoufquWk25YMjTDwRI=;
        b=PX7vfq6V0l+wUCuHw6v6W3CQnGwlnA/6q8YD2Uc2ADo34vnQ6pqufXseVHEZb4D5j/
         u8wNAXS132LjhZ7sOjG37lREx0ff+TVV6ERAmy1SUCIP0/aAvslcnCPy3FHR1bhJixcG
         yKWgH54hM5gBNr168OtJWQ0hMygXK4U7Pb/vKkD1/ebpEqHmeG5XMnhvBS3FXQWMh9Bx
         7g0m/BvWqF0yTkpw2H9ZqucmhhLTNOHxj3OhcT7K9jO8e7R6nV4tIz+T5SM4AWHqhfH2
         Rt5MvNyQ3JrrbG86AFB1npsyXt5KcPDSHkUmM/D135T9dABqOfV0p46At00PcoSuEL8f
         Q6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpAWxyK9tlB1NXZqSpDU40Yy2PoufquWk25YMjTDwRI=;
        b=puto1KLYBRk/04DpiXfnlcvgyJ03lW2sOcGJs2CV5+9VsPtQYGo3y7J9t8yIweNMZ2
         aheKBhP7MocEuzxCeBd9tXtxadTdszuqd7EqomghtTt5VCb9lqR2T8GzkG3Js4/cj2DY
         DMANxUHTapomexTpiSAHsAaJzQgvlJPkvBKMij1OQ4kmqtiOz2SZlyGV/4hUAf8ZYmyj
         z6duo3/t0boWKXqESr4OMJ0rwGhpC4mnO8lhvp8yS2m4Y1362ZVOH7U4N8oR2W3lE59p
         fDHhdftViLD1sSZ+Gc9vKTlpK8Ik+jq5ZmSmFRgWVL5E3tGXdGG+R/e0axNon3hSHjDb
         nQHg==
X-Gm-Message-State: AOAM530X+VQwIQacXxpvyIeSp3OcyRjc6LxhduZQEs1rkJ4leEMluV+s
        OxTN/K1hhysK8WaPYExQtvn71XojEa2kQ5SJYpuvcWMbtYw=
X-Google-Smtp-Source: ABdhPJxqc0lXSFbvA3Ut0IGpwjcf3TF/bOR3bkGC0ezlzTRSqca3q6/3Iw7iFD9QiXzm8n7lSg0mcbPuhTZTNnd7VIM=
X-Received: by 2002:a37:a354:: with SMTP id m81mr10814578qke.277.1596750132783;
 Thu, 06 Aug 2020 14:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnni_G2tw+0eCLQQvvdcz97Fy1-cBjzPvLwbBNDu1-KqQ@mail.gmail.com>
 <20200728004736.3590053-1-nhuck@google.com> <CAK7LNAT-AO9_Y-qunRvPbBYf7GZnoE6bxYKFNtcdKAKV8d_A+w@mail.gmail.com>
In-Reply-To: <CAK7LNAT-AO9_Y-qunRvPbBYf7GZnoE6bxYKFNtcdKAKV8d_A+w@mail.gmail.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Thu, 6 Aug 2020 16:42:00 -0500
Message-ID: <CAJkfWY5ywOtO6fAyPd0B2BjEWamJRRMgg4et0uVq2bpkJSECwA@mail.gmail.com>
Subject: Re: [PATCH v7] Makefile: Add clang-tidy and static analyzer support
 to makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Pirama Arumuga Nainar <pirama@google.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Jul 28, 2020 at 9:47 AM Nathan Huckleberry <nhuck@google.com> wrote:
> >
> > This patch adds clang-tidy and the clang static-analyzer as make
> > targets. The goal of this patch is to make static analysis tools
> > usable and extendable by any developer or researcher who is familiar
> > with basic c++.
> >
> > The current static analysis tools require intimate knowledge of the
> > internal workings of the static analysis. Clang-tidy and the clang
> > static analyzers expose an easy to use api and allow users unfamiliar
> > with clang to write new checks with relative ease.
> >
> > ===Clang-tidy===
> >
> > Clang-tidy is an easily extendable 'linter' that runs on the AST.
> > Clang-tidy checks are easy to write and understand. A check consists of
> > two parts, a matcher and a checker. The matcher is created using a
> > domain specific language that acts on the AST
> > (https://clang.llvm.org/docs/LibASTMatchersReference.html).  When AST
> > nodes are found by the matcher a callback is made to the checker. The
> > checker can then execute additional checks and issue warnings.
> >
> > Here is an example clang-tidy check to report functions that have calls
> > to local_irq_disable without calls to local_irq_enable and vice-versa.
> > Functions flagged with __attribute((annotation("ignore_irq_balancing")))
> > are ignored for analysis. (https://reviews.llvm.org/D65828)
> >
> > ===Clang static analyzer===
> >
> > The clang static analyzer is a more powerful static analysis tool that
> > uses symbolic execution to find bugs. Currently there is a check that
> > looks for potential security bugs from invalid uses of kmalloc and
> > kfree. There are several more general purpose checks that are useful for
> > the kernel.
> >
> > The clang static analyzer is well documented and designed to be
> > extensible.
> > (https://clang-analyzer.llvm.org/checker_dev_manual.html)
> > (https://github.com/haoNoQ/clang-analyzer-guide/releases/download/v0.1/clang-analyzer-guide-v0.1.pdf)
> >
> > The main draw of the clang tools is how accessible they are. The clang
> > documentation is very nice and these tools are built specifically to be
> > easily extendable by any developer. They provide an accessible method of
> > bug-finding and research to people who are not overly familiar with the
> > kernel codebase.
> >
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> > Changes v6->v7
> > * Fix issues with relative paths
> > * Additional style fixes
> >  MAINTAINERS                                   |  1 +
> >  Makefile                                      |  3 +
> >  scripts/clang-tools/Makefile.clang-tools      | 23 ++++++
> >  .../{ => clang-tools}/gen_compile_commands.py |  0
> >  scripts/clang-tools/run-clang-tools.py        | 74 +++++++++++++++++++
> >  5 files changed, 101 insertions(+)
> >  create mode 100644 scripts/clang-tools/Makefile.clang-tools
> >  rename scripts/{ => clang-tools}/gen_compile_commands.py (100%)
> >  create mode 100755 scripts/clang-tools/run-clang-tools.py
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1d4aa7f942de..a444564e5572 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4198,6 +4198,7 @@ W:        https://clangbuiltlinux.github.io/
> >  B:     https://github.com/ClangBuiltLinux/linux/issues
> >  C:     irc://chat.freenode.net/clangbuiltlinux
> >  F:     Documentation/kbuild/llvm.rst
> > +F:     scripts/clang-tools/
> >  K:     \b(?i:clang|llvm)\b
> >
> >  CLEANCACHE API
> > diff --git a/Makefile b/Makefile
> > index fe0164a654c7..3e2df010b342 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -747,6 +747,7 @@ KBUILD_CFLAGS       += $(call cc-option,-fno-allow-store-data-races)
> >
> >  include scripts/Makefile.kcov
> >  include scripts/Makefile.gcc-plugins
> > +include scripts/clang-tools/Makefile.clang-tools
> >
> >  ifdef CONFIG_READABLE_ASM
> >  # Disable optimizations that make assembler listings hard to read.
> > @@ -1543,6 +1544,8 @@ help:
> >         @echo  '  export_report   - List the usages of all exported symbols'
> >         @echo  '  headerdep       - Detect inclusion cycles in headers'
> >         @echo  '  coccicheck      - Check with Coccinelle'
> > +       @echo  '  clang-analyzer  - Check with clang static analyzer'
> > +       @echo  '  clang-tidy      - Check with clang-tidy'
> >         @echo  ''
> >         @echo  'Tools:'
> >         @echo  '  nsdeps          - Generate missing symbol namespace dependencies'
> > diff --git a/scripts/clang-tools/Makefile.clang-tools b/scripts/clang-tools/Makefile.clang-tools
> > new file mode 100644
> > index 000000000000..5c9d76f77595
> > --- /dev/null
> > +++ b/scripts/clang-tools/Makefile.clang-tools
> > @@ -0,0 +1,23 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) Google LLC, 2020
> > +#
> > +# Author: Nathan Huckleberry <nhuck@google.com>
> > +#
> > +PHONY += clang-tidy
> > +clang-tidy:
> > +ifdef CONFIG_CC_IS_CLANG
> > +       $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
> > +       $(PYTHON3) scripts/clang-tools/run-clang-tools.py clang-tidy compile_commands.json
> > +else
> > +       $(error clang-tidy requires CC=clang)
> > +endif
> > +
> > +PHONY += clang-analyzer
> > +clang-analyzer:
> > +ifdef CONFIG_CC_IS_CLANG
> > +       $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
> > +       $(PYTHON3) scripts/clang-tools/run-clang-tools.py clang-analyzer compile_commands.json
> > +else
> > +       $(error clang-analyzer requires CC=clang)
> > +endif
>
>
>
> You can unify the almost same two rules.
>
> PHONY += clang-tidy clang-analyzer
> clang-tidy clang-analyzer:
> ifdef CONFIG_CC_IS_CLANG
>         $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
>         $(PYTHON3) scripts/clang-tools/run-clang-tools.py $@
> compile_commands.json
> else
>         $(error $@ requires CC=clang)
> endif
>

I like this.

>
>
>
> But, before we proceed, please tell me
> what this check is intended for.
>

Clang-tidy invokes clang using the command line
options specified in the compile_commands.json file.
Using gcc command line options causes a bunch of
errors for unknown options.

>
>
>
>
> Case 1)
> Build the kernel with CC=clang,
> and then run clang-tidy without CC=clang.
>
> $ make CC=clang defconfig
> $ make CC=clang -j$(nproc)
> $ make clang-tidy
>
> scripts/clang-tools/Makefile.clang-tools:13: *** clang-tidy requires
> CC=clang.  Stop.
>

I suppose this case could allow clang-tidy to
be run.

>
>
>
> Case 2)
> Build the kernel using GCC,
> and then run clang-tidy with CC=clang.
>
> $ make defconfig
> $ make -j$(nproc)
> $ make CC=clang clang-tidy
>
> This patch happily runs clang-tidy
> although compile_commands.json
> contains GCC commands.
>

This is the worst of the two cases. I'm not
sure how to prevent this other than parsing the
compiler invocation in run-clang-tools.py.

I'm open to better suggestions.

>
>
>
>
> So, it checks if you have passed CC=clang
> to "make clang-tidy", where I do not see
> any user of the $(CC) variable.
>
> It does not care whether you have built
> the kernel with GCC or Clang.
>
>
>
> What happens if you run clang-tidy against
> compile_commands.json that contains GCC
> commands?

Clang-tidy itself uses the command line options from
compile_commands.json to invoke clang. If you run
clang-tidy against GCC commands you get lots of
errors similar to this

Found compiler error(s).
12 warnings and 8 errors generated.
Error while processing /usr/local/google/home/nhuck/linux/arch/x86/lib/iomem.c.
error: unknown argument: '-fconserve-stack' [clang-diagnostic-error]
error: unknown argument: '-fno-var-tracking-assignments'
[clang-diagnostic-error]
error: unknown argument: '-mindirect-branch-register' [clang-diagnostic-error]
error: unknown argument: '-mindirect-branch=thunk-extern'
[clang-diagnostic-error]
error: unknown argument: '-mno-fp-ret-in-387' [clang-diagnostic-error]
error: unknown argument: '-mpreferred-stack-boundary=3' [clang-diagnostic-error]
error: unknown argument: '-mskip-rax-setup' [clang-diagnostic-error]

>
>
> I also care about stale commands
> in compile_commands.json.
>

I agree with this point, but it's more of a bug with
gen_compile_commands.py. Maybe gen_compile_commands.py
could emit a warning when stale commands are detected in the
.*.cmd files.

>
> gen_compile_commands.py creates compile_commands.json
> based on *.cmd files it found.
>
> If you rebuild the kernel for various settings
> using GCC/clang without "make clean",
> stale .*.cmd files will grow.
>
> compile_commands.json will pick up commands
> from older compilation, i.e. the end up with
> the mixture of GCC/Clang commands.
>
> So, I'd like to know how clang-tidy handles
> the GCC commands from compile_commands.json
>
>
>
>
>
> > diff --git a/scripts/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> > similarity index 100%
> > rename from scripts/gen_compile_commands.py
> > rename to scripts/clang-tools/gen_compile_commands.py
> > diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> > new file mode 100755
> > index 000000000000..fa7655c7cec0
> > --- /dev/null
> > +++ b/scripts/clang-tools/run-clang-tools.py
> > @@ -0,0 +1,74 @@
> > +#!/usr/bin/env python
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) Google LLC, 2020
> > +#
> > +# Author: Nathan Huckleberry <nhuck@google.com>
> > +#
> > +"""A helper routine run clang-tidy and the clang static-analyzer on
> > +compile_commands.json.
> > +"""
> > +
> > +import argparse
> > +import json
> > +import multiprocessing
> > +import os
> > +import subprocess
> > +import sys
> > +
> > +
> > +def parse_arguments():
> > +    """Set up and parses command-line arguments.
> > +    Returns:
> > +        args: Dict of parsed args
> > +        Has keys: [path, type]
> > +    """
> > +    usage = """Run clang-tidy or the clang static-analyzer on a
> > +        compilation database."""
> > +    parser = argparse.ArgumentParser(description=usage)
> > +
> > +    type_help = "Type of analysis to be performed"
> > +    parser.add_argument("type",
> > +                        choices=["clang-tidy", "clang-analyzer"],
> > +                        help=type_help)
> > +    path_help = "Path to the compilation database to parse"
> > +    parser.add_argument("path", type=str, help=path_help)
> > +
> > +    return parser.parse_args()
> > +
> > +
> > +def init(l, a):
> > +    global lock
> > +    global args
> > +    lock = l
> > +    args = a
> > +
> > +
> > +def run_analysis(entry):
> > +    # Disable all checks, then re-enable the ones we want
> > +    checks = "-checks=-*,"
> > +    if args.type == "clang-tidy":
> > +        checks += "linuxkernel-*"
> > +    else:
> > +        checks += "clang-analyzer-*"
> > +    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
> > +                       stdout=subprocess.PIPE,
> > +                       stderr=subprocess.STDOUT,
> > +                       cwd=entry["directory"])
> > +    with lock:
> > +        sys.stderr.buffer.write(p.stdout)
> > +
> > +
> > +def main():
> > +    args = parse_arguments()
> > +
> > +    lock = multiprocessing.Lock()
> > +    pool = multiprocessing.Pool(initializer=init, initargs=(lock, args))
> > +    # Read JSON data into the datastore variable
> > +    with open(args.path, "r") as f:
> > +        datastore = json.load(f)
> > +        pool.map(run_analysis, datastore)
> > +
> > +
> > +if __name__ == "__main__":
> > +    main()
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada
