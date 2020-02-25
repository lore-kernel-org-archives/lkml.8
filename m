Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6283C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43D720637
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgBYMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:41:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbgBYMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:41:21 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CA47237A79C3964632B6;
        Tue, 25 Feb 2020 20:41:12 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 20:41:04 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <paulmck@kernel.org>, <tj@kernel.org>, <jiangshanlai@gmail.com>,
        <wanghaibin.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] Documentation: kthread: Fix WQ_SYSFS workqueues path name
Date:   Tue, 25 Feb 2020 20:40:52 +0800
Message-ID: <20200225124052.1506-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set of WQ_SYSFS workqueues should be displayed using
"ls /sys/devices/virtual/workqueue", add the missing '/'.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index baeeba8762ae..21818aca4708 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -234,7 +234,7 @@ To reduce its OS jitter, do any of the following:
 	Such a workqueue can be confined to a given subset of the
 	CPUs using the ``/sys/devices/virtual/workqueue/*/cpumask`` sysfs
 	files.	The set of WQ_SYSFS workqueues can be displayed using
-	"ls sys/devices/virtual/workqueue".  That said, the workqueues
+	"ls /sys/devices/virtual/workqueue".  That said, the workqueues
 	maintainer would like to caution people against indiscriminately
 	sprinkling WQ_SYSFS across all the workqueues.	The reason for
 	caution is that it is easy to add WQ_SYSFS, but because sysfs is
-- 
2.19.1


