Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F64206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977473;
	bh=7vW9pubFJ2lXT/pAXpSXlFiiGmSmzPr2BzVU76xukgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ueUIDD2hsTs2OGuB5q35tVRG5Qh4hGBH077AnADoTYf4Gr/2Dqb9A+JrOR+oDU7rd
	 bfRbYjsyc7nzHBtoXB+Du1stWOVuOohfN2mzaB3aC6N52OTpTNMm/urtm0lBxi0bmI
	 5nBlCcJq/WIDC8H34X9ChCdIBdRERBHH216Yv20k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgIAQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbgIAPcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E28205F4;
        Tue,  1 Sep 2020 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974333;
        bh=7vW9pubFJ2lXT/pAXpSXlFiiGmSmzPr2BzVU76xukgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmv0ZAk+DrdiNb88Ir7+odgoTVlx+eqKEFgB/Ebj9+F5lm9Ej4ae7tKsMfezPpVbN
         T9gLi/2h/cEqrOeeJXrIQuJfIO5yZWTwyJAbK5uALUIDW3FGMj6aYXfUOzRt5pRAD7
         3z6mzgsiiyQiNXybrdswdJ/tsXJJl1HoOo+A8ht0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 136/214] scsi: fcoe: Fix I/O path allocation
Date:   Tue,  1 Sep 2020 17:10:16 +0200
Message-Id: <20200901150959.496775379@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit fa39ab5184d64563cd36f2fb5f0d3fbad83a432c ]

ixgbe_fcoe_ddp_setup() can be called from the main I/O path and is called
with a spin_lock held, so we have to use GFP_ATOMIC allocation instead of
GFP_KERNEL.

Link: https://lore.kernel.org/r/1596831813-9839-1-git-send-email-michael.christie@oracle.com
cc: Hannes Reinecke <hare@suse.de>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index ccd852ad62a4b..d50c5b55da180 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -192,7 +192,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
-- 
2.25.1



