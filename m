Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9C6206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecIE6H8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgHKEaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgHKEaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:30:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 21:30:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so10133434wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 21:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTA/jlI4ZkjE+5vHGh7qBO6GyXxZqYMrHrBvLYqNA/8=;
        b=ecIE6H8POPKe2GmWnNT6j85kVXuCut+VRP5UWYxjZhFuR0utGUaTCLiyLZFEFaDGXA
         Nk/IlTphNYMbm49+EFFnIapGm8TEPL82eic3iPh2Rlf0lJA+8IhA3A3oHXIQu8w5MVug
         OvVkhDq+VZYnuiK6dN1Bu0HPFneZmrTPkI3nfzbMatTEZlaex8bGobr6YOJ7YoXcI07z
         DkFRr3Qa5XPbsrwvmjqdYC/0QkNHbwQzMak6Zf9z33kZSpuCDs0VGKCcRf8TGkbkT+vT
         dqycUjwh94zMZvgPC4Dchf6trndi28QLRRNPB7oCxwuYZkAjf/7FraDP6yUyEczB2yKe
         wI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTA/jlI4ZkjE+5vHGh7qBO6GyXxZqYMrHrBvLYqNA/8=;
        b=qizLPUUjoUs9bv6iN03xfS2JsMAxiDzXU0XoIhqFeIz2SZiY/cW1sBYMH8oYMD43Kw
         KZ0TJpNutNU4j+gy7kFp5shNXCzzKPHeFQYdkOMMHmCW/HqNvouQBCW7HueoQw3azTfJ
         t2kK3ytHceoSwaRIiP6LBk5qh+bbmBn4iDTz2TY8IjRXloHkamWVuMfoYZhX2HWm3Epe
         59yu4Qfi+bhSEVoAxm4BKIHP//bJnZONtRFOSVM032ehBalBcZUWM+mDfInUu6/d6ETx
         85Vu1xXlyGvRj7KmMaXPQecLNA3sIF4KB3yG8d1fo6PaoPhbIgItliBgeEa4iluB1ABX
         mU4g==
X-Gm-Message-State: AOAM532zYdITMKSZaPZP4Mbg1E75ncbRB2yc0oQXOB8TzVwNsm3bBzS/
        dNs7uQTOdPlYmVV0Tgkc2FRPnvaArvDNrnmvG34QgQ==
X-Google-Smtp-Source: ABdhPJycvgzrejAmWvErgPyXmMcxP7oFh0zNGsbjxXriifiC7oqFsCyotTtJ4bM768Iz1pVpC2Nv3L+9xIOQhTKoCgc=
X-Received: by 2002:adf:f511:: with SMTP id q17mr4184981wro.414.1597120210798;
 Mon, 10 Aug 2020 21:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com>
 <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com> <CAFd5g47itmDHzVRiihUe_P2yjqGuvGC8LPLpiDx1D8aQX1T1BA@mail.gmail.com>
In-Reply-To: <CAFd5g47itmDHzVRiihUe_P2yjqGuvGC8LPLpiDx1D8aQX1T1BA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Aug 2020 12:29:59 +0800
Message-ID: <CABVgOSkpTuT6=V08xU0eun-7_OgMR2TdQe0f5rA=mvEPkVrrsw@mail.gmail.com>
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

On Sat, Aug 8, 2020 at 4:51 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Aug 7, 2020 at 10:45 PM David Gow <davidgow@google.com> wrote:
> >
> > On Sat, Aug 8, 2020 at 9:17 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Currently kunit_tool does not work correctly when executed from a path
> > > outside of the kernel tree, so make sure that the current working
> > > directory is correct and the kunit_dir is properly initialized before
> > > running.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  tools/testing/kunit/kunit.py | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > > index 425ef40067e7..96344a11ff1f 100755
> > > --- a/tools/testing/kunit/kunit.py
> > > +++ b/tools/testing/kunit/kunit.py
> > > @@ -237,9 +237,14 @@ def main(argv, linux=None):
> > >
> > >         cli_args = parser.parse_args(argv)
> > >
> > > +       if get_kernel_root_path():
> > > +               print('cd ' + get_kernel_root_path())
> > Do we want to print this, or is it a leftover debug statement?
>
> Whoops, I was supposed to delete that. That's embarrassing... ^_^;
>
> > > +               os.chdir(get_kernel_root_path())
> > > +
> > >         if cli_args.subcommand == 'run':
> > >                 if not os.path.exists(cli_args.build_dir):
> > >                         os.mkdir(cli_args.build_dir)
> > > +                       create_default_kunitconfig()
> > Why are we adding this everywhere when it's already in config_tests,
> > which should already be called in all of the places where a
> > kunitconfig is required?
>
> Ah yes, .kunitconfig needs to be created before config_tests() can be
> called because the LinuxSourceTree constructor needs .kunitconfig to
> exist.

I see. I guess the ultimate solution will be for LinuxSourceTree not
require a .kunitconfig unless it's actually being used.

> > Is the goal to always copy the default kunitconfig when creating a new
> > build_dir? While I can sort-of see why we might want to do that, if
> > the build dir doesn't exist, most of the subcommands will fail anyway
> > (maybe we should only create the build-dir for 'config' and 'run'?)
>
> I just did it because we were getting a failure in a constructor so we
> couldn't do much. Ideally we would check that the current state allows
> for the command that the user intended to run, but I think that's
> beyond the scope of this change.
>
> So I guess the real question is: Is it okay for it to crash in the
> constructor with a cryptic error message for now, or do we want to let
> it fail with a slightly less cryptic message later?
>

I personally am leaning towards allowing it to crash in the build,
exec, etc. subcommands for now, and tidying up the error messages
later, rather than silently creating a blank build dir, only for it
then to fail later.

In the meantime, yeah, we can add this for the config and run tasks,
and maybe remove the whole "if cli_args.build_dir" / mkdir branch from
the other subcommands.

If we weren't going to fix the LinuxSourceTree constructor, it'd make
sense to get rid of the redundant code to create it in config_tests(),
too, but I'm not sure it's worthwhile.

In any case, now I know what's happening, I'm okay with anything
moderately sensible which gets the 'config' and 'run' subcommands
working on an empty build dir, and the code and error messages can be
fixed when tidying up the LinuxSourceTree() constructor in a separate
patch.

Cheers,
-- David

> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > > @@ -257,6 +262,7 @@ def main(argv, linux=None):
> > >                 if cli_args.build_dir:
> > >                         if not os.path.exists(cli_args.build_dir):
> > >                                 os.mkdir(cli_args.build_dir)
> > > +                               create_default_kunitconfig()
> > >
> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > > @@ -273,6 +279,7 @@ def main(argv, linux=None):
> > >                 if cli_args.build_dir:
> > >                         if not os.path.exists(cli_args.build_dir):
> > >                                 os.mkdir(cli_args.build_dir)
> > > +                               create_default_kunitconfig()
> > >
> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > > @@ -291,6 +298,7 @@ def main(argv, linux=None):
> > >                 if cli_args.build_dir:
> > >                         if not os.path.exists(cli_args.build_dir):
> > >                                 os.mkdir(cli_args.build_dir)
> > > +                               create_default_kunitconfig()
> > >
> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > >
> > > base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> > > --
> > > 2.28.0.236.gb10cc79966-goog
> > >
