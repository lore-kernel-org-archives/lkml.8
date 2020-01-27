Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3E12467E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUQ0gI0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0Sub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:50:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgA0Sua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580151029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1Gai6vxTjkumKj6PkexgQY+X4x4Qxy3rVtAsMEidoI=;
        b=AUQ0gI0ZHj2OP7SLapkIGMn/UIHRvT7M9K5A/wXQsLXlNF9ra2/8rZvNwwwQJC5DshfLG8
        XhmEvnzefn1yLvNjnucNVDstTBeas5O91DEVI4wfAVsuBlca6wsdb3kkr5hv1UQO+BphjG
        oK0AA9Fj/RGHSSXo2rng9bqZF+REjoA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-zm28AmxDNvmOZvL5-b6WRA-1; Mon, 27 Jan 2020 13:50:27 -0500
X-MC-Unique: zm28AmxDNvmOZvL5-b6WRA-1
Received: by mail-wm1-f70.google.com with SMTP id m21so1902971wmg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1Gai6vxTjkumKj6PkexgQY+X4x4Qxy3rVtAsMEidoI=;
        b=tEiAWTW+wgH/xCyHJjFYjtVf52Z4nwiWZfOoCJXpVM54zQw8OnAENFxxhEFuQBDw/5
         uOdaFmxJ+MzpzszROQbllXkn2nvF2yT7HzpS2mETC4wE3xk3KVI33WvC0IB9DFA2vM79
         Y7nuUQOqgWnbWWL8fqilzH0oCJfZ3rfjaKjckxhIRJVNRG9hrHUBowHGqOVZLxb+HReb
         wBhc/u463kQtgASObcPmvnzE/+4T9TR/KM7GkuEMy8I42nqF1vY7LCGelaGDIWde7u6P
         HKW7G4K+B7Hk4lvZ3iSMYbfZY/MX93h0AnquEeQRa7ag0NfzQvdxnVPfLpRjdLi/KH86
         vmlw==
X-Gm-Message-State: APjAAAV2/42SLq0NOlNk1ErOifMSuMa8vPDIRHdr7F/HqZnb9QFA4zvW
        fbnF21A1fXc9+8M8ls+EM/UOkvYkmnwOHGpDrChrpUpy4inrhKtI39vH5MP6l0186fdFFKGg0xu
        UP0uB41eey2iR5U4KOmyklqHs
X-Received: by 2002:a1c:4144:: with SMTP id o65mr28714wma.81.1580151026732;
        Mon, 27 Jan 2020 10:50:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAwOQAd2U/RwoyuZU05L0e9solmdu8yt3ejwrX511RNsTq4+1QZAZv6aqaSgF3SixnfB11VA==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr28695wma.81.1580151026505;
        Mon, 27 Jan 2020 10:50:26 -0800 (PST)
Received: from steredhat ([80.188.125.198])
        by smtp.gmail.com with ESMTPSA id b10sm23618928wrt.90.2020.01.27.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 10:50:25 -0800 (PST)
Date:   Mon, 27 Jan 2020 19:50:24 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH liburing 1/1] test: add epoll test case
Message-ID: <20200127185024.zp4n3d6jktgnoznq@steredhat>
References: <20200127161701.153625-1-sgarzare@redhat.com>
 <20200127161701.153625-2-sgarzare@redhat.com>
 <b1b26e79-507a-b339-2850-d2686661e669@kernel.dk>
 <20200127182534.5ljsj53vzpj6kkru@steredhat>
 <646cbb04-9bef-0d99-64ec-322d1584abe7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646cbb04-9bef-0d99-64ec-322d1584abe7@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:46:34AM -0700, Jens Axboe wrote:
> On 1/27/20 11:25 AM, Stefano Garzarella wrote:
> > On Mon, Jan 27, 2020 at 09:32:43AM -0700, Jens Axboe wrote:
> >> On 1/27/20 9:17 AM, Stefano Garzarella wrote:
> >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>
> >> You're not reaping CQ events, and hence you overflow the ring. Once
> >> overflown, an attempt to submit new IO will returns in a -16/-EBUSY
> >> return value. This is io_uring telling you that it won't submit more
> >> IO until you've emptied the completion ring so io_uring can flush
> >> the overflown entries to the ring.
> > 
> > How can I reaping CQ events? (I was hoping the epoll would help me with that)
> > 
> > What I'm seeing is that the producer (EPOLLOUT) can fill the SQ without issues,
> > the consumer (read()) is receiving all the buffers produced, but the thread
> > that frees the buffers (EPOLLIN) is not woken up.
> > 
> > I tried to set a timeout to the epoll_wait(), but the io_uring_peek_cqe()
> > returns -EAGAIN.
> > 
> > If I'm using a ring with 16 entries, it seems to work better, but
> > sometimes I lose events and the thread that frees the buffer doesn't wake up.
> > 
> > Maybe I'm missing something...
> 
> OK, so that helps in terms of understanding the issue you are seeing with
> it. I'll take a look at this, but it'll probably be a few days. You can

Sure, take your time!

> try and enable tracing, I see events completed just fine. Maybe a race
> with your epoll wait and event reaping?

Could be. I'll try to investigate better enabling the tracing!

Thanks,
Stefano

