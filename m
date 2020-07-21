Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FADC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13DA2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1xsv+Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbgGUXxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGUXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:53:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CEAC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:53:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so206778pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GAANOVEkg7Oss4DpDH0gr9ifNPUbhRTyDcGnsT2WTE=;
        b=p1xsv+JsYJXhYalj5ZZCc9wnW1uf56mVn0Gc1i+QWyJBhVm2oAo15ONIoGH5a++qc3
         nS8vtFYiWBbBZN/ZbGkIgOWNPX3q2HAp+ZRYAz0yz6yBgjgbaVNRv9jJYBy2nfqY++4s
         49RCXlqcN1Khtcr2FHPAlM6wIONJZ/uQkd34FX01Bue6DVy0I1d2B1vmNGTCO94yzDW+
         Fsd6zuBB7YB7X0nSbZNQjQSwkxI+h8rk5XJzp/8bgnBgal//1dKnFv7A0QGSbptnJ7tf
         1JcrpYnLejhIZ2RRFRpcz+Ki1fmJRs7nlyLeVDnnreujKpiOcnohfnZRviTLvcVEKJgB
         pezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GAANOVEkg7Oss4DpDH0gr9ifNPUbhRTyDcGnsT2WTE=;
        b=iLd9a1dCG64aKqdT/hTje8sBlO6hnpVvU69y624ssvgqCRbp0HP/xZhdDu/GvCHzPj
         CixPRUGx5/9d09dgUzBcAeNttnNXXNFy4L/NwCVzOKajF+oPElNwFaRYH9EiyrncgMPz
         qiRW5ZJ1FCX4rZK7ZFIuRA/ZBSMv7h5mhgrGL/Khoxd5ZEVFqP/4Qzgyy6Q86oikVvsV
         KRqFpP7dr4jnw3SP0Z15ukDZOVI0utgmW0d0itPatbWL9cAySFB8vcCjwxGBZNTmbEGc
         ym3gr7LzR9n0opbGSznzRdKR7Dl2FmAca8RxZQk+pcEANRO9fXM5I18FQloylIMXutQj
         T0ww==
X-Gm-Message-State: AOAM532dyAQjjkPJsMHfSs1r8ynt+aeEmPojCR02av4ZRaVWtRLiJff1
        gz7hIy8bZcCPKOhQZEARliqSX65XNBTQzPBtQS6YMQ==
X-Google-Smtp-Source: ABdhPJwlgYLxoZWZx8+svKNEBY0q6bxsav7DHLE6pxfIoOZcXdRkc72QEfSINPDlzRr5arUe6DKa0UAUjzPNjGbgJMA=
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr23017886plb.297.1595375582338;
 Tue, 21 Jul 2020 16:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174036.71072-1-vitor@massaru.org>
In-Reply-To: <20200721174036.71072-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 21 Jul 2020 16:52:51 -0700
Message-ID: <CAFd5g45DrBCA2Oq0RCb5FDWybt9NnXj=tN7pZFqjMLhuWWQoew@mail.gmail.com>
Subject: Re: [PATCH v3] lib: kunit: Provides a userspace memory context when
 tests are compiled as module
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:40 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> KUnit test cases run on kthreads, and kthreads don't have an
> adddress space (current->mm is NULL), but processes have mm.
>
> The purpose of this patch is to allow to borrow mm to KUnit kthread
> after userspace is brought up, because we know that there are processes
> running, at least the process that loaded the module to borrow mm.
>
> This allows, for example, tests such as user_copy_kunit, which uses
> vm_mmap, which needs current->mm.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Isn't this a dependency for the test_user_copy? Also, don't we also
need the change that makes kunit_tool build modules? It seems like you
should put these together in a patchset like you did before. If not,
you should at least reference the dependencies in each patch.
