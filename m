Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03962C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0242072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVtO74pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEUOVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgEUOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:21:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CBC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:21:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v4so5597368qte.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pcs70r+jLgxPgoJvLwzbsID0j/rkvxXG6DlxyjvqoHw=;
        b=nVtO74pap1x8NIfAz5i0d2jKSmGXkeOJVwRYOKDarinCRDgjGGUkxE/J1TzUNJygsB
         O0ZN796Z0V2+Aa818R8buT8JqL2CU6R27ko02QCE3xn2FnMUlLaIGEbuvrrYh+6029bv
         Bk40Rvo/C5vIvkdkbSXp1Xi06BFwFlDOeVBpLQRCbJ5NqywhmTDL7yTSz8jhJFCVqoRq
         895JFanRAKlfeBE0G0OciV7jFbKC0KFOgNCLs4sipHE0m5TW8vhoXDLf1Ln90s1K75Pl
         dZ3gY9Imvc0UZWiZ2ETTlJz9pw1zPPnBlNcwcTbmamAUtuSvb+9t66vXLhKcdRF3zxtV
         vnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pcs70r+jLgxPgoJvLwzbsID0j/rkvxXG6DlxyjvqoHw=;
        b=ora7NYmiTYF2JOCyva2NyrNJLGiSQHkO5/DWwzC3rypo/zxWECZy6vPUjuWnxcyoh9
         5JdUCAVluXUAz6ZjtAiywj5XsSKLQeF/fooSfzwTe8//rjzV71MovRKA5dgKsW5GdaaC
         NMf4UxTkbvPWTwQmUK+zEgXcBdJhA5f9wNdGZl/IWpeqdGfXg6gekA1YWv2RI3he01aV
         rSRYTArusinIjtesP9g5uKEERS1gEFFp4HuD4F67DTr+rCzRKvK70Go7u5cnjc1U7rPH
         6g8X0EooWlQD0f+fm8V9i+xHr5hLuBP2SaLjwIDShKQiWb+25OENOcHaM4A84IlelOca
         +rRg==
X-Gm-Message-State: AOAM533iP16KvCpgXzx9jqw4T4TOKOdeq1PYXiPa0Rzvb6OHOUQJTL5M
        +UmDKINN0gNTIOa93m55TWt5AL4OnvfMFqumUUj4IA==
X-Google-Smtp-Source: ABdhPJy8cCZ9oT9uBMA6ACH2vLLvE83My3rHUrXgHIL8dqU1ksdB3gDA/0LyZ6iOZrlRI5zm7Dk9jTVm3ZdPjeFJGsA=
X-Received: by 2002:aed:37e7:: with SMTP id j94mr10693345qtb.57.1590070878207;
 Thu, 21 May 2020 07:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c866c705a61a95d4@google.com> <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
In-Reply-To: <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 May 2020 16:21:06 +0200
Message-ID: <CACT4Y+bAg0jJSVSu-AwP2k5QMk3kgnwRn4xXb3C5Mx-CyMRwdA@mail.gmail.com>
Subject: Re: INFO: task hung in locks_remove_posix
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 4:09 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/05/21 5:53, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    806d8acc USB: dummy-hcd: use configurable endpoint naming ..
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c9ece2100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d800e9bad158025f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f5bc30abd8916982419c
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> This seems to be a mislabeling due to '?' in all lines in a trace.
>
> #syz dup: INFO: task hung in wdm_flush

It seems that unwind from __schedule is broken. Fixing the unwinder
may be the action item here, otherwise we will get an infinite number
of such reports.
