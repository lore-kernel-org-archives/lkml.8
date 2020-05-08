Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F8C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B5C2496D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941554;
	bh=ms3FREfyZi9NtI4y72lyzMZ3+AJnRMj4Cp5dTvwD+FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6WW4NUBuIN/upIllA0nFcVD4rM8Jgwxb/Zl9svufzqu4ZtvrP2/MI9muPA46KIs5
	 dggcCPU+M0gA/Mrm8TmxQ0lxdAePi2Ko1Caa1AyWs5OZhTT9haTPwXaXyD2+3pmi51
	 O06HePg4WPVMw4tdriq2/1qfo1QF/ULsZcpt9WdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgEHMjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgEHMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:39:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5812496A;
        Fri,  8 May 2020 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941546;
        bh=ms3FREfyZi9NtI4y72lyzMZ3+AJnRMj4Cp5dTvwD+FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evkH0eOHrYJbID5CWpyNbgDzwn3WGn6hfieZnYbADtB8XkyAjTkYKwCahxceynCWj
         HBCh16DzzgHtkXeniFacQ0nmMpeHmFU9/tdCkkBjnbyZ00OKQG9KcXN1zVjhA1v21P
         wjLU5+TZE3SISS/rYVsu+ADYAwVWaHvfoTNk2A44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rana Shahout <ranas@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 076/312] net/mlx5e: Fix MLX5E_100BASE_T define
Date:   Fri,  8 May 2020 14:31:07 +0200
Message-Id: <20200508123129.872051428@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rana Shahout <ranas@mellanox.com>

commit 6e4c21894673baabdbef03c3ac2458a28246128b upstream.

Bit 25 of eth_proto_capability in PTYS register is
1000Base-TT and not 100Base-T.

Fixes: f62b8bb8f2d3 ('net/mlx5: Extend mlx5_core to
support ConnectX-4 Ethernet functionality')
Signed-off-by: Rana Shahout <ranas@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/en.h         |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -543,7 +543,7 @@ enum mlx5e_link_mode {
 	MLX5E_100GBASE_KR4	 = 22,
 	MLX5E_100GBASE_LR4	 = 23,
 	MLX5E_100BASE_TX	 = 24,
-	MLX5E_100BASE_T		 = 25,
+	MLX5E_1000BASE_T	 = 25,
 	MLX5E_10GBASE_T		 = 26,
 	MLX5E_25GBASE_CR	 = 27,
 	MLX5E_25GBASE_KR	 = 28,
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -138,10 +138,10 @@ static const struct {
 	[MLX5E_100BASE_TX]   = {
 		.speed      = 100,
 	},
-	[MLX5E_100BASE_T]    = {
-		.supported  = SUPPORTED_100baseT_Full,
-		.advertised = ADVERTISED_100baseT_Full,
-		.speed      = 100,
+	[MLX5E_1000BASE_T]    = {
+		.supported  = SUPPORTED_1000baseT_Full,
+		.advertised = ADVERTISED_1000baseT_Full,
+		.speed      = 1000,
 	},
 	[MLX5E_10GBASE_T]    = {
 		.supported  = SUPPORTED_10000baseT_Full,


