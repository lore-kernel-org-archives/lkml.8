Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFBC20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646011;
	bh=Goa+sN3LjxKCVzkvCM26Riwu1CZL5R9vqYLNvd0KDZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bLT0Jv2sLz8qkRSKzXcJSn/4ofuNMNsjP31YXuAYouNQMXZ+V9kYBgBQLCrpGgAFe
	 SzkmYx1EBhGtmzjJ9bwc2ivWtyDg3DdWpS34vXJB2JSVdPi/j/Du5cVLLxkJUr6T3E
	 hhzbledNnDCT/su5rBoR1qWDUgHnKJPxJh908Nis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgCaJN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgCaJN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:13:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F4A20787;
        Tue, 31 Mar 2020 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646007;
        bh=Goa+sN3LjxKCVzkvCM26Riwu1CZL5R9vqYLNvd0KDZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yd9dxtTb4YEFvqxdpJeQFCDCnmVuT+lVAem/1ITTq2nbjpFM1WcYaepd2TXjTiM45
         XrTy0i/mIkoVemBFP9KZrCmpk4D9VFQ2BYPH16PZfJsqMT7+av8ZWvVFRyI3WoVDZh
         vMnufGMuZaMxeVMSJdyYPJs73rzm9SGvTtTRNXts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 053/155] net/mlx5e: Do not recover from a non-fatal syndrome
Date:   Tue, 31 Mar 2020 10:58:13 +0200
Message-Id: <20200331085424.477201596@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 187a9830c921d92c4a9a8e2921ecc4b35a97532c ]

For non-fatal syndromes like LOCAL_LENGTH_ERR, recovery shouldn't be
triggered. In these scenarios, the RQ is not actually in ERR state.
This misleads the recovery flow which assumes that the RQ is really in
error state and no more completions arrive, causing crashes on bad page
state.

Fixes: 8276ea1353a4 ("net/mlx5e: Report and recover from CQE with error on RQ")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/health.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
@@ -10,8 +10,7 @@
 
 static inline bool cqe_syndrome_needs_recover(u8 syndrome)
 {
-	return syndrome == MLX5_CQE_SYNDROME_LOCAL_LENGTH_ERR ||
-	       syndrome == MLX5_CQE_SYNDROME_LOCAL_QP_OP_ERR ||
+	return syndrome == MLX5_CQE_SYNDROME_LOCAL_QP_OP_ERR ||
 	       syndrome == MLX5_CQE_SYNDROME_LOCAL_PROT_ERR ||
 	       syndrome == MLX5_CQE_SYNDROME_WR_FLUSH_ERR;
 }


