Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572F320716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597685079;
	bh=XmC5Gbza5UeU7Kf72z5M/6CooUNadr7oFKBfdMzI/hI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F3qXb9SX8vL4T1/S7XoOohxWDodbQ2ZT0+UbruPPsj0naC6+jBr96RV8iED90ssDj
	 eALu2/OfV9YJirXaBM0XlV7nQoCH+Qb2DkaeKfI2nPpxWMoXuApkycYDc+jwJfYIrJ
	 uImLi+oLmTEChvRFb7bhuQIsg7HXmWMaaeROTDn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbgHQRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389374AbgHQRJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:09:46 -0400
Received: from C02YQ0RWLVCF.internal.digitalocean.com (c-73-181-34-237.hsd1.co.comcast.net [73.181.34.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B112067C;
        Mon, 17 Aug 2020 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597684186;
        bh=XmC5Gbza5UeU7Kf72z5M/6CooUNadr7oFKBfdMzI/hI=;
        h=From:To:Cc:Subject:Date:From;
        b=XkUjBtMbVva/OY7CzF1LahcEjL8C890OUAu71IqHsKw1n2JQK/0OElj9Omb497+58
         6Ir8EmgDXmpnk2c6zTXhg4S+33hc/vEUE1sp8wgMsmQosxaxSSpfOjw40z8pT8f2PH
         VfAuUuRjdyPm8PZzNm7/DL/p4QsPWb7wmciBORRA=
From:   David Ahern <dsahern@kernel.org>
To:     acme@kernel.org
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH v2] perf sched timehist: Fix use of CPU list with summary option
Date:   Mon, 17 Aug 2020 11:09:42 -0600
Message-Id: <20200817170943.1486-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not update thread stats or show idle summary unless CPU is in
the list of interest.

Fixes: c30d630d1bcf ("perf sched timehist: Add support for filtering on CPU")
Signed-off-by: David Ahern <dsahern@kernel.org>
---
v2
- check that cpu_list is set before checking cpu_bitmap in timehist_print_summary
 
 tools/perf/builtin-sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0c7d599fa555..e6fc297cee91 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2584,7 +2584,8 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	}
 
 	if (!sched->idle_hist || thread->tid == 0) {
-		timehist_update_runtime_stats(tr, t, tprev);
+		if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
+			timehist_update_runtime_stats(tr, t, tprev);
 
 		if (sched->idle_hist) {
 			struct idle_thread_runtime *itr = (void *)tr;
@@ -2857,6 +2858,9 @@ static void timehist_print_summary(struct perf_sched *sched,
 
 	printf("\nIdle stats:\n");
 	for (i = 0; i < idle_max_cpu; ++i) {
+		if (cpu_list && !test_bit(i, cpu_bitmap))
+			continue;
+
 		t = idle_threads[i];
 		if (!t)
 			continue;
-- 
2.17.1

