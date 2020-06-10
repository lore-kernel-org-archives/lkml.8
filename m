Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F442074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj8i8RVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFJS7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:59:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730095AbgFJS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591815581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njC/3EtrSHYr3N+lofsXRFJb5f8U26RH2zCjj0w9AP4=;
        b=Oj8i8RVF3aa5DLbJAKv7WwMIlunVTwOpI4O0UFejz6K9EBh9G6AmCnayzjfyunG/cdFQnH
        NZWC0lrWr+ja0U1Niyju/tfpgls19ZJ8s9JYftz+xg0mg1tMuWOwQt95bYWcQHXI/sLLiX
        XMOFq86b5vrNOyyYZz5z9CRHNYG4pMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-_NqAYXwFM1iOjKL4VWVmhw-1; Wed, 10 Jun 2020 14:59:37 -0400
X-MC-Unique: _NqAYXwFM1iOjKL4VWVmhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52486873092;
        Wed, 10 Jun 2020 18:59:35 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8078A10013D0;
        Wed, 10 Jun 2020 18:59:33 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/4] mlx5: become aware of when running as a bonding slave
Date:   Wed, 10 Jun 2020 14:59:09 -0400
Message-Id: <20200610185910.48668-4-jarod@redhat.com>
In-Reply-To: <20200610185910.48668-1-jarod@redhat.com>
References: <20200608210058.37352-1-jarod@redhat.com>
 <20200610185910.48668-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

