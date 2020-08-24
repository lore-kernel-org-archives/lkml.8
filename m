Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA85F208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHXMA4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:00:56 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbgHXMAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:00:51 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 84CA87428669B52813CB;
        Mon, 24 Aug 2020 20:00:46 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 24 Aug 2020 20:00:46 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 24 Aug 2020 20:00:46 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Use wake_up_worker() to wake up first idle
 worker
Thread-Topic: [PATCH] workqueue: Use wake_up_worker() to wake up first idle
 worker
Thread-Index: AdZ6DhGFtArQTEKrSf6L16rQh15u4w==
Date:   Mon, 24 Aug 2020 12:00:45 +0000
Message-ID: <c2121f0611924681841799695bfbe50f@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping :)

>Miaohe Lin <linmiaohe@huawei.com> wrote:
>From: Miaohe Lin <linmiaohe@huawei.com>
>
>Use wrapper function wake_up_worker() to wake up first idle worker.
>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>---
> kernel/workqueue.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/kernel/workqueue.c b/kernel/workqueue.c index c41c3c17b86a..5302f227f38f 100644
>--- a/kernel/workqueue.c
>+++ b/kernel/workqueue.c
>@@ -864,7 +864,7 @@ void wq_worker_running(struct task_struct *task)
>  */
> void wq_worker_sleeping(struct task_struct *task)  {
>-	struct worker *next, *worker = kthread_data(task);
>+	struct worker *worker = kthread_data(task);
> 	struct worker_pool *pool;
> 
> 	/*
>@@ -896,11 +896,9 @@ void wq_worker_sleeping(struct task_struct *task)
> 	 * lock is safe.
> 	 */
> 	if (atomic_dec_and_test(&pool->nr_running) &&
>-	    !list_empty(&pool->worklist)) {
>-		next = first_idle_worker(pool);
>-		if (next)
>-			wake_up_process(next->task);
>-	}
>+	    !list_empty(&pool->worklist))
>+		wake_up_worker(pool);
>+
> 	raw_spin_unlock_irq(&pool->lock);
> }
> 
>--
>2.19.1
>
