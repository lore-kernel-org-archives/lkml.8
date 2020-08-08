Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E81C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5145120855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFgiaaUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHHFpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHHFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 01:45:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F6C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 22:45:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so3357451wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=441erG+nQmp/Gw1mKUcyWCbdvIu4tY4AskgERTUrfjg=;
        b=gFgiaaUI3R97K8gVNTA0DZeC1udE44Xe94EfLuFG1QpmUFFLrLEysS/L41zYbhywlR
         mPQkkd+eeFz/LTsg34gxiKRGptrqJhCYX9JpHb2zPZDfvKDf4EC824Em7a6WPF+Qx6ZG
         IyHyoO7cF3GP1ylR3urde/Y1x+HM1HMXDCaEEVM4N9t9AX+Nvr8VlhnUnpo9OMzUsDnt
         mYOmnT2IEGD86AG63um15D87y76SR2uMql/cULk2BXS9r+afuQlHDsuuw+vpjp0vdeya
         4kBLhd/DC2NyDWZh4c7JaDvRiK6eGx6TtAeR/UQVZ1NFR/F6HprG8LVCJH1H0RttbBcE
         0eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=441erG+nQmp/Gw1mKUcyWCbdvIu4tY4AskgERTUrfjg=;
        b=F65Fah5w+DCNm1lQllJ4Q082TcVUN72GXwKwbljxjfbQvnEqidGEfHcHeK0Fk+v/bo
         reNeRbkzKjWxFLdy71piDGk9R6TeKbFu/rxBUgMUyuhCzx8Gqrpfa01r0NP88xAmOYZH
         IBPOmyaFxECBg/XCuUnKdBccdRwKdcISVm2eIs/vx1LOkIyjIzOmoRx0JmXdCJfE046H
         aMwRCgymqmFrRdIRhGShE+4r0hcc8tqs8g9hY9pZULCtyI3k8icsOrTDYq4x6Roca+SA
         6rcx3mIBMhdjb2qvfHB+Cuq7PAa/qnf4txrtNGwtm0ujA1vViuAZIGO46B4fTfiWg+7C
         /mgg==
X-Gm-Message-State: AOAM530PBY5+rM19fYIfV0FhIH0JUk+6Bnl8mvKpOPWjmnmZ/h72F1g+
        HvCN5uQsh7MKMWtrf+D0d668KlzLI41D25vzb8WMOQ==
X-Google-Smtp-Source: ABdhPJx0rFe0zGAHdrBJuE8AHpoJMag7cGGMlYcCrkYzgb+JqKHHTSUqvpypkcKFaRZqkqXKMiukGIhlzijpTrDC9gs=
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr15492330wmk.86.1596865516755;
 Fri, 07 Aug 2020 22:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com>
In-Reply-To: <20200808011651.2113930-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 8 Aug 2020 13:45:05 +0800
Message-ID: <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 9:17 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Currently kunit_tool does not work correctly when executed from a path
> outside of the kernel tree, so make sure that the current working
> directory is correct and the kunit_dir is properly initialized before
> running.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  tools/testing/kunit/kunit.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 425ef40067e7..96344a11ff1f 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -237,9 +237,14 @@ def main(argv, linux=None):
>
>         cli_args = parser.parse_args(argv)
>
> +       if get_kernel_root_path():
> +               print('cd ' + get_kernel_root_path())
Do we want to print this, or is it a leftover debug statement?


> +               os.chdir(get_kernel_root_path())
> +
>         if cli_args.subcommand == 'run':
>                 if not os.path.exists(cli_args.build_dir):
>                         os.mkdir(cli_args.build_dir)
> +                       create_default_kunitconfig()
Why are we adding this everywhere when it's already in config_tests,
which should already be called in all of the places where a
kunitconfig is required?
Is the goal to always copy the default kunitconfig when creating a new
build_dir? While I can sort-of see why we might want to do that, if
the build dir doesn't exist, most of the subcommands will fail anyway
(maybe we should only create the build-dir for 'config' and 'run'?)


>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
> @@ -257,6 +262,7 @@ def main(argv, linux=None):
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> +                               create_default_kunitconfig()
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
> @@ -273,6 +279,7 @@ def main(argv, linux=None):
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> +                               create_default_kunitconfig()
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
> @@ -291,6 +298,7 @@ def main(argv, linux=None):
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> +                               create_default_kunitconfig()
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
>
> base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> --
> 2.28.0.236.gb10cc79966-goog
>
