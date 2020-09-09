Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C3CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1177C21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO84z27j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIIHLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgIIHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599635377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sbNdgPGbXHtzNZzICD+kjhviJAeGSAESo3O2fIQqjns=;
        b=iO84z27jpCNN3zPraC61ysbcmhTtf53E1Yp5lQiJ17aCOk91qHX0Bk1WwPAyFdYtUt3jXK
        QQxpzyYOBZS/dgKy8EFyKEFOifVQ6HKU0MLFeW0aosxam2YUxCi/Wh26TljJK4QR1N7wXn
        VdUY6dFj9hlCAVSro41EAHGMByww/L4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-LNBCfX6XPLafB6FhVoxvCg-1; Wed, 09 Sep 2020 03:09:34 -0400
X-MC-Unique: LNBCfX6XPLafB6FhVoxvCg-1
Received: by mail-wm1-f71.google.com with SMTP id c198so442966wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbNdgPGbXHtzNZzICD+kjhviJAeGSAESo3O2fIQqjns=;
        b=RLvR0qMSA5ELnfXwpdB78uYgTPpOGFGAgWe9AQoxXEVP2wODVOvuljrX/4gFUQAUIg
         T40O4p4RaOuumTNQcxvWLBw8KtoFm1e+b66PZNf/VCTIJ/k8awH9qUhWpBS+bFhG1yaG
         848R+N0703pt6+UZrzOZKcqaAYeQkMdpXqpjE2SWuBsWUZWom6PJpg6mBaXUm+jO7Uj1
         st4gMSIiG1ozKOl+1O9eMClV9Ae1R2KN/KYTa3QckO0SaF5mBVdlKsdsVuHHkjDNTR08
         e0h+miUCRx7RzJQz4oUuQAniMhk/+N8Xe6W1la6prj1VMqBzEzr+I55hTMXKlPx7oiCU
         WZcg==
X-Gm-Message-State: AOAM533KDmhZnc7BFBVZ7AeXKUwJh1cHkbgLAOSVpqplD2Fv0HL5Lv/h
        QvmQ58qXj5Z9ZedikAcO7Vg4itX7xx8BZczkHPxmoPxtytZqmu6yN3JIK8MB8ZL0DhtQIZGLj48
        irojrYsr31lOSTq7X8JZJG7r4
X-Received: by 2002:a7b:c015:: with SMTP id c21mr2067387wmb.87.1599635373596;
        Wed, 09 Sep 2020 00:09:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJLuHsYjEO/DZDcJ9fpG8m8GGKEsIJck/ZRUcpgnZH8FyK9x7ubj3A2yaHiurY8F0uZqsI3w==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr2067369wmb.87.1599635373328;
        Wed, 09 Sep 2020 00:09:33 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id t4sm2631177wrr.26.2020.09.09.00.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:09:32 -0700 (PDT)
Date:   Wed, 9 Sep 2020 09:09:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] io_uring: return EBADFD when ring isn't in the
 right state
Message-ID: <20200909070930.mdbm7aeh7z5ckwhq@steredhat>
References: <20200908165242.124957-1-sgarzare@redhat.com>
 <6e119be3-d9a3-06ea-1c76-4201816dde46@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e119be3-d9a3-06ea-1c76-4201816dde46@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:02:48AM -0600, Jens Axboe wrote:
> On 9/8/20 10:52 AM, Stefano Garzarella wrote:
> > This patch uniforms the returned error (EBADFD) when the ring state
> > (enabled/disabled) is not the expected one.
> > 
> > The changes affect io_uring_enter() and io_uring_register() syscalls.
> 
> I added a Fixes line:
> 
> Fixes: 7ec3d1dd9378 ("io_uring: allow disabling rings during the creation")

Oh right, I forgot!

> 
> and applied it, thanks!
> 
> > https://github.com/stefano-garzarella/liburing (branch: fix-disabled-ring-error)
> 
> I'll check and pull that one too.
> 

Thanks,
Stefano

