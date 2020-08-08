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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5178C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 08:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02AC2075D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 08:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cImpvsWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHHIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHHIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 04:51:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BCCC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 01:51:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so2421693pfb.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJ0NqtLhxMa8vy08p3okMi0ViGuJVupVz011S0TP8uw=;
        b=cImpvsWPA0tuRi4FaCIuCkXN09crvNWiva4SxYghBRxe6QF2UvZhTPYZb15Kg/i6q4
         U04UHFT/tSEwoIikSa9Sv9Ww6ahDFtp7AX/xoeCrjs09WdmOunuqUuQll8zvKiEI8xWl
         B5SS6ez59kzeNCmSP6eRF54eKARyzxYPJoGuqXxvfJ70QYV54PMxDCXnbPFnZd2eECBk
         bmMzFz8Q5U4eOEvqpx12T5+VfNpUNdTNemuIe3yul8DlBqCwiMSFO4FzonQLwBbiAD17
         hyRba4cPe6q4owa2MM8Q//2W8lXY3zXmDtx5B9W/F+2EeHESKda7rDJvNkzrsIeEJGv+
         a4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJ0NqtLhxMa8vy08p3okMi0ViGuJVupVz011S0TP8uw=;
        b=CLbxKLwxxHaURHzPc2SeeZdhoKgRbfPRc3B/Xo1Lh96jk9wLpiV3Z/3nxHMt6VrH1U
         yrw6exHyHVcTVzz+SNzPHWjO0KwbCYWxEVtQdS7B4DHGJC3ko5ZXuINtGgaXDFyp4WJE
         LG5NPZIaH04x2IQ0vAkuWsDQCgEj5RpOLc64JtVlW3NTNUrpRafIEWxp1d4VrVDt1zNG
         KNtXAsQrFu5lVgFbu28gK4Wzo+OPaaPiqRThQrEk7cnnSH/Hrsq4+lGrUAn2noZ3nVwu
         K+VHUqfVmh11DHKiRuap1O+xI/7z7Ry1jD61ivaPINdF+3ulC0XxCQ+00J3PHu74mQDD
         JdLA==
X-Gm-Message-State: AOAM533EYDWWe1OXTsADATl8n8uejymhbkURvRHf8pC51huOQcnrOvjm
        P+zjlYAjRkvqTRraoAwF940a+Z+qX1sgx0pLG0dlQg==
X-Google-Smtp-Source: ABdhPJxAo+2rzPqPflRATM8sZ8jKh8Eqk5Td2gDaK3rMsOsNEKuQG6IxCX+MvyVsMYXGQLQwroTsDDpIERUbjKXA8v0=
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr14337055pgc.384.1596876664643;
 Sat, 08 Aug 2020 01:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com> <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com>
In-Reply-To: <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 8 Aug 2020 01:50:53 -0700
Message-ID: <CAFd5g47itmDHzVRiihUe_P2yjqGuvGC8LPLpiDx1D8aQX1T1BA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
To:     David Gow <davidgow@google.com>
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

On Fri, Aug 7, 2020 at 10:45 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Aug 8, 2020 at 9:17 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Currently kunit_tool does not work correctly when executed from a path
> > outside of the kernel tree, so make sure that the current working
> > directory is correct and the kunit_dir is properly initialized before
> > running.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  tools/testing/kunit/kunit.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 425ef40067e7..96344a11ff1f 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -237,9 +237,14 @@ def main(argv, linux=None):
> >
> >         cli_args = parser.parse_args(argv)
> >
> > +       if get_kernel_root_path():
> > +               print('cd ' + get_kernel_root_path())
> Do we want to print this, or is it a leftover debug statement?

Whoops, I was supposed to delete that. That's embarrassing... ^_^;

> > +               os.chdir(get_kernel_root_path())
> > +
> >         if cli_args.subcommand == 'run':
> >                 if not os.path.exists(cli_args.build_dir):
> >                         os.mkdir(cli_args.build_dir)
> > +                       create_default_kunitconfig()
> Why are we adding this everywhere when it's already in config_tests,
> which should already be called in all of the places where a
> kunitconfig is required?

Ah yes, .kunitconfig needs to be created before config_tests() can be
called because the LinuxSourceTree constructor needs .kunitconfig to
exist.

> Is the goal to always copy the default kunitconfig when creating a new
> build_dir? While I can sort-of see why we might want to do that, if
> the build dir doesn't exist, most of the subcommands will fail anyway
> (maybe we should only create the build-dir for 'config' and 'run'?)

I just did it because we were getting a failure in a constructor so we
couldn't do much. Ideally we would check that the current state allows
for the command that the user intended to run, but I think that's
beyond the scope of this change.

So I guess the real question is: Is it okay for it to crash in the
constructor with a cryptic error message for now, or do we want to let
it fail with a slightly less cryptic message later?

> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> > @@ -257,6 +262,7 @@ def main(argv, linux=None):
> >                 if cli_args.build_dir:
> >                         if not os.path.exists(cli_args.build_dir):
> >                                 os.mkdir(cli_args.build_dir)
> > +                               create_default_kunitconfig()
> >
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> > @@ -273,6 +279,7 @@ def main(argv, linux=None):
> >                 if cli_args.build_dir:
> >                         if not os.path.exists(cli_args.build_dir):
> >                                 os.mkdir(cli_args.build_dir)
> > +                               create_default_kunitconfig()
> >
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> > @@ -291,6 +298,7 @@ def main(argv, linux=None):
> >                 if cli_args.build_dir:
> >                         if not os.path.exists(cli_args.build_dir):
> >                                 os.mkdir(cli_args.build_dir)
> > +                               create_default_kunitconfig()
> >
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> >
> > base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> > --
> > 2.28.0.236.gb10cc79966-goog
> >
