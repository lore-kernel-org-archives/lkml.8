Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F2CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE89207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDVXOi9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgAPRD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:03:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387767AbgAPRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579194233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwuqMFEPkLVf1SB1Qby1DH0sArybWQvfhVUygmsr0E4=;
        b=MDVXOi9lel4KL7Rwg/MNFUAQKPIirjV8lafVt94sqWFMt1n7NMwmXj2pQDmPvt1EkK2YCZ
        gAGOFloJdEBmFolPOHDYK+XGXfRrz4pzlKnsy3UexPnwBTNUvNdPJY0XUaVInHOyCcFK6O
        j7ODrAhICyA8xaWVP5u93WwNW7Tcn4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-HhwCKwLyPcePp0c-P2fBsw-1; Thu, 16 Jan 2020 12:03:46 -0500
X-MC-Unique: HhwCKwLyPcePp0c-P2fBsw-1
Received: by mail-wr1-f69.google.com with SMTP id b13so9435337wrx.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwuqMFEPkLVf1SB1Qby1DH0sArybWQvfhVUygmsr0E4=;
        b=VZ7Wofx2lWFqT6858tau3SnUrcCyLrz90HYCZdhQqASBUkjO1Lu+DVh76NeE2hlQ7Z
         V9SXQrzrPbxnaz2N152Ul/O5BZkSfm9ku4YGmzqu+qTFDWRBFtDIvX/TVC7P80g26tt9
         BvkoTZN8dM1Q8A7PORmJhNUrJ1eLIjil7ZwBdowLJAIsNoAU7j+gChqJlI/R2g/rGYcN
         CV2AAVAuwX8twsyiLvBEnSUjxLo+qUsS9LMQb5I02oh/MPqdnKjJPf9BaQiOcLizpX9e
         tMyC0DFYko44m+kxDEEnrrvBGJhla8wkJpZd7KNArsD1SttXO6WDAIdJBUoBAEcKNr3T
         tZTA==
X-Gm-Message-State: APjAAAXaOJz8nfurxHFRBhh026nsWl2NvY6N29UpJJtOnHt0BqXTsilH
        PqmVCYT8CYX7QI2wa1IF2kP8mqQYbNL1kUgg+4vrMfx/VPEZ0sHz4qMisxQl8a0YP1EkOWojm65
        6NGsQSkTVE6hCl/0rLPkCjtJk
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4222757wrn.245.1579194225147;
        Thu, 16 Jan 2020 09:03:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmahambFLYvDPNDfSiuwfj+RNjJ2awrp8kvOtBAw+JLe5Wbrx78e1fRaCj45Q555ccQHKFSw==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4222739wrn.245.1579194224894;
        Thu, 16 Jan 2020 09:03:44 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id q15sm29985051wrr.11.2020.01.16.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:03:44 -0800 (PST)
Date:   Thu, 16 Jan 2020 18:03:42 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
Message-ID: <20200116170342.4jvkhbbw4x6z3txn@steredhat>
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
 <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 09:30:12AM -0700, Jens Axboe wrote:
> On 1/16/20 9:26 AM, Stefano Garzarella wrote:
> >> Since the use case is mostly single submitter, unless you're doing
> >> something funky or unusual, you're not going to be needing POLLOUT ever.
> > 
> > The case that I had in mind was with kernel side polling enabled and
> > a single submitter that can use epoll() to wait free slots in the SQ
> > ring. (I don't have a test, maybe I can write one...)
> 
> Right, I think that's the only use case where it makes sense, because
> you have someone else draining the sq side for you. A test case would
> indeed be nice, liburing has a good arsenal of test cases and this would
> be a good addition!

Sure, I'll send a test to liburing for this case!

Thanks,
Stefano

