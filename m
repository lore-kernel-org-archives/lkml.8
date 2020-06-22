Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790A52071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqma2vVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgFVOfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:35:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728504AbgFVOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592836520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8LciREWJsj9AQY8WoqbJEs9+BzHuuZ2kYt75+dmYbI=;
        b=hqma2vVQ6GbNxolpthJP8wzThywsuwO2g72qG5AhqMyTrJWTLRtN1croR/l1QMy6IF4+rh
        JWC0gQBarCkLRmFOsNzV49EQ0Pm2LPT8Sqj4JDRX4SqfUP2c3AFLZFj1SEHpLLuaV5DAmx
        C55MxWNDxHG4iQmzA7us75A6mqCrtTo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-A8iKzda7OoGKvcY0HYwSHA-1; Mon, 22 Jun 2020 10:35:17 -0400
X-MC-Unique: A8iKzda7OoGKvcY0HYwSHA-1
Received: by mail-oo1-f71.google.com with SMTP id v9so8694100oov.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8LciREWJsj9AQY8WoqbJEs9+BzHuuZ2kYt75+dmYbI=;
        b=D4XXJ6TQ8cnjwShKUCfijFBnwao6U40lEhLxMBBsJpNiPK9685x6Dq/CD3DR5bQUhO
         2qlTzdyhmBieBLsplUbYjocjBg+X6E5PrhVaUDZdx2nAvBIJRXJ6Y22rb93c8j+MpIKy
         pV7dpzZpKADcfXRaARamTHqNIo2eCfMFEvVKbHvmVG80vKpAo4hCltM1j4tab1brP9Xn
         /R46b++n+RT+M67x7GC9k8xnvRpbpa4AHTd6LGrGnDNtyfVOR6Z6xYfi2jlybYb5boqj
         wnDLvEQJpF/ss3gVAunJiljQcpjR7djHufFxk1Q3920ox2Fm6RkJTq7YjOogBMVmPQ1K
         o8hg==
X-Gm-Message-State: AOAM531Xx7N7Ldf730txsWmB17Lq6DiB9eNVyUy3LKLyBXEWNXxqVnUz
        +OTK+xCvfN1ohA1r/sWJv8vgkYT1lqX75NDsp+GpUpx6Azm8q1lcnVQfnSG5ib7nf2X7N+koSw+
        XY+TQ5kMG/wWf1pcDqxkYb0eONZvkrl6FnUCqpRAk
X-Received: by 2002:a4a:868a:: with SMTP id x10mr5394720ooh.31.1592836517114;
        Mon, 22 Jun 2020 07:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmNbgEQyfxangZ/xtw/LtBecn8SD7Han8BUwPHyelwFuDLXZvgVZ4AhpiZLmG4l0zJHroGpJ6M/R2ujIRrCNs=
X-Received: by 2002:a4a:868a:: with SMTP id x10mr5394700ooh.31.1592836516902;
 Mon, 22 Jun 2020 07:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <20200622003215.GC2040@dread.disaster.area>
In-Reply-To: <20200622003215.GC2040@dread.disaster.area>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 22 Jun 2020 16:35:05 +0200
Message-ID: <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 2:32 AM Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> >
> > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > The advantage of this patch is that we can avoid taking any filesystem
> > lock, as long as the pages being accessed are in the cache (and we don't
> > need to readahead any pages into the cache).  We also avoid an indirect
> > function call in these cases.
>
> What does this micro-optimisation actually gain us except for more
> complexity in the IO path?
>
> i.e. if a filesystem lock has such massive overhead that it slows
> down the cached readahead path in production workloads, then that's
> something the filesystem needs to address, not unconditionally
> bypass the filesystem before the IO gets anywhere near it.

I'm fine with not moving that functionality into the VFS. The problem
I have in gfs2 is that taking glocks is really expensive. Part of that
overhead is accidental, but we definitely won't be able to fix it in
the short term. So something like the IOCB_CACHED flag that prevents
generic_file_read_iter from issuing readahead I/O would save the day
for us. Does that idea stand a chance?

We could theoretically also create a copy of
generic_file_buffered_read in gfs2 and strip out the I/O parts, but
that would be very messy.

Thanks,
Andreas

