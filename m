Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48FC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D482078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="mE1R29cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHVThC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgHVTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 15:36:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD63C061575
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:36:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so1235882wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2UpM4JiRz3DSJbLEVUit3CMbJBOHMsg2oZwhaPpIVA=;
        b=mE1R29cUE7e5dkG7Erf7qXQPY5FC1XBoN3dQ3DNlq6pOwtQs2QA/HXJg+Dgi5aOmH0
         eukcJ8ZutRhpaQncdPJv6JPb+cI8dUgxhZOl7G7h/+GRuyQAtNLkf8bbjBOFeimdSOEw
         OaSqA1PNnbdqb/ubLToV2eloOntz6ZLCiKy70oadVyFZ6JzY3sG06ZyzadCo2EyeY4nG
         3JyI0xU5lcq7UK77Ay6zWGuRPL+JSUd8q02b2LvB8p3d4NzD1i5DxjlxVKlcNoBjBOzM
         VtysgUcFhUiCjFFRHWw5qkE45NrxOCH/R44dGkF6SqKuKXiIW/RNpcd0ktK642yGEniJ
         kzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2UpM4JiRz3DSJbLEVUit3CMbJBOHMsg2oZwhaPpIVA=;
        b=BspZL1aKgJjRbFENHwJSpc13xBFs4bTc30iLBDwyIuy/CYqEd7D0XytV+WysPGWdXa
         8UbKfv6ziG9TOcpxQaeCPrp6ahujhWgBbH+zJSNvTTc80rKZh7jG4tzMImFLXvJHa0rW
         7HuGcNnDvUB2vHLIr+BlX47R9eir451N1LeT9THlb1f1/M6BFYpr/XpiqKYR7trFCf3Z
         ZGXoBG4kqrFqHstu13s7SK1XTo9NnYwFI1n1SNOuXDiLVBcpze6yXEYlh/v3P39o5B2V
         VP797UhJpiR6vBG+RaHftONQ65TN//YSW4GNJhG9wrzkekMBoumRxTPSCn/gkj9VzjcB
         U60Q==
X-Gm-Message-State: AOAM5309WESz8iLE+/2fBbesnz9bH92Ea5Sv4du0skRARgi/y+aGAIqH
        QsfbD5hN41q4W1IgGANUtPe4FiSHKRh0VwHGf1DdYw==
X-Google-Smtp-Source: ABdhPJw1FjXS8okxIasqbI2eFqqO4wV94l6O3Rxxnnk5P/VzZuRcNZ/6J3YlyMeLV+ABXrCSAZNjs+lqNalSNkMLC0c=
X-Received: by 2002:a7b:c15a:: with SMTP id z26mr8502959wmi.35.1598125014765;
 Sat, 22 Aug 2020 12:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200815182344.7469-1-kalou@tfz.net> <20200822032827.6386-1-kalou@tfz.net>
 <20200821205154.365e230dbf6f2b93a47443c4@linux-foundation.org>
In-Reply-To: <20200821205154.365e230dbf6f2b93a47443c4@linux-foundation.org>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sat, 22 Aug 2020 12:36:44 -0700
Message-ID: <CAGbU3_=K4aEhsc6kFyJC7PQSieTzH6=6-FVKUcBdogpFvuCJJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add GFP mask param to strndup_user
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look!

On Fri, Aug 21, 2020 at 8:51 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> Why change all existing callsites so that one callsite can pass in a
> different gfp_t?

My initial thought was to change strndup_user to use
GFP_KERNEL_ACCOUNT (or GFP_USER | __GFP_ACCOUNT ?) unconditionally.

(Would that work? that would be a simpler change for sure)

In the case it was not wanted, I assumed a good proportion of callers
might do the same on a case-by-case basis (esp. with regards to
enabling accounting).

> Also...
>
> why does strndup_user() use GFP_USER?  Nobody will be mapping the
> resulting strings into user pagetables (will they?).  This was done by
> Al's 6c2c97a24f096e32, which doesn't have a changelog :(

FWIW, I believe related to this: https://lkml.org/lkml/2018/1/6/333

It's a bit over my head (is GFP_USER cheaper?) if strndup_user needs
to follow memdup_user

> In [patch 2/2],
>
> +       desc = strndup_user(user_desc, SK_MAX_DESC_SIZE, GFP_KERNEL_ACCOUNT);
>
> if GFP_USER is legit then shouldn't this be GFP_USER_ACCOUNT (ie,
> GFP_USER|__GFP_ACCOUNT)?

Yes! I'll see clearer if I manage to wrap my head around what
strndup_user should do
Thanks!
