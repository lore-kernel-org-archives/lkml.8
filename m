Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A356C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CE820730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099933;
	bh=2TFAKaSdT+EMO+YKZ/LNnCEY582EwDyXXk3/bqOThdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v3aOt0bwCbE/TBRjQUTULUq5W1vfhC73Fwg1DB6pSteXTBgw3a1bAzLlGxjOm70AZ
	 tnoOQ1FX1Wtmk1b4TyYxyBgImeHk0s3e8v8VMHMiMujQcYr+egnZlqZuetTmMFFfd9
	 qAG9IRSCVFqgmbqTM4Nyug1BCrPiOZvqf2BRyQNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgD1SgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgD1SeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:34:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89A120B80;
        Tue, 28 Apr 2020 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098854;
        bh=2TFAKaSdT+EMO+YKZ/LNnCEY582EwDyXXk3/bqOThdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuS94Hps7oOxRIfaAf5l47nVD6vw73Eu0r/dlLZHm94Xdu7ENwj02g+7MRMqrVLhG
         Vynv+2mSzf+n1O2yJhqOxjYFLupGomw0uhuFDA+0JHBbvO8LjCoLcvlgItANE0u3TY
         uEVXBN4200Ef768gfQTzpcQhAB5FrhddnktOhufc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 023/168] dma-direct: fix data truncation in dma_direct_get_required_mask()
Date:   Tue, 28 Apr 2020 20:23:17 +0200
Message-Id: <20200428182234.638768073@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit cdcda0d1f8f4ab84efe7cd9921c98364398aefd7 ]

The upper 32-bit physical address gets truncated inadvertently
when dma_direct_get_required_mask() invokes phys_to_dma_direct().
This results in dma_addressing_limited() return incorrect value
when used in platforms with LPAE enabled.
Fix it here by explicitly type casting 'max_pfn' to phys_addr_t
in order to prevent overflow of intermediate value while evaluating
'(max_pfn - 1) << PAGE_SHIFT'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 867fd72cb2605..0a093a675b632 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -45,7 +45,8 @@ static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
+	u64 max_dma = phys_to_dma_direct(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
-- 
2.20.1



