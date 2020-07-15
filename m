Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42C22065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4y0MJ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgGOOe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:34:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727999AbgGOOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594823694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDUnF1gX4Wln5UGQpyw0DsCZrmXKbH1BJblX2g4HkKY=;
        b=f4y0MJ3byWsV/c4dAXaj0GExpxt5+5duSytOqyGeKX81CrDbxYHEgsCJKlhVLIiY5repuM
        tyPsJieTetq38kzbJphGXoiQU/TOUJLab9kMaCkFuvePxux1RDhT5Jnjwp64ck1emlaNeZ
        plbHhPoIRGMOaayDZxYSAG/FqKXS/Io=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-TSvnWXXxPd-x98TyeIwnYQ-1; Wed, 15 Jul 2020 10:34:52 -0400
X-MC-Unique: TSvnWXXxPd-x98TyeIwnYQ-1
Received: by mail-wm1-f70.google.com with SMTP id c81so1181201wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDUnF1gX4Wln5UGQpyw0DsCZrmXKbH1BJblX2g4HkKY=;
        b=jjM3/dLquQepEItOCoFagnT21Oc7cOiuhT6Z41uXuXeIeE/v0taddsoBI+sctdFKtE
         /dTV85PmHD0TxqO31DjMx5j8F5/kr5Xu7w96iJs5okChGTIhNxE0CYWcUG/7V/HpXqJK
         GeYK3ycYn2MchwdW9OdYfuxc5ib1yRUIovCemDRb2R7OIpYmDuD4aciSP2Rj76RKGS4r
         AZ/w8c9RuDBsgGthXqnrrQlixT0eWm1R5QnzpAUQba2RP6V3MYzSCRpN4/6gvI79yz8j
         v/SNOXqhnxGxZ7UM+qZcOQHwkqVYqoZf799OKCo9MQJF73GX9ZwZK1BY6USSomFEuosI
         3lhQ==
X-Gm-Message-State: AOAM532WN1dHOS1sLKVpLwbYeMsUj+IZ2J+Qc9gR5q/ETS5CKokAWdhi
        govVGRnoi6twZ8pfNHPfQ8j6E1QuEV+jPclW8HZ0ikXT206FbxRfj4V/2B1xeqNG6H3yOlDijIg
        wToE4vhH+45p320obxvXMssXz
X-Received: by 2002:a5d:6987:: with SMTP id g7mr11513365wru.79.1594823691729;
        Wed, 15 Jul 2020 07:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoUwaGmSvRQhzNykS+/dS1cmb21BRdb+HUz8NopOX7oAtNCENF0Kaaj4WsT5RV7bERzyNJsQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr11513341wru.79.1594823691514;
        Wed, 15 Jul 2020 07:34:51 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id e8sm3600980wrp.26.2020.07.15.07.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:34:50 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:34:46 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, davem@davemloft.net
Cc:     davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Message-ID: <20200715143446.kfl3zb4vwkk4ic4r@steredhat>
References: <20200710121243.120096-1-sgarzare@redhat.com>
 <20200713065423-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713065423-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 06:54:43AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2020 at 02:12:43PM +0200, Stefano Garzarella wrote:
> > Commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
> > on the_virtio_vsock") starts to use RCU to protect 'the_virtio_vsock'
> > pointer, but we forgot to annotate it.
> > 
> > This patch adds the annotation to fix the following sparse errors:
> > 
> >     net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
> > 
> > Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
> > Reported-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> who's merging this? Dave?

I think so, but I forgot the 'net' tag :-(

I'll wait to see if Dave will queue this, otherwise I'll resend with
the 'net' tag.

Thanks,
Stefano

