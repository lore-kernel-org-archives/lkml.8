Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53903C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD8A21941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiJNnp9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIJSoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIJSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:17:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEAC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:17:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k15so5084504pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtLKtH7cWRrM3fBgblOeHcZmUDs1Wpod83D+Qi8K1cc=;
        b=QiJNnp9n6c1hPuSVLuFhpjOR4+ZpNWRatUSshd6auMBfdw4ViobGDo1sLp8WptM+cr
         WzZ9S8RWNEJwaO9biXJJrXzZKrPD7/t8BroZ8/UqwcRk7x7UzOY5o5uG1GPrOILcHVF/
         sxqlovkq+EUePECSFJ8hAQxubuFE9VBRx1m8cNWkmk01F3S4bDCxA5HOU12fr/D+FZtM
         zNclSwXRg8HFwdlqmrzcSakRfrcUqv5VlzrlucdOuNku1VjFt5BNAInX4Lz24qUFd6Rb
         qgeoK+b4jxLXFXn1swOnaBleoO4cOdN6pK/11zb2yFXKBdxlhSbf49UCOUR2O/CRm912
         Wj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtLKtH7cWRrM3fBgblOeHcZmUDs1Wpod83D+Qi8K1cc=;
        b=XYTX8WZH5WB1di1wH+LMI/GWByZ4kOZ11xz2f1SBRQJ5qpysjilmqthA0woXnqySjz
         fQS/8zCj3lRlH8ibIu5gpUpV1pF5aBgIjZzAWAPi0oACTvqipHQcb1g2jIF2vcli/19A
         TaZhEi849QoLhxpC+A/rlBH5xksOM25xB5FwfF+uDQO5Bz1AB0uqaVR3VbAnmENRttyG
         EjDvCaTaZEARYsS87V+vSziSfAIvjXO8lzSAhlS5PKcigDvZ4jPQQj+gTFWeacAJX2/R
         CDLaC/LQ868rHpDB4NrzMvxkaldAvYaiY+osMqHpJYTmECetpmOPrlaGTOqqzVfbjSMV
         M6sw==
X-Gm-Message-State: AOAM530pM7YmjMRRwpeHWswp9sa3VAnadFdbBCEduH9afpI+gOVWU2h3
        mn53TdR9CxzqEybx65j5qS0DsjK56zIy3apECasYkQ==
X-Google-Smtp-Source: ABdhPJxEKiKH222RavCG1MjIuH2RIPD8diBxo187fBd0IF7zvgXujERcwklhJn5QVzlBDwMXk82VeIgbOz+PuiM8csA=
X-Received: by 2002:a17:902:988f:: with SMTP id s15mr6555650plp.26.1599761853442;
 Thu, 10 Sep 2020 11:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 10 Sep 2020 20:17:22 +0200
Message-ID: <CAAeHK+z1qMgg042rii5kNuDR1UeC9JzhXYMT=pSHnHQtoFFKew@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] KASAN-KUnit Integration
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 9:03 AM David Gow <davidgow@google.com> wrote:
>
> This patchset contains everything needed to integrate KASAN and KUnit.
>
> KUnit will be able to:
> (1) Fail tests when an unexpected KASAN error occurs
> (2) Pass tests when an expected KASAN error occurs
>
> Convert KASAN tests to KUnit with the exception of copy_user_test
> because KUnit is unable to test those.
>
> Add documentation on how to run the KASAN tests with KUnit and what to
> expect when running these tests.
>
> The dependencies for this patchset are all present in 5.9-rc1+.

Hi Andrew,

Could you consider taking this for 5.10?

Thanks!
