Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D97C52D5F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891C324691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811958;
	bh=tvqRbARabEljwMx+tvX53l3BrPBm/SN7FH5rgOVY3dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HApLrVZrhD0TxCLw1zz+gVh6P5Tns6u9GQtoL/tpYp3qVejJGl1Xfh1SZvOCK5PZL
	 EJ2TGWBZ4rY4uu4RE4auI4VcdWM4TrE/obIlJlJK+GVkW3I4ewv4xjNNlVMLd51wKI
	 vkmSgqMw6ZWfp7DY7JVADN+5ijgngCynrytZh8fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgB0N7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbgB0N7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:59:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7AB246A0;
        Thu, 27 Feb 2020 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811951;
        bh=tvqRbARabEljwMx+tvX53l3BrPBm/SN7FH5rgOVY3dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XB3oIbgFEBK4dqAoBIPplDfRTMiBLDjk5s9I+svNvTNe9LQgbelaz5x14aIxh4Nlh
         2xTARo8raC1fW/POv6E0zAsDhlEfpbQoJ405a2emRWalHPkyXscNeRzXvYVrlywG69
         WdaVGI44z8VKsLI38qg1GBd0rz8RJLpJ67rIfd60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 165/237] mlxsw: spectrum_dpipe: Add missing error path
Date:   Thu, 27 Feb 2020 14:36:19 +0100
Message-Id: <20200227132308.620694724@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 51e6846da72bc..3c04f3d5de2dc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
@@ -225,7 +225,7 @@ mlxsw_sp_dpipe_table_erif_entries_dump(void *priv, bool counters_enabled,
 start_again:
 	err = devlink_dpipe_entry_ctx_prepare(dump_ctx);
 	if (err)
-		return err;
+		goto err_ctx_prepare;
 	j = 0;
 	for (; i < rif_count; i++) {
 		struct mlxsw_sp_rif *rif = mlxsw_sp_rif_by_index(mlxsw_sp, i);
@@ -257,6 +257,7 @@ start_again:
 	return 0;
 err_entry_append:
 err_entry_get:
+err_ctx_prepare:
 	rtnl_unlock();
 	devlink_dpipe_entry_clear(&entry);
 	return err;
-- 
2.20.1



