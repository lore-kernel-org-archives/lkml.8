Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CC520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT0bKi1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGQvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:51:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbgBGQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581094302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVXuAtjnpbpcK/3nLiV4H0z/0WWAHLdJP08LfBHlaek=;
        b=AT0bKi1rAJF864bqwCiMLsFGEIaknytP1t7keHm0Uwx8IE63fYRJfIgi+BiK9ekwQtUVZH
        q1qQcnIVM41ZFL02ZTFQ/IeopDBu3aO7K+/F6NlpP7SVoAA/TMQAvwHBuqMWf43auAQgO9
        fKq4LbWfpV0dRQE8jtsJp0zUsdpVUV4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-sFa80aDTM-C2Le3ngKY3rw-1; Fri, 07 Feb 2020 11:51:40 -0500
X-MC-Unique: sFa80aDTM-C2Le3ngKY3rw-1
Received: by mail-wr1-f69.google.com with SMTP id v17so1534194wrm.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVXuAtjnpbpcK/3nLiV4H0z/0WWAHLdJP08LfBHlaek=;
        b=WYJtBrh1INTS+l7kzsBmKTpdkhzXfUmYEoBJMTjbp0QwPqTlBB9VQ2BTT7rRE7eLR/
         n7/ZXOgq6MA/5CiTfyC3aFzwBkHbj9rCOXQ/XTh3psySgOrMX7NjvLrgl742f5l7xQHr
         3PZoSYt/be4LJUqlHKPPAxk/aOQpcEIZNJOSggXpOXa0dyXyQMzzW4ZKtXnqd28MASCp
         wob4GjxebiZCTUcpOQIERQKQ4UO3ghV7jPe/Q4Zh97aXF3am0V6HQTauq2HiCpRyClfR
         itJSuqsX/8MgxdXRFCvslQ7m1xUuG9r/xrOVb/Qi1A5UcoiB9pEreiADVP8strFtVBVn
         hSyQ==
X-Gm-Message-State: APjAAAVIyCyzVGrKCcy9O5Wz9wILJg6CF2pIK2eEKYn6kfh2gxtQHtlq
        02jtpXDeIHr+tUtNe+FR/nIsaaRLWHdyZbVlkBqxt46ZpHU7ZYa6Td0YOBor1bE7vpvlPdlsWNn
        J9E8I1HJBzZT+d8+XF+Al1pVm
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr5840237wrs.326.1581094298910;
        Fri, 07 Feb 2020 08:51:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzp/ezdHBZZrxPIKD1yBYT/Gv3/DifAUAHfSsdpcBUQ73NODVcVye7Hica2tMzT9rM05bFfZg==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr5840216wrs.326.1581094298639;
        Fri, 07 Feb 2020 08:51:38 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id o4sm4149232wrx.25.2020.02.07.08.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:51:38 -0800 (PST)
Date:   Fri, 7 Feb 2020 17:51:36 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH liburing v2 0/1] test: add epoll test case
Message-ID: <20200207165136.obdezxvcws4eupbu@steredhat>
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

On Fri, Jan 31, 2020 at 08:39:46AM -0700, Jens Axboe wrote:
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
> 

Just an update: after the "io_uring: flush overflowed CQ events in the
io_uring_poll()" the test 3 works well.

Now the problem is the test 4 (with sqpoll). It works in most cases, but it
fails a few times in this way:
- the submitter freezes after submitting X requests
- the cleaner and the consumer see X-2 requests (2 are the entries in
  the queue)

I tried to put a timeout on the submitter's epoll and do an io_uring_submit()
to wake up the kthread (if we lose some notifications), but the problem seems
to be somewhere else. I think a race somewhere.

Any suggestion on how to debug this case?
I'll try with tracing.

Thanks,
Stefano

