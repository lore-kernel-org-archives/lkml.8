Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C59AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084492073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpE2r+vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGXMQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGXMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:16:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EDDC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:16:08 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id by13so6852741edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQmFtuJe5LENQ2B3jTqn/jSNNBEi2iYDWcf7NH5+r5U=;
        b=TpE2r+vFS3rCB9H1sZG+fJSQmUAee2FajqnJg7koOLVzf0Y/XjeupwflCp2KrVPBtx
         FRXqA6Lm2Q8JMFrW1LJgh98ktHsnPxEQClt4HwnMVXj9VPs5anmbbvO0m63Z+AyQpS+N
         RbEUwTlgpneRbMl2AMfHjWhgIrBeef2opoQ85krl1YMaCrQtcLxLm0N+MOzIKJRdlqeY
         IZyogGSO7ZxPmMOUi66pa8fLkctT2SBZUowI3uGldXZtnl9+yEYXRY91rQ6NRsNeRoZw
         p2zoxFl/nJMsDzmptDhsQ1JwvLs86mO7BLxZ3xFb+pApUfAjTsG8DsI+hg6BBLp/xIkV
         vOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQmFtuJe5LENQ2B3jTqn/jSNNBEi2iYDWcf7NH5+r5U=;
        b=WJU+mNim5yfDzwfu5Jx4jynh98cfceVMJ/Tt1Ysukz9uAeVk2SnekYH5Xe4GMIPL81
         LOaNR1pXxAiHRWfOIiPhRMnfGp375fm3OTJXcbFem2NSbTIuU2fyLwjE8yauHSVbnyu1
         Qao34rkthJrgi2Kmb7wzS2e1J+Aaavs3XiZ5eFk0Tax7y0ZIR2YXtxzGVZx56F8hT72m
         olk5QeKIsp64lgl7qTKwiHiegCQ/Vi179ocfdrXt1qy67SsdFKCeLZDDjA2y0OwFpRtO
         b1iceyru8vT7qIYx4iziNGxYSiCrC4SAOdf9Ac/HW8+ghnq6l2Q1TgBcLrmhJOodYqr9
         zOFA==
X-Gm-Message-State: AOAM532EfcyGVOoTc/hv0JjxFAY8qUNHFBY0evlZNGKVqPV/nO05J+bC
        dRz13Y7nBXGLSDaLwg2STR0=
X-Google-Smtp-Source: ABdhPJy/4jhe4ZKpESOqVzcl/bx6U9ICFKOBKjqt2GMpU0dMQosOjRhGxoPlkq8/j4TY+mtrVqaaYw==
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr8837243eds.370.1595592967334;
        Fri, 24 Jul 2020 05:16:07 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id a1sm551437ejk.125.2020.07.24.05.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 05:16:06 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] seccomp.2: Improve x32 and nr truncation notes
To:     Andy Lutomirski <luto@kernel.org>
References: <4c7e1cfa3978de83713b71a3f29c8c5f250cf0c6.1594404029.git.luto@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <96fe5db6-2b94-f77e-50d1-75d967a95080@gmail.com>
Date:   Fri, 24 Jul 2020 14:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4c7e1cfa3978de83713b71a3f29c8c5f250cf0c6.1594404029.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 7/10/20 8:04 PM, Andy Lutomirski wrote:
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  man2/seccomp.2 | 44 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)

Thanks. Patch applied.

Cheers,

Michael

> diff --git a/man2/seccomp.2 b/man2/seccomp.2
> index a1b1a28db9bf..e491825600e8 100644
> --- a/man2/seccomp.2
> +++ b/man2/seccomp.2
> @@ -342,16 +342,38 @@ is used on the system call number to tell the two ABIs apart.
>  .\"     an extra instruction in system_call to mask off the extra bit,
>  .\"     so that the syscall table indexing still works.
>  .PP
> -This means that in order to create a seccomp-based
> -deny-list for system calls performed through the x86-64 ABI,
> -it is necessary to not only check that
> -.IR arch
> -equals
> -.BR AUDIT_ARCH_X86_64 ,
> -but also to explicitly reject all system calls that contain
> +This means that a policy must either deny all syscalls with
>  .BR __X32_SYSCALL_BIT
> -in
> -.IR nr .
> +or it must recognize syscalls with and without
> +.BR __X32_SYSCALL_BIT
> +set.  A list of syscalls to be denied based on
> +.IR nr
> +that does not also contain
> +.IR nr
> +values with
> +.BR __X32_SYSCALL_BIT
> +set can be bypassed by a malicious program that sets
> +.BR __X32_SYSCALL_BIT .
> +.PP
> +Additionally, kernels prior to 5.4 incorrectly permitted
> +.IR nr
> +in the ranges 512-547 as well as the corresponding non-x32 syscalls ored
> +with
> +.BR __X32_SYSCALL_BIT .
> +For example,
> +.IR nr
> +== 521 and
> +.IR nr
> +== (101 |
> +.BR __X32_SYSCALL_BIT )
> +would result in invocations of
> +.BR ptrace (2)
> +with potentially confused x32-vs-x86_64 semantics in the kernel.
> +Policies intended to work on kernels before 5.4 must ensure that they
> +deny or otherwise correctly handle these system calls.  On kernels
> +5.4 and newer, such system calls will return -ENOSYS without doing
> +anything.
> +.\" commit 6365b842aae4490ebfafadfc6bb27a6d3cc54757
>  .PP
>  The
>  .I instruction_pointer
> @@ -368,8 +390,8 @@ and
>  system calls to prevent the program from subverting such checks.)
>  .PP
>  When checking values from
> -.IR args
> -against a deny-list, keep in mind that arguments are often
> +.IR args,
> +keep in mind that arguments are often
>  silently truncated before being processed, but after the seccomp check.
>  For example, this happens if the i386 ABI is used on an
>  x86-64 kernel: although the kernel will normally not look beyond
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
