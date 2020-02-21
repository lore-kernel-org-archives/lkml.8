Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D2CC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155542469D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273535;
	bh=UvVanc2Y8drvz0lTCD+gBtMmeB+L03JmO7eGDGY6rxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=diI1s7wJeOm7fkEP3T0UBnQhn+RLGdkWAE/yLdMOSlv3YsoXRRdVNzBN8PWSamaY7
	 IPTDX7eD8u6N+ixq7ir7wQBne2kY7dNCHaPVNsu8bYR3XBPgfq9hLJnm1nJgzFyiHC
	 H8+AnXsxva8780YeMDz6y2Zb2bdjzdEwI01Nr2+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgBUIZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388482AbgBUIZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:25:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AED246AA;
        Fri, 21 Feb 2020 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273511;
        bh=UvVanc2Y8drvz0lTCD+gBtMmeB+L03JmO7eGDGY6rxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDWDsbiE2g6sVnkLhYoLSynQunmp2OVTjF5Nik9CNVREsqHjJg9en4h3DgzhSxuho
         j+J0L32+Tp5VQrZLWDpOYHXtPmS3exmqvIjuJ/B82ZKqJIaZV2a6VNQo0Hh2vamdZ1
         25Z/1DM0RkvTtqn4GqtVxY3x9uJahz4TR/Gg9uA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 174/191] trigger_next should increase position index
Date:   Fri, 21 Feb 2020 08:42:27 +0100
Message-Id: <20200221072311.633212807@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 6722b23e7a2ace078344064a9735fb73e554e9ef ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

Without patch:
 # dd bs=30 skip=1 if=/sys/kernel/tracing/events/sched/sched_switch/trigger
 dd: /sys/kernel/tracing/events/sched/sched_switch/trigger: cannot skip to specified offset
 n traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
 # Available triggers:
 # traceon traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
 6+1 records in
 6+1 records out
 206 bytes copied, 0.00027916 s, 738 kB/s

Notice the printing of "# Available triggers:..." after the line.

With the patch:
 # dd bs=30 skip=1 if=/sys/kernel/tracing/events/sched/sched_switch/trigger
 dd: /sys/kernel/tracing/events/sched/sched_switch/trigger: cannot skip to specified offset
 n traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
 2+1 records in
 2+1 records out
 88 bytes copied, 0.000526867 s, 167 kB/s

It only prints the end of the file, and does not restart.

Link: http://lkml.kernel.org/r/3c35ee24-dd3a-8119-9c19-552ed253388a@virtuozzo.com

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_trigger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index b05d1b6a62911..9300e8bbf08ac 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -115,9 +115,10 @@ static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
 {
 	struct trace_event_file *event_file = event_file_data(m->private);
 
-	if (t == SHOW_AVAILABLE_TRIGGERS)
+	if (t == SHOW_AVAILABLE_TRIGGERS) {
+		(*pos)++;
 		return NULL;
-
+	}
 	return seq_list_next(t, &event_file->triggers, pos);
 }
 
-- 
2.20.1



