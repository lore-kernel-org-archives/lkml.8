Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3CC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3C206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlF7JCo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDUPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgDUPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:37:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6448C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:37:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e6so1488118pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvnUaepumbrX3tLwN7T+aV2zw9enslYEEKwoxp15Rbw=;
        b=VlF7JCo+pg6lkixAwHZhO5mSofYdutUMyuY/di4EA8M5drWY39LWPg7IPRo9iJZlYK
         xgCyAk2Rx6whnclxT4H6sXumN+FC6f4K1wejPs3i09hvt/pEBdC62m776LpdeWo148AC
         fZZKdgxoRyVZSBCKbfKIISoPMUsAzrUtCJfu4dR5/6m/mUTyQZvExCFMJlA1XhxKnFVB
         Rj9TZDid75U7muZmyaklevkrx7RjBlFKUSRt32U9IblhutLCLHwqpfdfBlPNYeLFiteO
         w6UEh/ny6Su1USgPxrynJ4CcYNLitw4zJP6OG2pMNyL9lC18UHm+QMft87+gsX/8u8ID
         Kl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvnUaepumbrX3tLwN7T+aV2zw9enslYEEKwoxp15Rbw=;
        b=OBKqprTIj8cZ33TzRuu1kXTF6UcNd00rypxAeeT/GsdWvgAHkTJQoV47yV04j5BGiW
         9M0VF47wJ4G+wSpmueaR+9z+dVLDSx6PHLqGCXNDdqEJI/HGj7bYoDp0nRhtSH+LYiDl
         6J6IwqA9hWsmCOyHo0WJ9xBKHiO8Vic+loja652VZYsgR8tR9CbymUVKbAicuyAXnHEA
         LCZydZqNuRLHLbqRHvjocDeVwAcWN8/VJ0OiNGBZCb4RT3uMW1YJsKs7w8kLxRc/Wcas
         zjdMkE6FvR7iBFfKkbYcX6AQvja40Cx/E2DdHfNCkMS+y3HmeQrRqn9XVPKtAd6MqjQc
         BVTQ==
X-Gm-Message-State: AGi0Pua7O5xPXr2c2mQasExseb9UbkebNMEzcrk5hPo5IVV4voYrCwWK
        OOdZYDCNl1SRtrRnoVyuE7iwvfmsrbrLwBfD4dgUfQ==
X-Google-Smtp-Source: APiQypL8NV5Stv4Tp37UrS0JSiyBP9L8NiZecBSv44W/NoAc9RSdkqgH+eSR15LF7zdwxQ/miIxk5rf4tZ3eABPM15U=
X-Received: by 2002:a17:90a:26a2:: with SMTP id m31mr6207645pje.128.1587483436814;
 Tue, 21 Apr 2020 08:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com> <20200418031833.234942-5-davidgow@google.com>
In-Reply-To: <20200418031833.234942-5-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 21 Apr 2020 17:37:05 +0200
Message-ID: <CAAeHK+yQqyw4GNTkk8eQMFU5baCmVQyQTrvSAk+zBNHDaJKwvQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] KASAN: Testing Documentation
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Sat, Apr 18, 2020 at 5:18 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
> CONFIG_TEST_KASAN_USER.

Hi David,

Please update commit message too.

Thanks!

>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..74fa6aa0f0df 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
>
>  This allows ``VMAP_STACK`` support on x86, and can simplify support of
>  architectures that do not have a fixed module region.
> +
> +CONFIG_TEST_KASAN_KUNIT & CONFIG_TEST_KASAN_MODULE
> +--------------------------------------------------
> +
> +``CONFIG_TEST_KASAN_KUNIT`` utilizes the KUnit Test Framework for testing.
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
> +With ``CONFIG_KUNIT`` enabled, ``CONFIG_TEST_KASAN_KUNIT`` can be built as
> +a loadable module and run on any architecture that supports KASAN
> +using something like insmod or modprobe.
> +
> +(2) Built-In
> +~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN_KUNIT`` can be built-in
> +on any architecure that supports KASAN. These and any other KUnit
> +tests enabled will run and print the results at boot as a late-init
> +call.
> +
> +(3) Using kunit_tool
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN`` built-in, we can also

CONFIG_TEST_KASAN_KUNIT here

> +use kunit_tool to see the results of these along with other KUnit
> +tests in a more readable way. This will not print the KASAN reports
> +of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
> +information on kunit_tool.
> +
> +.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> +
> +``CONFIG_TEST_KASAN_MODULE`` is a set of KASAN tests that could not be
> +converted to KUnit. These tests can be run only as a module with
> +``CONFIG_TEST_KASAN_MODULE`` built as a loadable module and
> +``CONFIG_KASAN`` built-in. The type of error expected and the
> +function being run is printed before the expression expected to give
> +an error. Then the error is printed, if found, and that test
> +should be interpretted to pass only if the error was the one expected
> +by the test.
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200418031833.234942-5-davidgow%40google.com.
