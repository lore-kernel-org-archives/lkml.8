Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1490820729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWMYll7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHJMGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:06:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgHJMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597061164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKMEj4LLBIlpg9dc7O4gTO5SL6FSODyW/zNWUMbYW/4=;
        b=iWMYll7XJvCAxmt+a24v9G5ZtXBTENkDLJKdk8HCUOs6GzBp0Bors2xFxN8D1JjXXUjkVu
        QA08QwkwI2pE6qBbe6UQY4t0145UAIDICfm+8er6g4M9kZRnajl4to4GhN8WVYp8iZaszm
        hU7/tnw3qIW0G8k3vMdqcsJNeGF7dEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-OZCz6e50OZ6krjUweykfTg-1; Mon, 10 Aug 2020 08:06:02 -0400
X-MC-Unique: OZCz6e50OZ6krjUweykfTg-1
Received: by mail-wm1-f72.google.com with SMTP id v8so2707703wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKMEj4LLBIlpg9dc7O4gTO5SL6FSODyW/zNWUMbYW/4=;
        b=b+I3w3T3v6m4zRmxYSBwLHlTqKAJAJ3I0Be+bsmx52S1SqR2fxZJbNJY57Cb9iM5nv
         PSHGxdBcKxJ5H2SVXD/q+6sVr4oLjSdYepbSfCOeC02IcBlrwfrw4kovcVkwYuPRbpOw
         eh/IemQpr/ez9Lj89YdJ0vkng9h5+vOdXJP6BBxqMpql8deRc+RjJ1TGbEe1U8zRDjGu
         S8PcejtWHXP/YCkSCOJytasbV+oCR4R8v+f2xmjFhkkDug6IJOwmmNS5c3U4MP3m1aYU
         WLVDOkSQ6OXrEu0UWFaJywdk5i3jsBwv7FtWDru+mYqH6/R2f+GqtIf9OvIfSKo+pQcf
         LChA==
X-Gm-Message-State: AOAM530lIJYQmbmR8MI9KEESna2lOt61Lo0u8Odlb0WXxCGwfc5h6S+b
        0IgIz9fBe4VgemIXST+SELMccJKDtusXS/oNvFA5UKLnWrztJRa4G5jlt73RnJG/5IJNNZiw8ys
        48J9hbQ2x6yqGCjuKbCvoKA1Y
X-Received: by 2002:a1c:61d5:: with SMTP id v204mr26101290wmb.102.1597061161368;
        Mon, 10 Aug 2020 05:06:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqAFGBcFY9c83qTCgWpUm3fN1gdspLbZEuXOkidZNF9FgzpzShlRZ6XzYHiuISMmVbh8wYDA==
X-Received: by 2002:a1c:61d5:: with SMTP id v204mr26101260wmb.102.1597061161105;
        Mon, 10 Aug 2020 05:06:01 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id 68sm21058637wra.39.2020.08.10.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:05:59 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:05:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200810080410-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:43:54PM +0300, Eli Cohen wrote:
> On Thu, Aug 06, 2020 at 08:29:22AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
> > > On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > > > This patch introduce a config op to get valid iova range from the vDPA
> > > > > device.
> > > > > 
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  include/linux/vdpa.h | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > index 239db794357c..b7633ed2500c 100644
> > > > > --- a/include/linux/vdpa.h
> > > > > +++ b/include/linux/vdpa.h
> > > > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > > > >  	unsigned int index;
> > > > >  };
> > > > >  
> > > > > +/**
> > > > > + * vDPA IOVA range - the IOVA range support by the device
> > > > > + * @start: start of the IOVA range
> > > > > + * @end: end of the IOVA range
> > > > > + */
> > > > > +struct vdpa_iova_range {
> > > > > +	u64 start;
> > > > > +	u64 end;
> > > > > +};
> > > > > +
> > > > 
> > > > 
> > > > This is ambiguous. Is end in the range or just behind it?
> > > > How about first/last?
> > > 
> > > It is customary in the kernel to use start-end where end corresponds to
> > > the byte following the last in the range. See struct vm_area_struct
> > > vm_start and vm_end fields
> > 
> > Exactly my point:
> > 
> > include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
> > 
> > in this case Jason wants it to be the last byte, not one behind.
> > 
> > 
> Maybe start, size? Not ambiguous, and you don't need to do annoying
> calculations like size = last - start + 1

Size has a bunch of issues: can overlap, can not cover the entire 64 bit
range. The requisite checks are arguably easier to get wrong than
getting the size if you need it.

