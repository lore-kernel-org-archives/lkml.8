Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B31C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1C021741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHUkb/dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBFRd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:33:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727358AbgBFRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581010434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BklOOZtpEbXR2lfLsVN/Nzs8K2IHl/5W7tD5xZRKzIw=;
        b=VHUkb/dCf1lkz/dTqsEpTq08yK+skgf6XxRl0xd674ZeA6tabIVBbCk+W3PHfYsxzxYKDg
        Thxl1zuPme50MS7F+DUazBQe2p+Oygs0QneI5dtTPuvxHGkBYsW0iHXkKnhJQUQwIIduPG
        cGVa3u/7FI2WRuUKVtmSV9C9RQqAkCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-9lJ2arPGN7mHAMEqyIiJFw-1; Thu, 06 Feb 2020 12:33:52 -0500
X-MC-Unique: 9lJ2arPGN7mHAMEqyIiJFw-1
Received: by mail-wm1-f72.google.com with SMTP id a10so363710wme.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 09:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BklOOZtpEbXR2lfLsVN/Nzs8K2IHl/5W7tD5xZRKzIw=;
        b=L1MByaNqFF2jQ6idzJcpuwNXLELp0gVP7NYtL8o0+vFXpvizlN6eZteT/oEnuIf68T
         BCWIFX4l5+mYsUiGBTwNvYwUA7l32M2zF2s0jADiZMYdMq8HfHDV5lqOFEuwP/D7Rn77
         +aBk685Hk8IJrZO1JkctJJV0pw1xS9ZDN0g+jV2ISKBX8wHEYzJJ04og/1Vj7ZbfxzKM
         Skki2Ulx0IanGb/zR8fjObJufkT+MuSjiN0dwWg/tVR4fNDu/FUr15mrWtqPz8qHUX0Q
         /+S42ppnEBpJBmT7nE03rnnPIaev5lmXS3u8DjMEkMQBtBxBRe1r0SL8LrTMzYX5T4qM
         0DcA==
X-Gm-Message-State: APjAAAVNbzeDpj0o0DYX9BY50Xsx8qDHGD1Ij+HQ9gaHONcKplHV6o+l
        ztwyariWFkdddkh7KWG1B2H0PHMXuOQyYJQAvLEeyfdyIBv6xT0qhIKIDXlcxSg0zxYMnh4o04g
        V0TGoKScXB4Avjr4kUBveeBRE
X-Received: by 2002:a1c:7915:: with SMTP id l21mr5504745wme.112.1581010431052;
        Thu, 06 Feb 2020 09:33:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/LgvjhDqPglzyKZz65I/FvXOuZVvP6MOg0sTKNxQjVoAU4NrjaJmmLB1IwT7DfEihNiQf7w==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr5504712wme.112.1581010430684;
        Thu, 06 Feb 2020 09:33:50 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id z133sm263777wmb.7.2020.02.06.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 09:33:50 -0800 (PST)
Date:   Thu, 6 Feb 2020 18:33:48 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH liburing v2 0/1] test: add epoll test case
Message-ID: <CAGxU2F6qvW28=ULNUi-UHethus2bO6VXYX127HOcH_KPToZC-w@mail.gmail.com>
References: <20200131142943.120459-1-sgarzare@redhat.com>
 <ebc2efdb-4e7f-0db9-ef04-c02aac0b08b1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc2efdb-4e7f-0db9-ef04-c02aac0b08b1@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jan 31, 2020 at 4:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/31/20 7:29 AM, Stefano Garzarella wrote:
> > Hi Jens,
> > this is a v2 of the epoll test.
> >
> > v1 -> v2:
> >     - if IORING_FEAT_NODROP is not available, avoid to overflow the CQ
> >     - add 2 new tests to test epoll with IORING_FEAT_NODROP
> >     - cleanups
> >
> > There are 4 sub-tests:
> >     1. test_epoll
> >     2. test_epoll_sqpoll
> >     3. test_epoll_nodrop
> >     4. test_epoll_sqpoll_nodrop
> >
> > In the first 2 tests, I try to avoid to queue more requests than we have room
> > for in the CQ ring. These work fine, I have no faults.
>
> Thanks!
>
> > In the tests 3 and 4, if IORING_FEAT_NODROP is supported, I try to submit as
> > much as I can until I get a -EBUSY, but they often fail in this way:
> > the submitter manages to submit everything, the receiver receives all the
> > submitted bytes, but the cleaner loses completion events (I also tried to put a
> > timeout to epoll_wait() in the cleaner to be sure that it is not related to the
> > patch that I send some weeks ago, but the situation doesn't change, it's like
> > there is still overflow in the CQ).
> >
> > Next week I'll try to investigate better which is the problem.
>
> Does it change if you have an io_uring_enter() with GETEVENTS set? I wonder if
> you just pruned the CQ ring but didn't flush the internal side.

If I do io_uring_enter() with GETEVENTS set and wait_nr = 0 it solves
the issue, I think because we call io_cqring_events() that flushes the
overflow list.

At this point, should we call io_cqring_events() (that flushes the
overflow list) in io_uring_poll()?
I mean something like this:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 77f22c3da30f..2769451af89a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6301,7 +6301,7 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
        if (READ_ONCE(ctx->rings->sq.tail) - ctx->cached_sq_head !=
            ctx->rings->sq_ring_entries)
                mask |= EPOLLOUT | EPOLLWRNORM;
-       if (READ_ONCE(ctx->rings->cq.head) != ctx->cached_cq_tail)
+       if (!io_cqring_events(ctx, false))
                mask |= EPOLLIN | EPOLLRDNORM;

        return mask;

Thanks,
Stefano

