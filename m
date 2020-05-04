Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02805C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D673120721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzZt5HP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgEDPAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727786AbgEDPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588604431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cdwwTQjs2pf4fY2Ig50VhFRUWCPT+YklWtjqKwPO5h4=;
        b=UzZt5HP/fhSDTfv+A5PdoB6EQi5D7t17SwfREJl5ZyipcCR8kkq/nPoTRHeNWeC5+ySC/E
        6AZguW9ZQaNjU2IT7+3qOMdhdMuSRExxk1pWhQBllIrLr4Cnugo+OUG37Px+tVsGd6sV5b
        oPpQkxvSgGHgPzDI+IqXQlE4RjeR86U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-5acs1N2TNjiXkABi1J9WOw-1; Mon, 04 May 2020 11:00:30 -0400
X-MC-Unique: 5acs1N2TNjiXkABi1J9WOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C4058064D1;
        Mon,  4 May 2020 15:00:27 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7D570525;
        Mon,  4 May 2020 15:00:21 +0000 (UTC)
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
Subject: [RFC PATCH net-next 0/3] bonding: support hardware crypto offload
Date:   Mon,  4 May 2020 10:59:40 -0400
Message-Id: <20200504145943.8841-1-jarod@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an initial "proof of concept" functional implementation for doing
pass-through of hardware encryption from bonding device to capable slaves=
.
This was tested using an ixgbe-driven Intel x520 NIC with libreswan and a
transport mode connection, on top of an active-backup bond, using netperf
and downing an interface during. Failover takes a moment, but does work,
and overall performance is right on par with offload when running on a
bare interface.

Caveats: this is ONLY enabled for active-backup, because I'm not sure
how one would manage multiple offload handles for different devices all
running at the same time in the same xfrm, and it relies on some minor
changes to both the xfrm code and slave device driver code to get things
to behave, and I don't have immediate access to any other hardware that
could function similarly to update driver code accordingly.

I'm hoping folks with more of an idea about xfrm have some thoughts on
ways to make this cleaner, and possibly support more bonding modes, but
I'm reasonably happy I've made it this far. :)

Jarod Wilson (3):
  xfrm: bail early on slave pass over skb
  ixgbe_ipsec: become aware of when running as a bonding slave
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

 drivers/net/bonding/bond_main.c               | 103 +++++++++++++++++-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  39 +++++--
 include/net/bonding.h                         |   1 +
 include/net/xfrm.h                            |   1 +
 net/xfrm/xfrm_device.c                        |  34 +++---
 5 files changed, 150 insertions(+), 28 deletions(-)

--=20
2.20.1

