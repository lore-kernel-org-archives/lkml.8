Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD81C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FB324683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220139;
	bh=kzoeI0KGtDBmmy5T6mosoSPAI094vzMh7ao939kS9b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ixV4hVfPos2Aqiuqi2LgifbTpSq+FfLHT7oct3xcGV/J1WDREoYtSiWDwAF2vzRyl
	 wAUeAG4cSgbmqoD1QAlEhtj5ohS+KpHN3tR7CtAaQItpifEzT2xy6lQyJskmZIa+q2
	 NO6xH5TOFwLppMBPxn7sfj5jw8Vwh4d4425AbQpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA1OCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgA1OCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:02:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A7724683;
        Tue, 28 Jan 2020 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220134;
        bh=kzoeI0KGtDBmmy5T6mosoSPAI094vzMh7ao939kS9b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMeEG6OfAWpEPq+wMLM3XMVsyrp5Cs/7tdGOi1Puj5dIZrK3hg/tUpFRmCOmCKWri
         JNqioo1ygZ1AnY4ThCI82SD3/mRHyL4eG/Hif/Pe+mlQwi+BtCPk+JnHLFxfxH+c3m
         Ekul8RqVFxC0iIJRyEHFpVqzw4LqtoAgV0yRDWvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 030/104] net/mlx5e: kTLS, Remove redundant posts in TX resync flow
Date:   Tue, 28 Jan 2020 14:59:51 +0100
Message-Id: <20200128135821.437418563@linuxfoundation.org>
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

From: Tariq Toukan <tariqt@mellanox.com>

commit 1e92899791358dba94a9db7cc3b6004636b5a2f6 upstream.

The call to tx_post_resync_params() is done earlier in the flow,
the post of the control WQEs is unnecessarily repeated. Remove it.

Fixes: 700ec4974240 ("net/mlx5e: kTLS, Fix missing SQ edge fill")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -383,8 +383,6 @@ mlx5e_ktls_tx_handle_ooo(struct mlx5e_kt
 	if (unlikely(contig_wqebbs_room < num_wqebbs))
 		mlx5e_fill_sq_frag_edge(sq, wq, pi, contig_wqebbs_room);
 
-	tx_post_resync_params(sq, priv_tx, info.rcd_sn);
-
 	for (; i < info.nr_frags; i++) {
 		unsigned int orig_fsz, frag_offset = 0, n = 0;
 		skb_frag_t *f = &info.frags[i];


