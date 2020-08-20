Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD2222B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929847;
	bh=Y+fIIY8x7WyEz2cmhqro6qkEptl2S2GE6qcCTO4P/Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q8PXBhs7a134kigLUusi30VgzgJZfoGMb0KExmUKToVkAxEvburvaTf5Ama5Ba040
	 EBMLX9uLpDP/lwQY8LIsxF4UbTAJdX0VXZ1rKmhzkW2xsQlv4zM8e7gjgWuiB+W+rF
	 5BUP6cj0IjPluiWbzSKqssdv+s+4DDd09u59Gtrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgHTNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgHTJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:34:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3274222BED;
        Thu, 20 Aug 2020 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916045;
        bh=Y+fIIY8x7WyEz2cmhqro6qkEptl2S2GE6qcCTO4P/Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzeB29XOKfL4G+Uoj5uaqPpcdIkSgeZ3v54f5mmhiumHzb4Su1hJWGbulCs9dZ+T1
         uM8nkGhL1IjrwFfIFdNTWrXhEgPRYKSYZ3AdVA1qZW35keyCqcOGcVTiPQ+Ht0aurd
         73+8ouFJIUMYrZF1seL497g74NfDjp+KVmZqG9VY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 195/232] vdpa_sim: init iommu lock
Date:   Thu, 20 Aug 2020 11:20:46 +0200
Message-Id: <20200820091622.235916680@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 1e3e792650d2c0df8dd796906275b7c79e278664 ]

The patch adding the iommu lock did not initialize it.
The struct is zero-initialized so this is mostly a problem
when using lockdep.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Max Gurtovoy <maxg@mellanox.com>
Fixes: 0ea9ee430e74 ("vdpasim: protect concurrent access to iommu iotlb")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8ac6f341dcc16..412fa85ba3653 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -331,6 +331,7 @@ static struct vdpasim *vdpasim_create(void)
 
 	INIT_WORK(&vdpasim->work, vdpasim_work);
 	spin_lock_init(&vdpasim->lock);
+	spin_lock_init(&vdpasim->iommu_lock);
 
 	dev = &vdpasim->vdpa.dev;
 	dev->coherent_dma_mask = DMA_BIT_MASK(64);
-- 
2.25.1



