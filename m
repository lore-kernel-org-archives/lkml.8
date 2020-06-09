Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A2BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92ED1206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkWSINAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgFITVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgFITVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:21:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C6C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:21:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so8414430plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8Y+QEIY0T38+LyOkVjhLl2iDQvo9/HQ1D/xWJhCBjs=;
        b=qkWSINAK4P2QFNy9LAGLjB9Ll1Jo9GgOJWulm5yJ5Bt7FfYC52YqZzgz8cMpEeVrvu
         q4c30GIyUx1FZfEKY5MORDgggYbsPxJ1NOQRhTQ7X6ytJV5fZSPDDqoHA97lZgSaUjwt
         FwiA0NE4Mi9sksbTyqJr89JWaQuh4FuVapyZr2ZvhbW36zc4b0Nw1h9S8yRw1K6Opgez
         UP+XzX2HzoHjrDc+ZlJwvG+RvXXHsAZkiCKut3vQH1aKO33Aj1B13oBbbxpTn/KuiU/G
         jx8ElnUpitRz5wfwU4rLfSxysDnncPOz/gIpQs34QFrEWUW52km4fVNmMcA/MczAHMc7
         /v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8Y+QEIY0T38+LyOkVjhLl2iDQvo9/HQ1D/xWJhCBjs=;
        b=VYcavf4ZedZog2Ox2bRsPHTgVDxe2liDu757yrTC5g5I/lImN9J3AKWsv1s7WLld29
         As+qWR++QKPMd715hsdVteYXPXNlGJKO5rQZays3iw2aEi+FZKP+fjF+S4as/83EIw8P
         m12gyPIZoYo2hyEtX+YXHwvoFpKsPo/OfRAlqVXK6xzLvVnzsR3Yge/jEEKzz8DzRxjw
         kzc4B5mVCFQTlp4kIkk8/z1AIDIhy4+LHGVar3vDrm3GZrrrUakSbMzufrRvvWbYr6+d
         4hl5PztlDQhEIBligfepey54Mp0PCRy030vg+7ijmNJ3XUd48pnoxxPtajtzd1Zfnko+
         rK0g==
X-Gm-Message-State: AOAM531MbYvPk+gMo7AdpdqQLYm8eVD9+u15t4Fsa5ICdWQPwpl1vgtr
        wTsAnrcV03IkbV29PgJIQGcf9j5Z2oUEnwvRa/4kdQ==
X-Google-Smtp-Source: ABdhPJxUq+MFXXxcdrcaS2Wo86HKkBEg4ZrncFyYrIhWKvnT0OWYNZ5A9Z8OUiJz1u5cnaeV/fcAeKaKenaqklmHvjY=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr6537329pjv.217.1591730499841;
 Tue, 09 Jun 2020 12:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com> <20200606040349.246780-3-davidgow@google.com>
In-Reply-To: <20200606040349.246780-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:21:28 -0700
Message-ID: <CAFd5g45zNikNb6wEa1UWDS_ZtxOVrUt006s_cMqM7ZCTMjfSYA@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] KUnit: KASAN Integration
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        andreyknvl@google.com, shuah <shuah@kernel.org>,
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

On Fri, Jun 5, 2020 at 9:03 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Integrate KASAN into KUnit testing framework.
>         - Fail tests when KASAN reports an error that is not expected
>         - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN
>         tests
>         - Expected KASAN reports pass tests and are still printed when run
>         without kunit_tool (kunit_tool still bypasses the report due to the
>         test passing)
>         - KUnit struct in current task used to keep track of the current
>         test from KASAN code
>
> This patch makes use of "kunit: generalize kunit_resource API beyond
> allocated resources" and "kunit: add support for named resources" from
> Alan Maguire [1]
>         - A named resource is added to a test when a KASAN report is
>         expected
>         - This resource contains a struct for kasan_data containing
>         booleans representing if a KASAN report is expected and if a KASAN
>         report is found
>
> [1] https://lore.kernel.org/linux-kselftest/CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com/T/#t
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
