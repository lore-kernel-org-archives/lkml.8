Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0D7206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876467;
	bh=Sz1Bppt4O5QqjzjUK9DivHQnbtFIzPAdJJy0YWOi9Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrXnJfP4ek2SKcX0TXpyJ3jJth39MmzlsEx03lC12IVSXgkBvgJZ7Fq7A8mr56eeV
	 ZobA37j6iXNhxq6CkORtiOBUNJj3E7oNIhIYhGfJYjNrU3hcg0DEEK+GKa+vnxC7D7
	 /3Jmr/Dz5xuhmUJulvRtyc3Pju7ehqgmOerKRjS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404791AbgAXOeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392094AbgAXOTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5192087E;
        Fri, 24 Jan 2020 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875588;
        bh=Sz1Bppt4O5QqjzjUK9DivHQnbtFIzPAdJJy0YWOi9Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9npbap8JtdfJQ9yqmNnWQwAfNo3vNzD1Km1pIStwroGo1U1DWAGPBaPB6u4N3s/z
         RIWiNqfpDeWK3ahZf6G1sTJZ/hEifVCgxYg2JPuDkgkG9QonBxC/4NOVKcVNcpEBcp
         Zh5UdUDDEnokzuoEWb+Xcw+pUfH0jMns0TJVQJls=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Machata <petrm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 078/107] mlxsw: spectrum: Wipe xstats.backlog of down ports
Date:   Fri, 24 Jan 2020 09:17:48 -0500
Message-Id: <20200124141817.28793-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit ca7609ff3680c51d6c29897f3117aa2ad904f92a ]

Per-port counter cache used by Qdiscs is updated periodically, unless the
port is down. The fact that the cache is not updated for down ports is no
problem for most counters, which are relative in nature. However, backlog
is absolute in nature, and if there is a non-zero value in the cache around
the time that the port goes down, that value just stays there. This value
then leaks to offloaded Qdiscs that report non-zero backlog even if
there (obviously) is no traffic.

The HW does not keep backlog of a downed port, so do likewise: as the port
goes down, wipe the backlog value from xstats.

Fixes: 075ab8adaf4e ("mlxsw: spectrum: Collect tclass related stats periodically")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 45f6836fcc629..a806c6190bb1e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1161,6 +1161,9 @@ static void update_stats_cache(struct work_struct *work)
 			     periodic_hw_stats.update_dw.work);
 
 	if (!netif_carrier_ok(mlxsw_sp_port->dev))
+		/* Note: mlxsw_sp_port_down_wipe_counters() clears the cache as
+		 * necessary when port goes down.
+		 */
 		goto out;
 
 	mlxsw_sp_port_get_hw_stats(mlxsw_sp_port->dev,
@@ -4170,6 +4173,15 @@ static int mlxsw_sp_port_unsplit(struct mlxsw_core *mlxsw_core, u8 local_port,
 	return 0;
 }
 
+static void
+mlxsw_sp_port_down_wipe_counters(struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	int i;
+
+	for (i = 0; i < TC_MAX_QUEUE; i++)
+		mlxsw_sp_port->periodic_hw_stats.xstats.backlog[i] = 0;
+}
+
 static void mlxsw_sp_pude_event_func(const struct mlxsw_reg_info *reg,
 				     char *pude_pl, void *priv)
 {
@@ -4191,6 +4203,7 @@ static void mlxsw_sp_pude_event_func(const struct mlxsw_reg_info *reg,
 	} else {
 		netdev_info(mlxsw_sp_port->dev, "link down\n");
 		netif_carrier_off(mlxsw_sp_port->dev);
+		mlxsw_sp_port_down_wipe_counters(mlxsw_sp_port);
 	}
 }
 
-- 
2.20.1

