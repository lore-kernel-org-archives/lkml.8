Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5517720747
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGCEzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:55:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgGCEzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:55:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 747E7F9BDDF3B4225495;
        Fri,  3 Jul 2020 12:55:21 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 12:55:14 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] locktorture: make function torture_percpu_rwsem_init() static
Date:   Fri, 3 Jul 2020 13:05:27 +0800
Message-ID: <20200703050527.67249-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

kernel/locking/locktorture.c:569:6: warning:
 symbol 'torture_percpu_rwsem_init' was not declared. Should it be static?

And this function is not used outside of locktorture.c,
so this commit marks it static.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/locking/locktorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9cfa5e89cff7..62d215b2e39f 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -566,7 +566,7 @@ static struct lock_torture_ops rwsem_lock_ops = {
 #include <linux/percpu-rwsem.h>
 static struct percpu_rw_semaphore pcpu_rwsem;
 
-void torture_percpu_rwsem_init(void)
+static void torture_percpu_rwsem_init(void)
 {
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }

