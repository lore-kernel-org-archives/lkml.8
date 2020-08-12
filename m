Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D891C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E816720774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejh9JhTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHLNCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgHLNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:02:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:02:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q9so1830549oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FYTOQHYFNoSSfeNhMyajUD/P2m5h59FWjXl7Kq1d4Y=;
        b=Ejh9JhTd9LtOhtE75SjvXpQnDSp7w66jJR1NQUvefFxvJxEft/FqE/PPqVJFAh50YM
         fsYCldXZS49D+1TpHN+1+wdEQSTLJUufRT78xZVGgjFBHtij+oq1ndEXkrCxInRnvStQ
         oYNQP/6wSLGd7hJ/JWp4afeodmgkalQwpryZ3L6ZjUDkljJ57PvdZlVrxoI0wURUzmNN
         264O/jK9pvqqp7CTk94vsYLmF+yS1u79QdYSg0o4wEXy8Y0a7/Cr/5NhUIZfasb/tIz1
         VwOgGJHWcVVJj2VVOe/du7c6iRFuo0iFKN7KrOstvfcptczohpx5kflIfJM/n5n8zgJY
         ac3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FYTOQHYFNoSSfeNhMyajUD/P2m5h59FWjXl7Kq1d4Y=;
        b=ixgSIERdd7q/xhoyjHeuwshaIgCwmnzGsfUQLEvKJNitr/ElS5FK252TdX8koC5+Gk
         b9KJffMX2K/HlsH8PjzY51ZGb4doURKz2v8WzbAMJsjqJSZ1/H50kxX/SsCHzZTq39zg
         WVKPXDaNFvdq/k5bK08r3jb5G978DIjxyC11TQUkgLxpk2OTEVzX363V0RNJP2BXIBtg
         4yrUooXnMElIcKtZvXUsJIfvwKYqATqS0Ry+1w0LZsh252wm0p59mqnc/wTOm9ScerFL
         T6Z0rVACIZYNecl5kqoJxjLuCe/7uOdocttzV+cdSndvXHlhTygwZMXYEFDhdFSmH9IU
         1u6Q==
X-Gm-Message-State: AOAM533ct4rUikxRqtp6XQC+RWW4T7HC+ktd0ByV9Xkr4uR2Ko4s93Ep
        kxBhQRH0vW1HHlAUbadVz4j+nf3w1fr39+flJcLGRQ==
X-Google-Smtp-Source: ABdhPJwoTEkpCpRgvslk7SPBlvFttSnZw3FOWuQBpposC+jZpNWauxHblvEM5fYuhUHQ0Uct3sFok1vM6Q6D6qyFm1M=
X-Received: by 2002:a9d:3da1:: with SMTP id l30mr9650285otc.233.1597237346320;
 Wed, 12 Aug 2020 06:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200810080625.1428045-1-elver@google.com>
In-Reply-To: <20200810080625.1428045-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 12 Aug 2020 15:02:14 +0200
Message-ID: <CANpmjNP5WpDyfXDc=v6cerd5=GpKyCmBKAKH+6qLT6JrBGPqnw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Optimize debugfs stats counters
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 at 10:06, Marco Elver <elver@google.com> wrote:
> Remove kcsan_counter_inc/dec() functions, as they perform no other
> logic, and are no longer needed.
>
> This avoids several calls in kcsan_setup_watchpoint() and
> kcsan_found_watchpoint(), as well as lets the compiler warn us about
> potential out-of-bounds accesses as the array's size is known at all
> usage sites at compile-time.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/kcsan/core.c    | 22 +++++++++++-----------
>  kernel/kcsan/debugfs.c | 21 +++++----------------
>  kernel/kcsan/kcsan.h   | 12 ++++++------
>  kernel/kcsan/report.c  |  2 +-
>  4 files changed, 23 insertions(+), 34 deletions(-)

Hi Paul,

I think this one is good to apply. I do not expect conflicts with current -rcu.

Thanks,
-- Marco
