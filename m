Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC7C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E163120732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jA2Um2bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgBZStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:49:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36834 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgBZStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:49:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so106756pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UE7SLV8s468yZbq8qcSb4sRo6dYTH3lmVINJK2pF/Rc=;
        b=jA2Um2bnLQg3BAkezzgjpMtGTg858Rxq4CJkWx4LfvljkkqPbfDzwR3l96lR+/xhJB
         VQkuio7/ZKPo9ZxiSc0BWA53DDAaxEC4Kig/1/MAwMPzTkxW0LsjsO9qRUWAG3+LwdxJ
         bBcXP/Qq5cZkrwppbFNmSDm9gDmJqMY2Rb5Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UE7SLV8s468yZbq8qcSb4sRo6dYTH3lmVINJK2pF/Rc=;
        b=mXSrFs8mnFWvO2cNFkaGZOpIKc9rcKzbmnZWIDn7aM6fqI4rPbSTWx5m+zstiGvS+X
         Hbzz4OJYTpPPB6PHoktMZe3Eju+1XX+8kjZ7O2qD8DShvr5UzAFtiVQmKxVN8YFQQfwd
         jkser9Cp1i0H8qCRudeDOMTboxmuJyRKHgxfBlmI+lEh5ublXpToQDabG6ykYDih5rzW
         Fn+kQ1QFpObAnvet8a0figKzvK/mVy8s9Urte453EmH8gs+U7NJl172yPIv683ykoynj
         ZZZEIdoi0Vp4b+QdKXV5NbNHcndaQ0noad/iRS3veyBQNFmuA0zUPBdF6dcMdofKz+WZ
         rgLQ==
X-Gm-Message-State: APjAAAWzNrMFff6WuHLiLCnHI6HAdOPCzfheegE6BHIkMLr7xMG6M3Gt
        w58nb9eoxE67etqz5h2zksQl5A==
X-Google-Smtp-Source: APXvYqxlTjlN/5RWPR7YFQfgZ7nC8YLL0uLCegeK1cb0d8ZefgQ7K7KigIJMn16KLKQbCje1JbcnoA==
X-Received: by 2002:a63:cc4c:: with SMTP id q12mr198639pgi.443.1582742970078;
        Wed, 26 Feb 2020 10:49:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k63sm3578966pjb.10.2020.02.26.10.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 10:49:29 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:49:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: selftests: Linux Kernel Dump Test Module output
Message-ID: <202002261048.E9417B65D@keescook>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
 <202002251131.3216B3B50C@keescook>
 <b485a8a9-5312-ca77-d091-3dbfac33ec5b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b485a8a9-5312-ca77-d091-3dbfac33ec5b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:53:37AM +0000, Cristian Marussi wrote:
> Sorry I lost track of this thread....tested now on v5.6rc3 on arm64 on a local
> setup (not proper CI) with CONFIG_LKDTM=y and solves the above issue. (missing CONFIG_LKDTM?)

Great!

> Looking at the general run though I have anyway a bunch of SKIP similar to Naresh
> 
> ./run_kselftest.sh 2>/dev/null | grep "SKIP"
> not ok 1 selftests: lkdtm: PANIC.sh # SKIP
> not ok 6 selftests: lkdtm: LOOP.sh # SKIP
> not ok 7 selftests: lkdtm: EXHAUST_STACK.sh # SKIP
> not ok 8 selftests: lkdtm: CORRUPT_STACK.sh # SKIP
> not ok 9 selftests: lkdtm: CORRUPT_STACK_STRONG.sh # SKIP
> not ok 15 selftests: lkdtm: UNSET_SMEP.sh # SKIP
> not ok 16 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP
> not ok 18 selftests: lkdtm: OVERWRITE_ALLOCATION.sh # SKIP
> not ok 19 selftests: lkdtm: WRITE_AFTER_FREE.sh # SKIP
> not ok 21 selftests: lkdtm: WRITE_BUDDY_AFTER_FREE.sh # SKIP
> not ok 26 selftests: lkdtm: SOFTLOCKUP.sh # SKIP
> not ok 27 selftests: lkdtm: HARDLOCKUP.sh # SKIP
> not ok 28 selftests: lkdtm: SPINLOCKUP.sh # SKIP
> not ok 29 selftests: lkdtm: HUNG_TASK.sh # SKIP
> not ok 59 selftests: lkdtm: REFCOUNT_TIMING.sh # SKIP
> not ok 60 selftests: lkdtm: ATOMIC_TIMING.sh # SKIP
> 
> BUT, if I look at one LKDTM test script
> (lkdtm/USERCOPY_STACK_FRAME_TO.sh):
> 
> ...
> # If the test is commented out, report a skip
> if echo "$test" | grep -q '^#' ; then
> ...
> 
> and in fact:
> 
> root@sqwt-ubuntu:/opt/ksft# cat lkdtm/tests.txt | grep ^#
> #PANIC
> #LOOP Hangs the system
> #EXHAUST_STACK Corrupts memory on failure
> #CORRUPT_STACK Crashes entire system on success
> #CORRUPT_STACK_STRONG Crashes entire system on success
> #OVERWRITE_ALLOCATION Corrupts memory on failure
> #WRITE_AFTER_FREE Corrupts memory on failure
> #WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
> #SOFTLOCKUP Hangs the system
> #HARDLOCKUP Hangs the system
> #SPINLOCKUP Hangs the system
> #HUNG_TASK Hangs the system
> #REFCOUNT_TIMING timing only
> #ATOMIC_TIMING timing only
> 
> so only two of the above tests are in fact unexpectedly skipped.

Yup, that is operating as expected. :)

> not ok 15 selftests: lkdtm: UNSET_SMEP.sh # SKIP
> not ok 16 selftests: lkdtm: DOUBLE_FAULT.sh # SKIP

These are x86-specific, so that is correct as well.

Thanks for following up!

-- 
Kees Cook
