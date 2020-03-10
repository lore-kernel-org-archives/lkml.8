Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEBFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E27A24686
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnjJ1AQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgCJMTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:19:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgCJMTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583842779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoDjVfCyMen1kfloMIClESpphvSaHWNU06cu9u+0VdQ=;
        b=fnjJ1AQo8M5QnNa78TOKPkii+JObvP34iBTB8JlpZf74BsSQgK0AthuDPB5/08OVoLIJrs
        9+WxURBlogdWwFtny/HAgYwvbPvO9sH0fhLhvG/gxBRa41XkNW+k0EwGtAKEd++CkLmXG5
        tIeYOBloeLkMifUfHNzwA4TqsagDRL8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-c_ZpUR1nNjG1U5vkIJeQ6A-1; Tue, 10 Mar 2020 08:19:37 -0400
X-MC-Unique: c_ZpUR1nNjG1U5vkIJeQ6A-1
Received: by mail-qt1-f198.google.com with SMTP id j35so8979625qte.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 05:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoDjVfCyMen1kfloMIClESpphvSaHWNU06cu9u+0VdQ=;
        b=OcCp3OoAaqpPbeKjifVjuy+sMZJ41cuZgN580lv0eDgm+zqN0F7TJe8MnP2WMD9m8h
         +UZQ3P2RVS3w7kwKCdaD2MeqhVrIs1bg+KzB+hATJaUZfQsPwGWqbmsZS0fm+qSME4bK
         d8I9JNfIHXB90TA0b/euNC6Ghi+kB5Z1kZHAwb9857iALMJOjw8345beLpIlVDASvzYk
         /ANt+Y4yNUT90CBxk2LKF282mAfwCztT7oliLWMV2O8qgbCW7WE0H+h5bplt/aPWAxl7
         03H6BeunwQWmGteN6luYjmnvCN2SwPXFFM5So62jb8phqkk5RnlEslP6pIjroW2OB4vR
         lcRQ==
X-Gm-Message-State: ANhLgQ2wb873CEcl8/1xxV1gtpFxky0EFbagfhuld01jhgpuHeFS6LDd
        yjvMcH6wlR7AVxuMgL+rJzrQa6RwaA3JgzgxiSulWdgAm7N0iR9qCmbqvKsqK/XUtWAQ/xKesGR
        WQY3vF8hhBsM423aQ9ZKw+dHF
X-Received: by 2002:a0c:c783:: with SMTP id k3mr18816400qvj.241.1583842776749;
        Tue, 10 Mar 2020 05:19:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu02wK5j5HqaBUlUP94aV2l+2NXRf1hgehYJ+CaAbsYTYbQKE4jxeirYry6aBbd1OWhTAdxvw==
X-Received: by 2002:a0c:c783:: with SMTP id k3mr18816387qvj.241.1583842776557;
        Tue, 10 Mar 2020 05:19:36 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id f13sm10035959qte.53.2020.03.10.05.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:19:35 -0700 (PDT)
Date:   Tue, 10 Mar 2020 08:19:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: Add myself as virtio-balloon
 co-maintainer
Message-ID: <20200310081850-mutt-send-email-mst@kernel.org>
References: <20200310115411.12760-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310115411.12760-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:54:11PM +0100, David Hildenbrand wrote:
> As suggested by Michael, let's add me as co-maintainer of virtio-balloon.
> While at it, also add "include/linux/balloon_compaction.h" to the file
> list.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yea I don't think Jason actually has time to look at balloon patches.
Thanks for helping out!
I'll queue this.

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c555f4be8c4e..da9f53a05d0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17800,6 +17800,15 @@ F:	drivers/block/virtio_blk.c
>  F:	include/linux/virtio*.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	drivers/crypto/virtio/
> +
> +VIRTIO BALLOON
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +M:	David Hildenbrand <david@redhat.com>
> +L:	virtualization@lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/virtio/virtio_balloon.c
> +F:	include/uapi/linux/virtio_balloon.h
> +F:	include/linux/balloon_compaction.h
>  F:	mm/balloon_compaction.c
>  
>  VIRTIO BLOCK AND SCSI DRIVERS
> -- 
> 2.24.1

