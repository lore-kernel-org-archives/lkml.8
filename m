Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1365C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C817206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8h/Af4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgFDLBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFDLBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:01:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558FC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 04:01:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p70so4660935oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmhC5ZDmlvSYeMm+z9/lJsXTTmh0XfMq7M7Gwn0dqbo=;
        b=m8h/Af4rGQHvENuZyX+ft/lFSosHk0V09CygIGWTC3r6CaJgn4aa1YE2MdBX9MNwE/
         q5reTPVjfvipl6goTI1UO6+7kDgl9eF8LXtWgcg6VmehPzG6HxuXot9J/fDr/Vrtfnd9
         Y8Mj9tqNOj47xVAS3EDecBi+o9kM/1pujcGo+J6SeCT4unleFC14I5Q0sE0kQdIKoPtx
         KUNoUaM3FHlvVeV0wH/81BdXgCOpKOds6iGHAbMDxyrEQl/DTvhLlmjhFqSegbVu3qd+
         9xT1FcakuGmauTg2QwR4QE1y0w8DQADqSjssQlHLrV1zCxn5r8ZL8vGfiGQpSv2omQmd
         u3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmhC5ZDmlvSYeMm+z9/lJsXTTmh0XfMq7M7Gwn0dqbo=;
        b=O2T7QzH0HOSWfbHXhkq/Qnze7SNmop9H2zzrcyAApJIxc0TI57Xc4hlXaVspneiFt1
         CMNCSZFeeyrFmHiFGrvR+yKWaI0qM7Thrjb1qv7MSsfGEOZT0XKIxjvmLU4fD3MyX5/u
         AMBQ7BIzi7Yh1T9V33lhVErfrJiPAh5c4H+0tJdZm7SMctFH6bsjBpyr9ywJ/SmKCV0E
         u2DmhMXm7wedT4ULAwgSz54eDYFHUi1a35O2n6lUfw3L0ooFQ32xAHBKHQl7jXpIG/KG
         1ruquW2RkFpU6wWsfc+41VwQMj26IfEecQSVTfb/+0YZPDwoN7Sy6Lkd7rWK81bzn3/k
         VFAA==
X-Gm-Message-State: AOAM533SG5E07dWaEyuF4LKa4YEVClO0UN/AuvYCGAgHfr934uMLOi7j
        FqNoHQiT5a09pRsU5weVNeLd1uJHzXE8Qb/FYWsutw==
X-Google-Smtp-Source: ABdhPJyZpM21cnzNpZFh2nKdyxaWDw3K3SG9x9erNnwBqE7wzSjyfNQMEAGm2u2AyMW2mgo4biufugAsbZzlrfUFP1U=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr2762211oih.70.1591268493393;
 Thu, 04 Jun 2020 04:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200604102241.466509982@infradead.org>
In-Reply-To: <20200604102241.466509982@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 13:01:21 +0200
Message-ID: <CANpmjNPEXdGV-ZRYrVieJJsA01QATH+1vUixirocwKGDMsuEWQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] x86/entry: KCSAN/KASAN/UBSAN vs noinstr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 12:25, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hai,
>
> Here's the remaining few patches to make KCSAN/KASAN and UBSAN work with noinstr.

Thanks for assembling the series!

For where it's missing (1,2,3 and last one):

Acked-by: Marco Elver <elver@google.com>
