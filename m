Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D9EC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B924685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220130;
	bh=MLCgaxSnSTyJxaX6lEGhzhwJQNiLmovMr7i2oLaS3Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yo89JnlHPb7FDjlVyuuW1o0xgigCFN4YO12G4HF0t+PGD/23cfRb3wJh3uysZTNVm
	 X6yc/RFUPO2s7HB2JNtXfpiDQHSMYtZBE5VMOXxj3XCQRu3pkge5A4siFO8Ihe2Plb
	 oNxEWEdzar6B0YAGeRm+AexueFAWceDq7bs4mpZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgA1OCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgA1OCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:02:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5DD24683;
        Tue, 28 Jan 2020 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220126;
        bh=MLCgaxSnSTyJxaX6lEGhzhwJQNiLmovMr7i2oLaS3Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekZgyFYUco93uMK3QSDnw7KqNiXDCuPBVSivJ8kBP+TyrXvjRXFwXpvD4cVEksAgF
         SCm8ler+HFMkQ7/PUnnsd//dnE62vEsh9rI4av7F2DU1yw4GyOpIqc2fIa/kNd35Xk
         sCA+h6+Uc2oRBjQdcXSxOfrSEWLbkSHWTMRGmjo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 027/104] net/mlx5: E-Switch, Prevent ingress rate configuration of uplink rep
Date:   Tue, 28 Jan 2020 14:59:48 +0100
Message-Id: <20200128135821.022792530@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Cohen <eli@mellanox.com>

commit e401a1848be87123a2b2049addbf21138cb47081 upstream.

Since the implementation relies on limiting the VF transmit rate to
simulate ingress rate limiting, and since either uplink representor or
ecpf are not associated with a VF, we limit the rate limit configuration
for those ports.

Fixes: fcb64c0f5640 ("net/mlx5: E-Switch, add ingress rate support")
Signed-off-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3951,6 +3951,13 @@ static int apply_police_params(struct ml
 	u32 rate_mbps;
 	int err;
 
+	vport_num = rpriv->rep->vport;
+	if (vport_num >= MLX5_VPORT_ECPF) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Ingress rate limit is supported only for Eswitch ports connected to VFs");
+		return -EOPNOTSUPP;
+	}
+
 	esw = priv->mdev->priv.eswitch;
 	/* rate is given in bytes/sec.
 	 * First convert to bits/sec and then round to the nearest mbit/secs.
@@ -3959,8 +3966,6 @@ static int apply_police_params(struct ml
 	 * 1 mbit/sec.
 	 */
 	rate_mbps = rate ? max_t(u32, (rate * 8 + 500000) / 1000000, 1) : 0;
-	vport_num = rpriv->rep->vport;
-
 	err = mlx5_esw_modify_vport_rate(esw, vport_num, rate_mbps);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "failed applying action to hardware");


