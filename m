Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA4C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E1C2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552461;
	bh=v7Vipc0VT/4/+NWQ5NLJhdexjHV4UhMafyaRIs4x8WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ezkuA/wThjkv7xqMaQ7sj+R7UUn9vpLNBO9XLa3UiBgkTzP+9XiX1Ma8cPlvkbvO3
	 fQedpfmzRkkASfxUho8HlJAAVzZamsUIcXAtqZh/Ff0GoHUM1Z/IjXKvKyGLptziJ6
	 SvwFqS2Yu6I8IKopa7IGUyEysWysz1Si8Z5wIOV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbgDVKrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgDVKPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:15:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D112070B;
        Wed, 22 Apr 2020 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550534;
        bh=v7Vipc0VT/4/+NWQ5NLJhdexjHV4UhMafyaRIs4x8WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpzjoLGuaav27l0wt7hVcgdfmIEIDy/e383t/W6dmd8BrYvlHuZP1Sc8x1+cRSkfS
         YVALNGKdS695TpMYmffwcMCqHjd94XNNUMOQM0GA+nlvg2oWvbP3Ed4yZOsecVNUz2
         dcEDPmFXINSNzFOP5p1GSqePiAzUdMZAOJAMiQcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/64] iommu/amd: Fix the configuration of GCR3 table root pointer
Date:   Wed, 22 Apr 2020 11:57:37 +0200
Message-Id: <20200422095022.347731069@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

[ Upstream commit c20f36534666e37858a14e591114d93cc1be0d34 ]

The SPA of the GCR3 table root pointer[51:31] masks 20 bits. However,
this requires 21 bits (Please see the AMD IOMMU specification).
This leads to the potential failure when the bit 51 of SPA of
the GCR3 table root pointer is 1'.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Fixes: 52815b75682e2 ("iommu/amd: Add support for IOMMUv2 domain mode")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 69f3d4c95b530..859b06424e5c4 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -352,7 +352,7 @@
 
 #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
 #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0xfffffULL)
+#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
 
 #define DTE_GCR3_INDEX_A	0
 #define DTE_GCR3_INDEX_B	1
-- 
2.20.1



