Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D11C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0888208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEHMH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:07:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4305 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgEHMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:07:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3F83352ABC14E86219A9;
        Fri,  8 May 2020 20:07:24 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 20:07:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] mm/page_io.c: remove an unnecessary goto in generic_swapfile_activate()
Date:   Fri, 8 May 2020 20:06:40 +0800
Message-ID: <20200508120640.1852-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200508120640.1852-1-thunder.leizhen@huawei.com>
References: <20200508120640.1852-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "goto" doesn't reduce any code, but bother the readers.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..19d429abb2cc 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -237,8 +237,7 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	return ret;
 bad_bmap:
 	pr_err("swapon: swapfile has holes\n");
-	ret = -EINVAL;
-	goto out;
+	return -EINVAL;
 }
 
 /*
-- 
2.26.0.106.g9fadedd


