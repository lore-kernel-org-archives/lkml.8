Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D4C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3688D206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255297;
	bh=PTwnaw8WZ8eWuAsZfw1G06EkIOWxvTsKmQGqoeB6scU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXl0PQMxowBe9VT24rqmxKwO4qe7GTowZZIGSq0SC8No72Uz9dcDYYrioME9sUqGm
	 2Gq++S2iSOVG2URXtEnPvUjdFpOg7mVhucYg75JfWhtp72WIsH7L8mjzpEQ036LPba
	 E5ymswpIBv3P+hUvyz/AmoiiToUZhtDzcV3W4QeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgD3OBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgD3Nxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F84B20774;
        Thu, 30 Apr 2020 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254834;
        bh=PTwnaw8WZ8eWuAsZfw1G06EkIOWxvTsKmQGqoeB6scU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIvEj1gh5OxSKM9MwifupimrdTK2gwxdrzrpXgrnVWKq8ZAYwMFwa56ORC4dhf31e
         UMGsYpCIcNVR0SaMNkqh6t95PdPEGAUVHIjFlgBLVjqF+KNYmpFdJJi7uxxLGYV6u8
         jQc+5ETdmUpxIUtRWsxQgDsYvEHjDiT0Sk/oNLqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>, KP Singh <kpsingh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 26/30] perf/core: fix parent pid/tid in task exit events
Date:   Thu, 30 Apr 2020 09:53:21 -0400
Message-Id: <20200430135325.20762-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135325.20762-1-sashal@kernel.org>
References: <20200430135325.20762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit f3bed55e850926614b9898fe982f66d2541a36a5 ]

Current logic yields the child task as the parent.

Before:
$ perf record bash -c "perf list > /dev/null"
$ perf script -D |grep 'FORK\|EXIT'
4387036190981094 0x5a70 [0x30]: PERF_RECORD_FORK(10472:10472):(10470:10470)
4387036606207580 0xf050 [0x30]: PERF_RECORD_EXIT(10472:10472):(10472:10472)
4387036607103839 0x17150 [0x30]: PERF_RECORD_EXIT(10470:10470):(10470:10470)
                                                   ^
  Note the repeated values here -------------------/

After:
383281514043 0x9d8 [0x30]: PERF_RECORD_FORK(2268:2268):(2266:2266)
383442003996 0x2180 [0x30]: PERF_RECORD_EXIT(2268:2268):(2266:2266)
383451297778 0xb70 [0x30]: PERF_RECORD_EXIT(2266:2266):(2265:2265)

Fixes: 94d5d1b2d891 ("perf_counter: Report the cloning task as parent on perf_counter_fork()")
Reported-by: KP Singh <kpsingh@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200417182842.12522-1-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 00fb2fe92c4d6..21e3c65abc76f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6923,10 +6923,17 @@ static void perf_event_task_output(struct perf_event *event,
 		goto out;
 
 	task_event->event_id.pid = perf_event_pid(event, task);
-	task_event->event_id.ppid = perf_event_pid(event, current);
-
 	task_event->event_id.tid = perf_event_tid(event, task);
-	task_event->event_id.ptid = perf_event_tid(event, current);
+
+	if (task_event->event_id.header.type == PERF_RECORD_EXIT) {
+		task_event->event_id.ppid = perf_event_pid(event,
+							task->real_parent);
+		task_event->event_id.ptid = perf_event_pid(event,
+							task->real_parent);
+	} else {  /* PERF_RECORD_FORK */
+		task_event->event_id.ppid = perf_event_pid(event, current);
+		task_event->event_id.ptid = perf_event_tid(event, current);
+	}
 
 	task_event->event_id.time = perf_event_clock(event);
 
-- 
2.20.1

