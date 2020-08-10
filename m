Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736B02076B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VcCcrVlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgHJQbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgHJQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:31:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC6C061756;
        Mon, 10 Aug 2020 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FMM2Oh5ZcSDbnvQyC1t6T96Kd/pYSYYJIBdqY44N+mE=; b=VcCcrVlTv4q8hsDw2XhWxjImqo
        1f9DJZEH46qIh7p2rkLn4PG88vV4p0bFar1lLmZYAcAnqwkhTAiw429X/TX1tUyN0psM1k4rzhFyC
        Ui8zFdkoEGd4AWQRbkB0IZBhUDj+YjVNCFxkddwgBeka9S7Tx3QR2KxoidCQn5qvjWB71pzfIFaX0
        Z0+i50mpuP1Lzsa33G6uCbb/edkwV+OWceRKtUI2dsywROH+KBPj46cClTkvRk7PUKjsxebypErvZ
        iuTMTLmK4HzvkNpr9HgNiqYvuqDpVO3GNB7kq+aJP4qFQTjJ4tnMFQUqfCfCdeYzXd9a7jrWqdGP1
        C+ByazgQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Ahq-0001Ko-0D; Mon, 10 Aug 2020 16:31:26 +0000
Subject: Re: linux-next: Tree for Aug 10 (drivers/vdpa/mlx5/net)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Cohen <eli@mellanox.com>,
        virtualization@lists.linux-foundation.org
References: <20200810141028.2140cfb2@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a7a0e6d-842a-78f6-aeac-c5b4c27b7186@infradead.org>
Date:   Mon, 10 Aug 2020 09:31:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810141028.2140cfb2@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/20 9:10 PM, Stephen Rothwell wrote:
> Hi all,
> 


on i386:

Lots (63) of left shift warnings: {not all are shown here}


  CC      drivers/vdpa/mlx5/net/mlx5_vnet.o
In file included from ../include/linux/bits.h:6:0,
                 from ../include/linux/bitops.h:5,
                 from ../include/linux/kernel.h:12,
                 from ../include/linux/vdpa.h:5,
                 from ../drivers/vdpa/mlx5/net/mlx5_vnet.c:4:
../drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'print_features':
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:27:60: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
                                                            ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:28:3: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
   ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:28:27: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
                           ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:28:55: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
                                                       ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:29:3: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
   ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:30:30: note: in expansion of macro 'BIT'
   BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
                              ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
