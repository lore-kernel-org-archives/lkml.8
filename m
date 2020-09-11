Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74001C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3803A222D5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599835221;
	bh=4Huu70dJ+HjD8QlR9LohnstfTGmLMG6oxi13lowcang=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFh9vJxM0/btzPpyFY/tNZLoO744id4tqD3sFB/o+AsbCigj0xLeI3sGhDQAl8IpU
	 mj5H3sMLP3niuxouXNc2/FRrMo5wro2tfU69o6Op2IFGNH5JskKNwSnkl4fnRYDlTl
	 j99e6w8fjHjk/RzaTzAmKl0bccQvQ23SZSqFZD8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIKOkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgIKNMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:12:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD7322475;
        Fri, 11 Sep 2020 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829254;
        bh=4Huu70dJ+HjD8QlR9LohnstfTGmLMG6oxi13lowcang=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vbhglolyzEBItOTzJAT4/vUIkm3izDju9qkvsUxArYblkNzGpkKL/mXAeEIXAp5V
         aD7cMe/H7Auj05wcFyAXl2yqN4pJm3+OjEGRW8pEMLbcHkBG1bmmxbRElv76u0YMTs
         r8BVagdextxHYfNWja/Z2zIO9wlrCmwbxwYy9EHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 8/8] net/mlx5e: Dont support phys switch id if not in switchdev mode
Date:   Fri, 11 Sep 2020 14:54:55 +0200
Message-Id: <20200911125422.103702175@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911125421.695645838@linuxfoundation.org>
References: <20200911125421.695645838@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

Support for phys switch id ndo added for representors and if
we do not have representors there is no need to support it.
Since each port return different switch id supporting this
block support for creating bond over PFs and attaching to bridge
in legacy mode.

This bug doesn't exist upstream as the code got refactored and the
netdev api is totally different.

Fixes: cb67b832921c ("net/mlx5e: Introduce SRIOV VF representors")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -198,7 +198,7 @@ int mlx5e_attr_get(struct net_device *de
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 
-	if (esw->mode == SRIOV_NONE)
+	if (esw->mode != SRIOV_OFFLOADS)
 		return -EOPNOTSUPP;
 
 	switch (attr->id) {


