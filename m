Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A903208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf5TG5YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFQCii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQCih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:38:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:38:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so298703pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2fsUbTxVXQuihX2yvqrI7NERARlbGjrtDeHmGabbVEU=;
        b=Wf5TG5YNvh6DHTC/0T6jlYTVpC4iC7DxxYZmDDnkhjXp536NkdxWm88Xc4J+bSnhkH
         pPqZvmVLxyBCwN+rMxsmAOcEavVUAAT9tvmQpYsT5PIltn3AoItPSFrjbCDfSX5j+8Gp
         ayPi4vydHAbNWSTSGGNfhgIF5Vfs0m6UvO5h2JPnMXaB3TuPChe3uqaIldWV+XuszzXx
         x3OXFPcJMUlK0HQ+TYRTuEE/PgNNmuLsua23gcqWw6xaLxBR/bx6TYTRqY+uLBwZFw0f
         f1zQtKBH2ctsK2HVIKauwSXsrUwZr+wAbgBh+Y+VxapXOdzZHbuek2uhLdS3vDaTBYRL
         JJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2fsUbTxVXQuihX2yvqrI7NERARlbGjrtDeHmGabbVEU=;
        b=tUB1+n9IhN86SuC2VHPFRNlRRFQ9l2YWx6TlzEqjuqipXIRR2Uru01zzWSmUj1ioH1
         mBD/OiEKcPdJEzuXPSnt0t4LUw5k9dnCCHXIZQ1GS1IkgaVeUVe60MSS/bxb8bDxl6EG
         nx1R2KGNZvTPKeQpcDZXMS37XbWd7ZlZo/+nJw5L9JXB2eaC1yud2Hhf3qYimamM7rzU
         Z8VMS3XGt+q+iACiXvoWhUaoa5GySStVJm6rVamxkghGFFKyNi3zFDXY0BZFDOUIQYAW
         rqs2KfsMh4DhQv6QKoWxqeO9dXoSXx/63IC0ysft7nZFf5hOp9zoE9qurGjjonryMIMT
         JGJQ==
X-Gm-Message-State: AOAM530an0cpZyqGqMdINqCegY/lDfqXyCzzDv01z+Y4l2sWl0kgBhp6
        bfI5X1nexsXB7z+jgVGQq9gy1U8nKFc=
X-Google-Smtp-Source: ABdhPJwi59hfult5Zg7AIgt1J9g2XkeDyBiXVlRPd6nR92yvVk9hrW3BpM0C20966+Kv7H45oOHGxg==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr5731559pjv.100.1592361517243;
        Tue, 16 Jun 2020 19:38:37 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id s11sm17806105pfh.204.2020.06.16.19.38.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:38:36 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: gasket: Convert get_user_pages*() --> pin_user_pages*()
Date:   Wed, 17 Jun 2020 08:15:30 +0530
Message-Id: <1592361930-3813-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
	https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>

---
Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.

v2: 
	Added review tag.

 drivers/staging/gasket/gasket_page_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index f6d7157..d712ad4 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -449,7 +449,7 @@ static bool gasket_release_page(struct page *page)
 
 	if (!PageReserved(page))
 		SetPageDirty(page);
-	put_page(page);
+	unpin_user_page(page);
 
 	return true;
 }
@@ -486,12 +486,12 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
 					   off + i * PAGE_SIZE;
 		} else {
-			ret = get_user_pages_fast(page_addr - offset, 1,
+			ret = pin_user_pages_fast(page_addr - offset, 1,
 						  FOLL_WRITE, &page);
 
 			if (ret <= 0) {
 				dev_err(pg_tbl->device,
-					"get user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
+					"pin user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
 					page_addr, offset, ret);
 				return ret ? ret : -ENOMEM;
 			}
-- 
1.9.1

