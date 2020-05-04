Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E143C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6213206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8YGTl2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgEDPIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:08:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEDPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:08:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9rR024707;
        Mon, 4 May 2020 15:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=6to12crgfoOIuzcAiBWiqiJcf/JFu8fFPEvAzj9Sfb8=;
 b=m8YGTl2PkOQ18N48rXkfB7xElNneljN8Ch1kqPBs1tVRiUPezq6M7ExACsbLB/c9gniX
 iGpRrqwNrlZU5+PLSR558eZPLd/1eykQGEFGYObMFyyNWYx/JoHW/lH05QJgDnH/SyJV
 R7FhN2GN9B6cGfgkBYIJVaVX5quTKerAt2tsg3zqlkUZGrRTOgpa5V1QH+K2/kZwHIE6
 WOIPUJDxdBV6ZDsSe6TP7tzOhNEx0b6Wpi4LsIGCGvRDV4kolKaoEKwtnRCVzHDKqFIR
 zf+59BuqWcOat6nDcKwMxHKJnYPjPV47dwEYcTzP7HJxFmJUkkXJUoaBXVmwK8cqRegC EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30s0tm7fbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:06:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVN2105700;
        Mon, 4 May 2020 15:04:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30sjjw18q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:47 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F4jdM025444;
        Mon, 4 May 2020 15:04:45 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:45 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 10/14] asidrv: Add ioctls to manage ASI mapped VA ranges
Date:   Mon,  4 May 2020 17:02:31 +0200
Message-Id: <20200504150235.12171-11-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctls to list, add, clear ASI mapped VA ranges.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asidrv.c | 138 +++++++++++++++++++++++++++++++++++
 drivers/staging/asi/asidrv.h |  26 +++++++
 2 files changed, 164 insertions(+)

diff --git a/drivers/staging/asi/asidrv.c b/drivers/staging/asi/asidrv.c
index e6edfbe5acea..9d9784629833 100644
--- a/drivers/staging/asi/asidrv.c
+++ b/drivers/staging/asi/asidrv.c
@@ -866,10 +866,137 @@ static int asidrv_ioctl_log_fault_stack(struct asi *asi, bool log_stack)
 	return 0;
 }
 
+/*
+ * ASI decorated pagetable ioctls
+ */
+
+static int asidrv_ioctl_add_mapping(struct dpt *dpt, unsigned long arg)
+{
+	struct asidrv_mapping_list __user *umlist;
+	struct asidrv_mapping mapping;
+	__u32 umlist_len;
+	int i, err;
+
+	umlist = (struct asidrv_mapping_list *)arg;
+	if (copy_from_user(&umlist_len, &umlist->length, sizeof(umlist_len)))
+		return -EFAULT;
+
+	err = 0;
+	for (i = 0; i < umlist_len; i++) {
+		if (copy_from_user(&mapping, &umlist->mapping[i],
+				   sizeof(mapping))) {
+			err = -EFAULT;
+			break;
+		}
+
+		pr_debug("add mapping %llx/%llx/%u %s\n",
+			 mapping.addr, mapping.size, mapping.level,
+			 mapping.percpu ? "percpu" : "");
+
+		if (mapping.percpu) {
+			if (mapping.level != PGT_LEVEL_PTE) {
+				err = -EINVAL;
+				break;
+			}
+			err = dpt_map_percpu(dpt, (void *)mapping.addr,
+					     mapping.size);
+		} else {
+			err = dpt_map_range(dpt, (void *)mapping.addr,
+					    mapping.size, mapping.level);
+		}
+		if (err)
+			break;
+	}
+
+	if (err)
+		return (i == 0) ? err : i;
+
+	return 0;
+}
+
+static int asidrv_ioctl_clear_mapping(struct dpt *dpt, unsigned long arg)
+{
+	struct asidrv_mapping_list __user *umlist;
+	struct asidrv_mapping mapping;
+	__u32 umlist_len;
+	int err, i;
+
+	umlist = (struct asidrv_mapping_list *)arg;
+	if (copy_from_user(&umlist_len, &umlist->length, sizeof(umlist_len)))
+		return -EFAULT;
+
+	err = 0;
+	for (i = 0; i < umlist_len; i++) {
+		if (copy_from_user(&mapping, &umlist->mapping[i],
+				   sizeof(mapping))) {
+			err = -EFAULT;
+			break;
+		}
+
+		pr_debug("clear mapping %llx %s\n",
+			 mapping.addr, mapping.percpu ? "percpu" : "");
+
+		if (mapping.percpu)
+			dpt_unmap_percpu(dpt, (void *)mapping.addr);
+		else
+			dpt_unmap(dpt, (void *)mapping.addr);
+	}
+
+	if (err)
+		return (i == 0) ? err : i;
+
+	return 0;
+}
+
+static int asidrv_ioctl_list_mapping(struct dpt *dpt, unsigned long arg)
+{
+	struct asidrv_mapping_list __user *umlist;
+	struct asidrv_mapping_list *mlist;
+	struct dpt_range_mapping *range;
+	unsigned long addr;
+	size_t mlist_size;
+	__u32 umlist_len;
+	int i;
+
+	umlist = (struct asidrv_mapping_list *)arg;
+	if (copy_from_user(&umlist_len, &umlist->length, sizeof(umlist_len)))
+		return -EFAULT;
+
+	umlist_len = min_t(unsigned int, umlist_len, 512);
+
+	mlist_size = sizeof(*mlist) +
+		sizeof(struct asidrv_mapping) * umlist_len;
+	mlist = kzalloc(mlist_size, GFP_KERNEL);
+	if (!mlist)
+		return -ENOMEM;
+
+	i = 0;
+	list_for_each_entry(range, &dpt->mapping_list, list) {
+		if (i < umlist_len) {
+			addr = (__u64)range->ptr;
+			mlist->mapping[i].addr = addr;
+			mlist->mapping[i].size = range->size;
+			mlist->mapping[i].level = range->level;
+		}
+		i++;
+	}
+	mlist->length = i;
+
+	if (copy_to_user(umlist, mlist, mlist_size)) {
+		kfree(mlist);
+		return -EFAULT;
+	}
+
+	kfree(mlist);
+
+	return 0;
+}
+
 static long asidrv_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct asidrv_test *test = asidrv_test;
 	struct asi *asi = test->asi;
+	struct dpt *dpt = test->dpt;
 
 	switch (cmd) {
 
@@ -884,6 +1011,17 @@ static long asidrv_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case ASIDRV_IOCTL_LOG_FAULT_STACK:
 		return asidrv_ioctl_log_fault_stack(asi, arg);
 
+	/* ASI decorated pagetable ioctls */
+
+	case ASIDRV_IOCTL_LIST_MAPPING:
+		return asidrv_ioctl_list_mapping(dpt, arg);
+
+	case ASIDRV_IOCTL_ADD_MAPPING:
+		return asidrv_ioctl_add_mapping(dpt, arg);
+
+	case ASIDRV_IOCTL_CLEAR_MAPPING:
+		return asidrv_ioctl_clear_mapping(dpt, arg);
+
 	/* Test ioctls */
 
 	case ASIDRV_IOCTL_RUN_SEQUENCE:
diff --git a/drivers/staging/asi/asidrv.h b/drivers/staging/asi/asidrv.h
index 99ab9843e36b..f042106419db 100644
--- a/drivers/staging/asi/asidrv.h
+++ b/drivers/staging/asi/asidrv.h
@@ -48,6 +48,20 @@ enum asidrv_run_error {
 #define ASIDRV_IOCTL_CLEAR_FAULT	_IO('a', 3)
 #define ASIDRV_IOCTL_LOG_FAULT_STACK	_IO('a', 4)
 
+/*
+ * ASIDRV_IOCTL_ADD_MAPPING: add mapping to the ASI.
+ *
+ * User should set 'length' with the number of mapping described in the
+ * 'mapping' array.
+ * Return value:
+ *   -1   - error no mapping was added
+ *    0   - no error, all mappings were added
+ *   N>0  - error but the first N mappings were added
+ */
+#define ASIDRV_IOCTL_ADD_MAPPING	_IOWR('a', 5, struct asidrv_mapping_list)
+#define ASIDRV_IOCTL_CLEAR_MAPPING	_IOW('a', 6, struct asidrv_mapping_list)
+#define ASIDRV_IOCTL_LIST_MAPPING	_IOWR('a', 7, struct asidrv_mapping_list)
+
 #define ASIDRV_KSYM_NAME_LEN	128
 /*
  * We need KSYM_SYMBOL_LEN to lookup symbol. However it's not part of
@@ -73,4 +87,16 @@ struct asidrv_fault_list {
 	struct asidrv_fault fault[0];
 };
 
+struct asidrv_mapping {
+	__u64 addr;
+	__u64 size;
+	__u32 level;
+	__u32 percpu;
+};
+
+struct asidrv_mapping_list {
+	__u32 length;
+	struct asidrv_mapping mapping[0];
+};
+
 #endif
-- 
2.18.2

