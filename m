Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE1BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43419207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJecqVZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHSVOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgHSVOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:14:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542AAC061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:14:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g15so9685plj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+umGhDcbGIZE1xFjxqU0bxabGlCttQLBQ+Y53ytOqC0=;
        b=KJecqVZ9hLXEAzJJNx3+s6VztJjf7IdAGVe1xvxkaR3MIOOrRYV+x5q4PkAmG97E47
         c9AfgbCo5kEgRCZ8hdbUxNjLSW4rUHKYJHgBYeI3No9tx1HVqRlWqvIUn26TUA+AX14V
         oI6hp4R03d/+IOM+djlJ6fbgWl+wRl5B/Ynr1CRdTtUZSJ7mP1IA3WAWXKZbcoVTHxky
         HJaON41XS9BzhwFiIwRDESb3MP5Zr4dLmn8S7gctlrq5qeF7GH/LTAl44vjXwKCSwhDZ
         tdBh+2voGT5VV/9cixVn2JjqYAj65P2LXuMvq6ETnzRPAreAd+K1RuNRDQZm6Ax6r9/r
         2LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+umGhDcbGIZE1xFjxqU0bxabGlCttQLBQ+Y53ytOqC0=;
        b=gtCCA2TKHsdwgLuKGPLcgmqWq24LsRyQHbaEQFEVYwReMaVocsgeFECmfe0+MtqUPy
         j1zoIQRinNe8+IB5RCUfDhRLpGXvIcs/kbnvG87KDTdJx/7yyq27+Xo2ewqozDixiQqK
         9RlQgYCYVa/p+yMqA8JW9nHCScmwvSUV9tfhpj1cXDWpXcoHZV1coMFtRkOkw4+TuWhf
         SUl39zz95ypmdkRFYL06P1eujkAt+D1m+zZ5+r8U5A5BAPQCrAWgQPYCnkCoVPSj8Byh
         FqmEcy7b1GdCt4r1TYvSfhk5x1eiRlo3YcTisaXw9QQyvuK9fFLtUOjfpr2flUqve94V
         Q5zg==
X-Gm-Message-State: AOAM532ycjB81T5DM5PbU85tuehNkQ8yGcW/velSD0f6rjc3JrCEBpOJ
        D27iQQ+33mSdRbOjlvKEQ2F6LOXwiKpaddJ8lQIjhA==
X-Google-Smtp-Source: ABdhPJxD98fjtFT8GxHwT05Ahp/1ulXZG6efUm0uXvNqB6cqEVXrUsqo9M64hDCvdg13zcl6KOod3fU3jP+YqsQ4JBs=
X-Received: by 2002:a17:90a:4603:: with SMTP id w3mr1306384pjg.20.1597871693322;
 Wed, 19 Aug 2020 14:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200729192357.477350-1-vitor@massaru.org>
In-Reply-To: <20200729192357.477350-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:14:42 -0700
Message-ID: <CAFd5g45rRMDD8=wQOzh+cGHEM4WJ=4vSu44W+4yPCFNFM2SB9A@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add list_sort test conversion to KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, elfring@users.sourceforge.net,
        mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:24 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_list_sort,
> from `lib/test_list_sort.c` to KUnit tests.
>
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Code Style Documentation: [0]
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

It would still be good to get some of the original authors/reviewers
to review this.
