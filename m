Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B2C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3423A2088E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RfXmPGTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgGEFq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 01:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGEFq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 01:46:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25545C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:46:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m9so5371645pfh.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2a5PLdldX+tMxKx3O4LIv9xtAhMAmYRl6zJFR/hXiA=;
        b=RfXmPGTto0Gz+MbvGo1QMO6md2BCUQfRW1QqjLWmCbGgpWhv+ZjlhVMZhByyZ81nCy
         yJEuOCfrQd1bVCiwemfHjqROV85NLuWzERnY/7MDfjpl9aHezsWWv0QcqSlKhSSlBftW
         6ywG3JjDEuoLx9YNUQFFYdIEENn7bAlblo42A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2a5PLdldX+tMxKx3O4LIv9xtAhMAmYRl6zJFR/hXiA=;
        b=qOpCe0g/Gnu5ZVJp37JEWrh1vT0GH9QN5de8/wzemSPT7reC5HHxZaMNThvDRlGsQm
         foc67sUDUnazMAcCzuYVTIuKE5DNLeBmXe/U+NoaglxVj/z3OJ9hLch/2S6JhfJt9zxX
         gQxOOjKn6N90mLyitU5qvQfFKxM35reUwmVwVn7NJ9i41AFwtILhb7QJbLT+J2IAGE3r
         rojm6wfB2rii7wH+7bgfCHdhzfcq3c/lGR+0huS/kdN1+mnoWUrCjBr+ss/9u1HgDENt
         7AJJmYX+gN+WTgcxupEnXzWqO13KKo0icWF6AvWmWi49gfVpPzLZrIa1wxYB7Lwy5U3R
         P27w==
X-Gm-Message-State: AOAM532pb63sJs9XDQiLx3dHuDSulTR8RQF66WiA/oW746/ked4SZRy7
        8BMO8l/INuNcyoBL2nORENaXJw==
X-Google-Smtp-Source: ABdhPJxLxBTBtwYIHio0yADOjvtvwnRBa62ORSVaTpJlmeQsJN600nicdVw6a1IlkKRlRiQpgmTtGA==
X-Received: by 2002:aa7:9d9a:: with SMTP id f26mr7487491pfq.26.1593927987520;
        Sat, 04 Jul 2020 22:46:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j3sm4663264pfe.102.2020.07.04.22.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 22:46:26 -0700 (PDT)
Date:   Sat, 4 Jul 2020 22:46:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] selftests/harness: Switch to TAP output
Message-ID: <202007042245.BCC693126@keescook>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:16:43AM -0700, Kees Cook wrote:
> Hi,
> 
> v2:
> - switch harness from XFAIL to SKIP
> - pass skip reason from test into TAP output
> - add acks/reviews
> v1: https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/
> 
> 
> I finally got around to converting the kselftest_harness.h API to actually
> use the kselftest.h API so all the tools using it can actually report
> TAP correctly. As part of this, there are a bunch of related cleanups,
> API updates, and additions.

Friendly ping -- I'd love to get this landed for -next, it makes doing
seccomp testing much nicer. :)

Thanks!

-Kees

> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (8):
>   selftests/clone3: Reorder reporting output
>   selftests: Remove unneeded selftest API headers
>   selftests/binderfs: Fix harness API usage
>   selftests: Add header documentation and helpers
>   selftests/harness: Switch to TAP output
>   selftests/harness: Refactor XFAIL into SKIP
>   selftests/harness: Display signed values correctly
>   selftests/harness: Report skip reason
> 
>  tools/testing/selftests/clone3/clone3.c       |   2 +-
>  .../selftests/clone3/clone3_clear_sighand.c   |   3 +-
>  .../testing/selftests/clone3/clone3_set_tid.c |   2 +-
>  .../filesystems/binderfs/binderfs_test.c      | 284 +++++++++---------
>  tools/testing/selftests/kselftest.h           |  78 ++++-
>  tools/testing/selftests/kselftest_harness.h   | 169 ++++++++---
>  .../pid_namespace/regression_enomem.c         |   1 -
>  .../selftests/pidfd/pidfd_getfd_test.c        |   1 -
>  .../selftests/pidfd/pidfd_setns_test.c        |   1 -
>  tools/testing/selftests/seccomp/seccomp_bpf.c |   8 +-
>  .../selftests/uevent/uevent_filtering.c       |   1 -
>  11 files changed, 356 insertions(+), 194 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Kees Cook
