Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC7DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDE82220A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RicVnspy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIKQ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:27:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35964 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgIKPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:20:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BDbmuT094124;
        Fri, 11 Sep 2020 09:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/DlSfj+qc/DKFfnxqp/QaMVjzQLq0SBZzTsv8j+fWSw=;
 b=RicVnspy5d63Y6X25prYN377f+LRKdK/q3Xjo+Nsn2aC+TlLrCvfIlSxvg2lz+N/KABB
 IJPYJofo2YZbkyJ97mVp4O9gStaNwFjOnpwtAwnhBhHkAessXAxVNZ21FvOvEG/nzsgy
 ZJUwc+P5jKEzZ46BkUL9RvOCj0q4bkXrwINyZOtdMGuGGwgZXKtgObusq4HC/Kdav5F7
 7utc8xrMaAq/aofBtyW+dz7u4COGIp2cotgSSaVd0ZZCrmISCFaNNtD2lRsgfcPYhGGC
 qicrJwSNE5cJvKe8rg8SjYPXB1jc912bm7pV9C7eKzuPYx7x/BDiKoTPKiIk6TcqFIhu pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ga35ghmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:48:40 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BDc8o9095555;
        Fri, 11 Sep 2020 09:48:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ga35ghks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:48:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BDh2jx029635;
        Fri, 11 Sep 2020 13:48:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8f9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 13:48:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BDmZoj35324388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 13:48:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37973AE04D;
        Fri, 11 Sep 2020 13:48:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BED6BAE053;
        Fri, 11 Sep 2020 13:48:34 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.47.39])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 13:48:34 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, mhocko@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: don't panic when links can't be created in sysfs
Date:   Fri, 11 Sep 2020 15:48:31 +0200
Message-Id: <20200911134831.53258-4-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911134831.53258-1-ldufour@linux.ibm.com>
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time, or when doing memory hot-add operations, if the links in
sysfs can't be created, the system is still able to run, so just report the
error in the kernel log.

Since the number of memory blocks managed could be high, the messages are
rate limited.

As a consequence, link_mem_sections() has no status to report anymore.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c  | 25 +++++++++++++++++--------
 include/linux/node.h | 17 ++++++++---------
 mm/memory_hotplug.c  |  5 ++---
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 862516c5a5ae..749a1c8ea992 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -811,12 +811,21 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
 		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
 					&mem_blk->dev.kobj,
 					kobject_name(&mem_blk->dev.kobj));
-		if (ret)
-			return ret;
+		if (ret && ret != -EEXIST)
+			pr_err_ratelimited(
+				"can't create %s to %s link in sysfs (%d)\n",
+				kobject_name(&node_devices[nid]->dev.kobj),
+				kobject_name(&mem_blk->dev.kobj), ret);
 
-		return sysfs_create_link_nowarn(&mem_blk->dev.kobj,
+		ret = sysfs_create_link_nowarn(&mem_blk->dev.kobj,
 				&node_devices[nid]->dev.kobj,
 				kobject_name(&node_devices[nid]->dev.kobj));
+		if (ret && ret != -EEXIST)
+			pr_err_ratelimited(
+				"can't create %s to %s link in sysfs (%d)\n",
+				kobject_name(&mem_blk->dev.kobj),
+				kobject_name(&node_devices[nid]->dev.kobj),
+				ret);
 	}
 	/* mem section does not span the specified node */
 	return 0;
@@ -837,17 +846,17 @@ void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 			  kobject_name(&node_devices[mem_blk->nid]->dev.kobj));
 }
 
-int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn,
-		      enum memplug_context context)
+void link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn,
+		       enum memplug_context context)
 {
 	struct rmsun_args args = {
 		.nid = nid,
 		.context = context,
 	};
 
-	return walk_memory_blocks(PFN_PHYS(start_pfn),
-				  PFN_PHYS(end_pfn - start_pfn), (void *)&args,
-				  register_mem_sect_under_node);
+	walk_memory_blocks(PFN_PHYS(start_pfn),
+			   PFN_PHYS(end_pfn - start_pfn), (void *)&args,
+			   register_mem_sect_under_node);
 }
 
 #ifdef CONFIG_HUGETLBFS
diff --git a/include/linux/node.h b/include/linux/node.h
index 8ff08520488c..6bdd6f3ed3aa 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -99,15 +99,14 @@ extern struct node *node_devices[];
 typedef  void (*node_registration_func_t)(struct node *);
 
 #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_NUMA)
-extern int link_mem_sections(int nid, unsigned long start_pfn,
-			     unsigned long end_pfn,
-			     enum memplug_context context);
+void link_mem_sections(int nid, unsigned long start_pfn,
+		       unsigned long end_pfn,
+		       enum memplug_context context);
 #else
-static inline int link_mem_sections(int nid, unsigned long start_pfn,
-				    unsigned long end_pfn,
-				    enum memplug_context context)
+static inline void link_mem_sections(int nid, unsigned long start_pfn,
+				     unsigned long end_pfn,
+				     enum memplug_context context)
 {
-	return 0;
 }
 #endif
 
@@ -130,8 +129,8 @@ static inline int register_one_node(int nid)
 		if (error)
 			return error;
 		/* link memory sections under this node */
-		error = link_mem_sections(nid, start_pfn, end_pfn,
-					  MEMPLUG_EARLY);
+		link_mem_sections(nid, start_pfn, end_pfn,
+				  MEMPLUG_EARLY);
 	}
 
 	return error;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 912d355ca446..668418071a49 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1080,9 +1080,8 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	}
 
 	/* link memory sections under this node.*/
-	ret = link_mem_sections(nid, PFN_DOWN(start), PFN_UP(start + size - 1),
-				MEMPLUG_HOTPLUG);
-	BUG_ON(ret);
+	link_mem_sections(nid, PFN_DOWN(start), PFN_UP(start + size - 1),
+			  MEMPLUG_HOTPLUG);
 
 	/* create new memmap entry */
 	if (!strcmp(res->name, "System RAM"))
-- 
2.28.0

