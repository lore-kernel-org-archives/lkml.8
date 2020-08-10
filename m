Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85256C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5944D2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBtIsrAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHJMeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:34:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgHJMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597062842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rZgeNC1EUi6JPr5GLAH/Le84z9qh03h/k4kDHsCbO8=;
        b=gBtIsrAOe3rYcYJejEmaMaXdSVCNjoIVPpB/D4PjVHnkVIkYuy+12HpnuxEhK8E2Rl5zYo
        8rqj9K1AB4nUfbSCQl/NKXQ8h80PzK9bbaPXhX1bjl2SRo8dFVqWfcvd8u1nRGeyQ7p+Lv
        KvQpsaAMCitrJHTpEIwn51XpwEgo+rU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-zpZpcA-tN2CCifBMIhPJjg-1; Mon, 10 Aug 2020 08:33:54 -0400
X-MC-Unique: zpZpcA-tN2CCifBMIhPJjg-1
Received: by mail-wr1-f72.google.com with SMTP id d6so4162251wrv.23
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rZgeNC1EUi6JPr5GLAH/Le84z9qh03h/k4kDHsCbO8=;
        b=AJtMvyOc9/xgPlygHOdTmlxEFqxNSbaGM/FroAartUqwS9oiu6u979kxOPOdKlKkgn
         0ksIUarvukAC7bWKX+b25yQm5ShNzeumRWPLx3eMwkEHMz0JALuOuJx7xdUQx4XnDXFI
         jG5XHmb4HsPKLc0XpXCwhqh9817/f5AM0zz0ARKtSiETCUnODo1MbILRd2p2QiLs3kf5
         theHCt56BUFYhotqGNpsPCtYdlqMSTab0PaZ6Pav07h4r5cciIbSaTVCmtTkXd3v5LLm
         yFcWOe6Ww0kISu4p5ypvUuTTuF/4S44BCGDs4hfKuyxgKkz5SYDDhKOtKuS1x3XMVvOw
         6rKg==
X-Gm-Message-State: AOAM532/+r6p7KqxwjNdFhb9IeQBl3hhqQBnO0sWZzQnuYsDxz/RiOAS
        RC+Bylr7WI8+k0NW52ah1dNYxISzDqgYnnm2XakI6aBYxgLkwfhqYRWvvJDr06B9lugP2gfk/zX
        pk4f8BMHqBhNfIOc00un5OmFC
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr23950490wrp.169.1597062832237;
        Mon, 10 Aug 2020 05:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxykxXM7P/dNEtUe9T5wlqyb90H1dE63BSZtx8LmNq8+Y+eKW5JWtGmEO7c+v+xDiC7cNFOQ==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr23950479wrp.169.1597062832057;
        Mon, 10 Aug 2020 05:33:52 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
        by smtp.gmail.com with ESMTPSA id f6sm3096761wme.32.2020.08.10.05.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:33:51 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:33:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error:
 double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
Message-ID: <20200810083313-mutt-send-email-mst@kernel.org>
References: <202008081502.F9nEsAf6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008081502.F9nEsAf6%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 03:37:07PM +0800, kernel test robot wrote:
> Hi Jason,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
> commit: 20c384f1ea1a0bc7320bc445c72dd02d2970d594 vhost: refine vhost and vringh kconfig
> date:   4 months ago
> config: arm-randconfig-m031-20200808 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> New smatch warnings:
> drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error: double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
> drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error: double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)

Weird. Can't figure out where the double unlock is ...


> Old smatch warnings:
> drivers/vhost/net.c:1528 vhost_net_set_backend() warn: passing a valid pointer to 'PTR_ERR'

this stumped me too...

> vim +1010 drivers/vhost/net.c
> 
> 8dd014adfea6f17 David Stevens   2010-07-27   994  
> be294a51adfc1e1 Toshiaki Makita 2018-07-03   995  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> be294a51adfc1e1 Toshiaki Makita 2018-07-03   996  				      bool *busyloop_intr)
> 030881372460654 Jason Wang      2016-03-04   997  {
> 28b9b33b983f4de Toshiaki Makita 2018-07-03   998  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
> 28b9b33b983f4de Toshiaki Makita 2018-07-03   999  	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
> 6369fec5be0aad4 Toshiaki Makita 2018-07-03  1000  	struct vhost_virtqueue *rvq = &rnvq->vq;
> 28b9b33b983f4de Toshiaki Makita 2018-07-03  1001  	struct vhost_virtqueue *tvq = &tnvq->vq;
> 28b9b33b983f4de Toshiaki Makita 2018-07-03 @1002  	int len = peek_head_len(rnvq, sk);
> 030881372460654 Jason Wang      2016-03-04  1003  
> dc151282bbdaed0 Tonghao Zhang   2018-09-25  1004  	if (!len && rvq->busyloop_timeout) {
> f5a4941aa6d190e Jason Wang      2018-05-29  1005  		/* Flush batched heads first */
> 09c3248938c3e3b Jason Wang      2018-07-20  1006  		vhost_net_signal_used(rnvq);
> 030881372460654 Jason Wang      2016-03-04  1007  		/* Both tx vq and rx socket were polled here */
> dc151282bbdaed0 Tonghao Zhang   2018-09-25  1008  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
> 030881372460654 Jason Wang      2016-03-04  1009  
> 28b9b33b983f4de Toshiaki Makita 2018-07-03 @1010  		len = peek_head_len(rnvq, sk);
> 030881372460654 Jason Wang      2016-03-04  1011  	}
> 030881372460654 Jason Wang      2016-03-04  1012  
> 030881372460654 Jason Wang      2016-03-04  1013  	return len;
> 030881372460654 Jason Wang      2016-03-04  1014  }
> 030881372460654 Jason Wang      2016-03-04  1015  
> 
> :::::: The code at line 1010 was first introduced by commit
> :::::: 28b9b33b983f4de3ce9e660e3efe1e08adabf779 vhost_net: Rename local variables in vhost_net_rx_peek_head_len
> 
> :::::: TO: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


