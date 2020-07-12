Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 01:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EB1206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 01:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGLBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 21:11:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46134 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgGLBLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 21:11:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2PN-4G_1594516291;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2PN-4G_1594516291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Jul 2020 09:11:31 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 0/4] tracing: trivial cleanup
Date:   Sun, 12 Jul 2020 09:10:32 +0800
Message-Id: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some trivial cleanup for tracing.

v2:
  * drop patch 1
  * merge patch 4 & 5
  * introduce a new patch change the return value of tracing_init_dentry()

Wei Yang (4):
  tracing: simplify the logic by defining next to be "lasst + 1"
  tracing: save one trace_event->type by using __TRACE_LAST_TYPE
  tracing: toplevel d_entry already initialized
  tracing: make tracing_init_dentry() returns an integer instead of a
    d_entry pointer

 kernel/trace/trace.c                 | 36 ++++++++++++++--------------
 kernel/trace/trace.h                 |  2 +-
 kernel/trace/trace_dynevent.c        |  8 +++----
 kernel/trace/trace_events.c          |  9 ++-----
 kernel/trace/trace_events_synth.c    |  9 +++----
 kernel/trace/trace_functions_graph.c |  8 +++----
 kernel/trace/trace_hwlat.c           |  8 +++----
 kernel/trace/trace_kprobe.c          | 10 ++++----
 kernel/trace/trace_output.c          | 14 +++++------
 kernel/trace/trace_printk.c          |  8 +++----
 kernel/trace/trace_stack.c           | 12 +++++-----
 kernel/trace/trace_stat.c            |  8 +++----
 kernel/trace/trace_uprobe.c          |  9 ++++---
 13 files changed, 66 insertions(+), 75 deletions(-)

-- 
2.20.1 (Apple Git-117)

