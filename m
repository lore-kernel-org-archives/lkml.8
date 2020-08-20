Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55974207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924520;
	bh=IzTK1brHvbzYGCLGKWtVUX/++/DgFMolRIjMEhdKywU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1mDyaojhcNZVmlSLXVDYqFST8DMw4I5fESgSOXvQ4NYYiDLmNn1AWvTRJXVEUvFx
	 U0nk7PFKNKxtNhvn2wcETdDMzApiyLSHcLP7E/dOfI5IsIo3gujD1CydkyS7HLkafC
	 fqkKfUI3xvnvr9CvMR3EZPdwH1IEJ71b3x/u8HKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgHTLzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgHTKCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:02:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABAA22C9F;
        Thu, 20 Aug 2020 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917755;
        bh=IzTK1brHvbzYGCLGKWtVUX/++/DgFMolRIjMEhdKywU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFiJjIIAx8GK7IzQUoyNkSUCLzQZsKIc87BUBNoaYWAT6G0tzUpVgs94HYxVyY9pe
         gQib86rNy1Ol7SSuO2ci8aQiZ+jU6ypH1PykCawYJuwxdjjjnadcC+GU23eBpx8z5S
         P8l0Yks/cDl2qb9QY6FdXTXtKJvDdCV53rMdjmxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florinel Iordache <florinel.iordache@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 147/212] fsl/fman: fix eth hash table allocation
Date:   Thu, 20 Aug 2020 11:22:00 +0200
Message-Id: <20200820091609.824011559@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florinel Iordache <florinel.iordache@nxp.com>

[ Upstream commit 3207f715c34317d08e798e11a10ce816feb53c0f ]

Fix memory allocation for ethernet address hash table.
The code was wrongly allocating an array for eth hash table which
is incorrect because this is the main structure for eth hash table
(struct eth_hash_t) that contains inside a number of elements.

Fixes: 57ba4c9b56d8 ("fsl/fman: Add FMan MAC support")
Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman_mac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_mac.h b/drivers/net/ethernet/freescale/fman/fman_mac.h
index dd6d0526f6c1f..19f327efdaff3 100644
--- a/drivers/net/ethernet/freescale/fman/fman_mac.h
+++ b/drivers/net/ethernet/freescale/fman/fman_mac.h
@@ -252,7 +252,7 @@ static inline struct eth_hash_t *alloc_hash_table(u16 size)
 	struct eth_hash_t *hash;
 
 	/* Allocate address hash table */
-	hash = kmalloc_array(size, sizeof(struct eth_hash_t *), GFP_KERNEL);
+	hash = kmalloc(sizeof(*hash), GFP_KERNEL);
 	if (!hash)
 		return NULL;
 
-- 
2.25.1



