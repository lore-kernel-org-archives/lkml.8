Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D723DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB7420675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645472;
	bh=av6Q11LrCmng11HhAnFQiGI6yq6s3dI1mlFBfB9NFtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgmE3sngsrBZZwMijW5bj2bOs0BHZgTP1hGh8YA1Li9TOk3g0S8NJtmB5UVp6eMBX
	 S/yIyUxR+gYoNrgmbzum93Y5q7y6MQZSgDY57scLMuIgNOwu5QIyg7Lr4a60fOQCQN
	 QIGoEIf8g2dSHcYHFru3Vzfq6DBW/hFzE1nvxceQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgCaJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbgCaJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:04:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16CAF208E0;
        Tue, 31 Mar 2020 09:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645466;
        bh=av6Q11LrCmng11HhAnFQiGI6yq6s3dI1mlFBfB9NFtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sptUVzw01LYuca/eFpwuMVbR3Hdad3eUc5UzuzrGayX7uR0Ekk8orxxe86jmbE9Zs
         F3F5C0SHzojmJFp/5ElhZbXx1Ok/ZXVGXVjzeiYkSoEo4Dfzx1AT1i4AfHaqNfgnV1
         g9nqVZq3vsIuxOSvIJcuDxH2R0wlhUZjbOxjIg2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 062/170] net/mlx5e: kTLS, Fix TCP seq off-by-1 issue in TX resync flow
Date:   Tue, 31 Mar 2020 10:57:56 +0200
Message-Id: <20200331085431.087051249@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 56917766def72f5afdf4235adb91b6897ff26d9d ]

We have an off-by-1 issue in the TCP seq comparison.
The last sequence number that belongs to the TCP packet's payload
is not "start_seq + len", but one byte before it.
Fix it so the 'ends_before' is evaluated properly.

This fixes a bug that results in error completions in the
kTLS HW offload flows.

Fixes: ffbd9ca94e2e ("net/mlx5e: kTLS, Fix corner-case checks in TX resync flow")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -218,7 +218,7 @@ tx_sync_info_get(struct mlx5e_ktls_offlo
 	 *    this packet was already acknowledged and its record info
 	 *    was released.
 	 */
-	ends_before = before(tcp_seq + datalen, tls_record_start_seq(record));
+	ends_before = before(tcp_seq + datalen - 1, tls_record_start_seq(record));
 
 	if (unlikely(tls_record_is_start_marker(record))) {
 		ret = ends_before ? MLX5E_KTLS_SYNC_SKIP_NO_DATA : MLX5E_KTLS_SYNC_FAIL;


