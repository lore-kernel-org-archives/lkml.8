Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFAEC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63D6208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858973;
	bh=hi2dX1oVv8yZreDP+0pmyOaOSai6d6i0N6rpzahexjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KZDr1nDBWQzyh3cl+PT+xWrQY9+CtCX4VAotxXzXYA47jzflNRu9yWOtIcVP0M040
	 kNU+/UHRudUDllr2nfHMw3+oS+kxSYfVtjnnQOMCScdQUw6UPqRxEqSu/Tu7LjMQSK
	 gZJxZzmAAXiTC2fWHGwHkfNN74NwXcCHNdGSzNHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgAXJmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733151AbgAXJmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:42:45 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD2D20718;
        Fri, 24 Jan 2020 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858965;
        bh=hi2dX1oVv8yZreDP+0pmyOaOSai6d6i0N6rpzahexjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRsJfQUP9RnckdnCP4AFyR10OTnQGebc/rb0IybwmBwbt7eeIR/ZWTdbfcZh8lSeS
         +1bwaz+LGFszyfbh9QwWtS6GQkQWv99ZJEMCqAqw3kLlTrap/NoyLXC0f1QGcjdMIn
         /RTm+fN7bxKojAddggZb2gsd/NZJJeJazDkgq+1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Cao <vincent.t.cao@intel.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 102/102] optee: Fix multi page dynamic shm pool alloc
Date:   Fri, 24 Jan 2020 10:31:43 +0100
Message-Id: <20200124092822.172144798@linuxfoundation.org>
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

From: Sumit Garg <sumit.garg@linaro.org>

[ Upstream commit 5a769f6ff439cedc547395a6dc78faa26108f741 ]

optee_shm_register() expected pages to be passed as an array of page
pointers rather than as an array of contiguous pages. So fix that via
correctly passing pages as per expectation.

Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
Reported-by: Vincent Cao <vincent.t.cao@intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Vincent Cao <vincent.t.cao@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/shm_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index 0332a5301d613..d767eebf30bdd 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -28,9 +28,22 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->size = PAGE_SIZE << order;
 
 	if (shm->flags & TEE_SHM_DMA_BUF) {
+		unsigned int nr_pages = 1 << order, i;
+		struct page **pages;
+
+		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		if (!pages)
+			return -ENOMEM;
+
+		for (i = 0; i < nr_pages; i++) {
+			pages[i] = page;
+			page++;
+		}
+
 		shm->flags |= TEE_SHM_REGISTER;
-		rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
+		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
+		kfree(pages);
 	}
 
 	return rc;
-- 
2.20.1



