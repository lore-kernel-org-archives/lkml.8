Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C8C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB015206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNmL09Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbgDBKeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:34:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42928 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbgDBKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:34:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id 139so3307342qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEP3RMsbwsrI38M6GC4MFJAeeR3HIT91ewh4ArtAzP0=;
        b=wNmL09WqNAJCq/Zh7CB+zsPu6hCH6lwgl7TSW86QaaVtklcYMl0UFCOGoLO4c/O+E8
         48ruYKc3EMXGfuats9p8cObcwf8+STLBDY2OW6ElsvqAvPnPUmePoTj81Lgbs/UIXIyA
         Ej1wBVNPDC+vArdrWOzb1h7S6DhdVhM+um57UZ5SUVzjIYnnEJyn8cJ7yBCpxVV+4lQW
         OpZEgAaqLZAJq+MJTZMVOunJlAB5b24LUqtA8Gbze2TCVXVYF7tpfwWFNIVtSzPfWQKx
         4xnPB2QxUGCgvYMCZv/SHHrk3WkRiWWRiJeEUD7ngt1NQc/O5Ddsy1HqozmlCISuNG0S
         V7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEP3RMsbwsrI38M6GC4MFJAeeR3HIT91ewh4ArtAzP0=;
        b=PNOcl88eMewPZYsWtY0NFTpm0y6D7ZY+bx6Ei3bGyHkWi+ho9hW733xv044os6vlow
         /UFU4OS4yavZFVav3CSKozxZmDSXMRgX34h5o4FxxEh1s1HVIUEVO0K6FoE0vJBnfgkg
         JLoHLwd6fGV/FdpDy/GouUbAG1qRFWxkHQVsy13INakGfkw4qyumY3FGkWUM2LqtSaWB
         D6EmeU3jwbDrivxDiCR+B/Hg8sXeum1iCee1w3qik+MB4ZHCqT9WXVrhBRRXSCbEgqZ0
         tdT1ZpbQE0yyxk84rWQRUq9enicEPiUZM7WI72XnnrOcqL8lR66ExeApHADy9RW4BBq5
         V2jA==
X-Gm-Message-State: AGi0PuYKGRGIhIGavrVqK0ghxZVfaU0U8eXIDvRpYu64w2lT31nMk/oF
        BTf4JScUgxwX2EecGylcGfVIcFoJ9Q7QkWYrw9u9QQ==
X-Google-Smtp-Source: APiQypIOWiL9o+vRtZcgU4CkXRpytuU3rlYSZ7U093Yf4i6Z+QL4DvnkmoljSMw2R7FPJC+7DGue8ruoNLwJ0szuoOA=
X-Received: by 2002:a05:620a:348:: with SMTP id t8mr2337035qkm.407.1585823657756;
 Thu, 02 Apr 2020 03:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com> <20200401180907.202604-3-trishalfonso@google.com>
In-Reply-To: <20200401180907.202604-3-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Apr 2020 12:34:05 +0200
Message-ID: <CACT4Y+a6ijfY9styijimkxw2dd7xXTobw1vbj2kY_=GjhiUOZA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] KASAN: Testing Documentation
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 8:09 PM Patricia Alfonso <trishalfonso@google.com> wrote:
>
> Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
> CONFIG_TEST_KASAN_USER.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..287ba063d9f6 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
>
>  This allows ``VMAP_STACK`` support on x86, and can simplify support of
>  architectures that do not have a fixed module region.
> +
> +CONFIG_TEST_KASAN & CONFIG_TEST_KASAN_USER
> +-------------------------------------------
> +
> +``CONFIG_TEST_KASAN`` utilizes the KUnit Test Framework for testing.
> +This means each test focuses on a small unit of functionality and
> +there are a few ways these tests can be run.
> +
> +Each test will print the KASAN report if an error is detected and then
> +print the number of the test and the status of the test:
> +
> +pass::
> +
> +        ok 28 - kmalloc_double_kzfree
> +or, if kmalloc failed::
> +
> +        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
> +        Expected ptr is not null, but is
> +        not ok 4 - kmalloc_large_oob_right
> +or, if a KASAN report was expected, but not found::
> +
> +        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
> +        Expected kasan_data->report_expected == kasan_data->report_found, but
> +        kasan_data->report_expected == 1
> +        kasan_data->report_found == 0
> +        not ok 28 - kmalloc_double_kzfree
> +
> +All test statuses are tracked as they run and an overall status will
> +be printed at the end::
> +
> +        ok 1 - kasan_kunit_test
> +
> +or::
> +
> +        not ok 1 - kasan_kunit_test
> +
> +(1) Loadable Module
> +~~~~~~~~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built as
> +a loadable module and run on any architecture that supports KASAN
> +using something like insmod or modprobe.
> +
> +(2) Built-In
> +~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built-in
> +on any architecure that supports KASAN. These and any other KUnit
> +tests enabled will run and print the results at boot as a late-init
> +call.
> +
> +(3) Using kunit_tool
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN`` built-in, we can also
> +use kunit_tool to see the results of these along with other KUnit
> +tests in a more readable way. This will not print the KASAN reports
> +of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
> +information on kunit_tool.
> +
> +.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> +
> +``CONFIG_TEST_KASAN_USER`` is a set of KASAN tests that could not be
> +converted to KUnit. These tests can be run only as a module with
> +``CONFIG_TEST_KASAN_USER`` built as a loadable module and
> +``CONFIG_KASAN`` built-in. The type of error expected and the
> +function being run is printed before the expression expected to give
> +an error. Then the error is printed, if found, and that test
> +should be interpretted to pass only if the error was the one expected
> +by the test.
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
