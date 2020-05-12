Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3976BC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1898B20736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZmCrcjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgELKPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:15:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:15:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b188so12912297qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPvMln8fETCvIb1O9zDTgMvwvAqRofofWlm0c6p2k1M=;
        b=GZmCrcjgtcCm4s480qly1KJ1qHt6LNr4Iqs2eH8PDxX04Qxu6dMhKOGW1hLPe3zrEe
         HCQ/K3D2cSoKKhNEZlK9rPNbzsz8y5vG/ieUSGjoJfwCdfjD/OQtWeN99+W+ZwqwNLPi
         VweR6RdSPSguDgiGOrHfa7LLfrIfctHl7/Ps/VCjcQ1GM4+1CdQoI+fj31etUHtPw4ov
         PdCKXYSfad49Vm/PAdXR6W4snDYYMeYTScbrv4dC9bQrLcgo9o9hJjGXew04FyUpJvO+
         xLqPVvkFgTRtbZ6ju7q6drxXDMYVH2qcLoRELr8dBNWKA4X57yGeH+f8Qjd826AdiE9a
         rOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPvMln8fETCvIb1O9zDTgMvwvAqRofofWlm0c6p2k1M=;
        b=X0hwCteS0iqfuvCVhRGQfz9kDrkFbeVqYZ7PZx1LvphwYHGJn06uUZBzJaFBTtWwFn
         gIzfWr/S1DPWl8HENKdncKsRZs8WpR0kWcJSuqAyDGytLaTc9thVVds1NsPk00Gaxx7W
         pKmE3tEw5Bz7Wn05u20jQr7/uoi1LFrAOjZHiqKZezCS9GTEXNL8fy4MJLbU7sMFK6+4
         wE1kmjFPom6X7PhxLcmGn7kK5K2Ebps06FNjO/TJKlJ9gl6zV9vLEVdvxJUFnRClRg7D
         OACFpZaFIvpAEz5X97l4f/g7WGoK2Ca1l8k9J05IHrKKHsXc8jqi2L93OmUqHKq5a+K5
         or7g==
X-Gm-Message-State: AGi0PuYx5bSFMl1WblppIeXfwnwHzqlKVblfwwC2uBhrRpTP5CLPQirG
        IGF4OUsc/D5A9wsLQzcgAuwk5knFXl09eXkUDeqDPQ==
X-Google-Smtp-Source: APiQypJ+DqbeC1O5KOyrpWyqx704axL30zwPYq7143oUeeXsMkdaCiq01Ps1n85YwDuFFgsTbC2lJqCPXxOu54bj/Ws=
X-Received: by 2002:a37:4b0c:: with SMTP id y12mr19417043qka.43.1589278520977;
 Tue, 12 May 2020 03:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dc82ac05a55f3005@google.com> <c8f94666-3e55-2421-78c6-c2cdd0f24d16@redhat.com>
In-Reply-To: <c8f94666-3e55-2421-78c6-c2cdd0f24d16@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 May 2020 12:15:09 +0200
Message-ID: <CACT4Y+bjwR1KUkGxU9iRM+hOnMq7id5E=i84RYv41ygrv-KCEQ@mail.gmail.com>
Subject: Re: INFO: task hung in do_read_cache_page (3)
To:     Mike Christie <mchristi@redhat.com>
Cc:     syzbot <syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 7:31 PM Mike Christie <mchristi@redhat.com> wrote:
>
> On 5/11/20 8:19 AM, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 2da22da573481cc4837e246d0eee4d518b3f715e
> > Author: Mike Christie <mchristi@redhat.com>
> > Date:   Tue Aug 13 16:39:52 2019 +0000
> >
> >     nbd: fix zero cmd timeout handling v2
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d6ab14100000
> > start commit:   e99332e7 gcc-10: mark more functions __init to avoid secti..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d6ab14100000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15d6ab14100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8a96cf498e199d8b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=518c54e255b5031adde4
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e45ec100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164444a4100000
> >
> > Reported-by: syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com
> > Fixes: 2da22da57348 ("nbd: fix zero cmd timeout handling v2")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
>
> How do you adjust/modify what is expected from the test or what is
> reported as an error?
>
> The patch added back behavior that got removed. With the patch we expect
> the hung task warnings, because we specifically want to hold onto
> running commands for longer than 120/hung_task_timeout seconds

Hi Mike,

All task hung messages are considered a kernel bug. So far this was
always true as far as I can tell. Tasks that are blocked for any
prolonged period should be killable.
