Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1E2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPOWbsEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgFJJjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:39:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbgFJJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591781969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHhN+DXAIMHw8hGd/EZXD/3ZlKq/Nb955xAU2QRluu4=;
        b=EPOWbsEdOsPRVS4p+PzoAdDF3yKWC6Z35psRPdv9l4tNtHNxm7ifmYKD6W1hDxNOWnB67P
        VTEaAImY+4fTkit+QRWwJ1JBIueqkeRL3NVsc0dRsvYwk/Lso4uSzmPjRKdkdgo7/5+VMr
        iHG6o9sZLEqI2OFPD3NzxE5Ov8qu7Es=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-J32Y5RXhMC-Wok4AlMoyVA-1; Wed, 10 Jun 2020 05:39:27 -0400
X-MC-Unique: J32Y5RXhMC-Wok4AlMoyVA-1
Received: by mail-wr1-f72.google.com with SMTP id z10so851031wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHhN+DXAIMHw8hGd/EZXD/3ZlKq/Nb955xAU2QRluu4=;
        b=eQCbyuv7XNKVguhtXG0GqpGjs4HT5P5AulfInf6bP5iLNxTdLdsVctmgZ2eH/DZI+b
         B1MfeUsxBjruzNSsGTX24BRTspbXtMQUuwcPcZFDQTWpzSrL4PsCvgxRx9ZkvDjmmWFu
         VL5BNI1S7KhbhlNOVjlDlSM/5z8tq8CaV7APKe2KJRAfICEByXosSTV82o33wFv5A6pu
         4d9sRAo4o0FvQPxLe7U/bAP9JbfhufvOptKuaNUCjpQ/BPZ+EMlaR4+pDSc1GYLpn3jx
         h9tEtxWHR7wvNr3aV6WW5kN70Yq34uTmkjunptr329U97p4CgXuNJ4xLn9JPLF9PGD46
         K/hA==
X-Gm-Message-State: AOAM530aHaja6g+iLXiLcrIh2EgW07CcH+R1ePbwm0BhE2V3ouqUzDdc
        MwGXNfzUnazIWubG70jrOESNJBnlOYCA0sXJXFlE5TEKNon33WS6UQTZ8N7Knlule+ivBfitGTs
        iJbCvRanPZhx/5qkVvEKeTg/s
X-Received: by 2002:a1c:154:: with SMTP id 81mr2260881wmb.23.1591781963813;
        Wed, 10 Jun 2020 02:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQX9a47BGmJoqN+JImhK5ZUe/6waoIaFpAVaxQJvVOjhT3XwxiiPuNU8njX16wSPNDegWrSA==
X-Received: by 2002:a1c:154:: with SMTP id 81mr2260855wmb.23.1591781963549;
        Wed, 10 Jun 2020 02:39:23 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id n19sm6011219wmi.33.2020.06.10.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 02:39:22 -0700 (PDT)
Date:   Wed, 10 Jun 2020 05:39:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] virtio-mem: silence a static checker warning
Message-ID: <20200610053912-mutt-send-email-mst@kernel.org>
References: <20200610085911.GC5439@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610085911.GC5439@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:59:11AM +0300, Dan Carpenter wrote:
> Smatch complains that "rc" can be uninitialized if we hit the "break;"
> statement on the first iteration through the loop.  I suspect that this
> can't happen in real life, but returning a zero literal is cleaner and
> silence the static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149beb..893ef18060a02 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1192,7 +1192,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
>  						VIRTIO_MEM_MB_STATE_OFFLINE);
>  	}
>  
> -	return rc;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.26.2

