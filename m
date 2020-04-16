Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0162C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2C92078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sps5ULMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgDPWdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:33:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60208 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728460AbgDPWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587076383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUf9DXimPD8UBiVLdfnQM98oUkmHdl6eiPE6mf0vIko=;
        b=Sps5ULMq4ITIhAj/rLvb95C6Fp04EONH3OvrUE5JSk4+D6z3FivwwiNo2AqBQkSrgLJf2F
        CzTaNbUZ/ExTmC94a7wvFhU0QW24k+p+0kRpIyD6NGAo9RwBt6QjOfSdbSVTNyiaeGqzC5
        oFGeC3SD4d38HRyq63tF0KQP4t15RXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-RGkDskWaOmSH1H_nMoNpdw-1; Thu, 16 Apr 2020 18:33:01 -0400
X-MC-Unique: RGkDskWaOmSH1H_nMoNpdw-1
Received: by mail-wm1-f69.google.com with SMTP id o5so125219wmo.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 15:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qUf9DXimPD8UBiVLdfnQM98oUkmHdl6eiPE6mf0vIko=;
        b=tGpXtEq/wW3VnKx8mDd++Ve+CC+FC2X6M5zp01RYve7Ph2RkEt+vcAdbaERcSOKpZx
         LGpf9p9ez6dO4n8+6Nm6/xPRatoLaVcS2abjGZZvKK6zdsKlN9dA2vXqpdeWkHAEQ596
         JS1USOFXkm6SfqQNx9oCqnZePUEUF9ZZ8tKQ0yZp6cBOVq0fGKsufAcvaGYM06oEinBY
         hrFf2TqOJoT148xAoWuLVvWuv3XkNW0xKURtE2ijsqmdWDv1w879ASm586dnGnsc1AZX
         spriyyG1h/ZAq3RLtjw+IEKcfyRSGIb92V6MjGmLUdaSfYpMk88MXpUXXwDp7ekf9LON
         12lQ==
X-Gm-Message-State: AGi0PuYg9g0lt4Ou0+0mKb9zxg9ndlDo4X9NBdMnnXQh9ilsMswE09r9
        nZaVhVjPYAOIltjoCIcujMLxpm4of+ZYZh0K5zPCmks8Mt3Kr8U7dJoP7NfehAnCUrW9tE9u1LI
        qeK8YCgT+GS1S4TtiaFi8bHfP
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr106316wmj.156.1587076380276;
        Thu, 16 Apr 2020 15:33:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypIy+rWP6GLwQOV39yuKvCoJ5WM3R60eHJj8M3PsMQSHsFk9lyxG27YOo0I93W1RyqT/v7nwTQ==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr106300wmj.156.1587076380092;
        Thu, 16 Apr 2020 15:33:00 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id h137sm6135220wme.0.2020.04.16.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:32:59 -0700 (PDT)
Date:   Thu, 16 Apr 2020 18:32:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] tools/virtio: Use __vring_new_virtqueue in
 virtio_test.c
Message-ID: <20200416183244-mutt-send-email-mst@kernel.org>
References: <20200416075643.27330-1-eperezma@redhat.com>
 <20200416075643.27330-6-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416075643.27330-6-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:56:40AM +0200, Eugenio Pérez wrote:
> As updated in ("2a2d1382fe9d virtio: Add improved queue allocation API")
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Pls add motivation for these changes.

> ---
>  tools/virtio/virtio_test.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 1d5144590df6..d9827b640c21 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -106,10 +106,9 @@ static void vq_info_add(struct vdev_info *dev, int num)
>  	assert(r >= 0);
>  	memset(info->ring, 0, vring_legacy_size(num, 4096));
>  	vring_legacy_init(&info->vring, num, info->ring, 4096);
> -	info->vq = vring_new_virtqueue(info->idx,
> -				       info->vring.num, 4096, &dev->vdev,
> -				       true, false, info->ring,
> -				       vq_notify, vq_callback, "test");
> +	info->vq =
> +		__vring_new_virtqueue(info->idx, info->vring, &dev->vdev, true,
> +				      false, vq_notify, vq_callback, "test");
>  	assert(info->vq);
>  	info->vq->priv = info;
>  	vhost_vq_setup(dev, info);
> -- 
> 2.18.1

