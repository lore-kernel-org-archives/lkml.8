Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0080C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A898F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGEX3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 00:23:29 -0400
Received: from smtp.h3c.com ([221.12.31.13]:35769 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGEX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 00:23:28 -0400
X-Greylist: delayed 3576 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 00:23:27 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0473Nop1042756
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 11:23:50 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 0473NcBg042361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 May 2020 11:23:38 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 11:23:39 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <yubin@h3c.com>,
        <tian.xianting@h3c.com>
Subject: [PATCH] sched/fair: Fix typo in comment
Date:   Thu, 7 May 2020 11:18:53 +0800
Message-ID: <20200507031853.35994-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0473NcBg042361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_prempt_curr() -> check_preempt_curr()

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85..458ab5521 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6858,7 +6858,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_

        /*
         * This is possible from callers such as attach_tasks(), in which we
-        * unconditionally check_prempt_curr() after an enqueue (which may have
+        * unconditionally check_preempt_curr() after an enqueue (which may have
         * lead to a throttle).  This both saves work and prevents false
         * next-buddy nomination below.
         */
--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
邮件！
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
