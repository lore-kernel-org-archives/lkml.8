Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7262078B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgGHGcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:32:19 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:33968 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgGHGcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:32:18 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-03 (Coremail) with SMTP id rQCowAD3ePioZQVfC8ppAw--.13022S2;
        Wed, 08 Jul 2020 14:20:24 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, chris@zankel.net,
        jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-xtensa@linux-xtensa.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] kernel: perf_event: use for_each_set_bit() to simplify the code
Date:   Wed,  8 Jul 2020 06:20:23 +0000
Message-Id: <20200708062023.7986-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAD3ePioZQVfC8ppAw--.13022S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryDCw1rGF18Zr18Jr1rCrg_yoWDJwc_JF
        4xJa4kWF1Fkan0v34DJr4rtryFq398Ka4ruw1vgayDGr15W345Aw18J34UXrWUursa9w18
        KF95WFZ8XF129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfU589NDUUUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCAQLA102YQ9nfwAAsZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using for_each_set_bit() to simplify the code.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 arch/xtensa/kernel/perf_event.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index 9bae79f70301..99fcd63ce597 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -362,9 +362,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id)
 	struct xtensa_pmu_events *ev = this_cpu_ptr(&xtensa_pmu_events);
 	unsigned i;
 
-	for (i = find_first_bit(ev->used_mask, XCHAL_NUM_PERF_COUNTERS);
-	     i < XCHAL_NUM_PERF_COUNTERS;
-	     i = find_next_bit(ev->used_mask, XCHAL_NUM_PERF_COUNTERS, i + 1)) {
+	for_each_set_bit(i, ev->used_mask, XCHAL_NUM_PERF_COUNTERS) {
 		uint32_t v = get_er(XTENSA_PMU_PMSTAT(i));
 		struct perf_event *event = ev->event[i];
 		struct hw_perf_event *hwc = &event->hw;
-- 
2.17.1

