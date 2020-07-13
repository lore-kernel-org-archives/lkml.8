Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A521C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F612077D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB0zPGTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgGMKyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:54:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36684 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729059AbgGMKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594637689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NLlKHEztDWyj5cXVFVh6qpf88cHYugGxDnOHI6njCI=;
        b=DB0zPGTa6Wq2+Q7g9DkAy1CqH6pMSftFU6pCGX8nhPGmV18xNPTNI8mPN0nOzXigrx2n2W
        7N8EXVA6u4Qq8J2nGQTekmCngnV155eqMhlNHWbYlkBae9j9THcJKZpuiV0wZJMxiCKWWh
        +9PxlqH8aZa8jg6+aAO72IHgTYpzP08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-vrOayXYpPqCBNd9s-bDtEg-1; Mon, 13 Jul 2020 06:54:47 -0400
X-MC-Unique: vrOayXYpPqCBNd9s-bDtEg-1
Received: by mail-wm1-f72.google.com with SMTP id q20so18230227wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0NLlKHEztDWyj5cXVFVh6qpf88cHYugGxDnOHI6njCI=;
        b=Q9NgnMpPuh/N2s+Sq8R9KwFvPEYXssAWbPQ5jo+dUCFM0a9s2YYqA9dxmH+PR8QBMT
         4caEA01bouZc62zzQedfc58SmS8jQSqO0jpmt6v8p3CVag08Bsh5GGpdncO5JmJtrir7
         Sr3gRA2fFOLO7t/eDGkxdes+i+8tEpNfFHClonSJ9koR4gnzLN/dZHwuNkj2GueCVgnj
         +LXnhqXz5POfgga6ZRrOXucyLGVsOa9dsJun6E8vCTzQiLEU6xYa3MC7R9gzcba6OPIP
         6U6eNmGslXRloFJdP72x9uvjKI/ld1lka1R+C7FY+QsFJzwFnrx/NEhvS4QM5gAGinTq
         fe8Q==
X-Gm-Message-State: AOAM5327PQT2Us0l6by5QU6TwvAMi1yHlIiUkmmv92DkwyR3xRYtaVaK
        B9GdZsspE0lEqkTK38RKZPhS2TI9pAPJgGg0XlhO4QFg6ox5bzYQIhcB1SuAt8RBfrz5YHzFKhm
        VkT1gczn33CO9WOr0JYO9g9B6
X-Received: by 2002:adf:ce85:: with SMTP id r5mr87517230wrn.157.1594637686804;
        Mon, 13 Jul 2020 03:54:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAncOEl2kEHA0hOXAsJ7SmP/xoYe30HIdDfYymthuFQE102T/NGVomRy+ErWMsZJ86/tL52g==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr87517218wrn.157.1594637686635;
        Mon, 13 Jul 2020 03:54:46 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id 1sm21378309wmf.0.2020.07.13.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 03:54:46 -0700 (PDT)
Date:   Mon, 13 Jul 2020 06:54:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Message-ID: <20200713065423-mutt-send-email-mst@kernel.org>
References: <20200710121243.120096-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710121243.120096-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:12:43PM +0200, Stefano Garzarella wrote:
> Commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
> on the_virtio_vsock") starts to use RCU to protect 'the_virtio_vsock'
> pointer, but we forgot to annotate it.
> 
> This patch adds the annotation to fix the following sparse errors:
> 
>     net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
> 
> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

who's merging this? Dave?

> ---
>  net/vmw_vsock/virtio_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index dfbaf6bd8b1c..2700a63ab095 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -22,7 +22,7 @@
>  #include <net/af_vsock.h>
>  
>  static struct workqueue_struct *virtio_vsock_workqueue;
> -static struct virtio_vsock *the_virtio_vsock;
> +static struct virtio_vsock __rcu *the_virtio_vsock;
>  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>  
>  struct virtio_vsock {
> -- 
> 2.26.2

