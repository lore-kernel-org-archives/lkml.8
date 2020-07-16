Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC312070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aV+zZZrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgGPRbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:31:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:31:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHN5WN194015;
        Thu, 16 Jul 2020 17:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=dh9XlH7tcErW5JjhDQpp3ynCODYBy0/3QNVW+UL0wEA=;
 b=aV+zZZrpZJ2wySmoSVQDN4Qqx0QNkJN1J/D1VVPvQbCOcg+SxLlzymNDfLE6EvoQ0Hcv
 E3gZBWDOyn+qDDKf5OjeT0oSSQS45jZUnVASqyjlM7q2hIktxGJi62/sAVOa+3D7ltG3
 xPbn72KmZyxyKhyPIw+VrhZYDqKLEhNRFhjf37JGzMX4wduYOZ9lTgC/00lggZrDeP0z
 7W7AyvIICpshkuZZLg/UfgEgUXxuiE/e3OZRZaNjL3ch/dGuUnJQwfITuwQkprKk8/mK
 OA3QkGTUCfri2P23ON1DwEOiy2TiBWcqkC8SPYElykdmZttzyf/5WcS0DqaXaSbvyezW yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3275cmjtf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 17:31:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHHjKH005851;
        Thu, 16 Jul 2020 17:29:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 327q0tvk2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 17:29:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GHTbK5019040;
        Thu, 16 Jul 2020 17:29:37 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 10:29:37 -0700
From:   Joao Martins <joao.m.martins@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 1/4] device-dax: Make align a per-device property
Date:   Thu, 16 Jul 2020 18:29:10 +0100
Message-Id: <20200716172913.19658-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716172913.19658-1-joao.m.martins@oracle.com>
References: <20200716172913.19658-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce @align to struct dev_dax.

When creating a new device, we still initialize to the default
dax_region @align. Child devices belonging to a region may wish
to keep a different alignment property instead of a global
region-defined one.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/dax/bus.c         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/device.c      | 35 +++++++++++++++--------------------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 8b6c4ddc5f42..2578651c596e 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1215,6 +1215,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 13780f62b95e..96ef5a8ae0ba 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -62,6 +62,7 @@ struct dax_mapping {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	unsigned int align;
 	int target_node;
 	int id;
 	struct ida ida;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bfc5c83e3b0..346c7bb8cf06 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -17,7 +17,6 @@
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
-	struct dax_region *dax_region = dev_dax->region;
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
 
@@ -32,7 +31,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -EINVAL;
 	}
 
-	mask = dax_region->align - 1;
+	mask = dev_dax->align - 1;
 	if (vma->vm_start & mask || vma->vm_end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
@@ -86,13 +85,13 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 
 	dax_region = dev_dax->region;
-	if (dax_region->align > PAGE_SIZE) {
+	if (dev_dax->align > PAGE_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size != dax_region->align)
+	if (fault_size != dev_dax->align)
 		return VM_FAULT_SIGBUS;
 
 	phys = dax_pgoff_to_phys(dev_dax, vmf->pgoff, PAGE_SIZE);
@@ -120,15 +119,15 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 
 	dax_region = dev_dax->region;
-	if (dax_region->align > PMD_SIZE) {
+	if (dev_dax->align > PMD_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size < dax_region->align)
+	if (fault_size < dev_dax->align)
 		return VM_FAULT_SIGBUS;
-	else if (fault_size > dax_region->align)
+	else if (fault_size > dev_dax->align)
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
@@ -164,15 +163,15 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 
 	dax_region = dev_dax->region;
-	if (dax_region->align > PUD_SIZE) {
+	if (dev_dax->align > PUD_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size < dax_region->align)
+	if (fault_size < dev_dax->align)
 		return VM_FAULT_SIGBUS;
-	else if (fault_size > dax_region->align)
+	else if (fault_size > dev_dax->align)
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
@@ -267,9 +266,8 @@ static int dev_dax_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
-	struct dax_region *dax_region = dev_dax->region;
 
-	if (!IS_ALIGNED(addr, dax_region->align))
+	if (!IS_ALIGNED(addr, dev_dax->align))
 		return -EINVAL;
 	return 0;
 }
@@ -278,9 +276,8 @@ static unsigned long dev_dax_pagesize(struct vm_area_struct *vma)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
-	struct dax_region *dax_region = dev_dax->region;
 
-	return dax_region->align;
+	return dev_dax->align;
 }
 
 static const struct vm_operations_struct dax_vm_ops = {
@@ -319,13 +316,11 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 {
 	unsigned long off, off_end, off_align, len_align, addr_align, align;
 	struct dev_dax *dev_dax = filp ? filp->private_data : NULL;
-	struct dax_region *dax_region;
 
 	if (!dev_dax || addr)
 		goto out;
 
-	dax_region = dev_dax->region;
-	align = dax_region->align;
+	align = dev_dax->align;
 	off = pgoff << PAGE_SHIFT;
 	off_end = off + len;
 	off_align = round_up(off, align);
-- 
2.17.1

