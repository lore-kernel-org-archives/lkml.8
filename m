Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E706320706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJyV10MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHYXbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHYXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:31:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:31:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so13572pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H8MjPqeDYxmd5ry+yVN2NIJr4injOVdiQvMa1tt54Lw=;
        b=hJyV10MJ0r2E65URxV/MgPUI3iQt87Hhfyb3M7g6OxXEQ42fCaqHczz9uWuraIU0Hq
         vqIAmecSsfdWTQZfOaPYpwwy9UtK/nKJVk8BUw2x3NkOFkXrc/+qbcn8nemL6cfRRtti
         cpmvJduUCh+B8AQmTkFfyhtv5sPyeFuGGFSUNNN0xgIkQFAm1c+btBSf4pjcJ5rRU4N8
         dUoQN95jhUj2zacYT009H9/EFlLUftOLRcDPnpFWnMFNU/XDIHvszRck+ioCMOYZA5bp
         p8AWYnLNiW60+EkqCe57Y+SPdnq3LHBNY+cgkdxSMdrfeBJEONvSM5Nw/WQa7HbpF043
         7g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8MjPqeDYxmd5ry+yVN2NIJr4injOVdiQvMa1tt54Lw=;
        b=gQ+40Q8N+r3Kg1z1UvopTRje0Cg4FHjDGnhmMw3M2iu6Jeqy+1yOzpqUZuBPNiZ/qF
         MhmZHQN6/Ouqp+LdwmZ23PTYFLgTOxnPiA3anTxwV23YPAAv0v23yY+QrEb3fcbz6XQ8
         mcsItX7g2tES0iY+EnicancYS0qnP30cCeSBsr36fLuNU12k43nO987MGsNhxXhSBvMV
         uy48rHCGsRaucRIp5IYfYI98bVMHKCXTWcZTbC7D1d5TDDLFMH1fwK7MYWzri8BTjQru
         yjVsOx2Qy0emP9uud6jqnXRwIajBX3DyZ84+W1gjHN4xFA1yjxgd8lyp2GGdCt8qjLUj
         lKTQ==
X-Gm-Message-State: AOAM533UA1jKxzs54W10N5CvaD2B+/8GzfN59IyIh0ith4Tf3o3WlJLt
        l9rrClZsTTWoxKAObBHco5S1mw==
X-Google-Smtp-Source: ABdhPJzcWEQgoTPTBuRznJFKGhd54NNC+yro1TVNCRXImFC9HWLwCY7UuGUpzllcyPAXxByjN3eFBQ==
X-Received: by 2002:a17:90a:1a42:: with SMTP id 2mr3359100pjl.16.1598398313787;
        Tue, 25 Aug 2020 16:31:53 -0700 (PDT)
Received: from google.com ([2620:15c:211:2:a28c:fdff:fee1:f6fa])
        by smtp.gmail.com with ESMTPSA id l3sm205391pgp.34.2020.08.25.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 16:31:53 -0700 (PDT)
Date:   Tue, 25 Aug 2020 16:31:49 -0700
From:   Peter Kalauskas <peskal@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tom Roeder <tmroeder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] gen_compile_commands: Add support for separate kbuild
 output directory
Message-ID: <20200825233149.GA2143288@google.com>
References: <20200731212141.3709716-1-peskal@google.com>
 <CAK7LNARxnLGpiHO8ovfF_+pjFw+Uo=2c9wYiWMjZRh3B4_wMUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARxnLGpiHO8ovfF_+pjFw+Uo=2c9wYiWMjZRh3B4_wMUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 09:28:32PM +0900, Masahiro Yamada wrote:
> (+cc clang-built-linux)
> 
> 
> On Sat, Aug 1, 2020 at 6:21 AM Peter Kalauskas <peskal@google.com> wrote:
> >
> > Add support for builds that use an output directory different than the
> > kernel source tree (e.g. make O=/tmp/kernel-obj). This also introduces
> > support for .cmd files that use absolute paths.
> >
> > Previously, gen_compile_commands.py only supported builds where the
> > kernel source tree and the output directory were the same:
> >  $ make defconfig
> >  $ make -j32
> >  $ ./scripts/gen_compile_commands.py
> >
> > gen_compile_commands.py had flags to support out of tree use, but the
> > generated compile_commands.json file still assumed that the source tree
> > and kbuild output directory were the same.
> 
> Thanks Tom for CCing Kbuild ML.
> Otherwise, I would not have noticed this patch.
> 
> 
> 
> I think the current code _mostly_ supports the out of tree use.
> The key is to specify '-p <build-dir>'
> when you use compile_commands.json from
> clang-check, clang-tidy, etc.
> 

Thanks, I wasn't aware of the -p option for clang-tidy. When I wrote
this, I was trying to use the compile_commands.json with YCM for vim. I
see now that I can easily change the build dir for that use-case as well
by specifying:

  :let g:ycm_clangd_args=['--compile-commands-dir=kernel-obj']

> 
> 
> 
> 
> > Now, the following cases are supported as well:
> >
> >  - Absolute output path:
> >    $ mkdir /tmp/kernel-obj
> >    $ make O=/tmp/kernel-obj defconfig
> >    $ make O=/tmp/kernel-obj -j32
> >    $ ./scripts/gen_compile_commands.py -k /tmp/kernel-obj
> >
> >  - Relative output path:
> >    $ mkdir kernel-obj
> >    $ make O=kernel-obj/ defconfig
> >    $ make O=kernel-obj/ -j32
> >    $ ./scripts/gen_compile_commands.py -k kernel-obj
> 
> 
> In the current script, I would do like follows:
> 
> - Absolute output path:
> $ export CC=clang
> $ make O=/tmp/kernel-obj defconfig
> $ make O=/tmp/kernel-obj -j32
> $ ./scripts/gen_compile_commands.py -d /tmp/kernel-obj
> $ clang-tidy  '--checks=linuxkernel*'  -p /tmp/kernel-obj kernel/fork.c
> 
> 
> - Relative output path:
> $ export CC=clang
> $ make O=kernel-obj defconfig
> $ make O=kernel-obj -j32
> $ ./scripts/gen_compile_commands.py -d kernel-obj
> $ clang-tidy  '--checks=linuxkernel*'  -p kernel-obj   kernel/fork.c
> 
> 
> 
> With your patch and the -k option use,
> compile_commands.json is always created in the source tree
> whether O= is given or not.
> Then, you no longer need to pass '-p <build-path>'
> from clang tools.
> 
> However, I like the workflow to create any build artifact
> in the output tree for O= use-case, and keep the source tree
> completely clean.
> This is because the source tree might be read-only.
> Perhaps, it is located under /usr/src/,
> or the source code might be provided by DVD-ROM, etc.
> 
> 
> 
> 
> 
> In my understanding, the flaw of the -d option is,
> it cannot handle objtool.
> 
> '--log_level DEBUG' emits error log for objtool.
> 
> masahiro@oscar:~/ref/linux$ ./scripts/gen_compile_commands.py  -d
> /tmp/kernel-obj  --log_level  DEBUG
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.elf.o.cmd: File elf.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.builtin-orc.o.cmd: File builtin-orc.c
> not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.builtin-check.o.cmd: File
> builtin-check.c not in /tmp/kernel-obj or
> /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.orc_dump.o.cmd: File orc_dump.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.libstring.o.cmd: File ../lib/string.c
> not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.libctype.o.cmd: File ../lib/ctype.c not
> in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.parse-options.o.cmd: File
> parse-options.c not in /tmp/kernel-obj or
> /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.objtool.o.cmd: File objtool.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.fixdep.o.cmd: File fixdep.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.pager.o.cmd: File pager.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.str_error_r.o.cmd: File
> ../lib/str_error_r.c not in /tmp/kernel-obj or
> /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.special.o.cmd: File special.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.orc_gen.o.cmd: File orc_gen.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.help.o.cmd: File help.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.librbtree.o.cmd: File ../lib/rbtree.c
> not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.run-command.o.cmd: File run-command.c
> not in /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.exec-cmd.o.cmd: File exec-cmd.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.weak.o.cmd: File weak.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.subcmd-config.o.cmd: File
> subcmd-config.c not in /tmp/kernel-obj or
> /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.check.o.cmd: File check.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/.sigchain.o.cmd: File sigchain.c not in
> /tmp/kernel-obj or /tmp/kernel-obj/tools/objtool
> INFO: Could not add line from
> /tmp/kernel-obj/tools/objtool/arch/x86/.decode.o.cmd: File
> arch/x86/decode.c not in /tmp/kernel-obj or
> /tmp/kernel-obj/tools/objtool/arch/x86
> 
> 
> 
> Your patch solves it, but I wonder if it is worth lots of code addition.
> objtool is the only unfortunate case because it did not join Kbuild.
> 

I'd also prefer not to complicate things more than necessary, so maybe
it's best to abandon this patch and leave the script as is. Probably the
only thing needed is to clean up some of the variable names (e.g. as you
mentioned, relative_path can sometimes be absolute) and maybe add more
documentation on suggested usage.

> 
> 
> 
> > The new argument, -k, is introduced in a way that makes the script
> > backward compatible with how -d was previously used.
> >
> > Signed-off-by: Peter Kalauskas <peskal@google.com>
> > ---
> 
> 
> 
> > -def process_line(root_directory, file_directory, command_prefix, relative_path):
> > +def process_line(src_dir, kbuild_out_dir, file_dir, cmd_prefix, file_path):
> >      """Extracts information from a .cmd line and creates an entry from it.
> >
> >      Args:
> > -        root_directory: The directory that was searched for .cmd files. Usually
> > +        src_dir: The directory of the kernel source tree.
> > +        kbuild_out_dir: The directory that was searched for .cmd files. Usually
> >              used directly in the "directory" entry in compile_commands.json.
> > -        file_directory: The path to the directory the .cmd file was found in.
> > -        command_prefix: The extracted command line, up to the last element.
> > -        relative_path: The .c file from the end of the extracted command.
> > -            Usually relative to root_directory, but sometimes relative to
> > -            file_directory and sometimes neither.
> > +        file_dir: The path to the directory the .cmd file was found in.
> > +        cmd_prefix: The extracted command line, up to the last element.
> > +        file_path: The .c file from the end of the extracted command.
> > +            Usually relative to kbuild_out_dir, but sometimes relative to
> > +            src_dir and sometimes neither.
> >
> >      Returns:
> >          An entry to append to compile_commands.
> >
> >      Raises:
> > -        ValueError: Could not find the extracted file based on relative_path and
> > -            root_directory or file_directory.
> > +        ValueError: Could not find the extracted file.
> >      """
> >      # The .cmd files are intended to be included directly by Make, so they
> >      # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
> > -    # kernel version). The compile_commands.json file is not interepreted
> > +    # kernel version). The compile_commands.json file is not interpreted
> >      # by Make, so this code replaces the escaped version with '#'.
> > -    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
> > -
> > -    cur_dir = root_directory
> > -    expected_path = os.path.join(cur_dir, relative_path)
> > -    if not os.path.exists(expected_path):
> > -        # Try using file_directory instead. Some of the tools have a different
> > -        # style of .cmd file than the kernel.
> > -        cur_dir = file_directory
> > -        expected_path = os.path.join(cur_dir, relative_path)
> > +    prefix = cmd_prefix.replace('\#', '#').replace('$(pound)', '#')
> > +
> > +    # Compile commands are usually run in the top level of the kbuild output
> > +    # directory
> > +    working_dir = kbuild_out_dir
> > +
> > +    if os.path.isabs(file_path):
> 
> I might be misreading the code, but
> is this if-else switch needed?
> 
> 
> os.path.join() returns the last parameter as-is
> if it is already absolute, right?
> 
> 
> This is my quick experiment:
> 
> masahiro@oscar:~$ python3
> Python 3.8.2 (default, Jul 16 2020, 14:00:26)
> [GCC 9.3.0] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import os
> >>> os.path.join("/foo/bar/", "a/b/c")
> '/foo/bar/a/b/c'
> >>> os.path.join("/foo/bar/", "/a/b/c")
> '/a/b/c'
> 
> 
> 
> 
> So, the current code:
> 
>    expected_path = os.path.join(cur_dir, relative_path)
> 
> works whether 'relative_path' is relative or not.
> 
> I was also thinking this variable name was misleading
> since 'relative_path' may be actually absolute.
> 

You are correct about os.path.join. That if-else is unnecessary in
hindsight.

Thanks again for reviewing!

> 
> 
> 
> 
> --
> Best Regards
> 
> Masahiro Yamada
