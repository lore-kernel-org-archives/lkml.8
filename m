Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5700622D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/aJXW5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHERDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728274AbgHERBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596646862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bM6BX5L4/TWGWo6Fw0MECvbQOerPg7X6HOlNI1yptJk=;
        b=c/aJXW5V2bW96PpUMpUyEZEDeF+Kdw2/6TRizqF1g12wuOD8mLnhpany40DNnBaWSTRKM7
        FqjJg/tcK7LdYys39+gyeNcSVAqtZO2B3VlsBYfusMIed/ZYyOXfkYsOPYFtCuVm//qq2G
        vfPpfIdCoAps7hZbsaoUT0d0Nksd4F4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-XSqVGqvPOMqnzOisVT-AbQ-1; Wed, 05 Aug 2020 09:29:54 -0400
X-MC-Unique: XSqVGqvPOMqnzOisVT-AbQ-1
Received: by mail-wr1-f71.google.com with SMTP id s23so13416777wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bM6BX5L4/TWGWo6Fw0MECvbQOerPg7X6HOlNI1yptJk=;
        b=LzdPR0M1yMpV3zzhp3GeSSpBaaaYaWmuhg3UbgghDvJFhMa8sx6EVJeDeK8cBEA8cc
         PIFzyuV/tUX80uQPLvi1RAblam1EzPgI702XbwEaUY4qGjAXCUCE4WJEtsAh7n2dXnOG
         3JsWJ27u2trGt973KzRVJEbR32VpS5IW2q+bRcfVRJQOcBfiFF1BwZVbyNtj+FgqFvlH
         UIRySnoNPp3geHLFjp+88s1ulcoUCXn5hHlTElXRYHif9PI/sMAjH7b39gtO4HpEGeax
         tq3XhAoaPaVSc36woPgbNNETzPZIs8M/0cOYLX42RMoW+djvUj6X8thXey8NuZ9DKzoj
         KLEg==
X-Gm-Message-State: AOAM5320SB9s7LYFgT0EaYxZB69Z2xByyavvZ6D9hOer+uzmJldG2WKQ
        QtZWtNHwa28nmjULXu4cMNgS+4zFi/dh1IJvzksHMnbE9BgyYgSuHYPGmBl+CHuBQle9eKowI4U
        xxszp/9lCi7NpofxjHNi+ESsv
X-Received: by 2002:adf:fd04:: with SMTP id e4mr2729024wrr.353.1596634191933;
        Wed, 05 Aug 2020 06:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD71GjrxuIPt/70247PjYqetL3L7dJwS2itOOTaj8djrdCVByKfXCsWH/un1uLPcWYOq4+WA==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr2729006wrr.353.1596634191720;
        Wed, 05 Aug 2020 06:29:51 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id q2sm2752486wro.8.2020.08.05.06.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:29:51 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:29:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 17/24] virtio_config: disallow native type fields
Message-ID: <20200805092923-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-18-mst@redhat.com>
 <20200804165039.58dcb29e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804165039.58dcb29e.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:50:39PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 16:59:57 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Transitional devices should all use __virtioXX types.
> 
> I think they should use __leXX for those fields that are not present
> with legacy devices?

Will correct.

> > Modern ones should use __leXX.
> > _uXX type would be a bug.
> > Let's prevent that.
> 
> That sounds right, though.
> 
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 64da491936f7..c68f58f3bf34 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -319,9 +319,8 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
> >  	__virtio_pick_type(x, __u8, __u8,					\
> >  		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
> >  			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> > -				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> > -					/* No other type allowed */		\
> > -					(void)0)))))
> > +				/* No other type allowed */			\
> > +				(void)0))))
> >  
> >  #endif
> >  

