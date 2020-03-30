Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E25D2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgC3CSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:18:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbgC3CSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:18:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31DAE3ED48BD469060FE;
        Mon, 30 Mar 2020 10:18:44 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 10:18:34 +0800
To:     <ebiederm@xmission.com>, <christian.brauner@ubuntu.com>,
        <oleg@redhat.com>, <tj@kernel.org>, <guro@fb.com>,
        <joel@joelfernandes.org>, <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] signal: check sig before setting info in kill_pid_usb_asyncio
Message-ID: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
Date:   Mon, 30 Mar 2020 10:18:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In kill_pid_usb_asyncio, if signal is not valid, we do not need to
set info struct.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ad8dea93dbb..9cdc9e388a19 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1505,15 +1505,15 @@ int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
 	unsigned long flags;
 	int ret = -EINVAL;

+	if (!valid_signal(sig))
+		return ret;
+
 	clear_siginfo(&info);
 	info.si_signo = sig;
 	info.si_errno = errno;
 	info.si_code = SI_ASYNCIO;
 	*((sigval_t *)&info.si_pid) = addr;

-	if (!valid_signal(sig))
-		return ret;
-
 	rcu_read_lock();
 	p = pid_task(pid, PIDTYPE_PID);
 	if (!p) {
-- 
2.19.1

