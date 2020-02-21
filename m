Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB25C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AE24656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271575;
	bh=wIqsMrdKLb+D/TuHlWfbWthZCsYzOhhbmcyKf/OfsBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VLVdjNuSPQd3DnRpZsHE5FAzIUKgeuJxI+5uITai2Tq9hLXLbsWgXpJ8jEyLQqlrC
	 ztxpC/GrZOULAaTTpKivyrB6ihoeowwgGocqhwGwZLmeMxmKvQ6o2Aalk3Mrvrr81/
	 FqJYaJuXMfuJHOWo20QUAfEWQcJEQ7gDG2JAdWxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgBUHwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgBUHws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:52:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA1520578;
        Fri, 21 Feb 2020 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271567;
        bh=wIqsMrdKLb+D/TuHlWfbWthZCsYzOhhbmcyKf/OfsBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxtxnbKRaTchZ+GT+iyTOrykgJxoGu13kszGDX6+N9CQY7iPmixZc3Utsy/P0+gH7
         YiIW0T2glPiotyJaU4WbNfXo0zHUEcHM6iRJqgpCV8q1lT+t2ch620rgS1AmEA35ZM
         DN4aAPQBPnqEX8yVOlSV/R1+eVwewoAGBX4hrND8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 215/399] mlx5: work around high stack usage with gcc
Date:   Fri, 21 Feb 2020 08:39:00 +0100
Message-Id: <20200221072423.900172139@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 42ae1a5c76691928ed217c7e40269db27f5225e9 ]

In some configurations, gcc tries too hard to optimize this code:

drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function 'mlx5e_grp_sw_update_stats':
drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:302:1: error: the frame size of 1336 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

As was stated in the bug report, the reason is that gcc runs into a corner
case in the register allocator that is rather hard to fix in a good way.

As there is an easy way to work around it, just add a comment and the
barrier that stops gcc from trying to overoptimize the function.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92657
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 9f09253f9f466..a05158472ed11 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -297,6 +297,9 @@ static void mlx5e_grp_sw_update_stats(struct mlx5e_priv *priv)
 			s->tx_tls_drop_bypass_req   += sq_stats->tls_drop_bypass_req;
 #endif
 			s->tx_cqes		+= sq_stats->cqes;
+
+			/* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92657 */
+			barrier();
 		}
 	}
 }
-- 
2.20.1



