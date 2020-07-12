Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C8C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C695206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lo5i0c1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgGLKBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:01:36 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6979 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgGLKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:01:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0adf710001>; Sun, 12 Jul 2020 03:01:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:01:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 Jul 2020 03:01:33 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:01:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:01:33 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0adf7c0000>; Sun, 12 Jul 2020 03:01:32 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/5] firmware: tegra: Use consistent return variable name
Date:   Sun, 12 Jul 2020 11:01:15 +0100
Message-ID: <20200712100118.13343-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200712100118.13343-1-jonathanh@nvidia.com>
References: <20200712100118.13343-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594548081; bh=/f9jgSJ9tc4Dql1EUTvDqrJZi7DhqWo1pAFdDNooQgU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lo5i0c1cN5rAneyJtrZzq42eY2tKffe9RfrQ+M3XI23h9BFXPR5uggpZbCT9gseWR
         80zRKKYt7uRJSzy0JKWgvYD8IgQY/mxtzg6HT6n89RfmdBbbTo08LuFzsQTvRY+QPH
         RZEHcjkz4HeO7CjsYX3oaQuzeEzROh/6TVxZFRoT5qjRuntSGnoRA1ZsoSLNxNL9I3
         OLUTlYS6zMI2Qc172l0Btxmff+HvpjnChoHEZX3/+tfzwDt4wyLOapStbluMFyv+Ae
         LPtsiSmFFkkOISsxrG9YgJUAqtbaSphnBRbq06+TYE2o/RpOLVr0inxvnh36iIH61n
         CdH1Kf4M5isew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most functions in the BPMP driver use 'err' as the return variable
name but there are a few places that use 'ret'. Let's use 'err' to
be consistent.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 36 +++++++++++++--------------
 drivers/firmware/tegra/bpmp.c         |  6 ++---
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 08e0f05f46c6..f7bf19248d15 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -206,7 +206,7 @@ static int debugfs_show(struct seq_file *m, void *p)
 	char buf[256];
 	const char *filename;
 	size_t len, nbytes;
-	int ret;
+	int err;
 
 	filename = get_filename(bpmp, file, buf, sizeof(buf));
 	if (!filename)
@@ -220,24 +220,24 @@ static int debugfs_show(struct seq_file *m, void *p)
 	datavirt = dma_alloc_coherent(bpmp->dev, datasize, &dataphys,
 				      GFP_KERNEL | GFP_DMA32);
 	if (!datavirt) {
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto free_namebuf;
 	}
 
 	len = strlen(filename);
 	strncpy(namevirt, filename, namesize);
 
-	ret = mrq_debugfs_read(bpmp, namephys, len, dataphys, datasize,
+	err = mrq_debugfs_read(bpmp, namephys, len, dataphys, datasize,
 			       &nbytes);
 
-	if (!ret)
+	if (!err)
 		seq_write(m, datavirt, nbytes);
 
 	dma_free_coherent(bpmp->dev, datasize, datavirt, dataphys);
 free_namebuf:
 	dma_free_coherent(bpmp->dev, namesize, namevirt, namephys);
 
-	return ret;
+	return err;
 }
 
 static int debugfs_open(struct inode *inode, struct file *file)
@@ -257,7 +257,7 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 	char fnamebuf[256];
 	const char *filename;
 	size_t len;
-	int ret;
+	int err;
 
 	filename = get_filename(bpmp, file, fnamebuf, sizeof(fnamebuf));
 	if (!filename)
@@ -271,7 +271,7 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 	datavirt = dma_alloc_coherent(bpmp->dev, datasize, &dataphys,
 				      GFP_KERNEL | GFP_DMA32);
 	if (!datavirt) {
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto free_namebuf;
 	}
 
@@ -279,11 +279,11 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 	strncpy(namevirt, filename, namesize);
 
 	if (copy_from_user(datavirt, buf, count)) {
-		ret = -EFAULT;
+		err = -EFAULT;
 		goto free_databuf;
 	}
 
-	ret = mrq_debugfs_write(bpmp, namephys, len, dataphys,
+	err = mrq_debugfs_write(bpmp, namephys, len, dataphys,
 				count);
 
 free_databuf:
@@ -291,7 +291,7 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 free_namebuf:
 	dma_free_coherent(bpmp->dev, namesize, namevirt, namephys);
 
-	return ret ?: count;
+	return err ?: count;
 }
 
 static const struct file_operations debugfs_fops = {
@@ -380,8 +380,8 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 	void *virt;
 	const size_t sz = SZ_512K;
 	size_t nbytes;
-	int ret;
 	struct dentry *root;
+	int err;
 
 	if (!tegra_bpmp_mrq_is_supported(bpmp, MRQ_DEBUGFS))
 		return 0;
@@ -393,24 +393,24 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 	virt = dma_alloc_coherent(bpmp->dev, sz, &phys,
 				  GFP_KERNEL | GFP_DMA32);
 	if (!virt) {
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto out;
 	}
 
-	ret = mrq_debugfs_dumpdir(bpmp, phys, sz, &nbytes);
-	if (ret < 0) {
+	err = mrq_debugfs_dumpdir(bpmp, phys, sz, &nbytes);
+	if (err < 0) {
 		goto free;
 	} else if (nbytes > sz) {
-		ret = -EINVAL;
+		err = -EINVAL;
 		goto free;
 	}
 
-	ret = create_debugfs_mirror(bpmp, virt, nbytes, root);
+	err = create_debugfs_mirror(bpmp, virt, nbytes, root);
 free:
 	dma_free_coherent(bpmp->dev, sz, virt, phys);
 out:
-	if (ret < 0)
+	if (err < 0)
 		debugfs_remove(root);
 
-	return ret;
+	return err;
 }
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index fe6702df24bf..4d93d8925e14 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -515,10 +515,10 @@ bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp, unsigned int mrq)
 			.size = sizeof(resp),
 		},
 	};
-	int ret;
+	int err;
 
-	ret = tegra_bpmp_transfer(bpmp, &msg);
-	if (ret || msg.rx.ret)
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err || msg.rx.ret)
 		return false;
 
 	return resp.status == 0;
-- 
2.17.1

