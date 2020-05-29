Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E100C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C55F207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763188;
	bh=exjd1DeyzZL/6POk5choc9MsqHwYdc70Ebbvb45qc0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oB2ozg9v+YRjxl2L3kXZ9AQxM5304HjuM+jGyzUKNUlFFdFUkikndUgypJp+31l7i
	 Ec74P/XVGei9TOZxaHeHbC/9nhUWYIVs2W2TqDgYRBsf9Vok5QYvWb8AWS/gnSYDsn
	 y3KdsG3nFShcMmnpNdh4z0o/zwd7SQNlx+EkaV4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgE2Ojr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgE2Ojr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:39:47 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2F92072D;
        Fri, 29 May 2020 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763186;
        bh=exjd1DeyzZL/6POk5choc9MsqHwYdc70Ebbvb45qc0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2oTwMO6rScF7H52nQIEMI42Wx7JqOuvRaw1hCjZLtmSTJNLQ/kZrTixH/k7lRXc6
         nDu8l4Y3sgH2uVkqyRASqN4yVOVHHeo4eljLRaTMOoNnZEYn2FXcXPTJSj/gvj2ExB
         /YIFJpB4Onh46sTilEGRHZxYp00zat2C7mk9bWwg=
Date:   Fri, 29 May 2020 23:39:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 0/4] selftests, sysctl, lib: Fix prime_numbers and
 sysctl test to run
Message-Id: <20200529233942.a47bbd8e918175e9af3fefab@kernel.org>
In-Reply-To: <218210da-7d06-5b6e-13af-13a07e8e7064@linuxfoundation.org>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
        <218210da-7d06-5b6e-13af-13a07e8e7064@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 08:14:39 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/28/20 8:51 AM, Masami Hiramatsu wrote:
> > Hi,
> > 
> > Recently, I found some tests were always skipped.
> > Here is a series of patches to fix those issues.
> > 
> > The prime_numbers test is skipped in some cases because
> > prime_numbers.ko is not always compiled.
> > Since the CONFIG_PRIME_NUMBERS is not independently
> > configurable item (it has no title and help), it is enabled
> > only if other configs (DRM_DEBUG_SELFTEST etc.) select it.
> > 
> > To fix this issue, I added a title and help for
> > CONFIG_PRIME_NUMBERS.
> > 
> > The sysctl test is skipped because
> >   - selftests/sysctl/config requires CONFIG_TEST_SYSCTL=y. But
> >     since lib/test_sysctl.c doesn't use module_init(), the
> >     test_syscall is not listed under /sys/module/ and the
> >     test script gives up.
> >   - Even if we make CONFIG_TEST_SYSCTL=m, the test script checks
> >     /sys/modules/test_sysctl before loading module and gives up.
> >   - Ayway, since the test module introduces useless sysctl
> >     interface to the kernel, it would better be a module.
> > 
> > This series includes fixes for above 3 points.
> >   - Fix lib/test_sysctl.c to use module_init()
> >   - Fix tools/testing/selftests/sysctl/sysctl.sh to try to load
> >     test module if it is not loaded (nor embedded).
> >   - Fix tools/testing/selftests/sysctl/config to require
> >     CONFIG_TEST_SYSCTL=m, not y.
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (4):
> >        lib: Make prime number generator independently selectable
> >        lib: Make test_sysctl initialized as module
> >        selftests/sysctl: Fix to load test_sysctl module
> >        selftests/sysctl: Make sysctl test driver as a module
> > 
> > 
> >   lib/math/Kconfig                         |    7 ++++++-
> >   lib/test_sysctl.c                        |    2 +-
> >   tools/testing/selftests/sysctl/config    |    2 +-
> >   tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
> >   4 files changed, 10 insertions(+), 14 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> > 
> 
> Thanks Masami. I see Kees reviewing patches. I will wait for Luis to
> weigh in on patch 2 before pulling this series in.

OK, Thanks Shuah! 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
