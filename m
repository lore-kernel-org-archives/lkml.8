Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F21CC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D956223127
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363606;
	bh=gmah9KEAeFrzt5Pb5eobdMbcMTm/fjmivIHVkNUhpXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=icBHP8rpl0BB1v5L7s2ltQJQ1oEh3vXdNEETjQJQVCz6UZqyqpltFV8pj6OFQzKwB
	 NC4+yCF/jv7cSJlSwO/uT0/9aXGhtG+yY9PBxd6Uy4RkztoM8S9qSnSSRThYaNPHh7
	 GX7MZBTk31MH2byKyHWdsKBEMCnb7Yr/B1kdbYoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgEMJxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387431AbgEMJxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:53:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BB120753;
        Wed, 13 May 2020 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363599;
        bh=gmah9KEAeFrzt5Pb5eobdMbcMTm/fjmivIHVkNUhpXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDobpIQeTrF103ZEdOdvG38YYvtkajWjrFcWRfBXwS0s3lj4tg67+IhJ9hqQgYuZO
         Oh9kb8dmCB6FDzGzLfeBund+QCipXrevZDsWaCg1ehNk1gzxjBZgTJj5FCciyh0fld
         WbJgAcWSNtFTjkRVUFYLbKbSQ+a4f7AVLIrySZ7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.6 049/118] net/mlx5e: Fix q counters on uplink representors
Date:   Wed, 13 May 2020 11:44:28 +0200
Message-Id: <20200513094421.478529411@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit 67b38de646894c9a94fe4d6d17719e70cc6028eb ]

Need to allocate the q counters before init_rx which needs them
when creating the rq.

Fixes: 8520fa57a4e9 ("net/mlx5e: Create q counters on uplink representors")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Vlad Buslov <vladbu@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1692,19 +1692,14 @@ static void mlx5e_cleanup_rep_rx(struct
 
 static int mlx5e_init_ul_rep_rx(struct mlx5e_priv *priv)
 {
-	int err = mlx5e_init_rep_rx(priv);
-
-	if (err)
-		return err;
-
 	mlx5e_create_q_counters(priv);
-	return 0;
+	return mlx5e_init_rep_rx(priv);
 }
 
 static void mlx5e_cleanup_ul_rep_rx(struct mlx5e_priv *priv)
 {
-	mlx5e_destroy_q_counters(priv);
 	mlx5e_cleanup_rep_rx(priv);
+	mlx5e_destroy_q_counters(priv);
 }
 
 static int mlx5e_init_uplink_rep_tx(struct mlx5e_rep_priv *rpriv)


