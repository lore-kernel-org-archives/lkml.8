Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D85C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504CF20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgEKLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:21:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgEKLVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:21:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF5F05D704CED6D715BE;
        Mon, 11 May 2020 19:21:11 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 19:21:05 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <wangle6@huawei.com>
Subject: [PATCH] trace: Remove duplicate semicolons at the end of line
Date:   Mon, 11 May 2020 19:21:02 +0800
Message-ID: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate semicolons at the end of line in
include/trace/events/iocost.h

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 include/trace/events/iocost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index 7ecaa65b..91297eb 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -152,7 +152,7 @@
 
 	TP_fast_assign(
 		__assign_str(devname, ioc_name(ioc));
-		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
+		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
 		__entry->read_missed_ppm = (*missed_ppm)[READ];
-- 
1.8.5.6

