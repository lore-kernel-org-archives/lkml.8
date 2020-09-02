Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA006C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DE4207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599068597;
	bh=L2RLNFBb3pJEFSKqzSJ2lW5q8hFqMs8sMwYcCEmwNmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qB3JJo6QGs5RGJV+NRAFOMMgIy9UrM67fwWKQeUA4F0RZW3kzat/8io10nZLs4i1o
	 A7fTs/2VSkhB0qhip9baJtybeJEibQJEKFAu1wJVL5O8IDc6j5URc8hVQ9IHyLwtCT
	 2N3SYuYcDstqsEACo7u6WPIP8yoXhECFlk8jBIc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIBRnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIBRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:43:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7321C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:43:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so238986lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ax4MLi3AqiY7j/Hjm/smPZihj5xUUH2jvyHqBkLg8ZY=;
        b=YJefbKeZi/8D+oX79CBi6m6JiUD4YlGAWejKmENbxOrApxhdnjTRlzKpFyhIH2lg2h
         WKXZLNwQ38a/TCCx4j38kHsKoHJ6hA9fO3L0p73zGKxNaB+7cMgL8tZuu8Rv7N3O41ot
         oKgmA9cmbOP1gjx/77tJ0qr+VW5W2R4qfc6PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ax4MLi3AqiY7j/Hjm/smPZihj5xUUH2jvyHqBkLg8ZY=;
        b=Oy0bEZEBoa5d3PX5AscVs9d65Kdp6LVh4e/LCJaESNvamnUi9DT5ojETB596HepGcT
         q/4lSArEKFu8LQRkdG2oLPRe4nDGtRDwNjl2WtenBB/yanQJJ4GOx1Los4GU7vHIO+Bw
         wdCnhd0tY+rrXSSBQ3frb2Tp2l/mAUaBZcvnsbnpub80Fex2cdKOvDA+65nzzGtw/jhM
         +70zjXlyrMSj3FXRAKLibhZsY3Hqp7bISbWwJpXdnAChnznA0WsWxHg3RQiJsL0k5dV5
         zkCtqEYRr2iQi0lD6B8JEQBl39ntdqTliNRZFZOdDvX5eNF5BT9X2lmbVf5MuNn7+YNs
         jyew==
X-Gm-Message-State: AOAM530VzAt9lIGdDfr+esVgpjKTQpKmHq+U+fp8QY41wLWUFHmIPDl5
        LesLfaqc3ApYMjHjB6Wv7nlh5Tgd6v5QEg==
X-Google-Smtp-Source: ABdhPJyYARgRErvIPht9nIvWkon/jvzNT4IXJKmc0ooe8MCtzfR88WU6RSR/8rWOzENElKjJilJImA==
X-Received: by 2002:ac2:592d:: with SMTP id v13mr3013367lfi.124.1599068592723;
        Wed, 02 Sep 2020 10:43:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h8sm55683ljk.138.2020.09.02.10.43.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:43:12 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e11so156591ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:43:11 -0700 (PDT)
X-Received: by 2002:a05:651c:219:: with SMTP id y25mr3652231ljn.314.1599068591485;
 Wed, 02 Sep 2020 10:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200902085513.748149-1-leon@kernel.org>
In-Reply-To: <20200902085513.748149-1-leon@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 10:42:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whURzFKdBsoHCVsy4VU-cmAKBQEhkiS8Y8TQ9nRgAbP8g@mail.gmail.com>
Message-ID: <CAHk-=whURzFKdBsoHCVsy4VU-cmAKBQEhkiS8Y8TQ9nRgAbP8g@mail.gmail.com>
Subject: Re: [PATCH -rc 0/4] Protect from GCC garbage input in GCOV
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 1:55 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Bottom line, GCOV is broken on GCC 10.2.

The patches don't really make sense to me.

How about we just disable GCOV with the known-broken compiler version
instead? As mentioned in the replies to individual patches, it looks
like the "fixes" are random bandaids that don't _really_ fix anything.

                Linus
