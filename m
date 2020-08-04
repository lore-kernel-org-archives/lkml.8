Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433952075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Axx4j12o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgHDOoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:44:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36535 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725932AbgHDOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596552291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0qQRP6FVPdcWxTvN3l6bnjm2x6UvPqdNJFTqbZG61E=;
        b=Axx4j12onfDhJZsOfVnKjbtVCasuL9DxopB/YTSYkNdXsB0l7ekRLPYwy6RM9gyC19XLMt
        sT4cuTnWQjJ/sFraWxZrQ6Owe6+/GTNommOP/IZsJjAhciVPhBgUCLZ+f9t8YYNHCsq1G1
        7lLdW/NUrQigRd99mp2UHFg2tniCYMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-zTJjV6pBNTK9yFuI5a2tmQ-1; Tue, 04 Aug 2020 10:44:49 -0400
X-MC-Unique: zTJjV6pBNTK9yFuI5a2tmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 564DB8BB686;
        Tue,  4 Aug 2020 14:44:48 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 731771001B2B;
        Tue,  4 Aug 2020 14:44:47 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:44:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 14/24] virtio_net: correct tags for config space
 fields
Message-ID: <20200804164444.5174452d.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-15-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-15-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:59:37 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Tag config space fields as having virtio endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_net.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 19d23e5baa4e..27d996f29dd1 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -87,19 +87,19 @@ struct virtio_net_config {
>  	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
>  	__u8 mac[ETH_ALEN];
>  	/* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
> -	__u16 status;
> +	__virtio16 status;
>  	/* Maximum number of each of transmit and receive queues;
>  	 * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
>  	 * Legal values are between 1 and 0x8000
>  	 */
> -	__u16 max_virtqueue_pairs;
> +	__virtio16 max_virtqueue_pairs;
>  	/* Default maximum transmit unit advice */
> -	__u16 mtu;
> +	__virtio16 mtu;
>  	/*
>  	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
>  	 * Any other value stands for unknown.
>  	 */
> -	__u32 speed;
> +	__virtio32 speed;

Hm... VIRTIO_NET_F_SPEED_DUPLEX can only be negotiated if VERSION_1 has
also been negotiated; I think this should be __le32?

>  	/*
>  	 * 0x00 - half duplex
>  	 * 0x01 - full duplex

