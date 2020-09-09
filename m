Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA1FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C93221973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah0lIFLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIIKEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgIIKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599645848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xgpe6AT0UH4aDp5ykLA0ugjbjmAIMFTMCg4Q4aJi8W4=;
        b=Ah0lIFLrde0uX1aZHJdNHdUjBzLkfR4y0I+6fIHE7HKfq93i2G7sSqjtFxO5ss0ZmTtVTK
        0tqgs8VyaCRsFaK5JEKPE6DqsKP5cXjfv6vynqdVasqgQdNqpb97zx3PlsfBmwhf0ll1uK
        sdhvXBBkWVPde5IJM5SmSrEBWCXGYws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-S7xj42T3O5SkebEzdQf29w-1; Wed, 09 Sep 2020 06:04:00 -0400
X-MC-Unique: S7xj42T3O5SkebEzdQf29w-1
Received: by mail-wr1-f70.google.com with SMTP id r16so769940wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 03:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xgpe6AT0UH4aDp5ykLA0ugjbjmAIMFTMCg4Q4aJi8W4=;
        b=BqE9X6uKqNYhUYqwERm2CgScJVqfu55kwnI95iRnkejsbBB+xScbgC+lliVrh6XW2k
         S9r9D3eyJ8v8H6ypH8bV/qNV/10Zyfh+eSuc0+nzFI8j8mPZOJEKNcsRe2XFjgUHUNJM
         Ll8re+Z6EwGZ4BGA6dSbf77wnE+YCKT+pYQ7Lmf9e8eAHWUPRbgILcydil66KCYtIOsJ
         Os/oWbQRQYjoiaLACG+bPh4+Qn3JKlC96aYR6fMdiNoB9zRjFPqRtxOnjobfeTuSBlff
         6hNctn1wu8q1b03yYt5RsSDBUhpOK72MmnFnaOOU/3n+4ZIwU2WpKK2xwh43td8ZFGNq
         lsdQ==
X-Gm-Message-State: AOAM531iH2BNLnV1rxceogxINWmeK1TUQN6AHIM3S3RzEL2TF14zV7ni
        OSTtUo9gof9yNP8YwnPn5OHCBEDNL6SstNOltDI3cV94o1kAo0VTfT22CKv7qMKcJYZJueGKLj3
        wlTt/l7hc8Fy4TaWCFseoy+93
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr3055061wru.232.1599645838889;
        Wed, 09 Sep 2020 03:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxzpk4/SFORo74kpPgFd3e7iurHZ1Y5Kodi+AuWqmcAZhebg/lKbKSiR2B2/p/oi5E2UOPzg==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr3055044wru.232.1599645838666;
        Wed, 09 Sep 2020 03:03:58 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id y1sm3133255wma.36.2020.09.09.03.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:03:58 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:03:55 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     syzbot <syzbot+3c23789ea938faaef049@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in io_sq_thread_stop
Message-ID: <20200909100355.ibz4jc5ctnwbmy5v@steredhat>
References: <00000000000030a45905aedd879d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000030a45905aedd879d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 01:49:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dff9f829 Add linux-next specific files for 20200908
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=112f880d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c23789ea938faaef049
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c082a5900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474f5f9900000
> 
> Bisection is inconclusive: the first bad commit could be any of:
> 
> d730b1a2 io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
> 7ec3d1dd io_uring: allow disabling rings during the creation

I'm not sure it is related, but while rebasing I forgot to update the
right label in the error path.

Since the check of ring state is after the increase of ctx refcount, we
need to decrease it jumping to 'out' label instead of 'out_fput':
diff --git a/fs/io_uring.c b/fs/io_uring.c
index d00eb6bf6ce9..f35da516095a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8649,7 +8649,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
                goto out_fput;

        if (ctx->flags & IORING_SETUP_R_DISABLED)
-               goto out_fput;
+               goto out;

        /*
         * For SQ polling, the thread will do all submissions and completions.

I'll send a patch ASAP and check if it solves this issue.

Thanks,
Stefano

