Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE86C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3162208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520365;
	bh=WPj0jjv6Ts+fStz7KcOL0WNWp4wINcRRJV6yd0QuEiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OxZQblKIom8iEXzv315iLdVv+DaLRQn+xIDxSYIuQjoaoop0y43eoRAXS8E/s1Zyg
	 RY2yupyGvhBtthH3XBDsO7d94faXbw1v4dpuaOG408M8pDXa0NC6USXHCUqa4z3aha
	 D/lMGA11geGMVeFmOnM7K9+hD1qwN3G3dNAAeSvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbgEZTMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392109AbgEZTMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5A3208A7;
        Tue, 26 May 2020 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520359;
        bh=WPj0jjv6Ts+fStz7KcOL0WNWp4wINcRRJV6yd0QuEiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc65seZHXTw+r1+VSCyKXpAqhDeG5308PCmc3QWazfekV9oWaN08E+eHSMLY1Chnq
         m31z8Ldg0CCUPxyPqFtozMtRvyWpcvEfyGvWmpFn02YpIuJjMgm3cPdon35+TPwhgz
         g1TW0dt8u8m8JuTwvHI+nyxGrHLb2Ny3Rtz417q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 048/126] iommu/amd: Do not loop forever when trying to increase address space
Date:   Tue, 26 May 2020 20:53:05 +0200
Message-Id: <20200526183942.060883968@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 5b8a9a047b6cad361405c7900c1e1cdd378c4589 ]

When increase_address_space() fails to allocate memory, alloc_pte()
will call it again until it succeeds. Do not loop forever while trying
to increase the address space and just return an error instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/r/20200504125413.16798-3-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1d8634250afc..18c995a16d80 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1500,8 +1500,19 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
 	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
-		*updated = increase_address_space(domain, address, gfp) || *updated;
+		bool upd = increase_address_space(domain, address, gfp);
+
+		/* Read new values to check if update was successful */
 		amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+		/*
+		 * Return an error if there is no memory to update the
+		 * page-table.
+		 */
+		if (!upd && (address > PM_LEVEL_SIZE(pgtable.mode)))
+			return NULL;
+
+		*updated = *updated || upd;
 	}
 
 
-- 
2.25.1



