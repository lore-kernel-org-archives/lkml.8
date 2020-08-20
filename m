Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F76C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9573F22CA0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918076;
	bh=AmTZtyZUnDO5InHBHtS78KWfPouKRkGH35AeeRiiGuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Do8sxePyFmLDLTPVj58CFt2W+UjlEpHi52eF9tFRkkc2utPGN9URhpODUwtF4MLZ+
	 Tuj1rmRhRrbiOBzOL9wBxypoSARV/1W1A7V9FpfAUGDr0NusbEi43HymikCFexE/vS
	 q/HRuFKAPLtocE6hZOf9TQBksLq0TpbN7HVFmQ8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgHTKHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbgHTKGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:06:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08B1206DA;
        Thu, 20 Aug 2020 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918002;
        bh=AmTZtyZUnDO5InHBHtS78KWfPouKRkGH35AeeRiiGuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSTtuxV+Lqx2IOUHnokU7XutmNkSQ5uwy2u4PBbIeMZEEeAyqSlJC9GRdSg7Mk8hL
         9WfNe2BqElz5phC9u2sI0/Jg3M6da1xYOtihapElnfV8Nd7ITZGnMjVtU2XXCmFP8z
         kOmsHqjc4LugJa0M4D7ijp0ve3EKxewuHOX2WRx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 002/228] net/mlx5e: Dont support phys switch id if not in switchdev mode
Date:   Thu, 20 Aug 2020 11:19:37 +0200
Message-Id: <20200820091607.648150053@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
@@ -180,7 +180,7 @@ int mlx5e_attr_get(struct net_device *de
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 
-	if (esw->mode == SRIOV_NONE)
+	if (esw->mode != SRIOV_OFFLOADS)
 		return -EOPNOTSUPP;
 
 	switch (attr->id) {


