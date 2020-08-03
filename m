Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B5E2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458646;
	bh=Q/WErorfwQmavjrNJC3/0nwL753dymrid//mUfxcNUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/NzFY/368gGCthvrazupuwmXZ+Nm396MFiW5b2/NaqaMT8ANtGyWLPK1ykDBXt7v
	 iN8UOV/HbetnPhFmjWAHt1hoWYTwhR170rrF87y+U8Fkpvx2DlluF+nOCz89m9OhLY
	 Z13hZiVr2lzmDUZeg7lEdBvi/eVtApOMYRrQIvvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHCM2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbgHCM2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:28:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F03C2083B;
        Mon,  3 Aug 2020 12:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457713;
        bh=Q/WErorfwQmavjrNJC3/0nwL753dymrid//mUfxcNUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcD9G0dWDbExJwJbRzLEGoNaW3nRD0qshprHYZOOXQJQpf/yKlsYG2iBiTb2kSlbu
         O/a5pwuX22qZ63NnPYp6IgqT209tPHuaW6nNk4wD/AuOezSwwfaSRPE2zS+Hv4voH3
         66700Rp9FnWKj5iu4x2xWnWoq3tsXsPiAmO/cBmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 47/90] net/mlx5: E-switch, Destroy TSAR when fail to enable the mode
Date:   Mon,  3 Aug 2020 14:19:09 +0200
Message-Id: <20200803121859.898505363@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 2b8e9c7c3fd0e31091edb1c66cc06ffe4988ca21 ]

When either esw_legacy_enable() or esw_offloads_enable() fails,
code missed to destroy the created TSAR.

Hence, add the missing call to destroy the TSAR.

Fixes: 610090ebce92 ("net/mlx5: E-switch, Initialize TSAR Qos hardware block before its user vports")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index c6ed4b7f4f972..422a57404407d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1919,7 +1919,7 @@ abort:
 		mlx5_reload_interface(esw->dev, MLX5_INTERFACE_PROTOCOL_IB);
 		mlx5_reload_interface(esw->dev, MLX5_INTERFACE_PROTOCOL_ETH);
 	}
-
+	esw_destroy_tsar(esw);
 	return err;
 }
 
-- 
2.25.1



