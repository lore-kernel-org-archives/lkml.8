Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD5C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5194920791
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bouci4eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGLKBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:01:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4159 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGLKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:01:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0adf0f0000>; Sun, 12 Jul 2020 02:59:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:01:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 Jul 2020 03:01:34 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:01:34 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:01:34 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0adf7d0000>; Sun, 12 Jul 2020 03:01:33 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 3/5] firmware: tegra: Prepare for supporting in-band debugfs
Date:   Sun, 12 Jul 2020 11:01:16 +0100
Message-ID: <20200712100118.13343-4-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200712100118.13343-1-jonathanh@nvidia.com>
References: <20200712100118.13343-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594547983; bh=byHr4P5tZOUG2zGyOT9uxPLPq2n2mL3gS6q5LfAVHi8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bouci4eZdl+CDK8ViCnKZV5VYsvlcBw8YGEpNd3E4fAFiGqh0wBD5by6rWmzGNoeX
         8Eq3RxQearaXDY49SCOHf3Z86x8vQMuW6GhuhW7N302N/JrpcV9zVl0U+OVrp4IU8W
         aU9F0a1x8uDL1CjCFrjsohPLzSY7SsIfWEu4hr0jRjUT2wjqMjjJLOfZxDB4GjtD9J
         w20oRM+7hGqYebx/EMmbJV9NedqH1iLPT3j/So1QaWWZ9TZi3kXKgh/G9YudnTXCIb
         s6YwwYY6K57F3twUe9sn7JHPY4BqlRZ6Rcb1/oWiu2tn0MaiHqWCA467kuZ1rCqf/S
         1OBbrfImbwH9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, BPMP debug information is accessible via the Linux debugfs
file-system using a shared-memory scheme. More recent BPMP firmware now
supports accessing the debug information by in-band messaging which does
not require shared-memory. To prepare for adding in-band debugfs support
for the BPMP, move the shared-memory specific initialisation from the
tegra_bpmp_init_debugfs() into a sub-function.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 53 ++++++++++++---------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index f7bf19248d15..a1a1a3b9e667 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -354,32 +354,43 @@ static int bpmp_populate_dir(struct tegra_bpmp *bpmp, struct seqbuf *seqbuf,
 	return 0;
 }
 
-static int create_debugfs_mirror(struct tegra_bpmp *bpmp, void *buf,
-				 size_t bufsize, struct dentry *root)
+static int bpmp_populate_debugfs_shmem(struct tegra_bpmp *bpmp,
+				       struct dentry *root)
 {
 	struct seqbuf seqbuf;
+	const size_t sz = SZ_512K;
+	dma_addr_t phys;
+	size_t nbytes;
+	void *virt;
 	int err;
 
 	bpmp->debugfs_mirror = debugfs_create_dir("debug", root);
 	if (!bpmp->debugfs_mirror)
 		return -ENOMEM;
 
-	seqbuf_init(&seqbuf, buf, bufsize);
-	err = bpmp_populate_dir(bpmp, &seqbuf, bpmp->debugfs_mirror, 0);
+	virt = dma_alloc_coherent(bpmp->dev, sz, &phys,
+				  GFP_KERNEL | GFP_DMA32);
+	if (!virt)
+		return -ENOMEM;
+
+	err = mrq_debugfs_dumpdir(bpmp, phys, sz, &nbytes);
 	if (err < 0) {
-		debugfs_remove_recursive(bpmp->debugfs_mirror);
-		bpmp->debugfs_mirror = NULL;
+		goto free;
+	} else if (nbytes > sz) {
+		err = -EINVAL;
+		goto free;
 	}
 
+	seqbuf_init(&seqbuf, virt, nbytes);
+	err = bpmp_populate_dir(bpmp, &seqbuf, bpmp->debugfs_mirror, 0);
+free:
+	dma_free_coherent(bpmp->dev, sz, virt, phys);
+
 	return err;
 }
 
 int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 {
-	dma_addr_t phys;
-	void *virt;
-	const size_t sz = SZ_512K;
-	size_t nbytes;
 	struct dentry *root;
 	int err;
 
@@ -390,27 +401,9 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 	if (!root)
 		return -ENOMEM;
 
-	virt = dma_alloc_coherent(bpmp->dev, sz, &phys,
-				  GFP_KERNEL | GFP_DMA32);
-	if (!virt) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = mrq_debugfs_dumpdir(bpmp, phys, sz, &nbytes);
-	if (err < 0) {
-		goto free;
-	} else if (nbytes > sz) {
-		err = -EINVAL;
-		goto free;
-	}
-
-	err = create_debugfs_mirror(bpmp, virt, nbytes, root);
-free:
-	dma_free_coherent(bpmp->dev, sz, virt, phys);
-out:
+	err = bpmp_populate_debugfs_shmem(bpmp, root);
 	if (err < 0)
-		debugfs_remove(root);
+		debugfs_remove_recursive(root);
 
 	return err;
 }
-- 
2.17.1

