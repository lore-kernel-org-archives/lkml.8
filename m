Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E3C3524E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE8220661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRJ/xczl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgBCJEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:04:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36497 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727133AbgBCJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580720652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6fxCf78eVhuUAJ68T4mXmDzlZwZiDCeV31HsdqoAPA=;
        b=cRJ/xczlawbuqevs9NVEPeP2a+HphBQU4H0OgaBSNW25TJTpab8EV5d8xPKk4tfCLXHruK
        3S/AExvdldWf4ve9RARETRCntFgQoeCmEBzZHBy0QZdRGo7q8xjjZZgbPppOXabbjCHq8N
        1LgcVTzFv76ERgE7/faLXHaV15D2y/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Ak6DEi-yPEaSLEoRJzncuw-1; Mon, 03 Feb 2020 04:04:10 -0500
X-MC-Unique: Ak6DEi-yPEaSLEoRJzncuw-1
Received: by mail-wr1-f70.google.com with SMTP id t6so4803050wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6fxCf78eVhuUAJ68T4mXmDzlZwZiDCeV31HsdqoAPA=;
        b=ZBtxhITLx7xqUYBKaksNyEYYyEfM+parxJYySOrChRfFYdVI0RmwhtNX32StzbtZb+
         f75N2Q2sUOKGCmLnwg2wettEe0Vlnp9EArCLIQUNWcla1UE8pcNLznSsD3rKaGAVxQRb
         hnLKc6OCY7P3R39jKNMs+SL7OeOZV4k04sL3kQFI81ln2G4zHRvV2PZO9pAYtW/UlvFu
         5EZ5/cN1AGdvbkdnoLzRU9BS2AM/OO9Q2l4ZvYO/vOdvFLHLB6wFP/TuUFQBF0uYTEBt
         OK0yHUqhmH5gxj+D1o2XY+3YmeUgt0oCjGD1dCumlPD4juesHnOz+miOsBuafNKy90Z3
         fcjw==
X-Gm-Message-State: APjAAAU6Ue/m7R5cd1vuaUxWwAp4Yy+Klz4+fZnKRZH8MEt0ELSUTRFa
        SGoHOjFFB75Fj6oIHh7zofBY/mR0QkgQ1PSNmb2aCYzZG2juBlvU7Sr4vr5B3IY+u40RYDo+Ie8
        V5oT6nTrFhNcPMYy/U9XBreMb
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr14314706wrj.225.1580720649224;
        Mon, 03 Feb 2020 01:04:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYREAVG5O0ErdfVCjrJuHlKZLavmASH0lil9NjCzoWb7VUJmnMW/g8uhNveQrKDhLPzLxliw==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr14314686wrj.225.1580720649063;
        Mon, 03 Feb 2020 01:04:09 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id z3sm7458497wrs.32.2020.02.03.01.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:04:08 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:04:06 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH liburing v2 1/1] test: add epoll test case
Message-ID: <20200203090406.mlgmw2u7lv7a76vd@steredhat>
References: <20200131142943.120459-1-sgarzare@redhat.com>
 <20200131142943.120459-2-sgarzare@redhat.com>
 <00610b2b-2110-36c2-d6ce-85599e46013f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00610b2b-2110-36c2-d6ce-85599e46013f@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:41:49AM -0700, Jens Axboe wrote:
> On 1/31/20 7:29 AM, Stefano Garzarella wrote:
> > This patch add the epoll test case that has four sub-tests:
> > - test_epoll
> > - test_epoll_sqpoll
> > - test_epoll_nodrop
> > - test_epoll_sqpoll_nodrop
> 
> Since we have EPOLL_CTL now, any chance you could also include
> a test case that uses that instead of epoll_ctl()?

Sure, I'll add a test case for EPOLL_CTL!

Stefano

