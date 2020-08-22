Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C207FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2023207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Hy08vYzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHVJxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:53:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B510C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:53:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q93so1776405pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AA4QvqZ8G3UUgWk56L6siBEVYBlQ7DKtEof4BU/gmnM=;
        b=Hy08vYzbJ2PXLCKeaQ8gMOUe5NEBsJHKUF3pXyca6ilV/ucXow/JiUg6qZKy2iL14I
         4gM6qgv9d3Hpktgt722p6TTGFt9m5EXNQWFQafd65aD8q5URNVlW4HuD/16xYbKayopp
         ppWSbM5gpm2h9jQRzRfPHuYv/ChyvWGH8OfGw2uD3QLz9ZSrPvrSKxrGK12c1/Ve2YEv
         ydDNukJRr3Fp2rWaQX/jLpgaFtKouvt9pvF/qC7uxQcnpvKiUh0FIuuDU/JY3dBA77Ak
         +xaQ5ef9Ten+QwSHX+Y9gdq+4py32DSzTve84iV272hi//du1s++RPXnNKIMwLBVwEGa
         pl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AA4QvqZ8G3UUgWk56L6siBEVYBlQ7DKtEof4BU/gmnM=;
        b=hGpwMT7ov/3tpZnd6DEHVLd9uTGGnrbvYthY6j1CYiLLE9XduIG2VmHBbPCRJNAl65
         aPI9Tq9R6btij3SgkzJr0JarFSbce2VIg+6Evi0uHL/Lt0BlUgkmYmOkisVMJn60Idme
         8AQk3Tgu/FgZ/Kb31meRpboIDxdNJ74km3LT94FxiNRaUbGIMjzZ71owG3CVvl3pzoY+
         rkYVl0FFyJUeN8qpYEQAScLdnN7NZ3magGBP4q3E0zhORALkSDIbk9pwFs29DEQ2DmnP
         2/8BaSsgYm4HNVY8+8c25z4JELQEHsKcK8mzSo5H2u41DyoLAf0TN4S+izPsarI4Emd3
         AoLA==
X-Gm-Message-State: AOAM531/CXxu6ELubkCC3LmwpneAL9X2G8aCVMexWhMo9KRO8WfZyW3M
        f64Z20wFdt98sqbBQlb/w8nmtw==
X-Google-Smtp-Source: ABdhPJwCdC0vX5RwrRTQazcUNEUWzmuBbBvU1mkKSWh2/76IuEPrmpkdMhhiFvoPI3tn7Nm5ZeXcFw==
X-Received: by 2002:a17:902:b714:: with SMTP id d20mr5636180pls.103.1598090031269;
        Sat, 22 Aug 2020 02:53:51 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm4972397pfo.49.2020.08.22.02.53.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2020 02:53:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     npiggin@suse.de, agl@us.ibm.com, ak@linux.intel.com,
        nacc@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/hugetlb: Fix a race between hugetlb sysctl handlers
Date:   Sat, 22 Aug 2020 17:53:28 +0800
Message-Id: <20200822095328.61306-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between the assignment of `table->data` and write value
to the pointer of `table->data` in the __do_proc_doulongvec_minmax().
Fix this by duplicating the `table`, and only update the duplicate of
it. And introduce a helper of proc_hugetlb_doulongvec_minmax() to
simplify the code.

The following oops was seen:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor instruction fetch in kernel mode
    #PF: error_code(0x0010) - not-present page
    Code: Bad RIP value.
    ...
    Call Trace:
     ? set_max_huge_pages+0x3da/0x4f0
     ? alloc_pool_huge_page+0x150/0x150
     ? proc_doulongvec_minmax+0x46/0x60
     ? hugetlb_sysctl_handler_common+0x1c7/0x200
     ? nr_hugepages_store+0x20/0x20
     ? copy_fd_bitmaps+0x170/0x170
     ? hugetlb_sysctl_handler+0x1e/0x20
     ? proc_sys_call_handler+0x2f1/0x300
     ? unregister_sysctl_table+0xb0/0xb0
     ? __fd_install+0x78/0x100
     ? proc_sys_write+0x14/0x20
     ? __vfs_write+0x4d/0x90
     ? vfs_write+0xef/0x240
     ? ksys_write+0xc0/0x160
     ? __ia32_sys_read+0x50/0x50
     ? __close_fd+0x129/0x150
     ? __x64_sys_write+0x43/0x50
     ? do_syscall_64+0x6c/0x200
     ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a301c2d672bf..818d6125af49 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3454,6 +3454,23 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 }
 
 #ifdef CONFIG_SYSCTL
+static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
+					  void *buffer, size_t *length,
+					  loff_t *ppos, unsigned long *out)
+{
+	struct ctl_table dup_table;
+
+	/*
+	 * In order to avoid races with __do_proc_doulongvec_minmax(), we
+	 * can duplicate the @table and alter the duplicate of it.
+	 */
+	dup_table = *table;
+	dup_table.data = out;
+	dup_table.maxlen = sizeof(unsigned long);
+
+	return proc_doulongvec_minmax(&dup_table, write, buffer, length, ppos);
+}
+
 static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 			 struct ctl_table *table, int write,
 			 void *buffer, size_t *length, loff_t *ppos)
@@ -3465,9 +3482,8 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	if (!hugepages_supported())
 		return -EOPNOTSUPP;
 
-	table->data = &tmp;
-	table->maxlen = sizeof(unsigned long);
-	ret = proc_doulongvec_minmax(table, write, buffer, length, ppos);
+	ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
+					     &tmp);
 	if (ret)
 		goto out;
 
@@ -3510,9 +3526,8 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 	if (write && hstate_is_gigantic(h))
 		return -EINVAL;
 
-	table->data = &tmp;
-	table->maxlen = sizeof(unsigned long);
-	ret = proc_doulongvec_minmax(table, write, buffer, length, ppos);
+	ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
+					     &tmp);
 	if (ret)
 		goto out;
 
-- 
2.11.0

