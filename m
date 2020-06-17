Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7985C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF36E2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsTaMXtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFQDpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:45:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:45:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so522512oiy.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXa/EAzAPWZbyjrtvaqKvLMO3+1ux/O3QTvq8QLExXk=;
        b=DsTaMXttsBxzyqcuFOBfX36kQAO3kTwOdKtin+RF0w+Ho+acUw9f1f3c0u8GBdlV5a
         9k8FBhcDu06c54nGD7fMuMgjAeatZ2KzWSWegHAyhXPyh2dfitup6Caf1y+Mp4qzo45u
         pwCsO7M0DEkDLK1/f3Rb+gNqGf7/gDLVKYW7ZkhsIaROaP9KkhRkYjMQ/G7FiI8JrH3g
         6dBqrNC1s4HLG4tQ1pWmFOiiT80+vq17GR6JvplJeXLI98grK1JVRjZnAnODul3XkkY2
         vRPnijYCtpM2P2Mq5uaVCHAkNqbQzybm01Gfe5Dwpku414Rrt8MdY/JgNdVXIkiMTEKK
         wYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXa/EAzAPWZbyjrtvaqKvLMO3+1ux/O3QTvq8QLExXk=;
        b=n9d+r1hSWasszqWyBm8PzgwaMglzOj5vJE65+74L4NYDa9k5OW3aBIiKuBVaRs2wYD
         pnGyvntnWyW42MYkKdaTi5qVLVt1iJ5UlVBsMHZ9D21f2yOQi+2LZ/DOrr1aXcR99yAO
         HlxCDKB/zdL15dppcj80M//7U76XTJ82juzChsDATktN6504iJLt1Ecp+62TvwG0KZ2q
         nQc2j6H7WcAgBxI6pV6KcT0oBBXUr0UPxNO06se4QbqTunshr1KwZwBHOjhAm5+SsJ2x
         qt1U1MId3fAuUvBvqCMs7VnbducvWtptxYEjs41N5ELeKccfsztQcDd2lwNhCysAyXSM
         94Hg==
X-Gm-Message-State: AOAM5335zd0v+JAcQ6mlGS7jZIgvWl+jOPruE6NJD/fz6sTsGtnEg4Mf
        mNHSrS8XXRlADF24LrnW/uMsBNEsNQAUjQPAtoiVjg==
X-Google-Smtp-Source: ABdhPJwmYdY46Zncz0qcJ6y4cxLu/asxmUw9VTKjPeTL77rzZM2hJjoeAqsas4zUhjr4oT58D8HyNR3xPcDQfKQauhI=
X-Received: by 2002:aca:35d4:: with SMTP id c203mr5951576oia.30.1592365537818;
 Tue, 16 Jun 2020 20:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com> <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
 <20200529123025.GA1710508@kroah.com>
In-Reply-To: <20200529123025.GA1710508@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jun 2020 20:45:02 -0700
Message-ID: <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 5:30 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Looks semi-sane, but it's too close to the merge window at the moment
> for me to take this.  If there's no objections by the time 5.8-rc1 is
> out, I'll queue it up in my tree for 5.9-rc1.

Another friendly reminder :)

-Saravana
