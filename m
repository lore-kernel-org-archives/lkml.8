Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259CEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AB52073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9sx0BoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgHDGBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:01:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39338 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727862AbgHDGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596520910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCL1Xp60PBWuivH0HthdQ2JVXbrP96B1PBURhwN7M+g=;
        b=b9sx0BoXVLm3f3teaFERPFvxVfEQnJETcSIRcVdEr0aPcYkNU8mm/kKpFM26YNnAZxkDR4
        pKq4M658NMV9gaCZN/UKeRnwkZLYVlQx4Ke594xyUaNr5gvH1TKPVxTCjQsTge/3IPLkox
        PhwLxojIIJhuAOF4Jpnp5hHPpO2A+Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Mt-GLynOPTW0Da43TrKIng-1; Tue, 04 Aug 2020 02:01:46 -0400
X-MC-Unique: Mt-GLynOPTW0Da43TrKIng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC42C100A8C0;
        Tue,  4 Aug 2020 06:01:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com [10.36.115.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B80B45C1BD;
        Tue,  4 Aug 2020 06:01:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A2D4311AB5; Tue,  4 Aug 2020 08:01:41 +0200 (CEST)
Date:   Tue, 4 Aug 2020 08:01:41 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 11/24] virtio_input: correct tags for config space
 fields
Message-ID: <20200804060141.nhxsxs57oi576mzw@sirius.home.kraxel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-12-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-12-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:59:23PM -0400, Michael S. Tsirkin wrote:
> Since this is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_input.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_input.h b/include/uapi/linux/virtio_input.h
> index a7fe5c8fb135..52084b1fb965 100644
> --- a/include/uapi/linux/virtio_input.h
> +++ b/include/uapi/linux/virtio_input.h
> @@ -40,18 +40,18 @@ enum virtio_input_config_select {
>  };
>  
>  struct virtio_input_absinfo {
> -	__u32 min;
> -	__u32 max;
> -	__u32 fuzz;
> -	__u32 flat;
> -	__u32 res;
> +	__le32 min;
> +	__le32 max;
> +	__le32 fuzz;
> +	__le32 flat;
> +	__le32 res;
>  };
>  
>  struct virtio_input_devids {
> -	__u16 bustype;
> -	__u16 vendor;
> -	__u16 product;
> -	__u16 version;
> +	__le16 bustype;
> +	__le16 vendor;
> +	__le16 product;
> +	__le16 version;
>  };
>  
>  struct virtio_input_config {
> -- 
> MST

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

