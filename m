Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE25C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115922076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5kE0esf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGODrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgGODrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:47:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:47:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so934064wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80hgB3Fq3XFIKiId7PbT4ZtffySmJWFsmTxk7R8Jg78=;
        b=b5kE0esfW+M+PVUtyf+1XnxZWg/JuNQGk9B30zFKSWwurrF2Da7rR/RbN+1Bsb5aak
         6KCFwvBiX1KbZ/IogP3pgSu/O8PM6byEbFMOnbofAE3e1bqbESydmUgbJoT2RamHCP3e
         7v/euNreVZcaLhwBYqZjk2NGFCoTAsl0SrlER1JeMtgBdpcy+r18pjhL7vJV/dsDXyoO
         FUrWxn5TvZREZUQE4uNfw4jrxhuCA4zh+n6XztLstMWmDrC+KPeKPxvwWVCLv2faVPb+
         /nh1TAQA68sOIRN8bgOsMTmahPxi+zieMcpGMPPMLaHf9LVlWYr2Tb582/rfA9b77/Yz
         B/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80hgB3Fq3XFIKiId7PbT4ZtffySmJWFsmTxk7R8Jg78=;
        b=GknQn7qRXX3l0cRFWDI+q0LHKEZodxLzMH+US2e1BDbF40Z6/ROEey/ed5ZYaA1UYv
         NCdBXokwaAkyDSlXJAmKk4c6dSdZ5o3LRBemaVwLN+EZQk0SomuTwAv9fl7ZqGWCpnHQ
         CX4xqX+MGBugS1fjBYc9vD3pufkmP8dxuOMuD4dW1VLQMQ7sOl7kUiq68OkPD3VhxQMh
         KeHZb1Q/LQblw/VPs2wUoaTh4wvH9vTiik2nRK9JXXUZA59Z1vE1M7v6cB0rXxuClr7J
         V4HiOgBLg3cFP1BQzmIBtkaUtj+vWVDx8hBd9S6fjnTyBCqOojW86vKH9uTYX1WPEIhz
         EN0g==
X-Gm-Message-State: AOAM530WNj2jckWVjx5m0LejryOmQpKW98/Xwv9qKF0My09V5S29PbOR
        /zKDJNYqdBiRFoaLFHPZ2dGgM77W8aQRjXezmop3+Q==
X-Google-Smtp-Source: ABdhPJw9P2wWnLC30qk6qeKsB/4onQBt5QQ/Ff4rue+kzOL0Dw7pLXwt158nTqEpcLRe3Tk+o/VWZozgd5+OwoBRTJ8=
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr9253893wrx.203.1594784843205;
 Tue, 14 Jul 2020 20:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200715031120.1002016-1-vitor@massaru.org>
In-Reply-To: <20200715031120.1002016-1-vitor@massaru.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 15 Jul 2020 11:47:11 +0800
Message-ID: <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
Subject: Re: [RFC 0/3] kunit: add support to use modules
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:11 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Currently, KUnit does not allow the use of tests as a module.
> This prevents the implementation of tests that require userspace.

If this is what I think it is, thanks! I'll hopefully get a chance to
play with it over the next few days.

Can we clarify what this means: the current description is a little
misleading, as KUnit tests can already be built and run as modules,
and "tests that require userspace" is a bit broad.

As I understand it, this patchset does three things:
- Let kunit_tool install modules to a root filesystem and boot UML
with that filesystem.
- Have tests inherit the mm of the process that started them, which
(if the test is in a module), provides a user-space memory context so
that copy_{from,to}_user() works.
- Port the test_user_copy.c tests to KUnit, using this new feature.

A few comments from my quick glance over it:
- The rootfs support is useful: I'm curious how it'll interact with
non-UML architectures in [1]. It'd be nice for this to be extensible
and to not explicitly state UML where possible.
- The inheriting of the mm stuff still means that
copy_{from,to}_user() will only work if loaded as a module. This
really needs to be documented. (Ideally, we'd find a way of having
this work even for built-in tests, but I don't have any real ideas as
to how that could be done).
- It'd be nice to split the test_user_copy.c test port into a separate
commit. In fact, it may make sense to also split the kunit_tool
changes and the mm changes into separate series, as they're both quite
useful independently.

Cheers,
-- David

> This patchset makes this possible by introducing the use of
> the root filesystem in KUnit. And it allows the use of tests
> that can be compiled as a module
>
> Vitor Massaru Iha (3):
>   kunit: tool: Add support root filesystem in kunit-tool
>   lib: Allows to borrow mm in userspace on KUnit
>   lib: Convert test_user_copy to KUnit test
>
>  include/kunit/test.h                        |   1 +
>  lib/Kconfig.debug                           |  17 ++
>  lib/Makefile                                |   2 +-
>  lib/kunit/try-catch.c                       |  15 +-
>  lib/{test_user_copy.c => user_copy_kunit.c} | 196 +++++++++-----------
>  tools/testing/kunit/kunit.py                |  37 +++-
>  tools/testing/kunit/kunit_kernel.py         | 105 +++++++++--
>  7 files changed, 238 insertions(+), 135 deletions(-)
>  rename lib/{test_user_copy.c => user_copy_kunit.c} (55%)
>
>
> base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
> prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
> --
> 2.26.2
>
