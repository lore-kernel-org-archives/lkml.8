Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E65C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D142084D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgD0RSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0RSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:18:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A61C0610D5;
        Mon, 27 Apr 2020 10:18:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1092D15D4A682;
        Mon, 27 Apr 2020 10:18:20 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:18:19 -0700 (PDT)
Message-Id: <20200427.101819.498317950218972559.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] vsock/virtio: fixes about packet delivery
 to monitoring devices
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200424150830.183113-1-sgarzare@redhat.com>
References: <20200424150830.183113-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Apr 2020 10:18:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 24 Apr 2020 17:08:28 +0200

> During the review of v1, Stefan pointed out an issue introduced by
> that patch, where replies can appear in the packet capture before
> the transmitted packet.
> 
> While fixing my patch, reverting it and adding a new flag in
> 'struct virtio_vsock_pkt' (patch 2/2), I found that we already had
> that issue in vhost-vsock, so I fixed it (patch 1/2).
> 
> v1 -> v2:
> - reverted the v1 patch, to avoid that replies can appear in the
>   packet capture before the transmitted packet [Stefan]
> - added patch to fix packet delivering to monitoring devices in
>   vhost-vsock
> - added patch to check if the packet is already delivered to
>   monitoring devices
> 
> v1: https://patchwork.ozlabs.org/project/netdev/patch/20200421092527.41651-1-sgarzare@redhat.com/

Series applied, thank you.
