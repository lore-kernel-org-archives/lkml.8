Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FBBC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AB6206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQ3F4e20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDFSMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:12:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38697 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDFSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:12:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so136913plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ver6n6MUoiKJ9YQThw8+RbAg+VfgvE+bRaGA1TEZ9VE=;
        b=vQ3F4e20+rPDeXfCEpsaDzx4gn2vua9DgaFCprSToBwI20LZ5YB4UsBIJfyfRVCQw/
         Ink+pTcBBewybEaXx8NhUDqYX8w1Dw/rPVxpaIcMBOJUv/wyf3ZSTAsysrxDoksvoQSO
         fIQ4fEdj10/Ux4gC4Dwl6bekkG5P3XmylDoxXB/x1CZNeuPgacxGKd0niIyMFLCM0lw6
         n4KXDQTbJXV2JO2k6TDP7q2ntBK6053pabIyqsUvJS+migpswwmAjIk2FFPdLbXpEZ21
         Zn0OdSBc+7IDjqFnbKm82vd0w9UMPwNmD1cDMyreHkwtazMNAyR+RfJnBTfsPRxlF3Lk
         vwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ver6n6MUoiKJ9YQThw8+RbAg+VfgvE+bRaGA1TEZ9VE=;
        b=SPEv1cfnn+nJ+ibvYdRDbu2rMEYiGV/at7hNLStK0aFzcsGJvnZgF4WLpz1Ky9SEAd
         NcY2OpR5WplDTwHpAKZVXLrWgIwdLbEzXtBlwX+pf9QzJLGNXiM6QAiCaoVF5MTuX7um
         UKLr6xhv92gZ5EpjHFplc+Y1RjyQYvJ0dFpkd2qGED3KlWYO/daToZlp1oAhyPH35TbH
         AhJw1cywTKKwayaFUryNsjrM5cvGX0qCciJs/ODQfGFmSMdbb6sJiC+8qV1MV/seTQMq
         w9dj9rJQXHFQ1uT6+cFEsaImy+seJ3uPgIqYWB8rubYSblfXK6/CT9BOHDipwZfs8kSu
         LbZw==
X-Gm-Message-State: AGi0PuafWHi4QN+2GFbADq2GjmCVGv1VipdKNEfCxtI8GqYljF6qWyWp
        Og1UToHFf5olXULXEKbVISdtko7zT/ws2PrDrYAChg==
X-Google-Smtp-Source: APiQypKrJQ4k0jrnTIHHGTaNBKzi/QJwJ+B536oRq/t8JvxDSa97hNj3Szu7UByf6aPQ0mNLznHy80PVB1X5w5GHgBU=
X-Received: by 2002:a17:90a:9f03:: with SMTP id n3mr639147pjp.29.1586196735041;
 Mon, 06 Apr 2020 11:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200401013639.16388-1-vitor@massaru.org>
In-Reply-To: <20200401013639.16388-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 6 Apr 2020 11:12:03 -0700
Message-ID: <CAFd5g47Ot-MfxzYmU8kfxpfv2pWhgb_2WigouuHnPT+20Ejk_w@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Fix kunit.py run --build_dir='<foo>' fails on
 "unclean" trees
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 6:36 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> For some reason, the environment variable ARCH is used instead of ARCH
> passed as an argument, this patch uses a copy of the env, but using
> ARCH=um and CROSS_COMPILER='' to avoid this problem.
>
> This patch doesn't change the user's environment variables, avoiding
> side effects.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Sorry for the delayed reply. I had two people finish up on my team
last week and I needed to do some things for that. You now have my
undivided attention.

So, I tried to apply this patch and it still doesn't apply on
kselftest/kunit. At this point, basing your changes on torvalds/master
would be fine since kselftest/kunit just got merged for 5.7.

Can you use the --base branch option when you send your next revision
so I know what branch you are working against (just to be sure)?
