Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC65BC3524E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9293820661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZXnNB0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBCJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:03:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40474 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727308AbgBCJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580720593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QS5DhuU6CK4wbCVngU1PiTIKsJWzHpQ1TW55BC4N5Uk=;
        b=IZXnNB0DOYQuEkj6LyIS4l5Q7a3tvKRIX4/Pr+2rRCQP5PrBQ+eznUezD+lEhk53XABvQF
        YBtgsDIGcGJ8Bs1RdQkc8ZriYW8Oronr/LnaZumIxSX7zDY9NJjb1Hx/Yx+rKgaSVIbDnf
        ymy/CCtl9dAQ5eXyeDMCKRXuQ8IfzFo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-OMm89g0cPG2M720TmisTDg-1; Mon, 03 Feb 2020 04:03:11 -0500
X-MC-Unique: OMm89g0cPG2M720TmisTDg-1
Received: by mail-wm1-f70.google.com with SMTP id m21so3758085wmg.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QS5DhuU6CK4wbCVngU1PiTIKsJWzHpQ1TW55BC4N5Uk=;
        b=MCVwkEVlFOSUBPjC6sf8MJ5i3NikCCMVyCmKt3w4W1twZrjLsdoGd24QlkwhC85dK2
         1gMM1TcV9plqZk5wH2OJD0Rto6YkjUjvAwUHo44dkFB7G+Y3gJm8QEDiFl1k8tqTTKiu
         CsEaCbkSTBDExxW+qx5J3Frn4FV35UtVKSDHYat7gSLf//sv/yMQiMqNonrgo3QudPcx
         vKNb3tbNQoxxDPZnWehr6S5xGAypFAcqcjYKNfS6bwmDfvMQw+AgIQVeO4IP9bIeqrcD
         o3o5qEQFzZ0Jm3pTZqpvuZ7kbMKZsDSEAYFb+Fhf7cMOGubukPDu3R5PeOPAK+YymSeG
         3UFg==
X-Gm-Message-State: APjAAAVZH4cquQoKDmLuSFbEZeYaEVz7Z7lz5A0bAt/JrU0dEN56ZQ5M
        k1yKSvm8VXYLtiUasadloTsC1IHWYpmsOSTT9XelXf1nXtsNWopg4OEexD0VXbHMdnJD5YyYsYD
        HcRQ0lrUNpQO6RBuiYWVAF1La
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr14468724wrp.54.1580720590378;
        Mon, 03 Feb 2020 01:03:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0JZN0rHbvb/Lu2ak4/sjEHlVgc/AoTaAYJxDdu2O/mLRd8Vkl39m/5i4aqwiKZvESy1fumw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr14468698wrp.54.1580720590131;
        Mon, 03 Feb 2020 01:03:10 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id f189sm24145163wmf.16.2020.02.03.01.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:03:09 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:03:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH liburing v2 0/1] test: add epoll test case
Message-ID: <CAGxU2F4kKCGeg0xrGsAkj=ZWkfbswxswm6QF2EzDH_6+QQk5Zg@mail.gmail.com>
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

Yes, If I use the io_uring_wait_cqe() instead of io_uring_peek_cqe() all
the tests work great, but it is blocking and the epoll_wait() it is used
only the first time.

>
> > I hope my test make sense, otherwise let me know what is wrong.
>
> I'll take a look...

Thanks!

>
> > Anyway, when I was exploring the library, I had a doubt:
> > - in the __io_uring_get_cqe() should we call sys_io_uring_enter() also if
> >   submit and wait_nr are zero, but IORING_SQ_NEED_WAKEUP is set in the
> >   sq.kflags?
>
> It's a submission side thing, the completion side shouldn't care. That
> flag is only relevant if you're submitting IO with SQPOLL. Then it tells
> you that the thread needs to get woken up, which you need io_uring_enter()
> to do. But for just reaping completions and not needing to submit
> anything new, we don't care if the thread is sleeping.

Thank you for clarifying that,
Stefano

