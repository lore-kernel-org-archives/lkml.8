Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313612080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJwLfl9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgFSOcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:32:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbgFSOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592577139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jY8FDmUXtOuEmRWEl+8sZh7Yhfoekmg5zQ2i70hnoeU=;
        b=UJwLfl9DzFbpyP0bE3c4G5GQ9oHi0/xn3rPT0/cHLMsuP0bWa5tVOdnX1u34nFfvtGLf/w
        Ha/0Pt7oAwKPKMsOgbqgWaobVvqNjQJDtSS1krAyCB7DXyzsUktDcwFaFJP2JFlRHBjvEj
        HEXT25u5PixWqLxCjd5PuLVSkYXAt5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-EJ_yQEmhMCmp4ZJJ1HbATQ-1; Fri, 19 Jun 2020 10:32:14 -0400
X-MC-Unique: EJ_yQEmhMCmp4ZJJ1HbATQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826031005513;
        Fri, 19 Jun 2020 14:32:12 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 616157C21F;
        Fri, 19 Jun 2020 14:32:05 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next v3 0/4] bonding: initial support for hardware crypto offload
Date:   Fri, 19 Jun 2020 10:31:51 -0400
Message-Id: <20200619143155.20726-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an initial functional implementation for doing pass-through of
hardware encryption from bonding device to capable slaves, in active-backup
bond setups. This was developed and tested using ixgbe-driven Intel x520
interfaces with libreswan and a transport mode connection, primarily using
netperf, with assorted connection failures forced during transmission. The
failover works quite well in my testing, and overall performance is right
on par with offload when running on a bare interface, no bond involved.

Caveats: this is ONLY enabled for active-backup, because I'm not sure
how one would manage multiple offload handles for different devices all
running at the same time in the same xfrm, and it relies on some minor
changes to both the xfrm code and slave device driver code to get things
to behave, and I don't have immediate access to any other hardware that
could function similarly, but the NIC driver changes are minimal and
straight-forward enough that I've included what I think ought to be
enough for mlx5 devices too.

v2: reordered patches, switched (back) to using CONFIG_XFRM_OFFLOAD
to wrap the code additions and wrapped overlooked additions.
v3: rebase w/net-next open, add proper cc list to cover letter

Jarod Wilson (4):
  xfrm: bail early on slave pass over skb
  ixgbe_ipsec: become aware of when running as a bonding slave
  mlx5: become aware of when running as a bonding slave
  bonding: support hardware encryption offload to slaves

CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev@vger.kernel.org
CC: intel-wired-lan@lists.osuosl.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>

Jarod Wilson (4):
  xfrm: bail early on slave pass over skb
  ixgbe_ipsec: become aware of when running as a bonding slave
  mlx5: become aware of when running as a bonding slave
  bonding: support hardware encryption offload to slaves

 drivers/net/bonding/bond_main.c               | 127 +++++++++++++++++-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  39 ++++--
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   6 +
 include/net/bonding.h                         |   3 +
 include/net/xfrm.h                            |   1 +
 net/xfrm/xfrm_device.c                        |  34 ++---
 6 files changed, 183 insertions(+), 27 deletions(-)

-- 
2.20.1

