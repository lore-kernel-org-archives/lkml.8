Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0B6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD792065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3n1pNJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgG1UfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgG1UfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:35:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:35:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id r11so3749891pfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBkwAyTEXypPFrv1L/bcvqGsjN6kL4QWEhz3WakHkuw=;
        b=u3n1pNJBqmv+wnc325pObRLwelABKFK0TTLaazs9/l3rir9ewi34O5LCVVPgMCtXAp
         oAa/jHYVa4qB4hNcmIZXKI6sJooGpbWFkaH4ZdH2LlbajzjX2C7vmSxjVQmiD8TitfHh
         WlZf7MkbgxfqQ1jWo/fS5tkvRgRKTKR4KNPbdfsIaQVaZfv4W0Xap+LMI9nMS28ri5q5
         O/0k080ddNH4E0QmiYxXooJ4tbtx0Yq2Av/J/MLbTCIwodr56fRgAgrigFTug2W4Xmez
         3F67G2y5YxnuxqpRjIz/8Dg/81Rkcqk7ockNHRktDoYSCq9UcOZ8ho7Ysp2EeqSjwRgK
         subQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBkwAyTEXypPFrv1L/bcvqGsjN6kL4QWEhz3WakHkuw=;
        b=p/rvlYsqz1XWqASfFyK6ZOo6KectpuYw8+xQgYqVcx2a1QqOmWfT4XZ3/6BH3OjEhd
         VKaA+659h7XLx/gQP05wLjiqhmnlv7binbBlhWHqgK7Moa0RxeEc5HPJYnM1F4pvBQxX
         Vy4AVHFOZn7u1lSvLQLYWmdoyr4PIoEDY8Y5T0G3qr+ptbghSrmRfKCAzVtEMcFWvrWI
         mNNvohH0obOVVOR/V8Zi+/plddeE/MO3zVvpJzmFUfFrVGRPN7B1Sjl4ZkhFDUlpkBSe
         IDGS/0K3yUwUASPjudquXkwBk62FQcvCJKT4gjFJmbyyZjZ1JRJm5Ia97Ud7HbBkNP83
         a12w==
X-Gm-Message-State: AOAM5320jtK5YatMyZhzRVuFM80HXzIN76wLJ7ETIcfFUZDM4FtRFJ5d
        RK4jbpvJKW6g+kvxRvYSjcWUK7M2BcBcrcf9WzOByA==
X-Google-Smtp-Source: ABdhPJx8wHjF9qGKptJgatNHt0b1qWH35UqxoZXkEAs5cwCjg6+AuKH85TYZUtDBAiVSRk5ph+7xs65w9V8TuKWNjGU=
X-Received: by 2002:a62:86cc:: with SMTP id x195mr25927376pfd.39.1595968519048;
 Tue, 28 Jul 2020 13:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnni_G2tw+0eCLQQvvdcz97Fy1-cBjzPvLwbBNDu1-KqQ@mail.gmail.com>
 <20200728004736.3590053-1-nhuck@google.com>
In-Reply-To: <20200728004736.3590053-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Jul 2020 13:35:08 -0700
Message-ID: <CAKwvOdnrVP4Ci4MBd2NtW9Jkk60wVrpRwGV_rz1dw5NYVUdaSw@mail.gmail.com>
Subject: Re: [PATCH v7] Makefile: Add clang-tidy and static analyzer support
 to makefile
To:     Nathan Huckleberry <nhuck@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Pirama Arumuga Nainar <pirama@google.com>,
        Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 5:47 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> This patch adds clang-tidy and the clang static-analyzer as make
> targets. The goal of this patch is to make static analysis tools
> usable and extendable by any developer or researcher who is familiar
> with basic c++.
>
> The current static analysis tools require intimate knowledge of the
> internal workings of the static analysis. Clang-tidy and the clang
> static analyzers expose an easy to use api and allow users unfamiliar
> with clang to write new checks with relative ease.
>
> ===Clang-tidy===
>
> Clang-tidy is an easily extendable 'linter' that runs on the AST.
> Clang-tidy checks are easy to write and understand. A check consists of
> two parts, a matcher and a checker. The matcher is created using a
> domain specific language that acts on the AST
> (https://clang.llvm.org/docs/LibASTMatchersReference.html).  When AST
> nodes are found by the matcher a callback is made to the checker. The
> checker can then execute additional checks and issue warnings.
>
> Here is an example clang-tidy check to report functions that have calls
> to local_irq_disable without calls to local_irq_enable and vice-versa.
> Functions flagged with __attribute((annotation("ignore_irq_balancing")))
> are ignored for analysis. (https://reviews.llvm.org/D65828)
>
> ===Clang static analyzer===
>
> The clang static analyzer is a more powerful static analysis tool that
> uses symbolic execution to find bugs. Currently there is a check that
> looks for potential security bugs from invalid uses of kmalloc and
> kfree. There are several more general purpose checks that are useful for
> the kernel.
>
> The clang static analyzer is well documented and designed to be
> extensible.
> (https://clang-analyzer.llvm.org/checker_dev_manual.html)
> (https://github.com/haoNoQ/clang-analyzer-guide/releases/download/v0.1/clang-analyzer-guide-v0.1.pdf)
>
> The main draw of the clang tools is how accessible they are. The clang
> documentation is very nice and these tools are built specifically to be
> easily extendable by any developer. They provide an accessible method of
> bug-finding and research to people who are not overly familiar with the
> kernel codebase.
>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
> Changes v6->v7
> * Fix issues with relative paths
> * Additional style fixes
>  MAINTAINERS                                   |  1 +
>  Makefile                                      |  3 +
>  scripts/clang-tools/Makefile.clang-tools      | 23 ++++++
>  .../{ => clang-tools}/gen_compile_commands.py |  0
>  scripts/clang-tools/run-clang-tools.py        | 74 +++++++++++++++++++
>  5 files changed, 101 insertions(+)
>  create mode 100644 scripts/clang-tools/Makefile.clang-tools
>  rename scripts/{ => clang-tools}/gen_compile_commands.py (100%)
>  create mode 100755 scripts/clang-tools/run-clang-tools.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d4aa7f942de..a444564e5572 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4198,6 +4198,7 @@ W:        https://clangbuiltlinux.github.io/
>  B:     https://github.com/ClangBuiltLinux/linux/issues
>  C:     irc://chat.freenode.net/clangbuiltlinux
>  F:     Documentation/kbuild/llvm.rst
> +F:     scripts/clang-tools/
>  K:     \b(?i:clang|llvm)\b
>
>  CLEANCACHE API
> diff --git a/Makefile b/Makefile
> index fe0164a654c7..3e2df010b342 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -747,6 +747,7 @@ KBUILD_CFLAGS       += $(call cc-option,-fno-allow-store-data-races)
>
>  include scripts/Makefile.kcov
>  include scripts/Makefile.gcc-plugins
> +include scripts/clang-tools/Makefile.clang-tools
>
>  ifdef CONFIG_READABLE_ASM
>  # Disable optimizations that make assembler listings hard to read.
> @@ -1543,6 +1544,8 @@ help:
>         @echo  '  export_report   - List the usages of all exported symbols'
>         @echo  '  headerdep       - Detect inclusion cycles in headers'
>         @echo  '  coccicheck      - Check with Coccinelle'
> +       @echo  '  clang-analyzer  - Check with clang static analyzer'
> +       @echo  '  clang-tidy      - Check with clang-tidy'
>         @echo  ''
>         @echo  'Tools:'
>         @echo  '  nsdeps          - Generate missing symbol namespace dependencies'
> diff --git a/scripts/clang-tools/Makefile.clang-tools b/scripts/clang-tools/Makefile.clang-tools
> new file mode 100644
> index 000000000000..5c9d76f77595
> --- /dev/null
> +++ b/scripts/clang-tools/Makefile.clang-tools
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) Google LLC, 2020
> +#
> +# Author: Nathan Huckleberry <nhuck@google.com>
> +#
> +PHONY += clang-tidy
> +clang-tidy:
> +ifdef CONFIG_CC_IS_CLANG
> +       $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
> +       $(PYTHON3) scripts/clang-tools/run-clang-tools.py clang-tidy compile_commands.json
> +else
> +       $(error clang-tidy requires CC=clang)
> +endif
> +
> +PHONY += clang-analyzer
> +clang-analyzer:
> +ifdef CONFIG_CC_IS_CLANG
> +       $(PYTHON3) scripts/clang-tools/gen_compile_commands.py
> +       $(PYTHON3) scripts/clang-tools/run-clang-tools.py clang-analyzer compile_commands.json
> +else
> +       $(error clang-analyzer requires CC=clang)
> +endif
> diff --git a/scripts/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> similarity index 100%
> rename from scripts/gen_compile_commands.py
> rename to scripts/clang-tools/gen_compile_commands.py
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> new file mode 100755
> index 000000000000..fa7655c7cec0
> --- /dev/null
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -0,0 +1,74 @@
> +#!/usr/bin/env python
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) Google LLC, 2020
> +#
> +# Author: Nathan Huckleberry <nhuck@google.com>
> +#
> +"""A helper routine run clang-tidy and the clang static-analyzer on
> +compile_commands.json.
> +"""
> +
> +import argparse
> +import json
> +import multiprocessing
> +import os

^ unused import.  Maybe Masahiro would be so kind as to drop that line
for you when merging v7?

That said, I hammered on this in testing, and it now LGTM.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

For testing, I did `make clean` for x86/arm/arm64/powerpc, then a
defconfig (pseries_defconfig for ppc) build, then:
$ make -j71 LLVM=1 clang-tidy 2> log.txt
$ grep -e linuxkernel- -e clang- log.txt | sort -u | cut -d '[' -f 2 |
sort | uniq -c
$ make -j71 LLVM=1 clang-analyzer 2> log.txt
$ grep -e linuxkernel- -e clang- log.txt | sort -u | cut -d '[' -f 2 |
sort | uniq -c

Looks like it's already finding a couple bugs.  I'll probably disable
clang-diagnostic-* in a follow up, as those seem pretty noisy, though
clang-diagnostic-incompatible-pointer-types will likely be of interest
for the CFI work.

Thanks for all of the work that went into this, and tolerating my pedantry.

> +import subprocess
> +import sys
> +
> +
> +def parse_arguments():
> +    """Set up and parses command-line arguments.
> +    Returns:
> +        args: Dict of parsed args
> +        Has keys: [path, type]
> +    """
> +    usage = """Run clang-tidy or the clang static-analyzer on a
> +        compilation database."""
> +    parser = argparse.ArgumentParser(description=usage)
> +
> +    type_help = "Type of analysis to be performed"
> +    parser.add_argument("type",
> +                        choices=["clang-tidy", "clang-analyzer"],
> +                        help=type_help)
> +    path_help = "Path to the compilation database to parse"
> +    parser.add_argument("path", type=str, help=path_help)
> +
> +    return parser.parse_args()
> +
> +
> +def init(l, a):
> +    global lock
> +    global args
> +    lock = l
> +    args = a
> +
> +
> +def run_analysis(entry):
> +    # Disable all checks, then re-enable the ones we want
> +    checks = "-checks=-*,"
> +    if args.type == "clang-tidy":
> +        checks += "linuxkernel-*"
> +    else:
> +        checks += "clang-analyzer-*"
> +    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
> +                       stdout=subprocess.PIPE,
> +                       stderr=subprocess.STDOUT,
> +                       cwd=entry["directory"])
> +    with lock:
> +        sys.stderr.buffer.write(p.stdout)
> +
> +
> +def main():
> +    args = parse_arguments()
> +
> +    lock = multiprocessing.Lock()
> +    pool = multiprocessing.Pool(initializer=init, initargs=(lock, args))
> +    # Read JSON data into the datastore variable
> +    with open(args.path, "r") as f:
> +        datastore = json.load(f)
> +        pool.map(run_analysis, datastore)
> +
> +
> +if __name__ == "__main__":
> +    main()
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200728004736.3590053-1-nhuck%40google.com.



-- 
Thanks,
~Nick Desaulniers
