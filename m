Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CF2207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597235383;
	bh=g8EHUlMmU/ixG+0QtzsltE7fZb1SMk8x6MGggSRTRiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RqIW/2v8DgT8pnucmW04U6n19v2TM0g7gWtSTYc1r+S3drXGaqVYvUbfq+ueLs8xI
	 yss8GZV1uWiV+0UPShbt4LUAG9m5YSZ3s3K2KQ+/teNXsTUWYDpRy1kfMi2/vS/OhC
	 hVj9UVYNarlurb081/T2FF1QBACloVbPlYd8U/zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHLM3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:29:42 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:23310 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:29:41 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 07CCT91Y028933
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:29:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 07CCT91Y028933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597235350;
        bh=B1MXvvnziEh1YoGGi3U1Pjhexr9zmM/bxzeh626e5aA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MLfPisBdA1J9LqGeNi+po7bzOrYC9SkJi7W9oyvmlO0Fixg7lqzAAfld/5eiaOa1s
         XxxN9l9qsU25TGGXJ0wtD7OaPdxg5kgKI+VEdScdRZ4W19FOPiz7By41gms4/GeIAy
         K+YwI2yPo3bu4blZ7SBnk3F9EJ0cx2wgKP14fgchX2/IY4OBLJ75NXhd81NjNypfyh
         trex5WPjHfFR079DLzIM4s5YQim3OLMr/0C5yUH60XzYRJaSBeSPkRKcVApS5jkb6O
         Q5vyBWu2v1QsKWdiNHly72bSWhryXrFHmPwTlPQX1racluTGO2aW9IxS7P5dAaGWCj
         YqpIHe2nuU2LA==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id x187so462679vkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:29:10 -0700 (PDT)
X-Gm-Message-State: AOAM530WapSK2/k3Fi1UO69nV/dykpT27Y7a1poqTvX0fTAgOiVjrRAY
        5v8GJaQEmLww3Ei+X5i9LEZYmcS5EpJm3oDw21c=
X-Google-Smtp-Source: ABdhPJxO2kCrNx3bl1PukxkToFTw+//RO9B1//3tJpNs4kUPC8psjAXE5i52EAa0nvpAscYzlSuhqVNgBk+ktm254bE=
X-Received: by 2002:a1f:eac1:: with SMTP id i184mr28490318vkh.66.1597235349085;
 Wed, 12 Aug 2020 05:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200731212141.3709716-1-peskal@google.com>
In-Reply-To: <20200731212141.3709716-1-peskal@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 12 Aug 2020 21:28:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxnLGpiHO8ovfF_+pjFw+Uo=2c9wYiWMjZRh3B4_wMUg@mail.gmail.com>
Message-ID: <CAK7LNARxnLGpiHO8ovfF_+pjFw+Uo=2c9wYiWMjZRh3B4_wMUg@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_commands: Add support for separate kbuild
 output directory
To:     Peter Kalauskas <peskal@google.com>
Cc:     Tom Roeder <tmroeder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+cc clang-built-linux)


On Sat, Aug 1, 2020 at 6:21 AM Peter Kalauskas <peskal@google.com> wrote:
>
> Add support for builds that use an output directory different than the
> kernel source tree (e.g. make O=/tmp/kernel-obj). This also introduces
> support for .cmd files that use absolute paths.
>
> Previously, gen_compile_commands.py only supported builds where the
> kernel source tree and the output directory were the same:
>  $ make defconfig
>  $ make -j32
>  $ ./scripts/gen_compile_commands.py
>
> gen_compile_commands.py had flags to support out of tree use, but the
> generated compile_commands.json file still assumed that the source tree
> and kbuild output directory were the same.

Thanks Tom for CCing Kbuild ML.
Otherwise, I would not have noticed this patch.



I think the current code _mostly_ supports the out of tree use.
The key is to specify '-p <build-dir>'
when you use compile_commands.json from
clang-check, clang-tidy, etc.





> Now, the following cases are supported as well:
>
>  - Absolute output path:
>    $ mkdir /tmp/kernel-obj
>    $ make O=/tmp/kernel-obj defconfig
>    $ make O=/tmp/kernel-obj -j32
>    $ ./scripts/gen_compile_commands.py -k /tmp/kernel-obj
>
>  - Relative output path:
>    $ mkdir kernel-obj
>    $ make O=kernel-obj/ defconfig
>    $ make O=kernel-obj/ -j32
>    $ ./scripts/gen_compile_commands.py -k kernel-obj


In the current script, I would do like follows:

- Absolute output path:
$ export CC=clang
$ make O=/tmp/kernel-obj defconfig
$ make O=/tmp/kernel-obj -j32
$ ./scripts/gen_compile_commands.py -d /tmp/kernel-obj
$ clang-tidy  '--checks=linuxkernel*'  -p /tmp/kernel-obj kernel/fork.c


- Relative output path:
$ export CC=clang
$ make O=kernel-obj defconfig
$ make O=kernel-obj -j32
$ ./scripts/gen_compile_commands.py -d kernel-obj
$ clang-tidy  '--checks=linuxkernel*'  -p kernel-obj   kernel/fork.c



With your patch and the -k option use,
compile_commands.json is always created in the source tree
whether O= is given or not.
Then, you no longer need to pass '-p <build-path>'
from clang tools.

However, I like the workflow to create any build artifact
in the output tree for O= use-case, and keep the source tree
completely clean.
This is because the source tree might be read-only.
Perhaps, it is located under /usr/src/,
or the source code might be provided by DVD-ROM, etc.





In my understanding, the flaw of the -d option is,
it cannot handle objtool.

'--log_level DEBUG' emits error log for objtool.

masahiro@oscar:~/ref/linux$ ./scripts/gen_compile_commands.py  -d
/tmp/kernel-obj  --log_level  DEBUG
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.elf.o.cmd: File elf.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.builtin-orc.o.cmd: File builtin-orc.c
not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.builtin-check.o.cmd: File
builtin-check.c not in /tmp/kernel-obj or
/tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.orc_dump.o.cmd: File orc_dump.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.libstring.o.cmd: File ../lib/string.c
not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.libctype.o.cmd: File ../lib/ctype.c not
in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.parse-options.o.cmd: File
parse-options.c not in /tmp/kernel-obj or
/tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.objtool.o.cmd: File objtool.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.fixdep.o.cmd: File fixdep.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.pager.o.cmd: File pager.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.str_error_r.o.cmd: File
../lib/str_error_r.c not in /tmp/kernel-obj or
/tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.special.o.cmd: File special.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.orc_gen.o.cmd: File orc_gen.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.help.o.cmd: File help.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.librbtree.o.cmd: File ../lib/rbtree.c
not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.run-command.o.cmd: File run-command.c
not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.exec-cmd.o.cmd: File exec-cmd.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.weak.o.cmd: File weak.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.subcmd-config.o.cmd: File
subcmd-config.c not in /tmp/kernel-obj or
/tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.check.o.cmd: File check.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/.sigchain.o.cmd: File sigchain.c not in
/tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
INFO: Could not add line from
/tmp/kernel-obj/tools/objtool/arch/x86/.decode.o.cmd: File
arch/x86/decode.c not in /tmp/kernel-obj or
/tmp/kernel-obj/tools/objtool/arch/x86



Your patch solves it, but I wonder if it is worth lots of code addition.
objtool is the only unfortunate case because it did not join Kbuild.




> The new argument, -k, is introduced in a way that makes the script
> backward compatible with how -d was previously used.
>
> Signed-off-by: Peter Kalauskas <peskal@google.com>
> ---



> -def process_line(root_directory, file_directory, command_prefix, relative_path):
> +def process_line(src_dir, kbuild_out_dir, file_dir, cmd_prefix, file_path):
>      """Extracts information from a .cmd line and creates an entry from it.
>
>      Args:
> -        root_directory: The directory that was searched for .cmd files. Usually
> +        src_dir: The directory of the kernel source tree.
> +        kbuild_out_dir: The directory that was searched for .cmd files. Usually
>              used directly in the "directory" entry in compile_commands.json.
> -        file_directory: The path to the directory the .cmd file was found in.
> -        command_prefix: The extracted command line, up to the last element.
> -        relative_path: The .c file from the end of the extracted command.
> -            Usually relative to root_directory, but sometimes relative to
> -            file_directory and sometimes neither.
> +        file_dir: The path to the directory the .cmd file was found in.
> +        cmd_prefix: The extracted command line, up to the last element.
> +        file_path: The .c file from the end of the extracted command.
> +            Usually relative to kbuild_out_dir, but sometimes relative to
> +            src_dir and sometimes neither.
>
>      Returns:
>          An entry to append to compile_commands.
>
>      Raises:
> -        ValueError: Could not find the extracted file based on relative_path and
> -            root_directory or file_directory.
> +        ValueError: Could not find the extracted file.
>      """
>      # The .cmd files are intended to be included directly by Make, so they
>      # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
> -    # kernel version). The compile_commands.json file is not interepreted
> +    # kernel version). The compile_commands.json file is not interpreted
>      # by Make, so this code replaces the escaped version with '#'.
> -    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
> -
> -    cur_dir = root_directory
> -    expected_path = os.path.join(cur_dir, relative_path)
> -    if not os.path.exists(expected_path):
> -        # Try using file_directory instead. Some of the tools have a different
> -        # style of .cmd file than the kernel.
> -        cur_dir = file_directory
> -        expected_path = os.path.join(cur_dir, relative_path)
> +    prefix = cmd_prefix.replace('\#', '#').replace('$(pound)', '#')
> +
> +    # Compile commands are usually run in the top level of the kbuild output
> +    # directory
> +    working_dir = kbuild_out_dir
> +
> +    if os.path.isabs(file_path):

I might be misreading the code, but
is this if-else switch needed?


os.path.join() returns the last parameter as-is
if it is already absolute, right?


This is my quick experiment:

masahiro@oscar:~$ python3
Python 3.8.2 (default, Jul 16 2020, 14:00:26)
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import os
>>> os.path.join("/foo/bar/", "a/b/c")
'/foo/bar/a/b/c'
>>> os.path.join("/foo/bar/", "/a/b/c")
'/a/b/c'




So, the current code:

   expected_path = os.path.join(cur_dir, relative_path)

works whether 'relative_path' is relative or not.

I was also thinking this variable name was misleading
since 'relative_path' may be actually absolute.





--
Best Regards

Masahiro Yamada
