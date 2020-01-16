Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C2DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC342073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzQ7ulmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAPP4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:56:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbgAPP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579190164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59rSP/4nG5ysgfDP2nwJUgUTFNS/i6M0+YH8HiBE7YE=;
        b=MzQ7ulmhiE7+yz0UAnyTG3LAv7hAGbDW9Hy6+U07nPNWxEgc3BRS2zN7MdTafpmLRT55g7
        Fs3F92o3t6VwMCBqizxW7nzd5/H9Q3EaEarBO9KqL1nkR1q7qzwVy1vnQ07l9JHp/DK1G8
        HVEYqFZs5N22dOIq0LQUvlIvyFnkbj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-_gXHYdhXOo6IgMqwpVxdnA-1; Thu, 16 Jan 2020 10:56:01 -0500
X-MC-Unique: _gXHYdhXOo6IgMqwpVxdnA-1
Received: by mail-wr1-f71.google.com with SMTP id t3so9345635wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59rSP/4nG5ysgfDP2nwJUgUTFNS/i6M0+YH8HiBE7YE=;
        b=CpP8aN80o5DHuMk6WnHsmAX2ILEA4peVAxt9VxCIUkleZTF+Mx9+jKY3xfUoAQ6gRH
         Y7zBFGswcWh5jYPIUBmXhmhQcvWWZNJ1ArkDvTNf2OP/jv+1ELV4HcsopJ86Gtg17shV
         j9/5kf3Q8onRHMipK2SpLKAmCXjVSVZKZP/QGUk0N2E/9u+8YH5j6GyJwfaH/fWQ8lyK
         M7rZyG4UABShEwI5IfZP852tk5zrfjIvCeMAJ5Dgzdg7LtmgLBqkPLbf9On/kc2rj7dc
         OwpB4QPvLMaLXG7yi97PDe7FP0z9PeJtbvkTwueCJxfPoIARuNFneUR4b8XEndyoToN1
         0EvQ==
X-Gm-Message-State: APjAAAUyVANJsdBNHl/1mLOOtpb9MLGY1jPJIGeRVib2ADBYMOi1aId0
        XGjVO2ydnpUxIi+TFeovthtlZpFcZWMPw7oOv/rT0ylBAB0/HkpA4HXybabEZH8PYm8Etd/oP35
        36ADjXYYLDkBxRa1w9as7yM+a
X-Received: by 2002:a1c:488a:: with SMTP id v132mr4006wma.153.1579190160202;
        Thu, 16 Jan 2020 07:56:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyARJugJk6ZQ7MpUK2INr7v0S3I+70oMKj69iGSMkRzx4xa29/fG8xCm60wqugTUISWTMXsWQ==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr3985wma.153.1579190159959;
        Thu, 16 Jan 2020 07:55:59 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id n67sm5422048wmf.46.2020.01.16.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:55:59 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:55:57 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
Message-ID: <20200116155557.mwjc7vu33xespiag@steredhat>
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 08:29:07AM -0700, Jens Axboe wrote:
> On 1/16/20 6:49 AM, Stefano Garzarella wrote:
> > io_uring_poll() sets EPOLLOUT flag if there is space in the
> > SQ ring, then we should wakeup threads waiting for EPOLLOUT
> > events when we expose the new SQ head to the userspace.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > 
> > Do you think is better to change the name of 'cq_wait' and 'cq_fasync'?
> 
> I honestly think it'd be better to have separate waits for in/out poll,
> the below patch will introduce some unfortunate cacheline traffic
> between the submitter and completer side.

Agree, make sense. I'll send a v2 with a new 'sq_wait'.

About fasync, do you think could be useful the POLL_OUT support?
In this case, maybe is not simple to have two separate fasync_struct,
do you have any advice?

Thanks,
Stefano

