Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E326C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D2206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBnnNKgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgIIRTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729860AbgIIP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599665221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDWO8mkPjTmNhXQJGJVs3cfb8cCdbkUvXt6QGd7ZUJ8=;
        b=fBnnNKgGqRHGbiiJ43MOSTjDqmWnxKJ/S9OrSCB0E8Sl1zAOv4tJRYmm/ZMeA6WZr7aFlM
        lhkF2p2NzaEAz4nFmaQYlb8GuTmkqAy1x4sMjmUbd19Qdj+5hOesAqkEvW2l433+tLIRb4
        NQBxP9/oImptfVIXYMPH6HEvGckiCH4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-61o_xtKEOvWdWzQSazHOgQ-1; Wed, 09 Sep 2020 11:07:37 -0400
X-MC-Unique: 61o_xtKEOvWdWzQSazHOgQ-1
Received: by mail-wr1-f70.google.com with SMTP id v5so1059756wrs.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qDWO8mkPjTmNhXQJGJVs3cfb8cCdbkUvXt6QGd7ZUJ8=;
        b=mBfdMonEHd/b8YL+Orl03Cl2WqQ61Y6s9uxX3oD1Stsgs7ytim5+X4TJJqpTiPenjE
         WWSiQ7pet2WHF+wBHGHCo7+S6RxauWPO/6CI/4X3uo+OawZPP4M5SWoZ54RzuFY/KYml
         W3StBgn762vtzNmtDKmoFk5e5vKcF75f+0KZ4j5BKb7PTReQ90ohpBhXW27tx8JJ8VzV
         wQp+5fJpaHt/ztdtYsTSUlxKGRfaczHurKfuuT7Iq6c+Ns6N+H4tLvQyWa903flo9k0V
         p8hpe5UyRDz5q67/FA9/TIg6cpYQFxGGFq/8IY7ZOnhNLZp63+PdzZRh+1xpgHgo9UGo
         2cSA==
X-Gm-Message-State: AOAM5325co4+Bmivp7bNU5lzWBCau/oCIsOMoZ3f5VVMhuHQAWTwiG0q
        5Xk7aAgY6R7arvOQd2N0KErWaZI8/kHqq1ebQR6y7pJSqh2mdMguSeQ+BapfAiMjOupWVngBIga
        Vwai4f0QreLeKcAF2/KI5+rS9
X-Received: by 2002:a5d:6912:: with SMTP id t18mr4588742wru.326.1599664056036;
        Wed, 09 Sep 2020 08:07:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgmR6wsbqHZOimKtiUwJzkt0tPbLVLRW+WLKXdq2Ipz3PC56iDhT/bGnogsPhYTPglvB4/+w==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr4588724wru.326.1599664055788;
        Wed, 09 Sep 2020 08:07:35 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id g186sm4476245wmg.25.2020.09.09.08.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:07:35 -0700 (PDT)
Date:   Wed, 9 Sep 2020 17:07:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+3c23789ea938faaef049@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in io_sq_thread_stop
Message-ID: <20200909150727.wbatiuzl3o6u3vgo@steredhat>
References: <00000000000030a45905aedd879d@google.com>
 <20200909100355.ibz4jc5ctnwbmy5v@steredhat>
 <fa8f11bf-d0e6-42b9-0a2e-2bb4c8679b99@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8f11bf-d0e6-42b9-0a2e-2bb4c8679b99@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:03:32AM -0600, Jens Axboe wrote:
> On 9/9/20 4:03 AM, Stefano Garzarella wrote:
> > On Wed, Sep 09, 2020 at 01:49:22AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    dff9f829 Add linux-next specific files for 20200908
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=112f880d900000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3c23789ea938faaef049
> >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c082a5900000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474f5f9900000
> >>
> >> Bisection is inconclusive: the first bad commit could be any of:
> >>
> >> d730b1a2 io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
> >> 7ec3d1dd io_uring: allow disabling rings during the creation
> > 
> > I'm not sure it is related, but while rebasing I forgot to update the
> > right label in the error path.
> > 
> > Since the check of ring state is after the increase of ctx refcount, we
> > need to decrease it jumping to 'out' label instead of 'out_fput':
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index d00eb6bf6ce9..f35da516095a 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -8649,7 +8649,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
> >                 goto out_fput;
> > 
> >         if (ctx->flags & IORING_SETUP_R_DISABLED)
> > -               goto out_fput;
> > +               goto out;
> > 
> >         /*
> >          * For SQ polling, the thread will do all submissions and completions.
> > 
> > I'll send a patch ASAP and check if it solves this issue.
> 
> I think that's a separate bug, it's definitely a bug. So please do send
> the fix, thanks.
> 

Sure I'm sending it!

Thanks,
Stefano

