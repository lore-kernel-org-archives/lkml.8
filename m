Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D988C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F292071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgFPMiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:38:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43326 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgFPMiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:38:00 -0400
Received: from localhost.localdomain (unknown [114.242.248.106])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH98Lvehev3dEAA--.118S2;
        Tue, 16 Jun 2020 20:37:36 +0800 (CST)
From:   Lichao Liu <liulichao@loongson.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Lichao Liu <liulichao@loongson.cn>
Subject: [PATCH] sched/rt: Don't active rt throtting when no running cfs task
Date:   Tue, 16 Jun 2020 20:37:29 +0800
Message-Id: <20200616123729.153430-1-liulichao@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxH98Lvehev3dEAA--.118S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1kZw18urW7Jr43ZrW5Wrg_yoWfuFXEg3
        4Ygr18C3yqywn0kw1fJa4rWFZ5K3y5CF1jv3W8KFnrJrW8tFn0yrn8WFsxA3Z5ZryxCF9r
        ArnrKFn5Crn7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: xolxzxpfkd0qxorr0wxvrqhubq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active rt throtting will dequeue rt_rq from rq at least 50ms,
When there is no running cfs task, do we still active it?

Signed-off-by: Lichao Liu <liulichao@loongson.cn>
---
 kernel/sched/rt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index df11d88c9895..d6524347cea0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -961,12 +961,13 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 
 	if (rt_rq->rt_time > runtime) {
 		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
+		struct rq *rq = rq_of_rt_rq(rt_rq);
 
 		/*
 		 * Don't actually throttle groups that have no runtime assigned
 		 * but accrue some time due to boosting.
 		 */
-		if (likely(rt_b->rt_runtime)) {
+		if (likely(rt_b->rt_runtime) && rq->cfs.nr_running > 0) {
 			rt_rq->rt_throttled = 1;
 			printk_deferred_once("sched: RT throttling activated\n");
 		} else {
-- 
2.25.1

