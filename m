Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824D621739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221387;
	bh=jYUgY8SpWe77pPCfGwFT/2abOKo2SKlAk05poolCS2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=khPCXvUPFIbn+EarteUJxcI38HzO7hC5pdI78wrxpYvtXwe3dL3KMfIfgU0sxm3Ne
	 CPWqAWhsJfe0ZJzm8PetulxN9QY2HTsAnyRng98Oz+5+nQxO+3np5yEVpFcw965Hia
	 ddtirbKu3IuC3z8x3twpa21UhQBJ78AWTGI/h5FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgA1OXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731893AbgA1OXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374E024681;
        Tue, 28 Jan 2020 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221380;
        bh=jYUgY8SpWe77pPCfGwFT/2abOKo2SKlAk05poolCS2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MwtFERLrFmKOqlR4/L2C+98FzU41SsY7RYKFZL73zeLbI6OF8F/tRFhs04mF/xmd
         5WhTTerfSSnzbw045ks3YwOXkUYG5clCjLr/1PpZW454El5Wnklf6XheIPcwhmyem8
         CMGfMYsBG8RduS11x2XY6lsDGnmcek5yRjeMoByU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filippo Sironi <sironi@amazon.de>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 202/271] iommu/amd: Wait for completion of IOTLB flush in attach_device
Date:   Tue, 28 Jan 2020 15:05:51 +0100
Message-Id: <20200128135907.604031189@linuxfoundation.org>
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

From: Filippo Sironi <sironi@amazon.de>

[ Upstream commit 0b15e02f0cc4fb34a9160de7ba6db3a4013dc1b7 ]

To make sure the domain tlb flush completes before the
function returns, explicitly wait for its completion.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Fixes: 42a49f965a8d ("amd-iommu: flush domain tlb when attaching a new device")
[joro: Added commit message and fixes tag]
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c898c70472bb2..bb0448c91f672 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2113,6 +2113,8 @@ skip_ats_check:
 	 */
 	domain_flush_tlb_pde(domain);
 
+	domain_flush_complete(domain);
+
 	return ret;
 }
 
-- 
2.20.1



