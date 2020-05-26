Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0BFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A30D208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520063;
	bh=dEoJRVIXdZx8Bpu5GvIroeoIICrvc6cdlbgsrV+vVzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fVm/lqmKwtUQ+ZxEdtgEq8c7z8dqCRB7lZgbVls8HEbyppvPpxcCrBQaL26MYZzuy
	 zjBfBOzKtni4+0IbkZ11ukN7HKPKN+N57hH0vDERDaaMj/ivxjg8SJPlgIjyRQA6CV
	 Ddvel/GGUzjOueabDrCr9f1TdxgO06idHhrNR3LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbgEZTHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391709AbgEZTHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:07:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D3020873;
        Tue, 26 May 2020 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520058;
        bh=dEoJRVIXdZx8Bpu5GvIroeoIICrvc6cdlbgsrV+vVzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CiEnfjhPvOzCsE2S9v8KP/GuvkYFRurl839qcGjx2hp9cdGBn82z1eV0t9/7S+RD
         EWNa2xgDbNeTfYl7Z3RmW0vNmVKhosHO7yexihIv0vnpY9I55DgV3/ZMkKHDP2g8WX
         xCS1i75iJexmDcE6q6bXR4rHGedImwYhOkhDyG0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/111] iommu/amd: Call domain_flush_complete() in update_domain()
Date:   Tue, 26 May 2020 20:53:01 +0200
Message-Id: <20200526183937.017341854@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit f44a4d7e4f1cdef73c90b1dc749c4d8a7372a8eb ]

The update_domain() function is expected to also inform the hardware
about domain changes. This needs a COMPLETION_WAIT command to be sent
to all IOMMUs which use the domain.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/r/20200504125413.16798-4-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bc7771498342..32de8e7bb8b4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2386,6 +2386,7 @@ static void update_domain(struct protection_domain *domain)
 
 	domain_flush_devices(domain);
 	domain_flush_tlb_pde(domain);
+	domain_flush_complete(domain);
 }
 
 static int dir2prot(enum dma_data_direction direction)
-- 
2.25.1



