Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF582C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CE020644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255005;
	bh=CiDUe5Q2TUEW9mCUg7IqKdEful4ga79obeogsJc9u9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rdPEPB1HS49Zu2ytH92fZMg6vk3ydrJq9JBC9Pzm0nS4Ni7iVRXLB7YFmobJo0RXd
	 bGbHKkJNPVAh6t6eRRCE7UT9EUnBeVZ0e/15UE4M8ImKkhdwdvooJbTupfvHUh069k
	 n6LYUHtlvtVDqRxts+x/37vylfmRaVxSNqhDJhpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgDGKXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgDGKXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:23:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F862074B;
        Tue,  7 Apr 2020 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255001;
        bh=CiDUe5Q2TUEW9mCUg7IqKdEful4ga79obeogsJc9u9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb06Lpbmoyi+3ELZATlcARVNN6X9o7RygfzuL0+557m4t3X8AHx1UlbGbpc/OCiq1
         LSj3xWpsNsCBm6qhpEgn6DM37edn3/rSIJG6BbJxVFHkMc8nL5ukNEHxCAw5mUQxO/
         pMZjwzv5uvDqudIm18uF4gfPVISFhiKHDa8RCtO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 27/36] net/mlx5e: kTLS, Fix wrong value in record tracker enum
Date:   Tue,  7 Apr 2020 12:22:00 +0200
Message-Id: <20200407101457.716113746@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101454.281052964@linuxfoundation.org>
References: <20200407101454.281052964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

commit f28ca65efa87b3fb8da3d69ca7cb1ebc0448de66 upstream.

Fix to match the HW spec: TRACKING state is 1, SEARCHING is 2.
No real issue for now, as these values are not currently used.

Fixes: d2ead1f360e8 ("net/mlx5e: Add kTLS TX HW offload support")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -38,8 +38,8 @@ enum {
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_START     = 0,
-	MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_SEARCHING = 1,
-	MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_TRACKING  = 2,
+	MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_TRACKING  = 1,
+	MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_SEARCHING = 2,
 };
 
 struct mlx5e_ktls_offload_context_tx {


