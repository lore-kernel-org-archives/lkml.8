Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B99C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E1120656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586878073;
	bh=5lYnj+272sKQvhI108Iv8oKwS0a0XnbkMZ6mg9B3LZc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lqJ9Ul1FCI7I7vtvGAnvB22UruVDLIFNUtHXT41jY7vHY5Ir3mK0Rqw/K49YdI+9o
	 ZW3fOIwpNehKegJVhAFCCFsEQrTH/hFat9IiZ7I3kpt7cZB+jUWiS3Dydzbq4CvDIl
	 I00CVBZg7DbRNw+o6fFD7XSKWYX3ScIrMBN8/fZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439897AbgDNP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbgDNP1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:27:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9EC20656;
        Tue, 14 Apr 2020 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878038;
        bh=5lYnj+272sKQvhI108Iv8oKwS0a0XnbkMZ6mg9B3LZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h6SQjpIDC3OrPSsz6BKe9szCjfpFud0gMGAUL3NugjHfdmf8+jb4nDqMVZcl417t3
         6lAPLrjYGYhnxo6NLE0q7fwBc7FH+ETMxvkSny+g3SraGSsOt4XgGuTc/LbEHqavAc
         1WeAUKMRgbtxDg18+voqyLKgXc8LOzi7NrPqKd5E=
Subject: Re: [PATCH] selftest: add a script to perform selftest compile tests
To:     Tim Bird <tim@bird.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        tbird20d@gmail.com, tim.bird@sony.com, shuah <shuah@kernel.org>
References: <86508e9d-4aff-d9a0-3783-971a4686ccd1@bird.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9c2a8679-eb90-8dd1-43f6-40ce0a842c87@kernel.org>
Date:   Tue, 14 Apr 2020 09:27:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <86508e9d-4aff-d9a0-3783-971a4686ccd1@bird.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 4:15 PM, Tim Bird wrote:
> From: Tim Bird <tim.bird@sony.com>
> 
> Add ksft-compile-test.sh.  This is a program used to test
> cross-compilation and installation of selftest tests.
> 
> See the test usage for help
> 
> This program currently tests 3 scenarios out of a larger matrix
> of possibly interesting scenarios.  For each scenario, it conducts
> multiple tests for correctness.  This version tests:
>   1) does the test compile

Is it necessary to write this long a script? Could we just parse
the "kselftest
>   2) is the kernel source directory clean after the compile

Can you use make mrproper and see if anything needs cleaning?

>   3) does the test install operation succeed
>   4) does the test run script reference the test
> 

I like the idea of being able to test, however I am not convinced
you would need a whole new script for it.


> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>   MAINTAINERS                                  |   6 +
>   tools/testing/selftests/ksft-compile-test.sh | 567 +++++++++++++++++++++++++++
>   2 files changed, 573 insertions(+)
>   create mode 100755 tools/testing/selftests/ksft-compile-test.sh
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1d18c..a6289c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9127,6 +9127,12 @@ S:	Maintained
>   F:	tools/testing/selftests/
>   F:	Documentation/dev-tools/kselftest*
>   
> +KERNEL SELFTEST SELFTEST
> +M:	Tim Bird <tim.bird@sony.com>
> +L:	linux-kselftest@vger.kernel.org
> +S:	Maintained
> +F:	tools/testing/selftests/ksft-compile-test.sh
> +

Please don't add another entry to the MAINTAINERS file just
for a shell script under tools/testing/selftests

This doesn't make sense.

>   KERNEL UNIT TESTING FRAMEWORK (KUnit)
>   M:	Brendan Higgins <brendanhiggins@google.com>
>   L:	linux-kselftest@vger.kernel.org
> diff --git a/tools/testing/selftests/ksft-compile-test.sh b/tools/testing/selftests/ksft-compile-test.sh
> new file mode 100755
> index 0000000..e36e858
> --- /dev/null
> +++ b/tools/testing/selftests/ksft-compile-test.sh
> @@ -0,0 +1,567 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only OR MIT
> +#
> +# ksft-compile-test.sh - test compiling Linux kernel selftests under lots of
> +#   different configurations.  This is used to check that cross-compilation
> +#   and install works properly for a newly submitted test target, and
> +#   also that changes to existing test Makefiles don't regress with regard to
> +#   this functionality.
> +#
> +# Copyright 2020 Sony Corporation
> +#
> +# Here are the things that Shuah Kahn asked for on 3/6/2020
> +# 1. Cross-compilation & relocatable build support
> +# 2. Generates objects in objdir/kselftest without cluttering main objdir
> +# 3. Leave source directory clean
> +# 4. Installs correctly in objdir/kselftest/kselftest_install and adds
> +#        itself to run_kselftest.sh script generated during install.
> +#

I was asking for fixes to individual tests.

> +# Would be nice to make sure other features also work:
> +# 5. can use absolute, relative, or current directory for output directory
> +# 6. can use ~ in output directory path
> +#

I do think this can be achieved with a simpler script wrapper around
existing commands and kselftest_install.sh instead of writing a whole
new shell script.

thanks,
-- Shuah

