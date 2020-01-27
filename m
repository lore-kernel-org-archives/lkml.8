Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB99EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45BA214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXEi5bs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0SZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:25:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32416 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgA0SZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580149542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFX8a4sKZH8kQ5L4CHJJx/4RB7a0Z7xmq0iIUpWzSgw=;
        b=QXEi5bs5FoWhXc6GkufJC3vLNKSGxe8hKiTLlC86EmIXHWppj0FFAkDVqFs+r4QnTym7Jv
        PmSdo/8YarQ/WzNVT3TMsZSIhOxEGqMF/zLhVIzJhAYOmD/Oi5Gg5itmwMgFhr6N3X1Gac
        fnGV9AKZKo5mB8h4vjbVChBXLjbfHNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-AUr9arhGMYieUYN6Gi8Yng-1; Mon, 27 Jan 2020 13:25:38 -0500
X-MC-Unique: AUr9arhGMYieUYN6Gi8Yng-1
Received: by mail-wr1-f71.google.com with SMTP id f10so6600550wro.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFX8a4sKZH8kQ5L4CHJJx/4RB7a0Z7xmq0iIUpWzSgw=;
        b=gH4fHDbbhlMkI6xdR35wDY/PIS3olKnYI6QFGOTmhcFkIm3VZPaUjSMJv2hWrB5PAW
         JHNbb/YJPtnYVPau0Sy37bHb0j8k9Mpb+knnknC7em9d6wFaqiXIZrwdl6r/PMTfQilJ
         5858PKyYJg+Q873ptsXHGYZb9J8lkgWwD3LHP7O1+1USVWfHIhtxmStMopL1V2NL0UPq
         RSPxzPMKdA0I3j7fOU6nHPmsbDXPHIDM84oINTXBd4Rb7o4NgSCiKTixftfM6Azk3aiu
         Ph8JM6rnrK8m0v1FH54fzcMozDc6yjgB3ZZvFIZ0MRahhekHJPRaO3xhFqK5MLkS1pgs
         GtNw==
X-Gm-Message-State: APjAAAV46By8oQkB7fHGK/MP37eS7rLZfTFlXyYZL1+pTl/Z0DrdRGQ/
        qNTZaQf8lj9+vziYzSRW6jw0oOMQNJGaLZ5BvVPKGF6RiMux8qV5EeYWe484MhwhBMcMuf/BkI/
        yxAnqUvTTwZVfMz02lajEGJt0
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr23259wme.59.1580149537060;
        Mon, 27 Jan 2020 10:25:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDrE5ynqU3V8zhMZJssfW8GCZe6nB1OYfPuUC0PRWyZEmUR9pW1XXezbAKi6dGcOgvbIoxHA==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr23244wme.59.1580149536832;
        Mon, 27 Jan 2020 10:25:36 -0800 (PST)
Received: from steredhat ([80.188.125.198])
        by smtp.gmail.com with ESMTPSA id w8sm21405151wmm.0.2020.01.27.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 10:25:36 -0800 (PST)
Date:   Mon, 27 Jan 2020 19:25:34 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH liburing 1/1] test: add epoll test case
Message-ID: <20200127182534.5ljsj53vzpj6kkru@steredhat>
References: <20200127161701.153625-1-sgarzare@redhat.com>
 <20200127161701.153625-2-sgarzare@redhat.com>
 <b1b26e79-507a-b339-2850-d2686661e669@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b26e79-507a-b339-2850-d2686661e669@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:32:43AM -0700, Jens Axboe wrote:
> On 1/27/20 9:17 AM, Stefano Garzarella wrote:
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> You're not reaping CQ events, and hence you overflow the ring. Once
> overflown, an attempt to submit new IO will returns in a -16/-EBUSY
> return value. This is io_uring telling you that it won't submit more
> IO until you've emptied the completion ring so io_uring can flush
> the overflown entries to the ring.

How can I reaping CQ events? (I was hoping the epoll would help me with that)

What I'm seeing is that the producer (EPOLLOUT) can fill the SQ without issues,
the consumer (read()) is receiving all the buffers produced, but the thread
that frees the buffers (EPOLLIN) is not woken up.

I tried to set a timeout to the epoll_wait(), but the io_uring_peek_cqe()
returns -EAGAIN.

If I'm using a ring with 16 entries, it seems to work better, but
sometimes I lose events and the thread that frees the buffer doesn't wake up.

Maybe I'm missing something...

Thanks,
Stefano

