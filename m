Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F72207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUQk5nqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgFRUbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgFRUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:31:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF21C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:31:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l24so3445353pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vYguTxknGE8Dx16795P40n1hyMI+4rqo7SoKdZ0n4M=;
        b=jUQk5nqzrPWoyZry6OFj3XXe2iWiykd0oEPPhNsYguTw0jHnq0ttSeXC05Jbcj+aKH
         i2w49bRIQ5UXe4x22BDcgWgjawQPc1s94rGXML4EP3kzY94O7KzGbJmSf8A849v/UXa2
         oRf+0BFrbHWIBtEoBJdAikbWPgiYzu90FKcXuNY+ZRcgFcx+Wm8Nv9EGxMtm1b0LKXn3
         G5kB8nhaWvIOWj9+7918MeRleRN0sfuG6FyMC3ZIONGqNxWyBXVUr67HqJ+qoafWkLB7
         hCFfMmFjlUt/CmROnI8YhwVwYsILkkIJmZo5/IDHjO4Rsp9jrOOJozHQ13XkS+gRKeeM
         4BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vYguTxknGE8Dx16795P40n1hyMI+4rqo7SoKdZ0n4M=;
        b=Xxr4zQwhMevbAjYDekthene5Ij0Q8apx7ZmDoup8B9rYL9iPnSUDV6jPwe5/G98j8D
         Zeu8SOo+kI6g8IRfh3dBnTqOJBFZT4tFgxPnSspCBAlAEWxHIJDvZyMezgaW+WqwOE9D
         knq9lzYX/ycscC5DNDhLf1EJ6xG4lm6DhRux1CzFvN7sMS5DXRQ20YO91oKIbqVCmq+O
         l5NtV/ShV3s0VJmgr3lFlp4A5fEEggOOKSFplmi1StHmIz62jbZQ4FHJslhgsKifuU1S
         Hq709TQYfuHH/y8DHEEk/AdOno0pXkqXS3RUvEFkISB8mpyklwO1wTe0baLBxWnxxCms
         060A==
X-Gm-Message-State: AOAM532HJrbckqDG8C5ByxwSBGW5HWFZhMVdWEthH1VG1IEDZuTbdodA
        KisczUn4+A2PsQGeLSrU7KGwbwa5Tsrac+x+tExrLA==
X-Google-Smtp-Source: ABdhPJyg7+/EsMv/uILhnCx33cvfvyj/A5rdmlcYEhM69bT4X7pfCnqfldKiOJpntTlq+2IKO59hml9kLz5hSl5KpGY=
X-Received: by 2002:aa7:868f:: with SMTP id d15mr5402182pfo.166.1592512294729;
 Thu, 18 Jun 2020 13:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200618123912.64762-1-vitor@massaru.org>
In-Reply-To: <20200618123912.64762-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jun 2020 13:31:23 -0700
Message-ID: <CAFd5g47tWA=yqa2zN8f6d=dKDhutU_Dr3JLjAdu8+wRFq9iOyg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix KconfigParseError handling CC_VERSION_TEXT
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

On Thu, Jun 18, 2020 at 5:39 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
> is updated") added the environment variable CC_VERSION_TEXT,
> parse_from_string() doesn't expect a string in value field and this
> causes the failure below:
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
