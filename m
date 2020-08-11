Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3942073A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffLtItTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHKDDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:03:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727078AbgHKDDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597115013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SI8Js2mxCoXbXtkZ8wg9i6tg2cNBsDPngHO6YSr8VhI=;
        b=ffLtItTM4Jc0J0EcgfCck3F7zEqH2yn/uz82lj3bO585praH/mFEu8iyEfzVtpnAxgionJ
        0Ibz2y7lpPC6TsST1+uJx7x3OurTE+eYAX7s2VOPG2wnE2UWcUZhj7vNDMdC0ATOjHX6WN
        smdYtvFC83m3ut01mSBpdR2FDZbIOA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-CxXmk7yAOLSi9HDjpL7OWw-1; Mon, 10 Aug 2020 23:03:19 -0400
X-MC-Unique: CxXmk7yAOLSi9HDjpL7OWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 632F810059A9;
        Tue, 11 Aug 2020 03:03:18 +0000 (UTC)
Received: from [10.72.13.186] (ovpn-13-186.pek2.redhat.com [10.72.13.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC42C7B92F;
        Tue, 11 Aug 2020 03:03:13 +0000 (UTC)
Subject: Re: drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error:
 double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202008081502.F9nEsAf6%lkp@intel.com>
 <20200810083313-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5b711270-1307-9c57-548c-59404984ce66@redhat.com>
Date:   Tue, 11 Aug 2020 11:03:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810083313-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/10 下午8:33, Michael S. Tsirkin wrote:
> On Sat, Aug 08, 2020 at 03:37:07PM +0800, kernel test robot wrote:
>> Hi Jason,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
>> commit: 20c384f1ea1a0bc7320bc445c72dd02d2970d594 vhost: refine vhost and vringh kconfig
>> date:   4 months ago
>> config: arm-randconfig-m031-20200808 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> New smatch warnings:
>> drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error: double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
>> drivers/vhost/net.c:1010 vhost_net_rx_peek_head_len() error: double unlocked 'sk->sk_receive_queue.lock' (orig line 1002)
> Weird. Can't figure out where the double unlock is ...


Yes, looks like a false positive.

Thanks


>
>
>> Old smatch warnings:
>> drivers/vhost/net.c:1528 vhost_net_set_backend() warn: passing a valid pointer to 'PTR_ERR'
> this stumped me too...
>
>> vim +1010 drivers/vhost/net.c
>>
>> 8dd014adfea6f17 David Stevens   2010-07-27   994
>> be294a51adfc1e1 Toshiaki Makita 2018-07-03   995  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>> be294a51adfc1e1 Toshiaki Makita 2018-07-03   996  				      bool *busyloop_intr)
>> 030881372460654 Jason Wang      2016-03-04   997  {
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03   998  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03   999  	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
>> 6369fec5be0aad4 Toshiaki Makita 2018-07-03  1000  	struct vhost_virtqueue *rvq = &rnvq->vq;
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03  1001  	struct vhost_virtqueue *tvq = &tnvq->vq;
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03 @1002  	int len = peek_head_len(rnvq, sk);
>> 030881372460654 Jason Wang      2016-03-04  1003
>> dc151282bbdaed0 Tonghao Zhang   2018-09-25  1004  	if (!len && rvq->busyloop_timeout) {
>> f5a4941aa6d190e Jason Wang      2018-05-29  1005  		/* Flush batched heads first */
>> 09c3248938c3e3b Jason Wang      2018-07-20  1006  		vhost_net_signal_used(rnvq);
>> 030881372460654 Jason Wang      2016-03-04  1007  		/* Both tx vq and rx socket were polled here */
>> dc151282bbdaed0 Tonghao Zhang   2018-09-25  1008  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>> 030881372460654 Jason Wang      2016-03-04  1009
>> 28b9b33b983f4de Toshiaki Makita 2018-07-03 @1010  		len = peek_head_len(rnvq, sk);
>> 030881372460654 Jason Wang      2016-03-04  1011  	}
>> 030881372460654 Jason Wang      2016-03-04  1012
>> 030881372460654 Jason Wang      2016-03-04  1013  	return len;
>> 030881372460654 Jason Wang      2016-03-04  1014  }
>> 030881372460654 Jason Wang      2016-03-04  1015
>>
>> :::::: The code at line 1010 was first introduced by commit
>> :::::: 28b9b33b983f4de3ce9e660e3efe1e08adabf779 vhost_net: Rename local variables in vhost_net_rx_peek_head_len
>>
>> :::::: TO: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> :::::: CC: David S. Miller <davem@davemloft.net>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

