Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818AC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066AA2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OK1kyUrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCXLdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:33:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33537 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCXLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:33:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id c14so2126464qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Qc7uvYUanhBTdoYQFCXEMtsiSU/KMpNbflyVVa/k/0=;
        b=OK1kyUrgihIZSOJwUiTfwpiYANyW7kApVKmQ41+ImaXUd6xpIUQzC/fBdhJd6QlCtU
         oOV6vfncP1EW6DCy1bY6KN0oboppZMXnPmlHIxSXvSjDYvnMCxWsYKraHjE4r3DB09UP
         gnznbW1v5LROUTwb7VS6nbQV/KRcAggzMV/C8CjqHpB9EOCkL7Ft4sV/wD2JgEGuIbwI
         r94f3QvSrxCo5tRNA+an9IsKvURFkSrk5MibFzg2LP2VY098kj2C1tFT54atLiAOlmph
         bPR+xlaSuzrnjSslsaH3muNhf39gJfUab7DI9TQtbD4FQuJBwzPeJUr4NAs449zLrAY6
         A3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Qc7uvYUanhBTdoYQFCXEMtsiSU/KMpNbflyVVa/k/0=;
        b=rMFxmtQLPXmn2UjANT+L81VL9r1gkrJHQclQc6tZ933+xwvCcoYJR3wd+MTigm6/Wm
         Xj1EXetzYfHQyPgVfwbCrf6TK5hC0fSLsjouxoHRGbMshVkZWHnVBf4+/xl+ZqDgtIOp
         HJxw51bsDc7lNs5YtJUcWSdUUSRJM/funTNEZCWhmzErISaiq0Uqo5rbsuda22hMyHvx
         MZlVOtMLb9zwreI4wmUsVS88K9chj6K9yvZMeP58zj1u3WWrvhQqtvW+ZRbtaJsBtgRh
         4WF2BFNdeaiZ+477ANyU1ZeFty3U0gV5Y3/xbEXLaB8AwX/ACN+Y5eg6Jz7LoY7+E81m
         FlMg==
X-Gm-Message-State: ANhLgQ2avvKcszN2XZDSmHtFzILFSdng3xqj6CuFGjg8u0Wqbo/PNy2A
        3VgSam7o3IBXWkFXjlOAXoRMLzn+h6xb3mqPVYFwcA==
X-Google-Smtp-Source: ADFU+vtaIDlqEcDPnyVkLDfdein5xnF5prNYs7DXLAe+TaWYWAbSb1st0hXaOIvklJ7ZZ2BZWnsEnu+l8Up+lD0Zfkw=
X-Received: by 2002:ac8:719a:: with SMTP id w26mr25506964qto.257.1585049581891;
 Tue, 24 Mar 2020 04:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-2-trishalfonso@google.com>
In-Reply-To: <20200319164227.87419-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 Mar 2020 12:32:50 +0100
Message-ID: <CACT4Y+bbVtwfYUC_v3V0ZBh2kVwp=PHKq6Jyqiz6BVbLTtL3bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
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

On Thu, Mar 19, 2020 at 5:42 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
>  include/linux/sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..1fbfa0634776 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1180,6 +1180,10 @@ struct task_struct {
>         unsigned int                    kasan_depth;
>  #endif
>
> +#if IS_BUILTIN(CONFIG_KUNIT)
> +       struct kunit                    *kunit_test;
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +

Why can't this be used if KUNIT is built as a module?
