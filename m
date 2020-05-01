Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D672FC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46DC208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340406;
	bh=JIjDI1yWmotW1ixclDVHEKfcxGRhfZ1evqCSWr+9Ni4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qg85IL43bRGZtMBI8KVgMWDOpV2ZqtbwRgcdE7BaqebHrDTo9WQPWE+1cyBRkQ0sP
	 lcL75MCX1Kk0BXyxclYxwEfHSnaD/K7m3Gh54bEiT4gTmmbrmgNt0odVG4tG/88F/C
	 6XktTBS0sjLPswrwNKXBykL8YdeY6FkGbKT2sCp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgEANkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbgEANj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:39:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC95220757;
        Fri,  1 May 2020 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340398;
        bh=JIjDI1yWmotW1ixclDVHEKfcxGRhfZ1evqCSWr+9Ni4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpBjGUpkSvzZNIc/uTokAA61tAFcfXKrWyArcabyePNLEI0nKs9//v3VD+vvWl/GV
         F6Fw9y/Ufg+7SVr8sFpVEVITRRtn3mP+S/m60EvqBX04Yu0o7fVCnzU88JHRMxo8ls
         Xomoa/lTFOez/ywn60FyfBsZOqB6tKJaeTRK4j4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 40/83] net/mlx5: Fix failing fw tracer allocation on s390
Date:   Fri,  1 May 2020 15:23:19 +0200
Message-Id: <20200501131535.689630333@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Schnelle <schnelle@linux.ibm.com>

commit a019b36123aec9700b21ae0724710f62928a8bc1 upstream.

On s390 FORCE_MAX_ZONEORDER is 9 instead of 11, thus a larger kzalloc()
allocation as done for the firmware tracer will always fail.

Looking at mlx5_fw_tracer_save_trace(), it is actually the driver itself
that copies the debug data into the trace array and there is no need for
the allocation to be contiguous in physical memory. We can therefor use
kvzalloc() instead of kzalloc() and get rid of the large contiguous
allcoation.

Fixes: f53aaa31cce7 ("net/mlx5: FW tracer, implement tracer logic")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -935,7 +935,7 @@ struct mlx5_fw_tracer *mlx5_fw_tracer_cr
 		return NULL;
 	}
 
-	tracer = kzalloc(sizeof(*tracer), GFP_KERNEL);
+	tracer = kvzalloc(sizeof(*tracer), GFP_KERNEL);
 	if (!tracer)
 		return ERR_PTR(-ENOMEM);
 
@@ -982,7 +982,7 @@ destroy_workqueue:
 	tracer->dev = NULL;
 	destroy_workqueue(tracer->work_queue);
 free_tracer:
-	kfree(tracer);
+	kvfree(tracer);
 	return ERR_PTR(err);
 }
 
@@ -1061,7 +1061,7 @@ void mlx5_fw_tracer_destroy(struct mlx5_
 	mlx5_fw_tracer_destroy_log_buf(tracer);
 	flush_workqueue(tracer->work_queue);
 	destroy_workqueue(tracer->work_queue);
-	kfree(tracer);
+	kvfree(tracer);
 }
 
 static int fw_tracer_event(struct notifier_block *nb, unsigned long action, void *data)


