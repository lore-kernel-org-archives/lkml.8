Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3064C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AC220853
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825076;
	bh=tJRGNk7SX8eNPltUjlQO5LmafLOMsO6yY9TLKgqoxrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j4KauFeSdUCEkilj6As/s1M3TJnXVPbijfDBMBGQMrrkox0FnPZOACYz++KPvb1yU
	 UFbY8/5oO5swMvoMcOrxMy5z9XTcUKWbdyQRjuzxtVBlhETuIGgyWKK1+YlaeRyreb
	 SLWjjT3B+KUuJXKq5CtKsPvzE7NnmyoYmgPIqFmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbgERSEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbgERSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:04:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FBA20715;
        Mon, 18 May 2020 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825062;
        bh=tJRGNk7SX8eNPltUjlQO5LmafLOMsO6yY9TLKgqoxrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJgIgzYzkSLqQB2QmeXxGewdgCZ1pRg6k/ki4PiCElySSyd+W8g/lUOOPrVrUAG8A
         k7kLa6zjLyB3EHNiYxMsPsP68uiowd18P7js4UohZaIU647ZYKRXy7Ac2L4gkQroOK
         SfiUw3iGg6IE9W1lde1tJPalBlPVu9L8ZuMLon6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 113/194] IB/core: Fix potential NULL pointer dereference in pkey cache
Date:   Mon, 18 May 2020 19:36:43 +0200
Message-Id: <20200518173541.154322083@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 1901b91f99821955eac2bd48fe25ee983385dc00 ]

The IB core pkey cache is populated by procedure ib_cache_update().
Initially, the pkey cache pointer is NULL. ib_cache_update allocates a
buffer and populates it with the device's pkeys, via repeated calls to
procedure ib_query_pkey().

If there is a failure in populating the pkey buffer via ib_query_pkey(),
ib_cache_update does not replace the old pkey buffer cache with the
updated one -- it leaves the old cache as is.

Since initially the pkey buffer cache is NULL, when calling
ib_cache_update the first time, a failure in ib_query_pkey() will cause
the pkey buffer cache pointer to remain NULL.

In this situation, any calls subsequent to ib_get_cached_pkey(),
ib_find_cached_pkey(), or ib_find_cached_pkey_exact() will try to
dereference the NULL pkey cache pointer, causing a kernel panic.

Fix this by checking the ib_cache_update() return value.

Fixes: 8faea9fd4a39 ("RDMA/cache: Move the cache per-port data into the main ib_port_data")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20200507071012.100594-1-leon@kernel.org
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 17bfedd24cc34..4619629b958cd 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1536,8 +1536,11 @@ int ib_cache_setup_one(struct ib_device *device)
 	if (err)
 		return err;
 
-	rdma_for_each_port (device, p)
-		ib_cache_update(device, p, true);
+	rdma_for_each_port (device, p) {
+		err = ib_cache_update(device, p, true);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.20.1



