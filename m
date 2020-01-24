Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE802C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68B22075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860208;
	bh=2gLoL4rxof/UHV1wgyhkh9ljj0IUj1fXQyfEo7OIhRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QE2IrANagjCGMxYu3GdhGLEn6PfAqaXhfsDTyyW5GNwL1Ge7t+vGTabTz+tv1+ZYS
	 E5y5tuiwpgyMr3sOFxxjgJvjRYfUM18iOOaO34Gg/fq+MXMkQNf0+gqdqL6gcwfhOd
	 QusBvMsaizbnCsW3MXqAp9e1jQifQ/StlTeUtXuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbgAXKD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388265AbgAXKDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:03:25 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E11214DB;
        Fri, 24 Jan 2020 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860204;
        bh=2gLoL4rxof/UHV1wgyhkh9ljj0IUj1fXQyfEo7OIhRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2ynNE2Kt6cmRHrX+zwiX3PiCYjs6CU1aQWKdD5kd9DeHENKNGn+PT1ibNj5cqPQr
         5cArITaBUeEcbrR06fKXWaeUJyHoH5mVt6JjCfJjTVHy+NCs+/+QdwPkSQqD5hxHBX
         ctS9O/ndTPdcOk6HOeh+PX7LpnwB2oh7KlK34ppA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 266/343] net/mlx5: Fix mlx5_ifc_query_lag_out_bits
Date:   Fri, 24 Jan 2020 10:31:24 +0100
Message-Id: <20200124092954.972723244@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

[ Upstream commit ea77388b02270b0af8dc57f668f311235ea068f0 ]

Remove the "reserved_at_40" field to match the device specification.

Fixes: 84df61ebc69b ("net/mlx5: Add HW interfaces used by LAG")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mlx5/mlx5_ifc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 1d793d86d55fa..6ffa181598e61 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -8671,8 +8671,6 @@ struct mlx5_ifc_query_lag_out_bits {
 
 	u8         syndrome[0x20];
 
-	u8         reserved_at_40[0x40];
-
 	struct mlx5_ifc_lagc_bits ctx;
 };
 
-- 
2.20.1



