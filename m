Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BECC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6FE20720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgEHEEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:04:45 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56332 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgEHEEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:04:45 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT2tH2rReeAEyAA--.21S2;
        Fri, 08 May 2020 12:04:24 +0800 (CST)
From:   Kaige Li <likaige@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] perf/core: Do not initialise statics to 0 and add space before '{'
Date:   Fri,  8 May 2020 12:04:23 +0800
Message-Id: <1588910663-9437-1-git-send-email-likaige@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxT2tH2rReeAEyAA--.21S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xJF13Ar43ZFyxKrWfKrg_yoW8JFWUpr
        ZrGrn0yayqq3WYvanrAF1vvw1UCa1xXFZ3Ga1vkw1xtFy5Gr95Wa4DWr13tr1YgrWIkFyY
        yw40qr1jv345ZFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r
        45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWU
        JVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUzwZDUU
        UUU==
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch errors:

ERROR: do not initialise statics to 0
#10616: FILE: ./kernel/events/core.c:10616:
+ static int hw_context_taken = 0;

ERROR: space required before the open brace '{'
#11070: FILE: ./kernel/events/core.c:11070:
+ } else if (is_write_backward(event)){

Signed-off-by: Kaige Li <likaige@loongson.cn>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cf996..8d47d30 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10618,7 +10618,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 
 skip_type:
 	if (pmu->task_ctx_nr == perf_hw_context) {
-		static int hw_context_taken = 0;
+		static int hw_context_taken;
 
 		/*
 		 * Other than systems with heterogeneous CPUs, it never makes
@@ -11072,7 +11072,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (overflow_handler) {
 		event->overflow_handler	= overflow_handler;
 		event->overflow_handler_context = context;
-	} else if (is_write_backward(event)){
+	} else if (is_write_backward(event)) {
 		event->overflow_handler = perf_event_output_backward;
 		event->overflow_handler_context = NULL;
 	} else {
-- 
2.1.0

