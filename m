Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73D6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8423D206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhEEqpsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389205AbgFITZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbgFITZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:25:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AEC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:25:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so692388pgn.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFFH4rN6KjxMJmlzDoLxm8Mltw2hQsIo+kpRF7qr7R0=;
        b=WhEEqpsffIxSTyIwECrsIuUNt8DhKRax0O18nD8kxqBcEeWnYuCLuX21nciaW6ImnS
         uWjX+8o0+Qi9x+5dxeyD7iyw0vxQo0iE0rdaqg9bfFyTsKmL0sQjxfb6Q8TJQCwV+7Dg
         9kJW/FQtO9ixxD7ec4yUOvVSzDMGQuvAV6DeUgvtgvJmQwaKahKPBvUIxGABr39xfSTX
         adt8xos57naxWdvyWkeSCgcgWDMthybYzOOcbHFA2j8PqYpeiL0W2vcNlnf7INtBrHWi
         ypIQ9cHVrOxLUCRBlthpkC4LVtZQ1bM+0fvce7ExIMhVwnmSb1NwlIfC1wC+ZdO3ouWe
         ioqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFFH4rN6KjxMJmlzDoLxm8Mltw2hQsIo+kpRF7qr7R0=;
        b=IC5UX5bJmrk7u/p94zGLK45zCGg4EQvtMYtmwjyP9ab2DcSjMD1A3/UY7fZDtigEX9
         q7kNzGX/SobC4WVMs8G5FDin2sJqbdj5h0ddpSw27zfrnWfaXEqWtaqPxHPTX1JAuxm3
         EtEAmHXRTpLYgOHDSVKs1Mk/nYnLWK3TJd85Z9Mgft+FnLUT7/zkZlC3qHBVy+swI7fI
         2T7fwDsxNeeHq81DCgtdHcBOsb6RPxkWBJLgDffDap0CopxsExNsa2M/hUpawj3F81I7
         3w0RO7LtGxmH+u2dLAICKwMVteji141dt/T7y3zA1uH0SyMVCE/8fDPUIN6qKUaYlhWg
         6TJg==
X-Gm-Message-State: AOAM530RKiWYmleHF0jYvOmqctlgQtC9tXEudDhOaZiQ1KY9wcf/ChEp
        uL0fq9lpqcaIEjLTWsS5B+LF9kzSEROzohh3SHq2AA==
X-Google-Smtp-Source: ABdhPJxbbAeQHTukROqUecTz68J69iFM6/OzTYcDpD65Sxr8qt+HL2WuQjbTc01I/fKhxYN2fvRpYXWiuWIcBAjtVws=
X-Received: by 2002:a62:6583:: with SMTP id z125mr26502301pfb.106.1591730736382;
 Tue, 09 Jun 2020 12:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com> <20200606040349.246780-5-davidgow@google.com>
In-Reply-To: <20200606040349.246780-5-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:25:25 -0700
Message-ID: <CAFd5g46Zn6DuDVB+2SLFd=ofc3J9DXEZ1cn9eTva5-EHueRONw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] KASAN: Testing Documentation
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

On Fri, Jun 5, 2020 at 9:04 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Include documentation on how to test KASAN using CONFIG_TEST_KASAN_KUNIT
> and CONFIG_TEST_KASAN_MODULE.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
