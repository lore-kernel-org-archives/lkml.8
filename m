Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38BF20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858960;
	bh=rrAKy3cS1B60JcnPfK6SJ/chFdKXbH5NNXxHVRx9OHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJywdyC876z3XO25sHgva81hZZ61FhaJumcfPfAMRAI57Qwx9Hto55fd2rcj8FEv4
	 OB18zo1WWIUN3lvOhyrWKouuBJnnW+1kSi3dIQg/fjPwY2NNuzH2IwGwnBxGC9Pv5o
	 WLOplD/tgHnMETac6mptf8X72Zb3wlI9EgXoRL0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgAXJmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgAXJmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:42:35 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527E020718;
        Fri, 24 Jan 2020 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858954;
        bh=rrAKy3cS1B60JcnPfK6SJ/chFdKXbH5NNXxHVRx9OHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kbt+Wrz7Yzs+n3pvIz32p36ndOnyD5SaE2HnE9sCLY+LbhlthDdcaUdKCtxLNMgt3
         0usO2AHIGUQpMYboftfir5qVFY0KHoUOimLfoDQT1ke7Sv/iuRhnxBvMhRnvAd2wQf
         EoeRjL+05rx89vIsLZM4hBx52M0p5XUmoeNZyFvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/102] dma-direct: dont check swiotlb=force in dma_direct_map_resource
Date:   Fri, 24 Jan 2020 10:31:32 +0100
Message-Id: <20200124092820.420426594@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4268ac6ae5870af10a7417b22990d615f72f77e2 ]

When mapping resources we can't just use swiotlb ram for bounce
buffering.  Switch to a direct dma_capable check instead.

Fixes: cfced786969c ("dma-mapping: remove the default map_resource implementation")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8402b29c280f5..867fd72cb2605 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -375,7 +375,7 @@ dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 {
 	dma_addr_t dma_addr = paddr;
 
-	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
+	if (unlikely(!dma_capable(dev, dma_addr, size))) {
 		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
 	}
-- 
2.20.1



