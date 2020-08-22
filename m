Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0DE20724
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOh1OEAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHVAfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 20:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHVAfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 20:35:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1172C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 17:35:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so1612677plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tqaym6YY8iaHj+Q6kB4hQ2UFRz3fNuxdZoJtYXC2HaI=;
        b=eOh1OEAkvPLK9de2if6pYhN3E1jRLf6ksoKwtX5M1NPjek4+/2u+3jOm7+XQEYN6A/
         thqtscYN2+k7bUdA0JOmF/9lsNrVKDVVJbhba/dO125e18KfOxFCpU3VNlx0nnjCvm+r
         jTv2p+8/8GYtekIZph1DcsgH2GeORYBSQqnsjJvy7LBQo03uyZtAdkaLWdTzTLDHRep3
         8wBGIdfmXJQghRZHROWGJpmEuHfSX6Vt1TJbtkMrEvPIQh7rTf2RjliOZfvgFFa5KTE7
         JGnHXxN+gdiIvJ7jm1BWKr5qggjkudb/67gSU95A02KNnokOX1aBlvqusck9R7MdKg09
         nS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tqaym6YY8iaHj+Q6kB4hQ2UFRz3fNuxdZoJtYXC2HaI=;
        b=c5CnawzC0cOmih5oMCPwolaoopFeXwiVNvq5kROaw8+XCAPoi9RjKdrje/pP8j09kD
         ikh9lKX1KY1NaZURWF/Yx1+syS4Q433TYmDLMe1U5mccdESijILShThXB11+vfuEAsWC
         n9nL3mRlEFwycrZcjQjSOoqEU2iJrdxjqsQVC80LDV9X5SCnanZ1dBNweHklVqc27Rj8
         mVh2USaEIYAoii7P8cCAJ1P2tD+Fss8spC+IcqLLrIIcaLM1TCXxGihM72TB+BPzfPNN
         bY1oEuERuZDAVYpylPhd2mzpb/AY5/cy4V3r8wTFxcNcBDdbgI2YvHOAAGbuAJ8dSFi5
         UheA==
X-Gm-Message-State: AOAM533NLMqz9oP1hTtaZnrbSGW1OJ7OC7P5h3+0XsWf7J1ofSUowP30
        O3cV2FY1Q9qquDYvMvHSUE+4jd4GwST6bsItIUIWcA==
X-Google-Smtp-Source: ABdhPJzOzd8bvoTUITSwAw3/Hi1kDJVCaLpCqNcJEpwo3dMJ5QODS5YomHcYDreTimiV8cKSQQcXECSOzDIAaFy8Uko=
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr4189501ply.223.1598056542037;
 Fri, 21 Aug 2020 17:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200821190159.1033740-1-masahiroy@kernel.org> <20200821190159.1033740-6-masahiroy@kernel.org>
In-Reply-To: <20200821190159.1033740-6-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Aug 2020 17:35:30 -0700
Message-ID: <CAKwvOdmPzuQi5Z1KxP5KV6w-L+uYR709p4JheS6nCb2o56Pohw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] gen_compile_commands: make -o option independent
 of -d option
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
> Change the -o option independent of the -d option, which is I think
> clearer behavior. Some people may like to use -d to specify a separate
> output directory, but still output the compile_commands.py in the
> source directory (unless the source tree is read-only) because it is
> the default location Clang Tools search for the compilation database.
>
> Also, move the default parameter to the default= argument of the
> .add_argument().
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - New patch
>
>  scripts/gen_compile_commands.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index 5f6318da01a2..3ed958b64658 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -39,11 +39,13 @@ def parse_arguments():
>
>      directory_help = ('specify the output directory used for the kernel build '
>                        '(defaults to the working directory)')
> -    parser.add_argument('-d', '--directory', type=str, help=directory_help)
> +    parser.add_argument('-d', '--directory', type=str, default='.',
> +                        help=directory_help)
>
> -    output_help = ('The location to write compile_commands.json (defaults to '
> -                   'compile_commands.json in the search directory)')
> -    parser.add_argument('-o', '--output', type=str, help=output_help)
> +    output_help = ('path to the output command database (defaults to ' +
> +                   _DEFAULT_OUTPUT + ')')
> +    parser.add_argument('-o', '--output', type=str, default=_DEFAULT_OUTPUT,
> +                        help=output_help)
>
>      log_level_help = ('the level of log messages to produce (defaults to ' +
>                        _DEFAULT_LOG_LEVEL + ')')
> @@ -52,11 +54,9 @@ def parse_arguments():
>
>      args = parser.parse_args()
>
> -    directory = args.directory or os.getcwd()
> -    output = args.output or os.path.join(directory, _DEFAULT_OUTPUT)
> -    directory = os.path.abspath(directory)
> -
> -    return args.log_level, directory, output
> +    return (args.log_level,
> +            os.path.abspath(args.directory),
> +            args.output)
>
>
>  def process_line(root_directory, command_prefix, file_path):
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
