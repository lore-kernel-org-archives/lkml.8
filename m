Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C2BC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E655824957
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEIIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:52:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727835AbgEIIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:52:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21A63F014332F74A895D;
        Sat,  9 May 2020 16:52:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 16:52:25 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.or>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 3/3] s390/protvirt: use scnprintf() instead of snprintf()
Date:   Sat, 9 May 2020 16:56:08 +0800
Message-ID: <20200509085608.41061-4-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509085608.41061-1-chenzhou10@huawei.com>
References: <20200509085608.41061-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() returns the number of bytes that would be written,
which may be greater than the the actual length to be written.

uv_query_facilities() should return the number of bytes printed
into the buffer. This is the return value of scnprintf().
The other functions are the same.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/s390/kernel/uv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 4c0677fc8904..e7ea82a2bf63 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -331,7 +331,7 @@ EXPORT_SYMBOL_GPL(arch_make_page_accessible);
 static ssize_t uv_query_facilities(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%lx\n%lx\n%lx\n%lx\n",
+	return scnprintf(page, PAGE_SIZE, "%lx\n%lx\n%lx\n%lx\n",
 			uv_info.inst_calls_list[0],
 			uv_info.inst_calls_list[1],
 			uv_info.inst_calls_list[2],
@@ -344,7 +344,7 @@ static struct kobj_attribute uv_query_facilities_attr =
 static ssize_t uv_query_max_guest_cpus(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%d\n",
+	return scnprintf(page, PAGE_SIZE, "%d\n",
 			uv_info.max_guest_cpus);
 }
 
@@ -354,7 +354,7 @@ static struct kobj_attribute uv_query_max_guest_cpus_attr =
 static ssize_t uv_query_max_guest_vms(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%d\n",
+	return scnprintf(page, PAGE_SIZE, "%d\n",
 			uv_info.max_num_sec_conf);
 }
 
@@ -364,7 +364,7 @@ static struct kobj_attribute uv_query_max_guest_vms_attr =
 static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%lx\n",
+	return scnprintf(page, PAGE_SIZE, "%lx\n",
 			uv_info.max_sec_stor_addr);
 }
 
-- 
2.20.1

