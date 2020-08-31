Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F359C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007A82074B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PMGr1dUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHaERV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHaERU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:17:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283C9C061573;
        Sun, 30 Aug 2020 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hk9MKuYTLLrbYPyororI+1P9k/AQL7zML5WUOPd+C6c=; b=PMGr1dUjzsSLLZezD3HIALlL8q
        HqT6THcAJCmcjDT59RzuD2Of87nr/15+1XH4pvm/KedAGJNyHMlcfeoEdih24melWClTbOPxhFKF7
        Az17djVhyAk0DWJZQU2oIT6Hld0Tyg+ElHrhba4u5eWYUL5I6hI6hJ2EbLdS1oxHLBS5nvJfkG6rn
        yRSJ98sR65k3RQ8vxe8g36o2A8oDyzU8hQ1Hl1QalwZpY2Urgc1XUzJCZLCcT62uKrWpz7WMt4TSQ
        IpD6mmFTYqGhZw05LuBWG/dIOmqCWBNn3seu0lN8NHs7fWa2cSzMZpfJTKlMtDHXhpYxIvlVB3LMB
        aXLFxgCQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCbFt-000648-LC; Mon, 31 Aug 2020 04:17:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] dma-buf: fix kernel-doc warning in dma-fence.c
Date:   Sun, 30 Aug 2020 21:17:13 -0700
Message-Id: <20200831041713.12571-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add @cookie to dma_fence_end_signalling() to prevent kernel-doc
warning in drivers/dma-buf/dma-fence.c:

../drivers/dma-buf/dma-fence.c:291: warning: Function parameter or member 'cookie' not described in 'dma_fence_end_signalling'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/dma-buf/dma-fence.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-59-rc3.orig/drivers/dma-buf/dma-fence.c
+++ lnx-59-rc3/drivers/dma-buf/dma-fence.c
@@ -283,6 +283,7 @@ EXPORT_SYMBOL(dma_fence_begin_signalling
 
 /**
  * dma_fence_end_signalling - end a critical DMA fence signalling section
+ * @cookie: opaque cookie from dma_fence_begin_signalling()
  *
  * Closes a critical section annotation opened by dma_fence_begin_signalling().
  */
