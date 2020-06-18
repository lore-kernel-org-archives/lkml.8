Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384F9207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDbK89/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgFRU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgFRU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:29:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17BFC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:29:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so3058502pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/hCpa4EUzmgzyQWCDiDnoXra6cXP6DdcXvsMo077Gs=;
        b=RDbK89/DJFlPYBLi55AUzHik7hIPiAtrhNB3Qa2pdC8sq3oAKuRj+VhPo1gjJBe1GN
         pIusZmQqosz28RAPNaShZUmvRSvTZ4EzkJRinInfNnyR2OhGWhAIW7UagQLSbf8lTAKN
         KmPwknx0k7749KSqeRDXxoQZoh9ar4v/7B03lx02PuZFdeTdROniKhr+wLSEjik/enwI
         ihdjQVuWtYdfF+yQTXSerlGuocHTzvCp4gXjS8YmZne6mTxZIOWtwUp4HhH76bM5g8pQ
         /zR0EgeK5AgsprFpSFT4Wne7/sUVbgYXMvlO//r2X8YcgZr2pMj/0qoxF7dgOlNjLPZm
         b+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/hCpa4EUzmgzyQWCDiDnoXra6cXP6DdcXvsMo077Gs=;
        b=jR8WABKcuLQ0AyvIHXSGRNO8CqaT8yp2TYAkL5ij44m6I1Mm0Zdvow0jvCUB8e9rl8
         KUFwOLvP3CTsnfnZqZVpys2CKYmh6aDR/t6B6l15mB2Zk56FT4tMrYRKIoxtgZTc+r35
         nK1sPZPjTh5bbjf18ynAay2CSa6MWVaCkAUQWZUyZI1vFA6KrI21f0xcK3A5VkXvCmpV
         zi9WR3A/o3aVr2Mcyh6MdYRbk0stsiDsjXNZcTnWW4GE+tK53yr84cMKhhsT6nYm/0Uz
         tXtal4e0ax+sERPMONKdZ4Z2uoXodhfnjzxZI5j3aSiZM7B1i+cyYc0+n+lPwMZsJiJa
         G0xg==
X-Gm-Message-State: AOAM530vSdZF1s6Xkii4UYdW3UF92B4nAE2tFVaQIzWZfCeDefIi7ZUf
        xMb9MzRg73LfnnDAbwj3MPc0HaiIXuZLIQqjWBtK/A==
X-Google-Smtp-Source: ABdhPJzxU3pY06CWSm4LO7FME2n4fLBB6pVcJXHzNqN2LnUXllGbawGj0C6+Ydhb05A/tvBLq04fczMZ38da+qd63co=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr74335pjv.217.1592512197024;
 Thu, 18 Jun 2020 13:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200618035736.245566-1-vitor@massaru.org>
In-Reply-To: <20200618035736.245566-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jun 2020 13:29:46 -0700
Message-ID: <CAFd5g45AB8K-p78GRmauRPbkXLU572D2tuMTc0pumL+EgDA52Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix KconfigParseError by ignoring CC_VERSION_TEXT
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:57 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
> is updated") added the environment variable CC_VERSION_TEXT,
> parse_from_string() doesn't expect a string and this causes the
> failure below:
>
> [iha@bbking linux]$ tools/testing/kunit/kunit.py run --timeout=60
> [00:20:12] Configuring KUnit Kernel ...
> Generating .config ...
> Traceback (most recent call last):
>   File "tools/testing/kunit/kunit.py", line 347, in <module>
>     main(sys.argv[1:])
>   File "tools/testing/kunit/kunit.py", line 257, in main
>     result = run_tests(linux, request)
>   File "tools/testing/kunit/kunit.py", line 134, in run_tests
>     config_result = config_tests(linux, config_request)
>   File "tools/testing/kunit/kunit.py", line 64, in config_tests
>     success = linux.build_reconfig(request.build_dir, request.make_options)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 161, in build_reconfig
>     return self.build_config(build_dir, make_options)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 145, in build_config
>     return self.validate_config(build_dir)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 124, in validate_config
>     validated_kconfig.read_from_file(kconfig_path)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 89, in read_from_file
>     self.parse_from_string(f.read())
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 85, in parse_from_string
>     raise KconfigParseError('Failed to parse: ' + line)
> kunit_config.KconfigParseError: Failed to parse: CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"

I am pretty there is already a fix out for this issue:

https://patchwork.kernel.org/patch/11592313/

Can you confirm?
