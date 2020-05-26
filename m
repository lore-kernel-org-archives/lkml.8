Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30623208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519966;
	bh=xOXi9QnILk5id+/EduROfF8p82+tBxnekVsIOyBvAVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yvPMunesF0HRPixdg7p4JiUANXE459LJgXUY2wSlsPJj5hdD0wblki/2l/NVhebi5
	 iO633776VkIC8ecROJ9xryabj86d0lTjPsHCp0dmGFI22NCibWZqabENhNXc5KnkI7
	 6CQEM0uOGoxRalHHiVHcFU3qkHhLq2JXhfW0F+zE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390617AbgEZTGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391587AbgEZTF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911EE20776;
        Tue, 26 May 2020 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519956;
        bh=xOXi9QnILk5id+/EduROfF8p82+tBxnekVsIOyBvAVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miRPFDCj9Zljtsc/eg7eqYo2OQlnsNPePn2olnkHpOJYkG1QK5xm9EqWu3veqKeKK
         yDR/aFurusClI7qUcfy2CgGz6GKk+g+SuejUhf5kyRc2ZkSNGaHDprp6OviD5INJB3
         cjMhhl+qkrAMUhqzo40y8HImm33vx53w02oajcbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juliet Kim <julietk@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/81] Revert "net/ibmvnic: Fix EOI when running in XIVE mode"
Date:   Tue, 26 May 2020 20:53:32 +0200
Message-Id: <20200526183933.434785972@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juliet Kim <julietk@linux.vnet.ibm.com>

[ Upstream commit 284f87d2f3871247d08a2b6a24466ae905079913 ]

This reverts commit 11d49ce9f7946dfed4dcf5dbde865c78058b50ab
(“net/ibmvnic: Fix EOI when running in XIVE mode.”) since that
has the unintended effect of changing the interrupt priority
and emits warning when running in legacy XICS mode.

Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8a1916443235..abfd990ba4d8 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2731,10 +2731,12 @@ static int enable_scrq_irq(struct ibmvnic_adapter *adapter,
 
 	if (adapter->resetting &&
 	    adapter->reset_reason == VNIC_RESET_MOBILITY) {
-		struct irq_desc *desc = irq_to_desc(scrq->irq);
-		struct irq_chip *chip = irq_desc_get_chip(desc);
+		u64 val = (0xff000000) | scrq->hw_irq;
 
-		chip->irq_eoi(&desc->irq_data);
+		rc = plpar_hcall_norets(H_EOI, val);
+		if (rc)
+			dev_err(dev, "H_EOI FAILED irq 0x%llx. rc=%ld\n",
+				val, rc);
 	}
 
 	rc = plpar_hcall_norets(H_VIOCTL, adapter->vdev->unit_address,
-- 
2.25.1



