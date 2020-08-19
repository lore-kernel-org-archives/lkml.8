Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD5FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02317204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ/fSMj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHSVKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHSVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:10:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3319C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:10:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so8672pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISHsgRR5gl1O/B06PdWuntMjm3+ExqlO30Mr+J1G2xE=;
        b=PQ/fSMj0XrmkoZzKZR0CPMZehNvw/44Weg4jc42HK+CIyf5qjE1PYJfGFJVOPM81+V
         XdTT7clkmFaPSu7YXUD0ZrfauGexDDFjQjV2cRtF26zDONqog/mxRakacI8dVVzSozhX
         xMfKADktTXL/7dktq6oytc9ioxlRzGZozrNUm+Ay1xRnBee+78WPtV2QzQFd2S4DmN31
         gPNqhIeFbPzbxsn9voCo03tsh1ZQl3mke4fF6i4t4CS62rSxrpLOZ/1RG4KnCAGFd0vG
         tkMLJgOofjISqXRv3MvFCFM48r5gZP80UDhEtmIk1N8a+SFWyIxnGU2SKV7aOrJW3+HL
         lPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISHsgRR5gl1O/B06PdWuntMjm3+ExqlO30Mr+J1G2xE=;
        b=aBSLpfLWmLx36e+MS9yg9SFykkIWdmDii58RayJdhCYO0TnEWpRz6rxjlWinnt2JS7
         K1XEWPKiFX4R8FNmrJa6T56zJVeBW1s/TdKJxFP09aL2zsnHR0TAFFiUFJHL0JBMb7Xk
         Y8di7dR2zoH9rw6fsPFMp7DvZ7KeIs9GSrbuVNDiLwvxpoxQzPdVndS7OyKLI+AbER/R
         RRY41i5MHg5BvCbp4yYfbKxGWl//T9m3/grtXClfnhZBp7rKkDZMT1YMXpD/e44OWu5u
         LrfCWHtcyeprwtKXS4rzxY3Fm1NGXkfjmBL0hGqp96vNVa6oyRPYp3McUvwcrUvSfScK
         +M5A==
X-Gm-Message-State: AOAM532EXHNDkxbZNh+UAIu7sQheDx3bGVrCzwi1STCHiJUrZbrpFwOn
        nXmUjmhFVNlIBu3WnLKMMUdVfqjM0CUp8LKs9z+HpQ==
X-Google-Smtp-Source: ABdhPJw3rds3hFHXZBmb2t1NM0mWnTXuiGc2v5dZ5hD8649AwV9NTlXL0gWQVpT+9K7Iz9ak0hBsrTEyeAh4Vu5T6LI=
X-Received: by 2002:a17:90a:d317:: with SMTP id p23mr3682356pju.217.1597871423161;
 Wed, 19 Aug 2020 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175849.148332-1-vitor@massaru.org>
In-Reply-To: <20200729175849.148332-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:10:11 -0700
Message-ID: <CAFd5g47s09BfsqNx2RY1Zdp-TC4KbKgsMgr9-SHv1Nf6P9vAMQ@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add bitfield test conversion to KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, kvalo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:58 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_bitfield,
> from `lib/test_bitfield.c` to KUnit tests.
>
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Code Style Documentation: [0]
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Probably still want a review from Johannes though.
