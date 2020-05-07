Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15BFC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC69207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbtQf4Gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEGDRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgEGDRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:17:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3474FC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 20:17:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so4514349wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqklJJgxCrgioUG9/0U8VvVyNxzQPptp+H1kEoRUcfM=;
        b=rbtQf4Gr1SzoNJgT+TsCpnOedFkDlsI4GqX3HIApmxx6nalsQhD7JafeN3haqKF95q
         9FLfc0iLXRofGuj8xSvJr9fCGoEGljqW0AfmoM25AwFBMv01MhzQk74GjUBq8Hxt5HTu
         kF5LrtH67fdEpmW13BDlx/xM9q8ZC1pdAFNdCTsjb3r/+IQquQw3L1Mhmz5wPihbB8Oa
         RKcHl2HZ6Swg7Mv+wXEaoj0P119W8tJ06Y6nXdXSmuhhAUF7MuBwIDsA9MO0zAZToS3O
         JlWjOp3xPxrOLSgeM67Dve9aoviCMexgO0SwIEfM1UZpJ+jUSpQTzPg7wLqjsFeT0/pd
         XxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqklJJgxCrgioUG9/0U8VvVyNxzQPptp+H1kEoRUcfM=;
        b=Wq1mHhPds+wlKd/MJ9+iyjUELiUn8DEw5YAEOmyMEgMIgipQUpzK55SG4PolqDM9bO
         2mM3l99YukS2wRm/xow1OJSvRgqn0htMBwFK8rzBbrp/XwuUSBZE3yL97YcIjzFsQSYf
         3QsQld+MNL3xttwf95kYhxkRxhvaXvn1cNJ2I4p7W2f35cGci8aEXLf2RwkwlISuwuHV
         2e2GGW2NGLfTWFu1+1QJxPs5u5/5gH5X3npCjGyNrhOb5VgEXHORWa28s3vHn7uSKmvC
         h4W2p/dgJBqIIXWwDu2uGqWNsyGj23t38nngOsGFNJLNg4Mzr5TCuaPPC+3SURhd+BcA
         jwVg==
X-Gm-Message-State: AGi0PuaunB1ifyoReFvoa4P42xtw7Qjpuck2df3xJaZzVj4KDnrC0NnL
        YepVDEOoTrGsuInlNzfl69IC7QUgntAPVzLhxNf/sw==
X-Google-Smtp-Source: APiQypJ1wFSkBS5disj8Gxzhwhmj5hTspeDumfe4/uryjgVRkTODm3WVF6Mgksw5Lpz+kSadGCmEn0hnihhQMkh9SPY=
X-Received: by 2002:adf:f907:: with SMTP id b7mr12664785wrr.203.1588821425549;
 Wed, 06 May 2020 20:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102709.7964-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102709.7964-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:16:54 +0800
Message-ID: <CABVgOS=Qybfh_oMGmCONUWqZ3FRcKrwPU1pooSv1SsFumaCFjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kunit: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> This makes it easier to enable all KUnit fragments.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.

nit: Should this be "turned off" rather than "turned of" (and
"individual tests" rather than "individual test").
It _may_ be worth re-wording it to explain the "if !KUNIT_RUN_ALL"
change in more detail: that it's explicitly hiding the prompt if
KUNIT_RUN_ALL is enabled.
It's probably not worth redoing the patch just for this, but if you've
got to re-do all these to change KUNIT_RUN_ALL to KUNIT_ALL_TESTS or
similar, maybe.

>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/Kconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 537f37bc8400..e6a60391fa6b 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -15,7 +15,8 @@ menuconfig KUNIT
>  if KUNIT
>
>  config KUNIT_DEBUGFS
> -       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> +       bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enable debugfs representation for kunit.  Currently this consists
>           of /sys/kernel/debug/kunit/<test_suite>/results files for each
> @@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
>           run that occurred.
>
>  config KUNIT_TEST
> -       tristate "KUnit test for KUnit"
> +       tristate "KUnit test for KUnit" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enables the unit tests for the KUnit test framework. These tests test
>           the KUnit test framework itself; the tests are both written using
> @@ -32,7 +34,8 @@ config KUNIT_TEST
>           expected.
>
>  config KUNIT_EXAMPLE_TEST
> -       tristate "Example test for KUnit"
> +       tristate "Example test for KUnit" if !KUNIT_RUN_ALL
> +       default KUNIT_RUN_ALL
>         help
>           Enables an example unit test that illustrates some of the basic
>           features of KUnit. This test only exists to help new users understand
> --
> 2.20.1
>
