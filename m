Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F395620760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzsweOiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHVBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:01:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgFHVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591650069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DYZkBEdTgRi8pgHkgslXDjAmBDROBLmoQauKMzOyiHc=;
        b=GzsweOiPCQubhJGgskI9jpvrRAxe8PCU6e/+E2bMwgYnMquVfjoYCd++Mp5mfkx90OLuCV
        337tqwSWXofbx8PL1M/ZTUVmjDagxiDteoNSV/ICrYx4NQhv8SuoyO/kYcVqiPzNBgTU4B
        dU+4FUe8LiXU5mbHkEukcrWgnEMHk+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-huYbPaVjOg2Lp36aXSz9xQ-1; Mon, 08 Jun 2020 17:01:07 -0400
X-MC-Unique: huYbPaVjOg2Lp36aXSz9xQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B00B8018A7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 21:01:06 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3814061169;
        Mon,  8 Jun 2020 21:01:03 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>
Subject: [PATCH net-next 0/4] bonding: initial support for hardware crypto offload
Date:   Mon,  8 Jun 2020 17:00:54 -0400
Message-Id: <20200608210058.37352-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Earlier RFC submissions of this set didn't get any feedback, other than
from the build bot, so I'm hoping silence means nobody hated it...

Jarod Wilson (4):
  xfrm: bail early on slave pass over skb
  ixgbe_ipsec: become aware of when running as a bonding slave
  bonding: support hardware encryption offload to slaves
  mlx5: support crypto offload as a bonding slave

 drivers/net/Kconfig                           |  11 ++
 drivers/net/bonding/bond_main.c               | 111 +++++++++++++++++-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  39 ++++--
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   6 +
 include/net/bonding.h                         |   3 +
 include/net/xfrm.h                            |   1 +
 net/xfrm/xfrm_device.c                        |  34 +++---
 7 files changed, 177 insertions(+), 28 deletions(-)

-- 
2.20.1

