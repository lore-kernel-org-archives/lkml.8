Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A5FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A818206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM8DWTXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgFJPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:13:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728211AbgFJPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591802023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YfhNq/fazdZ8Eyi5klTe6PYJfVDAk96bmheZ7cnvsnc=;
        b=CM8DWTXOcm6czEgIiDsp3Eg8M02TF2L8NVCgAhh7JFvmw0DehBqIh1qb6rzHF8ur4LWGQN
        XxvSDpuOQlIntGCgVq5Vio7P0DwX3hYiuuAxY78rG1pgSR+mrSgOQfjEz3ac7Aq/MEGYJw
        D/IX6xdYbSIoeF9ueXDCgTz2GTQWmDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-WEFcBpmjOo2Bky5oZALk5w-1; Wed, 10 Jun 2020 11:13:41 -0400
X-MC-Unique: WEFcBpmjOo2Bky5oZALk5w-1
Received: by mail-wr1-f71.google.com with SMTP id p9so1217850wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YfhNq/fazdZ8Eyi5klTe6PYJfVDAk96bmheZ7cnvsnc=;
        b=Ugo5Zvr9zrk46Wm0/iX7R5ryFNPWaHSH7a1/Ljsw21+6rZn9jM/RNFt/8vHosvg5QL
         i7sWrf4NAZuoZEzjFMzMEOLK+ieMRQWpMFvgZo2eROBvr1D2BRJdDTrIyqnacCb+A7m2
         etIdkFcML2GqkTlwbKIqF0HCiJrDDprrYNA4pEVSk5srPQW+MnGYlJI/5+kEKkJHI4uw
         tg013oSk/HdSYbq2h6Hs+zM1Yh6cR37EeuQTFBUACbhyvneVFh/URm1yCK3y6mj6PEEa
         SksmFKDVT7BMBbn1SyuiX9YTTVzhAYDRoA9BuoK+NguXhwJLwc9mHCwe4ucqxLDvpm2d
         4mBw==
X-Gm-Message-State: AOAM53305JIrOzbSb2mg2ltsAG3iIac3wYeKvgDiWysB/ufedoxk223o
        VO9zWmOjnm1hVQL5rbIg1r2OgMw24HT9Bvn3yPi5kqTtCddNDg82iOta6j/e3CL4ZhLVpTJN+Mq
        reneWCx8jzoHtNKax4LZYWkEb
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr3730151wmf.69.1591802020717;
        Wed, 10 Jun 2020 08:13:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww1vH7zy+FsH/SZuuGBRzDcjEXQict36Ept0NkVt1LYqloJMLuBhZhh8r1NCU9jdQ8aYiDHA==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr3730071wmf.69.1591802019527;
        Wed, 10 Jun 2020 08:13:39 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id m24sm51095wmi.14.2020.06.10.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:13:38 -0700 (PDT)
Date:   Wed, 10 Jun 2020 11:13:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v7 03/14] vhost: use batched get_vq_desc version
Message-ID: <20200610111147-mutt-send-email-mst@kernel.org>
References: <20200610113515.1497099-1-mst@redhat.com>
 <20200610113515.1497099-4-mst@redhat.com>
 <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:37:50PM +0200, Eugenio Perez Martin wrote:
> > +/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
> > + * A negative code is returned on error. */
> > +static int fetch_descs(struct vhost_virtqueue *vq)
> > +{
> > +       int ret;
> > +
> > +       if (unlikely(vq->first_desc >= vq->ndescs)) {
> > +               vq->first_desc = 0;
> > +               vq->ndescs = 0;
> > +       }
> > +
> > +       if (vq->ndescs)
> > +               return 1;
> > +
> > +       for (ret = 1;
> > +            ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
> > +            ret = fetch_buf(vq))
> > +               ;
> 
> (Expanding comment in V6):
> 
> We get an infinite loop this way:
> * vq->ndescs == 0, so we call fetch_buf() here
> * fetch_buf gets less than vhost_vq_num_batch_descs(vq); descriptors. ret = 1
> * This loop calls again fetch_buf, but vq->ndescs > 0 (and avail_vq ==
> last_avail_vq), so it just return 1

That's what
	 [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
is supposed to fix.

-- 
MST

