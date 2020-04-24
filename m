Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55469C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2536C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7GwWAtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgDXACB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:02:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727877AbgDXACA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587686519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KnzXeTNRWsvkIaAIlOuvsLlBsmBeB6mNMsObtuVlOWs=;
        b=d7GwWAtvu9Xhfo8NUKZe1yjjBZQfu6AFciuRgRyjGTEgc3NGRFxqEKQL3IPtS9tGhuHcA6
        C/EJRrlliHMuq52wSOmGmr9hFZxAgkgRKbzyrNZCszX6ytvhELmBorOTj2mRiAu8WTA+08
        0t3OEYJ2ntM0IQPpcUgq407diqxOMTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-gHeyccHWOHeBfk9WVBeIhw-1; Thu, 23 Apr 2020 20:01:57 -0400
X-MC-Unique: gHeyccHWOHeBfk9WVBeIhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8CA80B70D;
        Fri, 24 Apr 2020 00:01:55 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A64C10016DA;
        Fri, 24 Apr 2020 00:01:51 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netanel@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com, saeedb@amazon.com,
        zorik@amazon.com, davem@davemloft.net
Subject: [PATCH] net/ena: Fix build warning in ena_xdp_set()
Date:   Fri, 24 Apr 2020 10:01:46 +1000
Message-Id: <20200424000146.6188-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following build warning in ena_xdp_set()

   In file included from ./include/net/inet_sock.h:19,
      from ./include/net/ip.h:27,
      from drivers/net/ethernet/amazon/ena/ena_netdev.c:46:
   drivers/net/ethernet/amazon/ena/ena_netdev.c: In function         \
   =E2=80=98ena_xdp_set=E2=80=99:                                        =
            \
   drivers/net/ethernet/amazon/ena/ena_netdev.c:557:6: warning:      \
   format =E2=80=98%lu=E2=80=99                                          =
            \
   expects argument of type =E2=80=98long unsigned int=E2=80=99, but argu=
ment 4      \
   has type =E2=80=98int=E2=80=99                                        =
            \
   [-Wformat=3D] "Failed to set xdp program, the current MTU (%d) is   \
   larger than the maximum allowed MTU (%lu) while xdp is on",

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/e=
thernet/amazon/ena/ena_netdev.c
index 2cc765df8da3..6ff648423867 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -554,7 +554,7 @@ static int ena_xdp_set(struct net_device *netdev, str=
uct netdev_bpf *bpf)
=20
 	} else if (rc =3D=3D ENA_XDP_CURRENT_MTU_TOO_LARGE) {
 		netif_err(adapter, drv, adapter->netdev,
-			  "Failed to set xdp program, the current MTU (%d) is larger than the=
 maximum allowed MTU (%lu) while xdp is on",
+			  "Failed to set xdp program, the current MTU (%d) is larger than the=
 maximum allowed MTU (%d) while xdp is on",
 			  netdev->mtu, ENA_XDP_MAX_MTU);
 		NL_SET_ERR_MSG_MOD(bpf->extack,
 				   "Failed to set xdp program, the current MTU is larger than the ma=
ximum allowed MTU. Check the dmesg for more info");
--=20
2.23.0

