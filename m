Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE69C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822E920719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860875;
	bh=PGRiRoVTRfv+QPQFffdOaLAOyu+ZjllG5kH32WIlkgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G+D3N6nY1kSOQ7uB8h/zcnjvZKovZK8RJ2Y7R0NsDHbCuw4xl2jEQAn5QbrFa2gt8
	 jbAlrftLxxHJDCcWIAIr/qsBcpov/VpRj/+7vh86oXSj4DD2b768go15QcueIEjKBI
	 Qx95EMLGcfZKOTiSDsY13SWACIF+R7Ds0YuGCHyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgG0OIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgG0OIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE0D207FC;
        Mon, 27 Jul 2020 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858903;
        bh=PGRiRoVTRfv+QPQFffdOaLAOyu+ZjllG5kH32WIlkgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjtmYs3Wpc/95k56Fcw1ih6JCt/jSVl/KvDT+3GcqqyWgN4jhicVaTpxunYw3xfGt
         5t9P4hpWIsMd8bu+9TExC7Xib0cmYRgv/bm+R5Gza0rUpZGNnGrHcOYB13fPHCVtt+
         uLIJXiOXiy69H7q8MNFqs/OAzFncsA2C0A4dL3qE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Jian <liujian56@huawei.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/64] mlxsw: destroy workqueue when trap_register in mlxsw_emad_init
Date:   Mon, 27 Jul 2020 16:04:07 +0200
Message-Id: <20200727134912.546393647@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 5dbaeb87f2b309936be0aeae00cbc9e7f20ab296 ]

When mlxsw_core_trap_register fails in mlxsw_emad_init,
destroy_workqueue() shouled be called to destroy mlxsw_core->emad_wq.

Fixes: d965465b60ba ("mlxsw: core: Fix possible deadlock")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index fad26046e1595..96f9f267d16d4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -619,7 +619,7 @@ static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 	err = mlxsw_core_trap_register(mlxsw_core, &mlxsw_emad_rx_listener,
 				       mlxsw_core);
 	if (err)
-		return err;
+		goto err_trap_register;
 
 	err = mlxsw_core->driver->basic_trap_groups_set(mlxsw_core);
 	if (err)
@@ -631,6 +631,7 @@ static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 err_emad_trap_set:
 	mlxsw_core_trap_unregister(mlxsw_core, &mlxsw_emad_rx_listener,
 				   mlxsw_core);
+err_trap_register:
 	destroy_workqueue(mlxsw_core->emad_wq);
 	return err;
 }
-- 
2.25.1



