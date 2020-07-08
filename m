Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7704BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5497420772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oR6mc7oX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgGHLPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHLPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:15:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961CC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 04:15:13 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w34so14055101qte.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mi6TL9T9iKfT5X0caZoWFf4L6ARlFDMGl6M6HUbAyGQ=;
        b=oR6mc7oXySioKIzpAZZS+JHd5d+4ZTUEYZi/yss9U0fkOuZo40/tparovX9Ueoos6v
         kOL2BlB3OVJnT9TYSGkFIkw1wRcR2b4G+Qs/l/o/QjiKD37PwGsiOQFBO6ee0cMMX6EN
         e0/BF/D9gdAKMXV08vSlx6b01PpCxrKoANdz6XjdNITkozPTjWilO8xoDBxeFiwyOzZS
         ioVwvbF16lpoIb4GVmeBEcB6B9q+SZRM9XUq1+Rgf5dvl7XdRD9RYz2eHw0wu/O9/zsB
         OtmSn++vBAbqSlmhKfRp1UGX5z9i3HU0Q2ac/5TVOq0bYpiQs8RUhhyLdlTY9mZNMJtC
         /dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi6TL9T9iKfT5X0caZoWFf4L6ARlFDMGl6M6HUbAyGQ=;
        b=rbEOgYLIflmF8fGHxUxg+lrJWZw1L7xoo3bQ5nT6KzgKTPxCyZ8llYzTbZPID9ylGt
         bVTe0iExEFdseDIKnWZKrhgUsHK7V9yAilptBI87XxNe1nGchdoRST8ZVpoERdHHlhrD
         64i4uSJFjr61ZS0WjC73xcA6Jy4BWtnFEX9M9lmNdV2gj/7E+BRKfik9Deh0lhTzJN5x
         00dMj0gq23INKQSz1gJCbLDyCcf0V5wppMbBCKKOaquT0rq/Vq0Tpdw/hhquWEmhKrYj
         lA3EAHAwPd5Itfter4kw6TS3KHn+35qRJlsfxPY+T0EOWDjElXlE4ci6e75DCLNx3v4q
         cRMg==
X-Gm-Message-State: AOAM533qKXn6aNrlM+4cqErZc4VXmRt+Sx3veNa0pJyMnd896ZX8A40Z
        ejRi3uceWvPFXZDJpPGGXYfNR4tD5yGxdq3cvwIrgg==
X-Google-Smtp-Source: ABdhPJz0cuf2U1RcCfJfUPmZLeauOtF48OOTeofNCW7eLZV45C29Pz+WifPZjuIr9BN+3xKxRdS7nyJmcjvANfOCiIA=
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr57010251qtv.57.1594206912372;
 Wed, 08 Jul 2020 04:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a47ace05a9c7b825@google.com> <20200707152411.GD25069@quack2.suse.cz>
 <20200707181710.GD32331@gaia> <CACT4Y+ZLx3wT3uvsMr9EOQ35wF+tw3SN_kzgwn2B+K5dTtHrOg@mail.gmail.com>
 <20200708110814.GA6308@gaia>
In-Reply-To: <20200708110814.GA6308@gaia>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Jul 2020 13:15:00 +0200
Message-ID: <CACT4Y+YSP8+Oy0Hm4ss8sH-eoas3ZHgUe18rVwDif8uba+qTxA@mail.gmail.com>
Subject: Re: memory leak in inotify_update_watch
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 1:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jul 08, 2020 at 09:17:37AM +0200, Dmitry Vyukov wrote:
> > On Tue, Jul 7, 2020 at 8:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Kmemleak never performs well under heavy load. Normally you'd need to
> > > let the system settle for a bit before checking whether the leaks are
> > > still reported. The issue is caused by the memory scanning not stopping
> > > the whole machine, so pointers may be hidden in registers on different
> > > CPUs (list insertion/deletion for example causes transient kmemleak
> > > confusion).
> > >
> > > I think the syzkaller guys tried a year or so ago to run it in parallel
> > > with kmemleak and gave up shortly. The proposal was to add a "stopscan"
> > > command to kmemleak which would do this under stop_machine(). However,
> > > no-one got to implementing it.
> > >
> > > So, in this case, does the leak still appear with the reproducer, once
> > > the system went idle?
> >
> > This report came from syzbot, so obviously we did not give up :)
>
> That's good to know ;).
>
> > We don't run scanning in parallel with fuzzing and do a very intricate
> > multi-step dance to overcome false positives:
> > https://github.com/google/syzkaller/blob/5962a2dc88f6511b77100acdf687c1088f253f6b/executor/common_linux.h#L3407-L3478
> > and only report leaks that are reproducible.
> > So far I have not seen any noticable amount of false positives, and
> > you can see 70 already fixed leaks here:
> > https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-gce-leak
> > https://syzkaller.appspot.com/upstream?manager=ci-upstream-gce-leak
>
> Thanks for the information and the good work here. If you have time, you
> could implement the stop_machine() kmemleak scan as well ;).

stop_machine will only help with pointers stored in registers/jumping
in memory. But there may be other sources of false positives like
hidden pointers via some hashing, offsets, reused low/high bits. Doing
several scans and crc checksum of object contents helps with these as
well and is orthogonal to stop_machine.
So now I wonder if using stop_machine will actually solve all
problems... because if not, then doing this work but then having to do
several scans and checksums anyway is kinda pointless...
