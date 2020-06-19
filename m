Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8EE2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STrxXC+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbgFSOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:32:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27047 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733218AbgFSOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592577146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njC/3EtrSHYr3N+lofsXRFJb5f8U26RH2zCjj0w9AP4=;
        b=STrxXC+SHkQUhjov6hJVUitjGwE2hJRKgzOm8XlPIqyOgQkHT0L91val6c5plEw82thou1
        xp9WQodZDhkR46Pfw5cle/UaD160fb7VlkCd8+We4Bugiwv/5i7LShEOIBmi/8MEiWxN6D
        QdNaGZ1KctZIm18VzJw+wE2ODlg7fvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-rkRw-MBSOOCvuTWNmeXu8g-1; Fri, 19 Jun 2020 10:32:22 -0400
X-MC-Unique: rkRw-MBSOOCvuTWNmeXu8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABF74BFC3;
        Fri, 19 Jun 2020 14:32:20 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E12037C215;
        Fri, 19 Jun 2020 14:32:18 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org
Subject: [PATCH net-next v3 3/4] mlx5: become aware of when running as a bonding slave
Date:   Fri, 19 Jun 2020 10:31:54 -0400
Message-Id: <20200619143155.20726-4-jarod@redhat.com>
In-Reply-To: <20200619143155.20726-1-jarod@redhat.com>
References: <20200619143155.20726-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been unable to get my hands on suitable supported hardware to date,
but I believe this ought to be all that is needed to enable the mlx5
driver to also work with bonding active-backup crypto offload passthru.

CC: Boris Pismenny <borisp@mellanox.com>
CC: Saeed Mahameed <saeedm@mellanox.com>
CC: Leon Romanovsky <leon@kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 92eb3bad4acd..72ad6664bd73 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -210,6 +210,9 @@ static inline int mlx5e_xfrm_validate_state(struct xfrm_state *x)
 	struct net_device *netdev = x->xso.dev;
 	struct mlx5e_priv *priv;
 
+	if (x->xso.slave_dev)
+		netdev = x->xso.slave_dev;
+
 	priv = netdev_priv(netdev);
 
 	if (x->props.aalgo != SADB_AALG_NONE) {
@@ -291,6 +294,9 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x)
 	unsigned int sa_handle;
 	int err;
 
+	if (x->xso.slave_dev)
+		netdev = x->xso.slave_dev;
+
 	priv = netdev_priv(netdev);
 
 	err = mlx5e_xfrm_validate_state(x);
-- 
2.20.1

