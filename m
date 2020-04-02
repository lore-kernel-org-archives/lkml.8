Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8267BC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575820719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbgDBTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:50:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731689AbgDBTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:50:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032JWs7e115342;
        Thu, 2 Apr 2020 15:50:02 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022r1rvq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 15:50:02 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032JnWOi031098;
        Thu, 2 Apr 2020 19:50:01 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 301x77bb88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 19:50:01 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 032Jo0ZC53281070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 19:50:00 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB030AE066;
        Thu,  2 Apr 2020 19:50:00 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C42E7AE05C;
        Thu,  2 Apr 2020 19:49:59 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.31.233])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 19:49:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v7 3/5] soc: aspeed: xdma: Add user interface
Date:   Thu,  2 Apr 2020 14:49:53 -0500
Message-Id: <20200402194955.16643-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200402194955.16643-1-eajames@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_09:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=4 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds a miscdevice to provide a user interface to the XDMA
engine. The interface provides the write operation to start DMA
operations. The DMA parameters are passed as the data to the write call.
The actual data to transfer is NOT passed through write. Note that both
directions of DMA operation are accomplished through the write command;
BMC to host and host to BMC.

The XDMA driver reserves an area of physical memory for DMA operations,
as the XDMA engine is restricted to accessing certain physical memory
areas on some platforms. This memory forms a pool from which users can
allocate pages for their usage with calls to mmap. The space allocated
by a client will be the space used in the DMA operation. For an
"upstream" (BMC to host) operation, the data in the client's area will
be transferred to the host. For a "downstream" (host to BMC) operation,
the host data will be placed in the client's memory area.

Poll is also provided in order to determine when the DMA operation is
complete for non-blocking IO.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffrey <andrew@aj.id.au>
---
Changes since v6:
 - Refactor probe error handling for misc device registration

 drivers/soc/aspeed/aspeed-xdma.c | 204 +++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index bc746b262de7..4fcdf0967cd4 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/mfd/syscon.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
@@ -208,6 +209,8 @@ struct aspeed_xdma {
 	struct reset_control *reset;
 	struct reset_control *reset_rc;
 
+	/* file_lock serializes reads of current_client */
+	struct mutex file_lock;
 	/* client_lock protects error and in_progress of the client */
 	spinlock_t client_lock;
 	struct aspeed_xdma_client *current_client;
@@ -230,6 +233,8 @@ struct aspeed_xdma {
 	void __iomem *mem_virt;
 	dma_addr_t cmdq_phys;
 	struct gen_pool *pool;
+
+	struct miscdevice misc;
 };
 
 struct aspeed_xdma_client {
@@ -538,6 +543,191 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
+				 size_t len, loff_t *offset)
+{
+	int rc;
+	struct aspeed_xdma_op op;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	if (len != sizeof(op))
+		return -EINVAL;
+
+	rc = copy_from_user(&op, buf, len);
+	if (rc)
+		return rc;
+
+	if (!op.len || op.len > client->size ||
+	    op.direction > ASPEED_XDMA_DIRECTION_UPSTREAM)
+		return -EINVAL;
+
+	if (file->f_flags & O_NONBLOCK) {
+		if (READ_ONCE(ctx->in_reset))
+			return -EBUSY;
+
+		if (!mutex_trylock(&ctx->file_lock))
+			return -EAGAIN;
+
+		if (READ_ONCE(ctx->current_client)) {
+			mutex_unlock(&ctx->file_lock);
+			return -EBUSY;
+		}
+	} else {
+		mutex_lock(&ctx->file_lock);
+
+		rc = wait_event_interruptible(ctx->wait, !ctx->current_client);
+		if (rc) {
+			mutex_unlock(&ctx->file_lock);
+			return -EINTR;
+		}
+	}
+
+	aspeed_xdma_start(ctx, &op, client->phys, client);
+
+	mutex_unlock(&ctx->file_lock);
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		rc = wait_event_interruptible(ctx->wait, !client->in_progress);
+		if (rc)
+			return -EINTR;
+
+		if (client->error)
+			return -EIO;
+	}
+
+	return len;
+}
+
+static __poll_t aspeed_xdma_poll(struct file *file,
+				 struct poll_table_struct *wait)
+{
+	__poll_t mask = 0;
+	__poll_t req = poll_requested_events(wait);
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	if (req & (EPOLLIN | EPOLLRDNORM)) {
+		if (client->in_progress)
+			poll_wait(file, &ctx->wait, wait);
+
+		if (!client->in_progress) {
+			if (client->error)
+				mask |= EPOLLERR;
+			else
+				mask |= EPOLLIN | EPOLLRDNORM;
+		}
+	}
+
+	if (req & (EPOLLOUT | EPOLLWRNORM)) {
+		if (ctx->current_client)
+			poll_wait(file, &ctx->wait, wait);
+
+		if (!ctx->current_client)
+			mask |= EPOLLOUT | EPOLLWRNORM;
+	}
+
+	return mask;
+}
+
+static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
+{
+	int rc;
+	struct aspeed_xdma_client *client = vma->vm_private_data;
+
+	rc = wait_event_interruptible(client->ctx->wait, !client->in_progress);
+	if (rc)
+		return;
+
+	gen_pool_free(client->ctx->pool, (unsigned long)client->virt,
+		      client->size);
+
+	client->virt = NULL;
+	client->phys = 0;
+	client->size = 0;
+}
+
+static const struct vm_operations_struct aspeed_xdma_vm_ops = {
+	.close =	aspeed_xdma_vma_close,
+};
+
+static int aspeed_xdma_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int rc;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	/* restrict file to one mapping */
+	if (client->size)
+		return -EBUSY;
+
+	client->size = vma->vm_end - vma->vm_start;
+	client->virt = gen_pool_dma_alloc(ctx->pool, client->size,
+					  &client->phys);
+	if (!client->virt) {
+		client->phys = 0;
+		client->size = 0;
+		return -ENOMEM;
+	}
+
+	vma->vm_pgoff = (client->phys - ctx->mem_phys) >> PAGE_SHIFT;
+	vma->vm_ops = &aspeed_xdma_vm_ops;
+	vma->vm_private_data = client;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	rc = io_remap_pfn_range(vma, vma->vm_start, client->phys >> PAGE_SHIFT,
+				client->size, vma->vm_page_prot);
+	if (rc) {
+		dev_warn(ctx->dev, "mmap err: v[%08lx] to p[%08x], s[%08x]\n",
+			 vma->vm_start, (u32)client->phys, client->size);
+
+		gen_pool_free(ctx->pool, (unsigned long)client->virt,
+			      client->size);
+
+		client->virt = NULL;
+		client->phys = 0;
+		client->size = 0;
+		return rc;
+	}
+
+	dev_dbg(ctx->dev, "mmap: v[%08lx] to p[%08x], s[%08x]\n",
+		vma->vm_start, (u32)client->phys, client->size);
+
+	return 0;
+}
+
+static int aspeed_xdma_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *misc = file->private_data;
+	struct aspeed_xdma *ctx = container_of(misc, struct aspeed_xdma, misc);
+	struct aspeed_xdma_client *client = kzalloc(sizeof(*client),
+						    GFP_KERNEL);
+
+	if (!client)
+		return -ENOMEM;
+
+	client->ctx = ctx;
+	file->private_data = client;
+	return 0;
+}
+
+static int aspeed_xdma_release(struct inode *inode, struct file *file)
+{
+	struct aspeed_xdma_client *client = file->private_data;
+
+	kfree(client);
+	return 0;
+}
+
+static const struct file_operations aspeed_xdma_fops = {
+	.owner			= THIS_MODULE,
+	.write			= aspeed_xdma_write,
+	.poll			= aspeed_xdma_poll,
+	.mmap			= aspeed_xdma_mmap,
+	.open			= aspeed_xdma_open,
+	.release		= aspeed_xdma_release,
+};
+
 static int aspeed_xdma_init_scu(struct aspeed_xdma *ctx, struct device *dev)
 {
 	struct regmap *scu = syscon_regmap_lookup_by_phandle(dev->of_node,
@@ -610,6 +800,7 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 	ctx->chip = md;
 	ctx->dev = dev;
 	platform_set_drvdata(pdev, ctx);
+	mutex_init(&ctx->file_lock);
 	mutex_init(&ctx->start_lock);
 	INIT_WORK(&ctx->reset_work, aspeed_xdma_reset_work);
 	spin_lock_init(&ctx->client_lock);
@@ -725,6 +916,18 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	aspeed_xdma_init_eng(ctx);
 
+	ctx->misc.minor = MISC_DYNAMIC_MINOR;
+	ctx->misc.fops = &aspeed_xdma_fops;
+	ctx->misc.name = "aspeed-xdma";
+	ctx->misc.parent = dev;
+	rc = misc_register(&ctx->misc);
+	if (rc) {
+		dev_err(dev, "Failed to register xdma miscdevice.\n");
+		gen_pool_free(ctx->pool, (unsigned long)ctx->cmdq,
+			      XDMA_CMDQ_SIZE);
+		goto err;
+	}
+
 	/*
 	 * This interrupt could fire immediately so only request it once the
 	 * engine and driver are initialized.
@@ -755,6 +958,7 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	misc_deregister(&ctx->misc);
 	gen_pool_free(ctx->pool, (unsigned long)ctx->cmdq, XDMA_CMDQ_SIZE);
 
 	reset_control_assert(ctx->reset);
-- 
2.24.0

