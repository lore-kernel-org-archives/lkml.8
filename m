Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3746C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD34824693
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221323;
	bh=0DKVW1u8jaF2bzJve6vRiEK6/0/OnD2loQbbSn1KhF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=auWmgvK/lNwmiIdsINVctyDs9c4jVhANpxGwxCkGJfg8DpyAYoUqA9LrtHkVUTjBj
	 8J7l/zp8QGbuKseYgEMx99SnEu0glY+KWgTpM53PRkqVWSCb7elzVB/+nkm9edYpQS
	 ZG6b0z8j6x4xKYj9HV28OWgX+N0Je2YlLDl8NQr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgA1OWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbgA1OV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:21:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9DC224690;
        Tue, 28 Jan 2020 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221318;
        bh=0DKVW1u8jaF2bzJve6vRiEK6/0/OnD2loQbbSn1KhF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzR8QpGr88QiGX0TizgSJTNFlNl4E+trlFu9GE6ioo26gpODcvhfqrpDRpjfwqk/9
         6yk/0ZUCmFWFjIFK0H5nkC5D0bcR3cxyeDaw2vHHnXl0zHb4FaFHYvaaT9SKzcUps7
         0eXUY1+xH4xgZDXSHtxlLOkNGUmBeRZOmSFIum4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 176/271] net/mlx5: Fix mlx5_ifc_query_lag_out_bits
Date:   Tue, 28 Jan 2020 15:05:25 +0100
Message-Id: <20200128135905.653407562@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 20ee90c47cd50..6dd276227217e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -7909,8 +7909,6 @@ struct mlx5_ifc_query_lag_out_bits {
 
 	u8         syndrome[0x20];
 
-	u8         reserved_at_40[0x40];
-
 	struct mlx5_ifc_lagc_bits ctx;
 };
 
-- 
2.20.1



