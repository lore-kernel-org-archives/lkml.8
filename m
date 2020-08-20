Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4E1214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924670;
	bh=lvI2uMSfZCmRpwD/L/vfVRFoRh3LmS1tUAkvVUgkxbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzR51/DetPOR9idVn7sk9vU5fBxMC/h6K/A0djD7pJrQVtKxAKZKwMVh2ogplZVzk
	 U719CKhSLDigQEZOCWcyXHywJW6pSH40KUhDuRLAk4glWcmI/GXqrs8H0Y2v2tqd3q
	 EOhkFrcNSE9qeZfYWIzk1Q9xHe+xlp+ptGh/rx24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHTL5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbgHTKAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:00:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813EC2067C;
        Thu, 20 Aug 2020 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917648;
        bh=lvI2uMSfZCmRpwD/L/vfVRFoRh3LmS1tUAkvVUgkxbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dr5kljkLBoFVxe+j7ExiMcFL63hNW31S8QJtgag0inIWs5HrN/ZpfbKlXxfoJi05
         lVhZJrjLvZXc06ZBKBxsCyYiwLXXz3I7noLnxULxniPo+W+E5b/gvnt5eiivlEjban
         qCUAeTaumEqP0+use5dRKKKbzJOQgHDciPkA0zwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 107/212] agp/intel: Fix a memory leak on module initialisation failure
Date:   Thu, 20 Aug 2020 11:21:20 +0200
Message-Id: <20200820091607.751278531@linuxfoundation.org>
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

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit b975abbd382fe442713a4c233549abb90e57c22b ]

In intel_gtt_setup_scratch_page(), pointer "page" is not released if
pci_dma_mapping_error() return an error, leading to a memory leak on
module initialisation failure.  Simply fix this issue by freeing "page"
before return.

Fixes: 0e87d2b06cb46 ("intel-gtt: initialize our own scratch page")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20200522083451.7448-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/agp/intel-gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 871e7f4994e8c..667882e996ecc 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -303,8 +303,10 @@ static int intel_gtt_setup_scratch_page(void)
 	if (intel_private.needs_dmar) {
 		dma_addr = pci_map_page(intel_private.pcidev, page, 0,
 				    PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr))
+		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
+			__free_page(page);
 			return -EINVAL;
+		}
 
 		intel_private.scratch_page_dma = dma_addr;
 	} else
-- 
2.25.1



