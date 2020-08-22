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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6EFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD29D214F1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIu0gzev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHVAXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHVAXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 20:23:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF77C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 17:23:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so1618810plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 17:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVdLiKM9f5DmQ4nw1uLUhU7UpsX2vw3oOdD0OyADK/0=;
        b=sIu0gzevYkqboleHnK2Q9CqZCj26fro5OeNZcUi6p+gA153dbXOvc3Mb/I6vM81W0L
         Oj6it/OcgT0MgfWplkZy4bAJRiswf5AFCijV+65+zoTlCZG/6mrZarA5m0e8Ij2/wvBL
         Cv2Gcr3dkUj91v6JxBq2YBXBxlTqWEjkuBID1CoTbl93ekviA4LSunno7hYvEFdSpdtE
         7+mxOtziV/B+2sMx7ziM70sUALjecs8FikInT+Ueif70uqLcHXnAo43DFGUY0+5twpW+
         wyR3t0vgpHiptl7NlLzMhSimb+HoyuQvmSmOSYV+fOl/fqw03KMGoiX5+HYC/vd7oLTN
         W88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVdLiKM9f5DmQ4nw1uLUhU7UpsX2vw3oOdD0OyADK/0=;
        b=LBRxTUCcTEhrocqZz/I9T9/827cxWwCJ3gd1tFIQGBgbYRewcDWsJYHQxIJvkLzite
         gTUeca3SI0e6gCYLkwrQC4zt4q/QGfZykWYDgAX56ZhIO0pl7t7wt0VYxEc4UtH/PoED
         LkWxs+2TpAW6jG3sShcbV0QT6U5EnHWxCI/2o0gApv1YbOvC8fhTUZ3lBpo4r/vcnPTs
         KtwYA8ta1J4iyZg3U0fTqA3AFVMujZXgv6QioCxHv37hUgahglfgbGv1948qXjIyxTkM
         fGQ7N/KDcH55NgLRys3fve/r1KtotQfwmAS7QIgjSCzPTT7qaRymswinLKWrvKX4F6gX
         xF9g==
X-Gm-Message-State: AOAM531P5ZWG9YL6v6SJmqUN4k6OhRY56zsjvID9k084Kgb06Sp4wxd9
        HnT3oV5Opmd3oIFazCahT51wE7pOoydgeaHpGmO7CA==
X-Google-Smtp-Source: ABdhPJyRUF02CDtQ6ouokAMHwyOD7b+hebBNoebXWi+VQhlKXfB/dJ0BXQNBwDHCHKrkSDKp7xnlBcZ10FdmQPGesRk=
X-Received: by 2002:a17:902:b485:: with SMTP id y5mr4181251plr.119.1598055810741;
 Fri, 21 Aug 2020 17:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200821190159.1033740-1-masahiroy@kernel.org> <20200821190159.1033740-3-masahiroy@kernel.org>
In-Reply-To: <20200821190159.1033740-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Aug 2020 17:23:19 -0700
Message-ID: <CAKwvOdkz3asVBpi63yj94OMLnkU5q3rqA80trVXwyoDDcPs9QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] gen_compile_commands: use choices for --log_levels option
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
> Use 'choices' instead of the own code to check if the given parameter
> is valid.
>
> I also simplified the help message because, with 'choices', --help
> shows the list of valid parameters:
>
>   --log_level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - New patch
>
>  scripts/gen_compile_commands.py | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index 1bcf33a93cb9..535248cf2d7e 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -45,24 +45,18 @@ def parse_arguments():
>                     'compile_commands.json in the search directory)')
>      parser.add_argument('-o', '--output', type=str, help=output_help)
>
> -    log_level_help = ('The level of log messages to produce (one of ' +
> -                      ', '.join(_VALID_LOG_LEVELS) + '; defaults to ' +
> +    log_level_help = ('the level of log messages to produce (defaults to ' +
>                        _DEFAULT_LOG_LEVEL + ')')
> -    parser.add_argument(
> -        '--log_level', type=str, default=_DEFAULT_LOG_LEVEL,
> -        help=log_level_help)
> +    parser.add_argument('--log_level', choices=_VALID_LOG_LEVELS,
> +                        default=_DEFAULT_LOG_LEVEL, help=log_level_help)
>
>      args = parser.parse_args()
>
> -    log_level = args.log_level
> -    if log_level not in _VALID_LOG_LEVELS:
> -        raise ValueError('%s is not a valid log level' % log_level)
> -
>      directory = args.directory or os.getcwd()
>      output = args.output or os.path.join(directory, _DEFAULT_OUTPUT)
>      directory = os.path.abspath(directory)
>
> -    return log_level, directory, output
> +    return args.log_level, directory, output
>
>
>  def process_line(root_directory, file_directory, command_prefix, relative_path):
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
