Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD19C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48ED22314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqpvhNfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGQjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:39:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbgBGQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581093539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y3B0NGs/W84aAaWzmg3vv3+Dtgz3ksAr9b9eZvFXTsE=;
        b=QqpvhNfSLA9Y7rfHB2+PxmwMGkI2+96Zbu/ticUsYElVip9WxuRvhFNQzwTHrloclByeUS
        zU+hfqFfXChwRQ/GAwxlqmBR3k1l0HeqYYywRDiVEMKrnT1qs7Sw1cvTfy/r+F3dgSRih7
        /iqDA+TFaX4RIsAKAqa5BH9TWeJJqxI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-1eR0feaMNHWiWJWm2FtRGA-1; Fri, 07 Feb 2020 11:38:57 -0500
X-MC-Unique: 1eR0feaMNHWiWJWm2FtRGA-1
Received: by mail-wm1-f72.google.com with SMTP id d4so975361wmd.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3B0NGs/W84aAaWzmg3vv3+Dtgz3ksAr9b9eZvFXTsE=;
        b=qlsjeI3tul2ysY9z+5HtzQgl6K73ilMSFZtGPGs0Z2YxY14CzpjvCva4UchpEl/l7j
         VZcqjEHa3vxXVnRgwBodIAvjiluceBSEUSvKFWdID55m8oEhtiIwrCgp9bBRnBQcLhlZ
         Alnyrx/waR+rK7V/eVO23gHXBA6VAHdBXq+T1AIh7xo+zimOAc++l2KkGG5kZR5zUt5Q
         w6IC8Wy946q+gP69Giq0cBEmNMEtDgJz1QQFr3yx9RndTLb0F8wlJNc8tiJKqLmyspxL
         MJS2exU4eJx4nFZT4LhMCymo1mFebmerSnSSpBtrxrx/kyV3iwPLmFVlTD81fe/qtCUY
         I6TA==
X-Gm-Message-State: APjAAAXpm+o4nTJOMUeogw64jtZ/X5+O7HBvG3C7CcAbh6ajkgEme9E4
        afoV9nEv43GXEkaB6E/aRffTW0NwzOpdl8tbU6c+Bcj3WpWLIoOkE+riufDlT34rctN999ALnGz
        4Ep/sDfvOtkUPYbbSfEH26pf5
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5508471wmj.54.1581093536531;
        Fri, 07 Feb 2020 08:38:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzfXiEMRFxiSTWfBktKv/u3HPrByhX07ia/ebkul4WxGWtBDC2/WJGWlaoi2DsBrj0R/Rgng==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5508452wmj.54.1581093536325;
        Fri, 07 Feb 2020 08:38:56 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id e17sm3919212wma.12.2020.02.07.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:38:55 -0800 (PST)
Date:   Fri, 7 Feb 2020 17:38:53 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH] io_uring: flush overflowed CQ events in the
 io_uring_poll()
Message-ID: <20200207163853.bzfgn2mzpactehk3@steredhat>
References: <20200207121828.105456-1-sgarzare@redhat.com>
 <0acf040c-4b00-1647-e0c9-fc8b1c94685d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acf040c-4b00-1647-e0c9-fc8b1c94685d@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 09:12:39AM -0700, Jens Axboe wrote:
> On 2/7/20 5:18 AM, Stefano Garzarella wrote:
> > In io_uring_poll() we must flush overflowed CQ events before to
> > check if there are CQ events available, to avoid missing events.
> > 
> > We call the io_cqring_events() that checks and flushes any overflow
> > and returns the number of CQ events available.
> > 
> > We can avoid taking the 'uring_lock' since the flush is already
> > protected by 'completion_lock'.
> 
> Thanks, applied. I dropped that last sentence, as a) it doesn't
> really matter, and b) we may very well already have it held here
> if someone is doing a poll on the io_uring fd itself.

Sure, indeed I was undecided whether to put it after the three dashes
as a response to your yesterday's request.

Thanks,
Stefano

