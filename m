Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAEEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3122322D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/7XQAnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgHEQ7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:59:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728363AbgHEQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596646676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zyd3PzoPVBU8umiKYNKDpmG6iIok/EZRtyPBBz7RY7k=;
        b=C/7XQAnb6Xty+oPzdAfcYxE1R3XR8clOLe85MFIlribPQqMpck4qBTlsA4gAE9ZCoZ5gLD
        HANA7B9PdNEkmOK8trkmD/cw1JyUGK7qnw4sxaIXAxniPjgKJRRv9xKZ2z10VoP07/XID9
        v7XW3Ae24U9O2DCBHKe9GmWnMb0CHqk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-GfHkMBVBPhilVqL1dTtTXw-1; Wed, 05 Aug 2020 09:26:54 -0400
X-MC-Unique: GfHkMBVBPhilVqL1dTtTXw-1
Received: by mail-wr1-f72.google.com with SMTP id e14so10102035wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zyd3PzoPVBU8umiKYNKDpmG6iIok/EZRtyPBBz7RY7k=;
        b=ZtM7+pXY79vCLZSDX0L4XLTbgqKrleE13fhvwh15YBdFhDc9seOqcE6UBdw6UbI1JQ
         zGMyVejyY4MYySQPs90cZI3gO6gtSfril78mlV3hvWl7mzE7+yCZjsZaLucBU00ATE27
         lOq8t9iwXHeb9wZJ8ckeAgs56cUrz0QAk0ZpSStrkSR2fcPBSQL0QoXhlQ5zvJVOvJWk
         MqOKmMDDWODkUP8MkZdR6TN44xqbow6qVSvgx4HmRd7Tcu9wzQhwXVerdECCM58C91GN
         NODFi4gYuZgC8wz7oMHpiUr+IyW/2bYhkYOPhSV2VLYCZo3vW/L9dLIt4IkSDOUxfLZ2
         /tYA==
X-Gm-Message-State: AOAM5326jPxTjjgUuCdwgcYGyBHwM8xPX392LupcmZ7zVYASgtQ7hsha
        0IcjQlqddsQIda9w/oi4nDfpNvPRVzs2pssAZ8KpqtxxDuou5SqdUPq8sx3SZxAcc9yefafSJF3
        AxTeJfP/WFDPpClfMJmHurQOO
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr3365746wmb.150.1596634011543;
        Wed, 05 Aug 2020 06:26:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwZAH5oygZ0ZUZzuE41OHF5cCSmEBQ89jkVd4RBBHCf1yH6T/rbTULK4FaN2pLJbGTzixbnQ==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr3365734wmb.150.1596634011358;
        Wed, 05 Aug 2020 06:26:51 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id g18sm2877887wru.27.2020.08.05.06.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:26:50 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:26:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 14/24] virtio_net: correct tags for config space fields
Message-ID: <20200805092621-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-15-mst@redhat.com>
 <20200804164444.5174452d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804164444.5174452d.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:44:44PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 16:59:37 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Tag config space fields as having virtio endian-ness.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/uapi/linux/virtio_net.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index 19d23e5baa4e..27d996f29dd1 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -87,19 +87,19 @@ struct virtio_net_config {
> >  	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
> >  	__u8 mac[ETH_ALEN];
> >  	/* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
> > -	__u16 status;
> > +	__virtio16 status;
> >  	/* Maximum number of each of transmit and receive queues;
> >  	 * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
> >  	 * Legal values are between 1 and 0x8000
> >  	 */
> > -	__u16 max_virtqueue_pairs;
> > +	__virtio16 max_virtqueue_pairs;
> >  	/* Default maximum transmit unit advice */
> > -	__u16 mtu;
> > +	__virtio16 mtu;
> >  	/*
> >  	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
> >  	 * Any other value stands for unknown.
> >  	 */
> > -	__u32 speed;
> > +	__virtio32 speed;
> 
> Hm... VIRTIO_NET_F_SPEED_DUPLEX can only be negotiated if VERSION_1 has
> also been negotiated; I think this should be __le32?

OK APIs for this are in a separate patch.
I'll add conversion as a patch on top.


> >  	/*
> >  	 * 0x00 - half duplex
> >  	 * 0x01 - full duplex

