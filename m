Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35532207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHUkJXgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405827AbgFXRvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405670AbgFXRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:51:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:51:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so1465492pfn.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYJBk/lcy+5bHLAKUiA14YDq9cZwKR/QE+4LLN0keF8=;
        b=wHUkJXgM9JWh7uuRdWjm4NZxNbanfjp+e7md5fz51Mll0du+AfeZWdV2njpxgNkNkp
         fc7H1GdFGBi+jK046z8SWZuEHwOeSuRh71uE2P/TbWBONrRSiyZoZ4B4QzoQWkqvoTKB
         DpE2RCzGKrzFGilBhFg6AM+J38lY1UBC7vOTI1ho9uqsoX6fGeIoLMqsUCEA7rLOAr1u
         vrz/5w01r+BKa2G4iYbWBwj+Uxqop8R62Vc6SgXNNWn7TcG3a7RtCYneevHOCR+PcHRY
         /IbZmrliidC9rKKLoUIRtKoRG4KwyvSXuCMYjVRcAW263fJy+3j99qPGe+cQ/KG6PVK2
         Yeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYJBk/lcy+5bHLAKUiA14YDq9cZwKR/QE+4LLN0keF8=;
        b=gi2sh+KVf4zA/JsDV7N+yLpf7VrkFnlHdvvEc6qrz1kh8uUcgakheevJyCJrSo3H8G
         Tx8Bv7ajGSnLtEZUomIgHP2YmFKqai4BlLooTNHl6VO6DnN0GI209U+mDxG0vW+0ph4P
         6kJCEDVPJadxudxV1fqp1IgyboehMB1yRPdpuKXSE1bhulPRy7Bxhre7igEtIE7NzJXX
         LTYUFNpx2gH/84CFodGbx7kOvGHQ5Dd6VHcD9Le/QQ16Jlb9gANX7I1NNKfbWJKVoo89
         9baXGVoCH2nwENdKc6miQxP0rUq5JJtlF5BmUrPh4taZMuQQHXU5iodKKHjeLLzjyCd2
         0/+w==
X-Gm-Message-State: AOAM532RFwc7YVnQ4iw7+OR0gVVEZIIJiCqXdpv1aopgNPJiKwP7EzN1
        MqKVsFnZM9OPPhUSEYpz3aVlZdkBk+V4NrG/gaPyEw==
X-Google-Smtp-Source: ABdhPJwn8bkslAX9+qbW3HQox/YIykR0sX3WOZUdQSycijkcvLZticyYsQ2uLUzk4PCiyfrrP5xFn3BfgCWZCYNc/rk=
X-Received: by 2002:a63:7e55:: with SMTP id o21mr12239340pgn.263.1593021079193;
 Wed, 24 Jun 2020 10:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624114646.28953-1-bp@alien8.de> <20200624114646.28953-3-bp@alien8.de>
In-Reply-To: <20200624114646.28953-3-bp@alien8.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 10:51:07 -0700
Message-ID: <CAKwvOdmmqEwX4Jy0gTBJrsh01VS28jhK-XrURJ7xDPf+yrzJog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>,
        Petteri Aimonen <jpa@kernelbug.mail.kapsi.fi>
Cc:     X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 4:46 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
>
> Add a selftest for the usage of FPU code in kernel mode.
>
> Currently only implemented for x86. In the future, kernel FPU testing
> could be unified between the different architectures supporting it.
>
>  [ bp:
>
>   - Split out from a conglomerate patch, put comments over statements.
>   - run the test only on debugfs write.
>   - Add bare-minimum run_test_fpu.sh, run 1000 iterations on all CPUs
>     by default.
>   - Add conditionally -msse2 so that clang doesn't generate library
>     calls.
>   - Use cc-option to detect gcc 7.1 not supporting -mpreferred-stack-boundary=3.
>   - Document stuff so that we don't forget.
>  ]
>
> Signed-off-by: Petteri Aimonen <jpa@git.mail.kapsi.fi>
> Signed-off-by: Borislav Petkov <bp@suse.de>

More tests make me happy.  Thanks for taking the time to write all
this.  In the future, it should be straightforward for us to test
single precision in test_fpu().  Exercising anything that would
otherwise generate a soft-fp call might be interesting
https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
(plz no `long double`).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  lib/Kconfig.debug                           | 11 +++
>  lib/Makefile                                | 24 ++++++
>  lib/test_fpu.c                              | 89 +++++++++++++++++++++
>  tools/testing/selftests/Makefile            |  1 +
>  tools/testing/selftests/fpu/.gitignore      |  2 +
>  tools/testing/selftests/fpu/Makefile        |  9 +++
>  tools/testing/selftests/fpu/run_test_fpu.sh | 46 +++++++++++
>  tools/testing/selftests/fpu/test_fpu.c      | 61 ++++++++++++++
>  8 files changed, 243 insertions(+)
>  create mode 100644 lib/test_fpu.c
>  create mode 100644 tools/testing/selftests/fpu/.gitignore
>  create mode 100644 tools/testing/selftests/fpu/Makefile
>  create mode 100755 tools/testing/selftests/fpu/run_test_fpu.sh
>  create mode 100644 tools/testing/selftests/fpu/test_fpu.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d74ac0fd6b2d..a1963a493920 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2308,6 +2308,17 @@ config TEST_HMM
>
>           If unsure, say N.
>
> +config TEST_FPU
> +       tristate "Test floating point operations in kernel space"
> +       depends on X86
> +       help
> +         Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
> +         which will trigger a sequence of floating point operations. This is used
> +         for self-testing floating point control register setting in
> +         kernel_fpu_begin().
> +
> +         If unsure, say N.
> +
>  endif # RUNTIME_TESTING_MENU
>
>  config MEMTEST
> diff --git a/lib/Makefile b/lib/Makefile
> index b1c42c10073b..d0f17a74afaf 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -99,6 +99,30 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
>  obj-$(CONFIG_TEST_HMM) += test_hmm.o
>
> +#
> +# CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
> +# off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
> +# get appended last to CFLAGS and thus override those previous compiler options.
> +#
> +FPU_CFLAGS := -mhard-float -msse -msse2
> +ifdef CONFIG_CC_IS_GCC
> +# Stack alignment mismatch, proceed with caution.
> +# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> +# (8B stack alignment).
> +# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
> +#
> +# The "-msse" in the first argument is there so that the
> +# -mpreferred-stack-boundary=3 build error:
> +#
> +#  -mpreferred-stack-boundary=3 is not between 4 and 12
> +#
> +# can be triggered. Otherwise gcc doesn't complain.
> +FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
> +endif
> +
> +obj-$(CONFIG_TEST_FPU) += test_fpu.o
> +CFLAGS_test_fpu.o += $(FPU_CFLAGS)
> +
>  obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
>
>  obj-$(CONFIG_KUNIT) += kunit/
> diff --git a/lib/test_fpu.c b/lib/test_fpu.c
> new file mode 100644
> index 000000000000..c33764aa3eb8
> --- /dev/null
> +++ b/lib/test_fpu.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test cases for using floating point operations inside a kernel module.
> + *
> + * This tests kernel_fpu_begin() and kernel_fpu_end() functions, especially
> + * when userland has modified the floating point control registers. The kernel
> + * state might depend on the state set by the userland thread that was active
> + * before a syscall.
> + *
> + * To facilitate the test, this module registers file
> + * /sys/kernel/debug/selftest_helpers/test_fpu, which when read causes a
> + * sequence of floating point operations. If the operations fail, either the
> + * read returns error status or the kernel crashes.
> + * If the operations succeed, the read returns "1\n".
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/debugfs.h>
> +#include <asm/fpu/api.h>
> +
> +static int test_fpu(void)
> +{
> +       /*
> +        * This sequence of operations tests that rounding mode is
> +        * to nearest and that denormal numbers are supported.
> +        * Volatile variables are used to avoid compiler optimizing
> +        * the calculations away.
> +        */
> +       volatile double a, b, c, d, e, f, g;
> +
> +       a = 4.0;
> +       b = 1e-15;
> +       c = 1e-310;
> +
> +       /* Sets precision flag */
> +       d = a + b;
> +
> +       /* Result depends on rounding mode */
> +       e = a + b / 2;
> +
> +       /* Denormal and very large values */
> +       f = b / c;
> +
> +       /* Depends on denormal support */
> +       g = a + c * f;
> +
> +       if (d > a && e > a && g > a)
> +               return 0;
> +       else
> +               return -EINVAL;
> +}
> +
> +static int test_fpu_get(void *data, u64 *val)
> +{
> +       int status = -EINVAL;
> +
> +       kernel_fpu_begin();
> +       status = test_fpu();
> +       kernel_fpu_end();
> +
> +       *val = 1;
> +       return status;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(test_fpu_fops, test_fpu_get, NULL, "%lld\n");
> +static struct dentry *selftest_dir;
> +
> +static int __init test_fpu_init(void)
> +{
> +       selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
> +       if (!selftest_dir)
> +               return -ENOMEM;
> +
> +       debugfs_create_file("test_fpu", 0444, selftest_dir, NULL,
> +                           &test_fpu_fops);
> +
> +       return 0;
> +}
> +
> +static void __exit test_fpu_exit(void)
> +{
> +       debugfs_remove(selftest_dir);
> +}
> +
> +module_init(test_fpu_init);
> +module_exit(test_fpu_exit);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 1195bd85af38..227ca78a5b7f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -15,6 +15,7 @@ TARGETS += filesystems
>  TARGETS += filesystems/binderfs
>  TARGETS += filesystems/epoll
>  TARGETS += firmware
> +TARGETS += fpu
>  TARGETS += ftrace
>  TARGETS += futex
>  TARGETS += gpio
> diff --git a/tools/testing/selftests/fpu/.gitignore b/tools/testing/selftests/fpu/.gitignore
> new file mode 100644
> index 000000000000..d6d12ac1d9c3
> --- /dev/null
> +++ b/tools/testing/selftests/fpu/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +test_fpu
> diff --git a/tools/testing/selftests/fpu/Makefile b/tools/testing/selftests/fpu/Makefile
> new file mode 100644
> index 000000000000..ea62c176ede7
> --- /dev/null
> +++ b/tools/testing/selftests/fpu/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +LDLIBS := -lm
> +
> +TEST_GEN_PROGS := test_fpu
> +
> +TEST_PROGS := run_test_fpu.sh
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/fpu/run_test_fpu.sh b/tools/testing/selftests/fpu/run_test_fpu.sh
> new file mode 100755
> index 000000000000..d77be93ec139
> --- /dev/null
> +++ b/tools/testing/selftests/fpu/run_test_fpu.sh
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Load kernel module for FPU tests
> +
> +uid=$(id -u)
> +if [ $uid -ne 0 ]; then
> +       echo "$0: Must be run as root"
> +       exit 1
> +fi
> +
> +if ! which modprobe > /dev/null 2>&1; then
> +       echo "$0: You need modprobe installed"
> +        exit 4
> +fi
> +
> +if ! modinfo test_fpu > /dev/null 2>&1; then
> +       echo "$0: You must have the following enabled in your kernel:"
> +       echo "CONFIG_TEST_FPU=m"
> +       exit 4
> +fi
> +
> +NR_CPUS=$(getconf _NPROCESSORS_ONLN)
> +if [ ! $NR_CPUS ]; then
> +       NR_CPUS=1
> +fi
> +
> +modprobe test_fpu
> +
> +if [ ! -e /sys/kernel/debug/selftest_helpers/test_fpu ]; then
> +       mount -t debugfs none /sys/kernel/debug
> +
> +       if [ ! -e /sys/kernel/debug/selftest_helpers/test_fpu ]; then
> +               echo "$0: Error mounting debugfs"
> +               exit 4
> +       fi
> +fi
> +
> +echo "Running 1000 iterations on all CPUs... "
> +for i in $(seq 1 1000); do
> +       for c in $(seq 1 $NR_CPUS); do
> +               ./test_fpu &
> +       done
> +done
> +
> +rmmod test_fpu
> diff --git a/tools/testing/selftests/fpu/test_fpu.c b/tools/testing/selftests/fpu/test_fpu.c
> new file mode 100644
> index 000000000000..200238522a9d
> --- /dev/null
> +++ b/tools/testing/selftests/fpu/test_fpu.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* This testcase operates with the test_fpu kernel driver.
> + * It modifies the FPU control register in user mode and calls the kernel
> + * module to perform floating point operations in the kernel. The control
> + * register value should be independent between kernel and user mode.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <fenv.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +
> +const char *test_fpu_path = "/sys/kernel/debug/selftest_helpers/test_fpu";
> +
> +int main(void)
> +{
> +       char dummy[1];
> +       int fd = open(test_fpu_path, O_RDONLY);
> +
> +       if (fd < 0) {
> +               printf("[SKIP]\tcan't access %s: %s\n",
> +                      test_fpu_path, strerror(errno));
> +               return 0;
> +       }
> +
> +       if (read(fd, dummy, 1) < 0) {
> +               printf("[FAIL]\taccess with default rounding mode failed\n");
> +               return 1;
> +       }
> +
> +       fesetround(FE_DOWNWARD);
> +       if (read(fd, dummy, 1) < 0) {
> +               printf("[FAIL]\taccess with downward rounding mode failed\n");
> +               return 2;
> +       }
> +       if (fegetround() != FE_DOWNWARD) {
> +               printf("[FAIL]\tusermode rounding mode clobbered\n");
> +               return 3;
> +       }
> +
> +       /* Note: the tests up to this point are quite safe and will only return
> +        * an error. But the exception mask setting can cause misbehaving kernel
> +        * to crash.
> +        */
> +       feclearexcept(FE_ALL_EXCEPT);
> +       feenableexcept(FE_ALL_EXCEPT);
> +       if (read(fd, dummy, 1) < 0) {
> +               printf("[FAIL]\taccess with fpu exceptions unmasked failed\n");
> +               return 4;
> +       }
> +       if (fegetexcept() != FE_ALL_EXCEPT) {
> +               printf("[FAIL]\tusermode fpu exception mask clobbered\n");
> +               return 5;
> +       }
> +
> +       printf("[OK]\ttest_fpu\n");
> +       return 0;
> +}
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
