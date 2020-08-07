Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB8722CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596818988;
	bh=KHVc4rrVB6GP4qW47T9z4oMwM3NEJSyq8XjBsOgInEM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nfdiu4jKiEJHOSndSY0C9sWREhAT3b+ioyoTUTBNWMv5Noc56QJYrnuLMfso5kbob
	 BtnCA7ewbU2wMyevnR5neXprcKogbhZHpSI5+Ur7oD7TQBewpmxBs3TWCq1e3L7aru
	 FQnw7j6i05ASfDOlkrf+VCiaQR+U2cRdPBXMop7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHGQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:49:42 -0400
Received: from C02YQ0RWLVCF.internal.digitalocean.com (c-73-181-34-237.hsd1.co.comcast.net [73.181.34.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B073221E2;
        Fri,  7 Aug 2020 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596818982;
        bh=KHVc4rrVB6GP4qW47T9z4oMwM3NEJSyq8XjBsOgInEM=;
        h=From:To:Cc:Subject:Date:From;
        b=TL+CSt5XVsQaa6jumRqvwFKl2fIOF64PnjWWi/oqjRlQWW82I5ft1LBIAyP1sq6R7
         DdM/eUuAPhNDn9Ch9g953vj3qEM941trBZwcHvlDXHl8F1j57A/Q0afSpR9SvEyXdM
         s4nT1KnC5ovFX78Un0NGy12Y/I6A1oEFwThisobE=
From:   David Ahern <dsahern@kernel.org>
To:     acme@kernel.org
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH 2/2] perf sched timehist: Fix use of CPU list with summary option
Date:   Fri,  7 Aug 2020 10:49:37 -0600
Message-Id: <20200807164937.44921-1-dsahern@kernel.org>
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
 tools/perf/builtin-sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0c7d599fa555..82ee0dfd1831 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2575,7 +2575,8 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	}
 
 	if (!sched->idle_hist || thread->tid == 0) {
-		timehist_update_runtime_stats(tr, t, tprev);
+		if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
+			timehist_update_runtime_stats(tr, t, tprev);
 
 		if (sched->idle_hist) {
 			struct idle_thread_runtime *itr = (void *)tr;
@@ -2848,6 +2849,9 @@ static void timehist_print_summary(struct perf_sched *sched,
 
 	printf("\nIdle stats:\n");
 	for (i = 0; i < idle_max_cpu; ++i) {
+		if (!test_bit(i, cpu_bitmap))
+			continue;
+
 		t = idle_threads[i];
 		if (!t)
 			continue;
-- 
2.17.1

