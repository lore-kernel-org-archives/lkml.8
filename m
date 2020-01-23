Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C6FC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4164621569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9GWqrtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgAWWYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:24:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46973 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgAWWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:24:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so1942864pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcBMCg1xOzuuW9uSCm6RuBHipcVvLSbNOERfrixtjfw=;
        b=b9GWqrtrUDOalKZJ/E1LqNXVXf6S+C3hC+aj5zlQnpRC/VykOQvI6CgYh0W5RXWe73
         DI8bJcOKkAjNZZwfSb6sUzDd9fBl3tfbBxlaf7q+pBKLVrzXBY+pmvwnPV3LPiUihQQd
         gad7Vvuw2ffN76CvxqII8GsCkph5NyMhM09pEMN1xHbJbZypajrTiA77QKFbbo1x6LrF
         L6c3yZt7HZdr074aKVvFrLNR+ebebwOBDFIhf5lcDnp15TmRwNuoYheg1r7qNJozhi9s
         +aokUyit201tb1sNaPHQMJ+vC59rXe/8iHAMyZgfYbC49FMXMB7cd27Zwu72uG8ElIIU
         prig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcBMCg1xOzuuW9uSCm6RuBHipcVvLSbNOERfrixtjfw=;
        b=lt5qDernrFm/QE1gka98KzQpXinDri6nrGeD8zcSj/jZHiuhFLEc3iujIdUbLIMhm+
         PRwFws8Ly/VRnJPoE2M0eSqBnNEOUnCMl63cHrOadF3faux6xCGSES/u5t07RqDEry7H
         RyKBKpWarNJ5hazYsPjWpPA0GbEZVxww+LKdisK65ft4zPCcyp/qF2Nf3c6xXCXaJDXd
         ZlIOXeS+yg/MSzzjmdhK1DOZ/x6fSLTynt6+qaPPG5jwri2zCJeQdKbtXLhYyfdnP00w
         uuFiVXLvFUiPkdlD7Rw2y//2mzdDmsbSCrHeN1o4SrW2gyyIKS8zXrNUcXwXIXHlSKN0
         M+Ww==
X-Gm-Message-State: APjAAAXB1lHsI9j0wriL69GFs45HIN/8EQMCBPyFFWZzX5uJCVGXhNYU
        sRZaa1sKa2jAGhQ+VErPL36MwFRvaXKujtfXs0sWlQ==
X-Google-Smtp-Source: APXvYqyOdPd27zjDr3Vvl8XRq5nf81atIvFAmdGg2bQjCVdleFBwZLe2APzvrchex8IJ3RYFDXFYLbANxgczr1wT2uk=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr352820plm.232.1579818257575;
 Thu, 23 Jan 2020 14:24:17 -0800 (PST)
MIME-Version: 1.0
References: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:24:06 -0800
Message-ID: <CAFd5g46657gZ36PaP8Pi999hPPgBU2Kz94nrMspS-AzGwdBF+g@mail.gmail.com>
Subject: Re: [PATCH v2 kunit-next 0/3] kunit: add debugfs representation to
 show results/run tests
To:     Alan Maguire <alan.maguire@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Luis Chamberlain

On Thu, Jan 23, 2020 at 10:47 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> When kunit tests are run on native (i.e. non-UML) environments, the results
> of test execution are often intermixed with dmesg output.  This patch
> series attempts to solve this by providing a debugfs representation
> of the results of the last test run, available as
>
> /sys/kernel/debug/kunit/<testsuite>/results
>
> In addition, we provide a way to re-run the tests and show results via
>
> /sys/kernel/debug/kunit/<testsuite>/run

Ooo, cool! I like this! I was actually thinking about doing something
similar after talking to either Shuah, or Luis, so this is great! I
think Luis will be interested in this regardless so I cc'ed him.

> Changes since v1:
>  - trimmed unneeded include files in lib/kunit/debugfs.c (Greg)
>  - renamed global debugfs functions to be prefixed with kunit_ (Greg)
>  - removed error checking for debugfs operations (Greg)
>
> Alan Maguire (3):
>   kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
>   kunit: add "run" debugfs file to run suites, display results
>   kunit: update documentation to describe debugfs representation
>
>  Documentation/dev-tools/kunit/usage.rst |  19 +++++
>  include/kunit/test.h                    |  21 +++--
>  lib/kunit/Makefile                      |   3 +-
>  lib/kunit/debugfs.c                     | 137 ++++++++++++++++++++++++++++++++
>  lib/kunit/debugfs.h                     |  16 ++++
>  lib/kunit/test.c                        |  85 +++++++++++++++-----
>  6 files changed, 254 insertions(+), 27 deletions(-)
>  create mode 100644 lib/kunit/debugfs.c
>  create mode 100644 lib/kunit/debugfs.h
>
> --
> 1.8.3.1
>
