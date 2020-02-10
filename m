Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD0C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA3320838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338261;
	bh=fWFqeUm5Jb7ttHz+jB91/ZkmtLCa2VvqMumc9FiwkAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQe027MSK8dP7yKZWahzgr/jRBEmj1O0juEbosNTMZ8CzUOfos7AdVkq8y/r0oca6
	 2WYpXocbzp1z6EQf58UxpuCVgTA4/WvXqMpL9Sy4JvWQ5mfg/HH6hIfV/7Ai3CsfCx
	 OqAMHGO2Uy/Xp4KfovrEjqZUwNhGsp38sVFBp6Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBJMhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgBJMgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:21 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D742085B;
        Mon, 10 Feb 2020 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338180;
        bh=fWFqeUm5Jb7ttHz+jB91/ZkmtLCa2VvqMumc9FiwkAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qViKv35CqxH1ucRnGY5zQYZeqaZl+NshFSxAa1Zp+0a6wf7yo607JlbP7FKT6z5zR
         KD2+X1+uX8qPb7Ez+p2MoEt1yV/Gk4CG8KkqynBvDEfXjIDXLkcOGUusZzW9225Kcq
         UhYi1wR/xri1AhErzcgKgbPgXz3cMX1em/okA6iQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raed Salem <raeds@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 171/195] net/mlx5: IPsec, Fix esp modify function attribute
Date:   Mon, 10 Feb 2020 04:33:49 -0800
Message-Id: <20200210122321.894253416@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raed Salem <raeds@mellanox.com>

[ Upstream commit 0dc2c534f17c05bed0622b37a744bc38b48ca88a ]

The function mlx5_fpga_esp_validate_xfrm_attrs is wrongly used
with negative negation as zero value indicates success but it
used as failure return value instead.

Fix by remove the unary not negation operator.

Fixes: 05564d0ae075 ("net/mlx5: Add flow-steering commands for FPGA IPSec implementation")
Signed-off-by: Raed Salem <raeds@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -1472,7 +1472,7 @@ int mlx5_fpga_esp_modify_xfrm(struct mlx
 	if (!memcmp(&xfrm->attrs, attrs, sizeof(xfrm->attrs)))
 		return 0;
 
-	if (!mlx5_fpga_esp_validate_xfrm_attrs(mdev, attrs)) {
+	if (mlx5_fpga_esp_validate_xfrm_attrs(mdev, attrs)) {
 		mlx5_core_warn(mdev, "Tried to create an esp with unsupported attrs\n");
 		return -EOPNOTSUPP;
 	}


