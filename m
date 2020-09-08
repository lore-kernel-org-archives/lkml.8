Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678AA2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFmX/3NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgIHQyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgIHQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:48:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE4C061756;
        Tue,  8 Sep 2020 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fgyJ4ZABWJZTj7EJc7LH/kSnQv89OxFbc7jSvV77U8I=; b=oFmX/3NSSOEZg6Vq7bQMcIBLUk
        JWXlC6td7jF2tESzThvQo06B/CWB4gLSJFO1NLu2AzaaJqTYZxJod3allRVzjZg4SAH0SCSMwp848
        k9OWRr6hR2F7La4bbgnTPiCDAglGjzDzt7eJNYX5AEoZxS3aEcZbkkpX7q08ykyc5/YiVeivQYBY+
        /Za4hFEcsoyTiP3Mt/TZ34Yxycs9q0b+K1WWimLplRJxvnG7c0pvdsLtvF4kFosPMUiDUDLCc+nAX
        BDEJlUpYmKIXCHeHxxnUJW2saEFjAhGWPaqucs9SfLKyCdH6BFAk7GIW0YSE9LDZB9jDhoup3Ahi3
        558Ztg1w==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFgmv-0001Sv-2X; Tue, 08 Sep 2020 16:48:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        iommu@lists.linux-foundation.org
Cc:     Tomasz Figa <tfiga@chromium.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 08/12] dma-direct: use phys_to_dma_direct in dma_direct_alloc
Date:   Tue,  8 Sep 2020 18:47:54 +0200
Message-Id: <20200908164758.3177341-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908164758.3177341-1-hch@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the currently open code copy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 12e9f5f75dfe4b..57a6e7d7cf8f16 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -240,10 +240,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 done:
-	if (force_dma_unencrypted(dev))
-		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
-	else
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return ret;
 
 out_encrypt_pages:
-- 
2.28.0

