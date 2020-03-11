Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgCKQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:12:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id t11so3400093wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:12:45 -0700 (PDT)
From: Jack Wang <jinpu.wang@cloud.ionos.com>
To: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 01/26] sysfs: export sysfs_remove_file_self()
Date: Wed, 11 Mar 2020 17:12:15 +0100
Message-Id: <20200311161240.30190-2-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 130fc6fbcc03..1ff4672d7746 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.17.1

