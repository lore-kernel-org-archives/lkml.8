Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CEC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 00:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01362080D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 00:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFCVvOGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgHWAkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 20:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgHWAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 20:40:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:40:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m34so2772915pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eh5sQVyCmH30XYzTZRKBdCm/XGoXbbsyIhSzkPDA3nY=;
        b=KFCVvOGjy3AcOG2bBSkOE+3LCzwwPZotSad1PWFQ4uJDa+qiLx1O6isw2wwjGzte+5
         CMnFYskCCwmtWO5Qt4aw1gHPOCl6EED6k9qUlfe9sQg3y4O7B0G07OU4SyalFCkYJBR9
         sYaDBVnSOeYpbfw8CHJ+fGbd7+adurmOiXd72K4p8AkijCTdm6P9wOnShFY93jbHECFQ
         29maW9D/0Gmk179UdXjnV//yhb0CBBxkjYT7Ag9wXNGziLL7xaJz8aD2vn4FCi2dynrZ
         CQoSUM/sJzKUQk3Zuj3FHSCqPtR99snCR0Z+J2Yk0OB3VtpCjVYAe3kMyth2evKk5Fj9
         cxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eh5sQVyCmH30XYzTZRKBdCm/XGoXbbsyIhSzkPDA3nY=;
        b=cbCQYWcdksHi1voaZ/7E8YTkuBr9C45cI+MYB6VuolH+yIAnotyT0gqmpTiUaXLt8/
         YfW+MueqrJgj5kWCsioMPFuJhhSvouMnVu6ZEFF+pmXiOUuLTGgC9nmIZ6/6li+LtqEG
         JJna4a8MvzQ9wGrD12I1ZNUI8o8x7dAow6fntOXKQKw0G12ra4cG3owljsInk/kUEdY2
         Hm1Wo2UMgbvdab8/ALtRofevW5RE2kKc3zI7N7Twy0GvI/+75TaeZh0lVInpRpgfGaqp
         wD5ErlQEEgPbsJKyiImBorBoFEved32ygVPIpz9ZGJ6COY8JgKd8oNe0HkKj2PlFQTq1
         qOqg==
X-Gm-Message-State: AOAM531+hy0bw+QwPqDMCKSWoi/71XJ7o49K0J4QmpDZb0Kt5iyjt//Y
        IpaRlqO8lUN8T3JEyxT5t5xdpvpKEdwxnSA1OWi/zQ==
X-Google-Smtp-Source: ABdhPJxbF8iHnyeBqTxIEzJj/7CIIpAKX88fhSnZMq4wcG3PnYETUVS5bin64B/+NXyGy8iKsuroJnqqbRO/M7eNFyY=
X-Received: by 2002:a63:a119:: with SMTP id b25mr6481177pgf.10.1598143242377;
 Sat, 22 Aug 2020 17:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200822145618.1222514-1-masahiroy@kernel.org> <20200822145618.1222514-8-masahiroy@kernel.org>
In-Reply-To: <20200822145618.1222514-8-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 22 Aug 2020 17:40:31 -0700
Message-ID: <CAKwvOdkbc-NH5-fx7DVOj8=fgo6AmM5ufOSvkVYp3XXVxVdoCQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] gen_compile_commands: support *.o, *.a,
 modules.order in positional argument
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 7:56 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This script currently searches the specified directory for .cmd files.
> One drawback is it may contain stale .cmd files after you rebuild the
> kernel several times without 'make clean'.
>
> This commit supports *.o, *.a, and modules.order as positional
> parameters. If such files are given, they are parsed to collect
> associated .cmd files. I added a generator helper for each of them.
>
> This feature is useful to get the list of active .cmd files from the
> last build, and will be used by the next commit to wire up the
> compile_commands.json rule to the Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v3:
>   - Use 'llvm-ar' instead of 'ar' for the default of -a option
>   - Fix the corrupted comment block
>
> Changes in v2:
>   - Separate the file parser into generator functions
>   - Use 'obj' instead of 'object' because 'object' is a built-in function
>   - I think using 'file' is OK because it is not a built-in function in Python3
>     (https://docs.python.org/3/library/functions.html)
>     Anyway, the variable 'file' is no longer used in this version
>   - Keep the previous work-flow to allow to search the given directory
>
>  scripts/gen_compile_commands.py | 100 ++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index e45f17be8817..f370375b2f70 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -12,6 +12,7 @@ import json
>  import logging
>  import os
>  import re
> +import subprocess
>
>  _DEFAULT_OUTPUT = 'compile_commands.json'
>  _DEFAULT_LOG_LEVEL = 'WARNING'
> @@ -32,8 +33,9 @@ def parse_arguments():
>      Returns:
>          log_level: A logging level to filter log output.
>          directory: The work directory where the objects were built.
> +        ar: Command used for parsing .a archives.
>          output: Where to write the compile-commands JSON file.
> -        paths: The list of directories to handle to find .cmd files.
> +        paths: The list of files/directories to handle to find .cmd files.
>      """
>      usage = 'Creates a compile_commands.json database from kernel .cmd files'
>      parser = argparse.ArgumentParser(description=usage)
> @@ -53,12 +55,21 @@ def parse_arguments():
>      parser.add_argument('--log_level', choices=_VALID_LOG_LEVELS,
>                          default=_DEFAULT_LOG_LEVEL, help=log_level_help)
>
> +    ar_help = 'command used for parsing .a archives'
> +    parser.add_argument('-a', '--ar', type=str, default='llvm-ar', help=ar_help)
> +
> +    paths_help = ('directories to search or files to parse '
> +                  '(files should be *.o, *.a, or modules.order). '
> +                  'If nothing is specified, the current directory is searched')
> +    parser.add_argument('paths', type=str, nargs='*', help=paths_help)
> +
>      args = parser.parse_args()
>
>      return (args.log_level,
>              os.path.abspath(args.directory),
>              args.output,
> -            [args.directory])
> +            args.ar,
> +            args.paths if len(args.paths) > 0 else [args.directory])
>
>
>  def cmdfiles_in_dir(directory):
> @@ -81,6 +92,73 @@ def cmdfiles_in_dir(directory):
>                  yield os.path.join(dirpath, filename)
>
>
> +def to_cmdfile(path):
> +    """Return the path of .cmd file used for the given build artifact
> +
> +    Args:
> +        Path: file path
> +
> +    Returns:
> +        The path to .cmd file
> +    """
> +    dir, base = os.path.split(path)
> +    return os.path.join(dir, '.' + base + '.cmd')
> +
> +
> +def cmdfiles_for_o(obj):
> +    """Generate the iterator of .cmd files associated with the object
> +
> +    Yield the .cmd file used to build the given object
> +
> +    Args:
> +        obj: The object path
> +
> +    Yields:
> +        The path to .cmd file
> +    """
> +    yield to_cmdfile(obj)
> +
> +
> +def cmdfiles_for_a(archive, ar):
> +    """Generate the iterator of .cmd files associated with the archive.
> +
> +    Parse the given archive, and yield every .cmd file used to build it.
> +
> +    Args:
> +        archive: The archive to parse
> +
> +    Yields:
> +        The path to every .cmd file found
> +    """
> +    for obj in subprocess.check_output([ar, '-t', archive]).decode().split():
> +        yield to_cmdfile(obj)
> +
> +
> +def cmdfiles_for_modorder(modorder):
> +    """Generate the iterator of .cmd files associated with the modules.order.
> +
> +    Parse the given modules.order, and yield every .cmd file used to build the
> +    contained modules.
> +
> +    Args:
> +        modorder: The modules.order file to parse
> +
> +    Yields:
> +        The path to every .cmd file found
> +    """
> +    with open(modorder) as f:
> +        for line in f:
> +            ko = line.rstrip()
> +            base, ext = os.path.splitext(ko)
> +            if ext != '.ko':
> +                sys.exit('{}: module path must end with .ko'.format(ko))
> +            mod = base + '.mod'
> +           # The first line of *.mod lists the objects that compose the module.
> +            with open(mod) as m:
> +                for obj in m.readline().split():
> +                    yield to_cmdfile(obj)
> +
> +
>  def process_line(root_directory, command_prefix, file_path):
>      """Extracts information from a .cmd line and creates an entry from it.
>
> @@ -117,7 +195,7 @@ def process_line(root_directory, command_prefix, file_path):
>
>  def main():
>      """Walks through the directory and finds and parses .cmd files."""
> -    log_level, directory, output, paths = parse_arguments()
> +    log_level, directory, output, ar, paths = parse_arguments()
>
>      level = getattr(logging, log_level)
>      logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
> @@ -127,7 +205,21 @@ def main():
>      compile_commands = []
>
>      for path in paths:
> -        cmdfiles = cmdfiles_in_dir(path)
> +        # If 'path' is a directory, handle all .cmd files under it.
> +        # Otherwise, handle .cmd files associated with the file.
> +        # Most of built-in objects are linked via archives (built-in.a or lib.a)
> +        # but some objects are linked to vmlinux directly.
> +        # Modules are listed in modules.order.
> +        if os.path.isdir(path):
> +            cmdfiles = cmdfiles_in_dir(path)
> +        elif path.endswith('.o'):
> +            cmdfiles = cmdfiles_for_o(path)
> +        elif path.endswith('.a'):
> +            cmdfiles = cmdfiles_for_a(path, ar)
> +        elif path.endswith('modules.order'):
> +            cmdfiles = cmdfiles_for_modorder(path)
> +        else:
> +            sys.exit('{}: unknown file type'.format(path))
>
>          for cmdfile in cmdfiles:
>              with open(cmdfile, 'rt') as f:
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
