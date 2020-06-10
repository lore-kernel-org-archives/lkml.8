Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F718C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8DE2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkJ0zWWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgFJS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:59:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgFJS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591815571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1EkliDOGSB9xkuTdbcr6iLnaXcM0xDsqDQCVWf55kg=;
        b=TkJ0zWWwYHkJuE+kuPaz7nNQICD9d3Q88SZTWraJFHXpmQYEqQA82gZ6Zd6AmRKECI785P
        aTSv/IcmB/myKBGmrwxgvCH39MgsDdVKh08SLBooAFOqToNJOypITEn27oXVM+P5869bSc
        r+ofPphnFXWucRgTN5XCZVGcaf45u4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-XfK0uIAwOrSePaGIpgrXVA-1; Wed, 10 Jun 2020 14:59:29 -0400
X-MC-Unique: XfK0uIAwOrSePaGIpgrXVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02DF7107ACCA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:59:29 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF54510013D0;
        Wed, 10 Jun 2020 18:59:25 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>
Subject: [PATCH net-next v2 0/4] bonding: initial support for hardware crypto offload
Date:   Wed, 10 Jun 2020 14:59:06 -0400
Message-Id: <20200610185910.48668-1-jarod@redhat.com>
In-Reply-To: <20200608210058.37352-1-jarod@redhat.com>
References: <20200608210058.37352-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

