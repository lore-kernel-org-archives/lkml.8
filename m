Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E221EC43617
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE10520658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JZLRSBhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgGOLM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgGOLMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:12:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C786C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:12:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a1so1717139ejg.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GNZTlebsq0eWIwEljX2xeBdZEHRs2k6AtH87hm9Zwgg=;
        b=JZLRSBhWm0oHxV3fok6cxthIXvhjAenz53D8fezRJjLbsEGzev4V175VrT5tTOPQ0L
         XAnaq/Ov0CMEsnpV/F+V8rK7u1bIHghoUkChEQwbMY9tpBz4kn9ZGAYdf+rjrsnXqUDy
         +MzGC5vqoZD/qK6UbJ4A75mLpvNLy6Zar3ArQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GNZTlebsq0eWIwEljX2xeBdZEHRs2k6AtH87hm9Zwgg=;
        b=Xl7r89TCiN1NPVwdOG0nPRmZ2rJmKZqQrGaYA6d8pVx+wIzTPoX4bCpPCyzeT3vgOz
         tXkOto8qWhpkYW+BSJNEP1xPxCgQfejCIAsuu+cNCc6l17/NHl35r4++86cSgeR7f5Bp
         rVefNLaP7BfNqR/N4ozNVU/oSt6tJ+FQG2l8FDE1z4inILA9mXpkiNtgUc0MsGRR/tmC
         7+QQbWy3UePi7ngcwpABt1pv5F+ftLiqO5ZLVb7AAVQwbowb9olMAAQKWYuE0en7JB8h
         nPHKGiZa8Zprh4U7+j26+eLG6G298cBspKhzPEj+EzDvZjBhlezGKvg0xRqVy3rAzaXo
         joDw==
X-Gm-Message-State: AOAM5313U0w4Vfm7pmfeNRt57qQv6Fhaawfk8X7f9lqaAD+661NbZ7RG
        tl7Ho8dHF8pC9V7oZKAr7eF46U3ZMHlFvIvmWT1+xg==
X-Google-Smtp-Source: ABdhPJw0oIZdNNSQSx2dAWVRtVjY5tScV5cqBbhIhCHnr1dD6YokQZCqwZVPmd0NLTWPqfK15c8L+dhgVb8e5/u5u6o=
X-Received: by 2002:a17:906:b74e:: with SMTP id fx14mr8403146ejb.202.1594811541019;
 Wed, 15 Jul 2020 04:12:21 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jul 2020 13:12:09 +0200
Message-ID: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
Subject: strace of io_uring events?
To:     strace-devel@lists.strace.io, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This thread is to discuss the possibility of stracing requests
submitted through io_uring.   I'm not directly involved in io_uring
development, so I'm posting this out of  interest in using strace on
processes utilizing io_uring.

io_uring gives the developer a way to bypass the syscall interface,
which results in loss of information when tracing.  This is a strace
fragment on  "io_uring-cp" from liburing:

io_uring_enter(5, 40, 0, 0, NULL, 8)    = 40
io_uring_enter(5, 1, 0, 0, NULL, 8)     = 1
io_uring_enter(5, 1, 0, 0, NULL, 8)     = 1
...

What really happens are read + write requests.  Without that
information the strace output is mostly useless.

This loss of information is not new, e.g. calls through the vdso or
futext fast paths are also invisible to strace.  But losing filesystem
I/O calls are a major blow, imo.

What do people think?

From what I can tell, listing the submitted requests on
io_uring_enter() would not be hard.  Request completion is
asynchronous, however, and may not require  io_uring_enter() syscall.
Am I correct?

Is there some existing tracing infrastructure that strace could use to
get async completion events?  Should we be introducing one?

Thanks,
Miklos
