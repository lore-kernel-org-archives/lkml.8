Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD098C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CC521556
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgDWXTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbgDWXTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:19:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537B520CC7;
        Thu, 23 Apr 2020 23:19:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRl7o-000Yri-7L; Thu, 23 Apr 2020 19:19:20 -0400
Message-Id: <20200423231920.111437253@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 19:18:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: [for-linus][PATCH 1/4] tracing: Fix memory leaks in trace_events_hist.c
References: <20200423231838.682478056@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>

kmemleak report 1:
    [<9092c50b>] kmem_cache_alloc_trace+0x138/0x270
    [<05a2c9ed>] create_field_var+0xcf/0x180
    [<528a2d68>] action_create+0xe2/0xc80
    [<63f50b61>] event_hist_trigger_func+0x15b5/0x1920
    [<28ea5d3d>] trigger_process_regex+0x7b/0xc0
    [<3138e86f>] event_trigger_write+0x4d/0xb0
    [<ffd66c19>] __vfs_write+0x30/0x200
    [<4f424a0d>] vfs_write+0x96/0x1b0
    [<da59a290>] ksys_write+0x53/0xc0
    [<3717101a>] __ia32_sys_write+0x15/0x20
    [<c5f23497>] do_fast_syscall_32+0x70/0x250
    [<46e2629c>] entry_SYSENTER_32+0xaf/0x102

This is because save_vars[] of struct hist_trigger_data are
not destroyed

kmemleak report 2:
    [<9092c50b>] kmem_cache_alloc_trace+0x138/0x270
    [<6e5e97c5>] create_var+0x3c/0x110
    [<de82f1b9>] create_field_var+0xaf/0x180
    [<528a2d68>] action_create+0xe2/0xc80
    [<63f50b61>] event_hist_trigger_func+0x15b5/0x1920
    [<28ea5d3d>] trigger_process_regex+0x7b/0xc0
    [<3138e86f>] event_trigger_write+0x4d/0xb0
    [<ffd66c19>] __vfs_write+0x30/0x200
    [<4f424a0d>] vfs_write+0x96/0x1b0
    [<da59a290>] ksys_write+0x53/0xc0
    [<3717101a>] __ia32_sys_write+0x15/0x20
    [<c5f23497>] do_fast_syscall_32+0x70/0x250
    [<46e2629c>] entry_SYSENTER_32+0xaf/0x102

struct hist_field allocated through create_var() do not initialize
"ref" field to 1. The code in __destroy_hist_field() does not destroy
object if "ref" is initialized to zero, the condition
if (--hist_field->ref > 1) always passes since unsigned int wraps.

kmemleak report 3:
    [<f8666fcc>] __kmalloc_track_caller+0x139/0x2b0
    [<bb7f80a5>] kstrdup+0x27/0x50
    [<39d70006>] init_var_ref+0x58/0xd0
    [<8ca76370>] create_var_ref+0x89/0xe0
    [<f045fc39>] action_create+0x38f/0xc80
    [<7c146821>] event_hist_trigger_func+0x15b5/0x1920
    [<07de3f61>] trigger_process_regex+0x7b/0xc0
    [<e87daf8f>] event_trigger_write+0x4d/0xb0
    [<19bf1512>] __vfs_write+0x30/0x200
    [<64ce4d27>] vfs_write+0x96/0x1b0
    [<a6f34170>] ksys_write+0x53/0xc0
    [<7d4230cd>] __ia32_sys_write+0x15/0x20
    [<8eadca00>] do_fast_syscall_32+0x70/0x250
    [<235cf985>] entry_SYSENTER_32+0xaf/0x102

hist_fields (system & event_name) are not freed

Link: http://lkml.kernel.org/r/20200422061503.GA5151@cosmos

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f6834a2bf41..fcab11cc6833 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3320,6 +3320,9 @@ static void __destroy_hist_field(struct hist_field *hist_field)
 	kfree(hist_field->name);
 	kfree(hist_field->type);
 
+	kfree(hist_field->system);
+	kfree(hist_field->event_name);
+
 	kfree(hist_field);
 }
 
@@ -4382,6 +4385,7 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	var->ref = 1;
 	var->flags = HIST_FIELD_FL_VAR;
 	var->var.idx = idx;
 	var->var.hist_data = var->hist_data = hist_data;
@@ -5011,6 +5015,9 @@ static void destroy_field_vars(struct hist_trigger_data *hist_data)
 
 	for (i = 0; i < hist_data->n_field_vars; i++)
 		destroy_field_var(hist_data->field_vars[i]);
+
+	for (i = 0; i < hist_data->n_save_vars; i++)
+		destroy_field_var(hist_data->save_vars[i]);
 }
 
 static void save_field_var(struct hist_trigger_data *hist_data,
-- 
2.26.1


