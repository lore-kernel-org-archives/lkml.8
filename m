Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CECC4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E149206E7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejxy5joI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgCNADV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:03:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32774 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCNADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:03:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay11so5085591plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1itqh9cc4kh0XmayEu5vKsKFU6ua5zUzS5gt0O5c6J0=;
        b=Ejxy5joItEd/+5sGbhoUHJ8XAwEfTSI0bZzwHp4wHGBwpcPPqqsq2++qFrDqLAae4Y
         /W9IRQZcLDhIDI+TQjMqPzbfsinuCNiEUL4GpZy/4PGlO8fDXkgiT+rh04nwySAdbgdD
         UkuZ36lP21XVB3QODVfE43DBWvuhyfVA7asrGUwYj903BZarex5nwAIQhJpkfLIvfzWy
         t3SalKNJlk+51HHfN66eQ+EZLU8qZwlsA6orv9aUKz37I8nxUf6H3rZnkdt+jQaZfApu
         rMg7cDdnoE9ABTQ5ljUQB6e9CrTE6NocR2mDp+nEByf2wn56bVP2rk+v/gX4ImpQVv+5
         +pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1itqh9cc4kh0XmayEu5vKsKFU6ua5zUzS5gt0O5c6J0=;
        b=fLDVfI0wP3no1w65gSy+EPfXh/Wx+PkWgBzGnRcBMRoYyjBFVzn7SLJb4QVBygTXll
         7cO7fvbH7sRcyeQ2ss0GUvavv2fJqplfBTQnGlt4DDp4XtqJCnGAQOWx9nDjNEcquYtZ
         isyHL9chLn5ykfOnmXvphW8TWipIuE5Zfahg3mkNrdqowbmEOn+qg0WTx7kTaE8QOrAc
         qp/FaE7VwK62QhLQG99RFN+yZiwqwYf9xbko4K10z4kDM0aAhiCrdy/wP2tFbOY9TbcE
         uLYJMXpfZsC0bbDrGUHK3Ta19nCdzNz0gOG8N5F33FWi3eaEXsJNJ/l59+87c8bO7+G6
         8+2Q==
X-Gm-Message-State: ANhLgQ2kSr01hEBG1jkkmDVTUCPKLkYBRq4CZHygy/ck9cxvtDEEH7UI
        Xhh6pg66ObXxErx0RP9XRtTm0NhJ0QWH199b6Js3rw==
X-Google-Smtp-Source: ADFU+vuB0Mxx+ltAIpT9/01uYB0ZCYPpx70ZsaVCPcTRWke0kPSN9SBNs7G9abQecMpMnU0d4AwlLZqMycCMSvs/j1k=
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr12903657pjq.47.1584144199202;
 Fri, 13 Mar 2020 17:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 13 Mar 2020 17:03:07 -0700
Message-ID: <CAFd5g44FvKCjj-qHCpkZhQEtWxgR7fA5qiNb_GN_YANuzsJM1w@mail.gmail.com>
Subject: Re: [PATCH v7 kunit-next 0/4] kunit: add debugfs representation to
 show results
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 7:44 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> When kunit tests are run on native (i.e. non-UML) environments, the results
> of test execution are often intermixed with dmesg output.  This patch
> series attempts to solve this by providing a debugfs representation
> of the results of the last test run, available as
>
> /sys/kernel/debug/kunit/<testsuite>/results
>
> Changes since v6:
>
> - fixed regexp parsing in kunit_parser.py to ensure test results are read
>   successfully with 4-space indentation (Brendan, patch 3)
>
> Changes since v5:
>
> - replaced undefined behaviour use of snprintf(buf, ..., buf) in
>   kunit_log() with a function to append string to existing log
>   (Frank, patch 1)
> - added clarification on log size limitations to documentation
>   (Frank, patch 4)
>
> Changes since v4:
>
> - added suite-level log expectations to kunit log test (Brendan, patch 2)
> - added log expectations (of it being NULL) for case where
>   CONFIG_KUNIT_DEBUGFS=n to kunit log test (patch 2)
> - added patch 3 which replaces subtest tab indentation with 4 space
>   indentation as per TAP 14 spec (Frank, patch 3)
>
> Changes since v3:
>
> - added CONFIG_KUNIT_DEBUGFS to support conditional compilation of debugfs
>   representation, including string logging (Frank, patch 1)
> - removed unneeded NULL check for test_case in
>   kunit_suite_for_each_test_case() (Frank, patch 1)
> - added kunit log test to verify logging multiple strings works
>   (Frank, patch 2)
> - rephrased description of results file (Frank, patch 3)
>
> Changes since v2:
>
> - updated kunit_status2str() to kunit_status_to_string() and made it
>   static inline in include/kunit/test.h (Brendan)
> - added log string to struct kunit_suite and kunit_case, with log
>   pointer in struct kunit pointing at the case log.  This allows us
>   to collect kunit_[err|info|warning]() messages at the same time
>   as we printk() them.  This solves for the most part the sharing
>   of log messages between test execution and debugfs since we
>   just print the suite log (which contains the test suite preamble)
>   and the individual test logs.  The only exception is the suite-level
>   status, which we cannot store in the suite log as it would mean
>   we'd print the suite and its status prior to the suite's results.
>   (Brendan, patch 1)
> - dropped debugfs-based kunit run patch for now so as not to cause
>   problems with tests currently under development (Brendan)
> - fixed doc issues with code block (Brendan, patch 3)
>
> Changes since v1:
>  - trimmed unneeded include files in lib/kunit/debugfs.c (Greg)
>  - renamed global debugfs functions to be prefixed with kunit_ (Greg)
>  - removed error checking for debugfs operations (Greg)

Everything looks good to me. I tried running kunit_tool and everything
looked good there well.
