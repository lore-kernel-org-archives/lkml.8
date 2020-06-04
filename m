Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2029AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5B72072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQyo7709"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgFDQq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:46:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60209 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729866AbgFDQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591289215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYFGtIC552gLkUpERPIGUzsoKzT9woC/5boahqlmcS4=;
        b=aQyo7709nAQS7MATHIQE1Xg/1IrSZAzALZierh4EbTCMyOv4fcl0LRCsCE1m9xNjbgatVx
        29RPt3rgOu8AZRGt/XnN4MwjJOJdIkasyD0novF1xYlRKcM3UeejDoxKr3GrwJu8QgWbrP
        9Qk46n/+/YIbXUpnBDDEhGIXthcrdyc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-J3v8DBe0Ns21_CZZZJh3yw-1; Thu, 04 Jun 2020 12:46:53 -0400
X-MC-Unique: J3v8DBe0Ns21_CZZZJh3yw-1
Received: by mail-wr1-f72.google.com with SMTP id l1so2645359wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rYFGtIC552gLkUpERPIGUzsoKzT9woC/5boahqlmcS4=;
        b=p9Ex6BcE7uB2FgKB05a/IZ8GwFdjLwoUB/z8r+wsqCyV0OQ3mN1lqcMpbHZGjm3eiD
         DFYv/e61oFiDvu/se3wR0kC6jvz21ETJLsAlptooV9wSQI99yy5VJLZ21gzB01sX1K9L
         MnFslX05jHlbqAzgYapBaPJO++iREyDPqE3N97eRcELTww40PUwCMTZF1jqJ5m+JOBok
         MggykeCVlfrsOIPCxdnIB2G6b+NgPoIzLewlNASOuTND5XOicorcV0geTWuk+h6Iewqq
         n1D3kYrpWX7wFAuYA2fDSAx4N6LlMdfy3zler58Su8XpDhnO7bXpSs5Zx0bpymKMwprp
         wa6w==
X-Gm-Message-State: AOAM531WzsJ1aFZfAFy5R51N14j2aGNINHDDBgxKII1ZSASoiOsSgKrf
        aeau8Njhxzh0SJmU0RUCQz8iy+W6PwP6SgHYck8XjqKnh2X0wKM6vNfx5+Xka2ekZMb8jNkteQU
        NpwtATRbRSj9bo2Ffr1RunbrC
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr5089893wmh.175.1591289212193;
        Thu, 04 Jun 2020 09:46:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9dODiYy5HcsVQeCdjVQOA6jF0pYa9ZPQQTKb/equwgut+prFilWfFwLf9io2WRO1UvoUCSQ==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr5089876wmh.175.1591289211954;
        Thu, 04 Jun 2020 09:46:51 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id d17sm7757908wme.43.2020.06.04.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:46:51 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:46:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200604124332-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <20200603014815.GR23230@ZenIV.linux.org.uk>
 <20200603011810-mutt-send-email-mst@kernel.org>
 <20200603165205.GU23230@ZenIV.linux.org.uk>
 <ec086f7b-be01-5ffd-6fc3-f865d26b0daf@redhat.com>
 <20200604145924.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604145924.GF23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:59:24PM +0100, Al Viro wrote:
> On Thu, Jun 04, 2020 at 02:10:27PM +0800, Jason Wang wrote:
> 
> > > > get_user(flags, desc->flags)
> > > > smp_rmb()
> > > > if (flags & VALID)
> > > > copy_from_user(&adesc, desc, sizeof adesc);
> > > > 
> > > > this would be a good candidate I think.
> > > Perhaps, once we get stac/clac out of raw_copy_from_user() (coming cycle,
> > > probably).  BTW, how large is the structure and how is it aligned?
> > 
> > 
> > Each descriptor is 16 bytes, and 16 bytes aligned.
> 
> Won't it be cheaper to grap the entire thing unconditionally?

Yes but we must read the rest of descriptor after the flags are valid.
If it's read before then the value we get might be the invalid one -
the one it had before another thread gave up control.

>  And what does
> that rmb order, while we are at it - won't all coherency work in terms of
> entire cachelines anyway?

Would be great to know that, but it's hardly guaranteed on all architectures, is it?

> Confused...


