Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E87C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D202064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943566;
	bh=0f2O6LbU1riSEQ/9fx14VTUmUVmQU+Istl42Am8osvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JrAQ43Rl4fJDVvF7BiH89Hh/CmHgM+WAPko3sGShpb6Alh8gaQ14ZmUkwKpFu3riI
	 kZXlHFaqTtFYGh+Ai1y3symfbzqAgLc/Y8XGGLxUQrRPKDrFcAX8duVV6AKq6WvTlU
	 MNpLhYEHgYDFYcpuSfqnA1BeGuvq2D6g/UkzQaYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbgFWUTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389494AbgFWUTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:19:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A402064B;
        Tue, 23 Jun 2020 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943559;
        bh=0f2O6LbU1riSEQ/9fx14VTUmUVmQU+Istl42Am8osvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RATIw7L2kCXjSr5ehfankNGINAUyn3wwiBrn4Okad4W9DTUyJva+QQxaJyFqDzI2
         Aw9WR9IENEk4X5+IJWeDdih76KBDEhnX0wtyn0tmUDQFoGt/FmsaO0WiQRm2KCb1Ou
         aML6Zh+h9vn2Ap1qqTfYCIstyVo+lNrHMOQbgxTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 409/477] mlxsw: spectrum: Adjust headroom buffers for 8x ports
Date:   Tue, 23 Jun 2020 21:56:46 +0200
Message-Id: <20200623195426.868827076@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 60833d54d56c21e7538296eb2e00e104768fd047 ]

The port's headroom buffers are used to store packets while they
traverse the device's pipeline and also to store packets that are egress
mirrored.

On Spectrum-3, ports with eight lanes use two headroom buffers between
which the configured headroom size is split.

In order to prevent packet loss, multiply the calculated headroom size
by two for 8x ports.

Fixes: da382875c616 ("mlxsw: spectrum: Extend to support Spectrum-3 ASIC")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c      |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h      | 13 +++++++++++++
 .../net/ethernet/mellanox/mlxsw/spectrum_buffers.c  |  1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c |  1 +
 4 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 6b39978acd078..3e4199246a18d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -990,8 +990,10 @@ int __mlxsw_sp_port_headroom_set(struct mlxsw_sp_port *mlxsw_sp_port, int mtu,
 
 		lossy = !(pfc || pause_en);
 		thres_cells = mlxsw_sp_pg_buf_threshold_get(mlxsw_sp, mtu);
+		mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port, &thres_cells);
 		delay_cells = mlxsw_sp_pg_buf_delay_get(mlxsw_sp, mtu, delay,
 							pfc, pause_en);
+		mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port, &delay_cells);
 		total_cells = thres_cells + delay_cells;
 
 		taken_headroom_cells += total_cells;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index ca56e72cb4b73..e28ecb84b8164 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -395,6 +395,19 @@ mlxsw_sp_port_vlan_find_by_vid(const struct mlxsw_sp_port *mlxsw_sp_port,
 	return NULL;
 }
 
+static inline void
+mlxsw_sp_port_headroom_8x_adjust(const struct mlxsw_sp_port *mlxsw_sp_port,
+				 u16 *p_size)
+{
+	/* Ports with eight lanes use two headroom buffers between which the
+	 * configured headroom size is split. Therefore, multiply the calculated
+	 * headroom size by two.
+	 */
+	if (mlxsw_sp_port->mapping.width != 8)
+		return;
+	*p_size *= 2;
+}
+
 enum mlxsw_sp_flood_type {
 	MLXSW_SP_FLOOD_TYPE_UC,
 	MLXSW_SP_FLOOD_TYPE_BC,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
index 968f0902e4fea..19bf0768ed788 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -312,6 +312,7 @@ static int mlxsw_sp_port_pb_init(struct mlxsw_sp_port *mlxsw_sp_port)
 
 		if (i == MLXSW_SP_PB_UNUSED)
 			continue;
+		mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port, &size);
 		mlxsw_reg_pbmc_lossy_buffer_pack(pbmc_pl, i, size);
 	}
 	mlxsw_reg_pbmc_lossy_buffer_pack(pbmc_pl,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 9fb2e9d93929c..7c5032f9c8fff 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -776,6 +776,7 @@ mlxsw_sp_span_port_buffsize_update(struct mlxsw_sp_port *mlxsw_sp_port, u16 mtu)
 		speed = 0;
 
 	buffsize = mlxsw_sp_span_buffsize_get(mlxsw_sp, speed, mtu);
+	mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port, (u16 *) &buffsize);
 	mlxsw_reg_sbib_pack(sbib_pl, mlxsw_sp_port->local_port, buffsize);
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sbib), sbib_pl);
 }
-- 
2.25.1



