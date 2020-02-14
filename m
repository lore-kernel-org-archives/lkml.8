Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C58C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000A32469F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696761;
	bh=nk3Sqj0NLjtU5VjaolQGd8Dtv/Yym6D2gggQLfIKF8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wmp44/rSEtAQfOYDp1Mf1EEf8b2Rb7ZchKoc/3sto4z/2dHW7BeVX2jkb3ludPnnU
	 aBSmtYDGVQMuQIziTunu75YIqKP0Np3Z0UC4V+rDNh5AKJKkgeEQRZVJVkw7N2T/vd
	 t7Q8ab5F7g1l8JqV6A5nUdFDj8m7o18oA78lngnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392035AbgBNQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391818AbgBNQLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B96F246A4;
        Fri, 14 Feb 2020 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696693;
        bh=nk3Sqj0NLjtU5VjaolQGd8Dtv/Yym6D2gggQLfIKF8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7EF/VE7x4WrsQaxp26jNwP+eZLmxqFa6BZXLtaARzeYnH/3sYIPMiZHlax20HNmc
         eAJ5+uI7cpMZ5+4f2Ra5A4CQOiH3+cHsiP0TYFlY26KBFd8A/oZdRO1GLrNUPRInRz
         RtzvTGAK8kvNNQdaVcwxi9rZxyvKhH/k3mAx8HDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 459/459] mlxsw: spectrum_dpipe: Add missing error path
Date:   Fri, 14 Feb 2020 11:01:49 -0500
Message-Id: <20200214160149.11681-459-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 3a99cbb6fa7bca1995586ec2dc21b0368aad4937 ]

In case devlink_dpipe_entry_ctx_prepare() failed, release RTNL that was
previously taken and free the memory allocated by
mlxsw_sp_erif_entry_prepare().

Fixes: 2ba5999f009d ("mlxsw: spectrum: Add Support for erif table entries access")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
index 49933818c6f59..2dc0978428e64 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
@@ -215,7 +215,7 @@ mlxsw_sp_dpipe_table_erif_entries_dump(void *priv, bool counters_enabled,
 start_again:
 	err = devlink_dpipe_entry_ctx_prepare(dump_ctx);
 	if (err)
-		return err;
+		goto err_ctx_prepare;
 	j = 0;
 	for (; i < rif_count; i++) {
 		struct mlxsw_sp_rif *rif = mlxsw_sp_rif_by_index(mlxsw_sp, i);
@@ -247,6 +247,7 @@ mlxsw_sp_dpipe_table_erif_entries_dump(void *priv, bool counters_enabled,
 	return 0;
 err_entry_append:
 err_entry_get:
+err_ctx_prepare:
 	rtnl_unlock();
 	devlink_dpipe_entry_clear(&entry);
 	return err;
-- 
2.20.1

