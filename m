Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41664C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EC52076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwRjNkpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgFHGp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:45:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728334AbgFHGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591598756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05DDfjAfIHUdRf5Uem2N9ccJI7OdmXrAgeiSijOGnoQ=;
        b=fwRjNkpGXZWdAMpa4vXELZvaRC/oEUa7Ee1E8TWf45Fdo/S3Pdf42us8QV/Cy1AuMMKKLK
        ZUm2WEAC3+iZU+pnHCF2fnpeEby3b+DXIb0Y7qQut8oVjMGJD46ySi4ZlkGx+tUg/yLIZd
        dQbKGDEgnX0fNhuRJrTywMIlIQcIMkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-i_BKgQR2M-O67UGS5LlGwg-1; Mon, 08 Jun 2020 02:45:54 -0400
X-MC-Unique: i_BKgQR2M-O67UGS5LlGwg-1
Received: by mail-wr1-f70.google.com with SMTP id f4so6748499wrp.21
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 23:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=05DDfjAfIHUdRf5Uem2N9ccJI7OdmXrAgeiSijOGnoQ=;
        b=YZOMqqg92i6/2W2lZ40Wl2f0hfXkgCXErEyDO4ZRqr1yrRXniyRsXNOlOVh+CfmQaH
         THWxBCpZtEhrgGwCGb7qGRlxBH+/t93qAXif0+OseNXm33OGXBQDx0mtWdzvxLnkP75R
         OHH7XDGXIUAKRwdTZBUPb6mS5XQ8T86tGbgrL8sEx6AO2L+OLQmK1+Elhhsm/M5MtwJz
         JdmVE1WfVD974C0rq0DjIWWZP5T9wUExScAHwZMFthmvj2S7yaKtwupyr/pz5zQJzCQV
         A+AI8wGJUQsDA4+HWyvPqnmYS6CcGLCj39vcFCjNeZmoSG88j9abnLe1m0vAn/EKxrTt
         HwJg==
X-Gm-Message-State: AOAM531ibzuMN/sKN+OwXsZUxKcPKw+dG53gSug1eEhmtrFgS/vc/svd
        F5Uwgj6fZIockB+oUMhS1LCeprbJDu6Y7u61Gyp4SRvCwO6KjtOZEZUNt/wpQBwIniKzRrmvtGP
        GiRHb9cqna6ixIwQcOoLKK5Q6
X-Received: by 2002:a5d:5261:: with SMTP id l1mr22608224wrc.246.1591598753584;
        Sun, 07 Jun 2020 23:45:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKhmvKgwfu6GksB3KTO4SFsuK8YxZWmnpeKf96R+VzqaaCilkPcOAlU2/3T/svRcNiLt4VEA==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr22608211wrc.246.1591598753423;
        Sun, 07 Jun 2020 23:45:53 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id x18sm20730927wmi.35.2020.06.07.23.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:45:52 -0700 (PDT)
Date:   Mon, 8 Jun 2020 02:45:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        eperezma@redhat.com
Subject: Re: [PATCH RFC v5 13/13] vhost: drop head based APIs
Message-ID: <20200608023311-mutt-send-email-mst@kernel.org>
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-14-mst@redhat.com>
 <8e3f5b6f-a47b-73cd-e8e3-959d40f6c91c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e3f5b6f-a47b-73cd-e8e3-959d40f6c91c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:57:48AM +0800, Jason Wang wrote:
> 
> On 2020/6/7 下午10:11, Michael S. Tsirkin wrote:
> > Everyone's using buf APIs, no need for head based ones anymore.
> > 
> > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > ---
> >   drivers/vhost/vhost.c | 36 ++++++++----------------------------
> >   drivers/vhost/vhost.h | 12 ------------
> >   2 files changed, 8 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 72ee55c810c4..e6931b760b61 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2299,12 +2299,12 @@ static int fetch_buf(struct vhost_virtqueue *vq)
> >   	return 1;
> >   }
> > -/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> > +/* Revert the effect of fetch_buf. Useful for error handling. */
> > +static
> >   void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> >   {
> >   	vq->last_avail_idx -= n;
> >   }
> > -EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
> 
> 
> The same question as previous version.
> 
> Do we need to rewind cached descriptor here?
> 
> Thanks

Good point.  This needs more thought, we need to also
rewind the avail idx each time we flush the descriptor cache.

-- 
MST

