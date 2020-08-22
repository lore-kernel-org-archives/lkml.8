Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B04C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360962072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPob3zYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHVAln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 20:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHVAll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 20:41:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 17:41:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so1531195pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 17:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpYkI6juAqMAAUVTQTHgpzHvlncEIWGwTCUc4UiA+NQ=;
        b=BPob3zYcwMB6bxh5Xy6HCPZOVzXpbXZAgORVwjpTTFMl/+hIoRgP9u9snUEd9ytwFN
         s/q8EexxPFJub6RCY0iCxBddroqjCnamTLaAwUGB0FQMR26DoQw8m08wSGK1JaZ8dlr1
         heVWZFhGKYkNuDcIsSP8YLSPQdUW0jZqvSPH1Hct1nc4y9b/hRyCxzw7jhRi1xoAOQ3M
         kbDAT57Xcz90ARycJCQYCjG/exCHnyD6Eh1HczygMhm7xr6zFsRGEVr6YWmUqZ3lwY1N
         SeJA8GohX+mwfQ3wFBnGbkeZxSt1zlJHv/5gqVkDZvrLYeOYLMrFwxIzl/AxByz4ISkl
         eAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpYkI6juAqMAAUVTQTHgpzHvlncEIWGwTCUc4UiA+NQ=;
        b=qP9lGep0xwnqH3FU89nFwDqMI2NpvkFO8PdlWAPuPBZLEL04gJhlfnhNYEpRAx+U3G
         AbWkjPrfA14Ygz9/cLOXyl6u/7BJVMOZuOghoKXXMgcNxvsGryiOpqn+jTcKx1HQfs8D
         GY984ZN0W1llFCetmBREWNCom+YkHHBoYt3+L6sQTzCAk2NisNYjxJkBxg2kPRIfAsYy
         VLNyNsHd2Bfm9ZrvCOd+gkHgAzOgez31+OvLExvBBC1sAVzlCUsdwXJpstKT9gHF5XQS
         dsSVY0N9ZD2DaH4yjudY1ula+D7fC/VcEuX3KO4e/Dn39LrVre0DUfgYyHZyLCodJAEs
         cmMQ==
X-Gm-Message-State: AOAM5308/sH+ZQk03JETzbHdFrbB4uPXleAkmDAYR/Cf8r//G1WilytJ
        3zSrfsUmBUqmCw2e6N2QAg4UjBTRf4oQ7cEbhcdaYw==
X-Google-Smtp-Source: ABdhPJxoznNG5mzZHJrBMDgeBePlf0XMcl7O3f+wmRk2kidEeZfhAnaAXZGPhl91K2hWHb7ldgHVUhfIVJs2bwaN4e4=
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr4204225ply.223.1598056899804;
 Fri, 21 Aug 2020 17:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200821190159.1033740-1-masahiroy@kernel.org> <20200821190159.1033740-7-masahiroy@kernel.org>
In-Reply-To: <20200821190159.1033740-7-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Aug 2020 17:41:28 -0700
Message-ID: <CAKwvOdn9ZfvC4dzuVnxc_a52JFn_q1ewOWwZZD5b9=izeEayKQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] gen_compile_commands: move directory walk to a
 generator function
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

On Fri, Aug 21, 2020 at 12:02 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, this script walks under the specified directory (default to
> the current directory), then parses all .cmd files found.
>
> Split it into a separate helper function because the next commit will
> add more helpers to pick up .cmd files associated with given file(s).
>
> There is no point to build and return a huge list at once. I used a
> generator so it works in the for-loop with less memory.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - New patch
>
>  scripts/gen_compile_commands.py | 44 ++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index 3ed958b64658..6dec7e2c4098 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -33,6 +33,7 @@ def parse_arguments():
>          log_level: A logging level to filter log output.
>          directory: The work directory where the objects were built
>          output: Where to write the compile-commands JSON file.
> +        paths: The list of directories to handle to find .cmd files

Punctuation: please add a period.

>      """
>      usage = 'Creates a compile_commands.json database from kernel .cmd files'
>      parser = argparse.ArgumentParser(description=usage)
> @@ -56,7 +57,28 @@ def parse_arguments():
>
>      return (args.log_level,
>              os.path.abspath(args.directory),
> -            args.output)
> +            args.output,
> +            [args.directory])
> +
> +
> +def cmdfiles_in_dir(directory):
> +    """Generate the iterator of .cmd files found under the directory.
> +
> +    Walk under the given directory, and yield every .cmd file found.
> +
> +    Args:
> +        directory: The directory to search for .cmd files.
> +
> +    Yields:
> +        The path to a .cmd file.
> +    """
> +
> +    filename_matcher = re.compile(_FILENAME_PATTERN)
> +
> +    for dirpath, _, filenames in os.walk(directory):
> +        for filename in filenames:
> +            if filename_matcher.match(filename):
> +                yield os.path.join(dirpath, filename)
>
>
>  def process_line(root_directory, command_prefix, file_path):
> @@ -94,31 +116,29 @@ def process_line(root_directory, command_prefix, file_path):
>
>  def main():
>      """Walks through the directory and finds and parses .cmd files."""
> -    log_level, directory, output = parse_arguments()
> +    log_level, directory, output, paths = parse_arguments()
>
>      level = getattr(logging, log_level)
>      logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
>
> -    filename_matcher = re.compile(_FILENAME_PATTERN)
>      line_matcher = re.compile(_LINE_PATTERN)
>
>      compile_commands = []
> -    for dirpath, _, filenames in os.walk(directory):
> -        for filename in filenames:
> -            if not filename_matcher.match(filename):
> -                continue
> -            filepath = os.path.join(dirpath, filename)
>
> -            with open(filepath, 'rt') as f:
> +    for path in paths:
> +        cmdfiles = cmdfiles_in_dir(path)
> +
> +        for cmdfile in cmdfiles:

If `cmdfiles` is never referenced again, please make this:

for cmdfile in cmdfiles_in_dir(path):

With those 2 changes feel free to add my
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +            with open(cmdfile, 'rt') as f:
>                  result = line_matcher.match(f.readline())
>                  if result:
>                      try:
> -                        entry = process_line(directory,
> -                                             result.group(1), result.group(2))
> +                        entry = process_line(directory, result.group(1),
> +                                             result.group(2))
>                          compile_commands.append(entry)
>                      except ValueError as err:
>                          logging.info('Could not add line from %s: %s',
> -                                     filepath, err)
> +                                     cmdfile, err)
>
>      with open(output, 'wt') as f:
>          json.dump(compile_commands, f, indent=2, sort_keys=True)
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
