Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E60AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186AC20788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qb4Qiodo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCXSUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:20:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37123 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgCXSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:20:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id x1so3718923plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7TBBxwNpvZEgu2P5vS45mLuMGm5bXW06PLHgtTqssI=;
        b=Qb4QiodoFRSeAhTNws1BGKTLfVwQURZEB+9ru/JmLHBeA0pAhKtqd+VUnu0E5SKyYM
         bye4qLMhUFG7j3MF06tObcrsefap0AIr5lC7zL6obQTERItM2rUrFXUDCNPZuWvJ5lTS
         NLTjApMbAd1h2cBovb8yg5bfaXrtOgZ9vj5Etnf2C0RRzntwrf+GgnFPX6NAD1RhEDev
         +/IhzhE7Rcs0KP4O6eM7rGdn/Vi7OY6BHgKtrg3sTtzY3hBPCJaFQvoUXJK4oJu8SXHh
         JaI2neNR+Qb+0HvUi0IkQP1ATE4E1g0IH9SberwTGLWZM3HS4lzNm6jPxRI7zegNPtdF
         oL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7TBBxwNpvZEgu2P5vS45mLuMGm5bXW06PLHgtTqssI=;
        b=dmU1IOa7qLSs2CIg4oArQM4x4aK+DNs1cOkkO4ORPyPNrnUcUyb/e23tIwXh86+eIE
         F6gRVkvmQgUeTxKNtkFN5bazmFIfSYEmaAKMjp9Mw5h9qA5vdg4RFRumVKFjA9qmaI2A
         eaJbZndUIuXWwdiPznCRBkWcdO4aiHrenlEj2K70fMNhWOJPUujbVf8Fa2rNPujug9y+
         67ehWnAipdRJuCsKWnRKSJIZv7fejskAKiRii7GzWwmrLlEye1Fehs6tF7I6eAWuqXJM
         1I+n4JZ3/8Yo6d9rcRusRDQNHnH+RfJMCtX2u2oEQGjJLSaBEtm7lqRR7VEwf/uK7wCC
         IJCg==
X-Gm-Message-State: ANhLgQ2ReYacwEj/xImtUPrK1r1R+/kFMphRsDfsp8q+F+cfH3B31/z8
        9FIotCKZUsUUe0QQiw4kAQKUzZzYW8qa5z5vcnuHPA==
X-Google-Smtp-Source: ADFU+vvU/DEpKK++hcYvv//uiYg/cZGTM7oLYwReML+Okiq04rSe9KXRONxXVeIa2d4G4pW2RqbBJqIOHuZpjNMauVo=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr6876474pjb.18.1585074047136;
 Tue, 24 Mar 2020 11:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-4-trishalfonso@google.com>
In-Reply-To: <20200319164227.87419-4-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 24 Mar 2020 11:20:36 -0700
Message-ID: <CAFd5g47jJ0f+NFDBXK5gTqbx4-UiyJ9xfZaRW1qzZ_6AcGKC+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 9:42 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> Transfer all previous tests for KASAN to KUnit so they can be run
> more easily. Using kunit_tool, developers can run these tests with their
> other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> report instead of needing to parse each KASAN report to test KASAN
> functionalities. All KASAN reports are still printed to dmesg.
>
> Stack tests do not work in UML so those tests are protected inside an
> "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> instrumentation is enabled.
>
> copy_user_test cannot be run in KUnit so there is a separate test file
> for those tests, which can be run as before as a module.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
