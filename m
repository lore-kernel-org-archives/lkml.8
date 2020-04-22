Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B1C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28007206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrdf/sGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDVGPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:15:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A0C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 23:15:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so563508pgj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 23:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cImNAiM8veWwWV4fNVSuLtzARU4L8YgFMKUsfNZoknU=;
        b=Rrdf/sGkps3Wh3pBfmrzuqxmgAD4H3mb3o0SSg23WHVU6vU6dQqsgw59ygdcBkvcn3
         MrtHTpDLSvoHXGx98k4+wZmh8QMqvT6laywNI5flyk1LNwlYBL1bS7RqccB2Os0xoPNi
         jSnhPddG5H9hqEkkUVyplbkTdAXqbprzZDaIQuuE84KLnzaDFT2TOK+doV/hdLmvAcEW
         UjRGzCYt1rZA0XCwPRJ6RMYsnQSabto16Hkr0rr1QivgM4KdPhboIOl/ZIrK5IXyvu7+
         nCGVa9BYjkknlbJbdaab7zA3xzVw5INz5/AlON6lzHZU+CG7qP9//5YWQisn9Xcc6FO3
         tMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cImNAiM8veWwWV4fNVSuLtzARU4L8YgFMKUsfNZoknU=;
        b=UpI36JoxXUDugrp7pxypx7vBJsnRTLL7UU22pKGA7QxKy6lLICxclD9qMESSlfyhND
         C31bghRZtvNxHrTpj3W+Es6u/mgXD6ZQrzQ+KEzo83OuHKlmGb6KlpLjUY7z6V8X5bv9
         SxFQNkgX8BWsmzzadtgHdoY1erG4KU+ssieYPQv5EvXnwNKlmG9KP8h98HPDk8smYjPL
         K5T/0X4HiVzAUcGlH8rovTrmpjTG+B3B87f1d+kxpfSZWytr96TBm3on/qEHVtxidyi2
         xdaG79fTfhPXL54SKSoDPEAPU+0pmedET1P9GXqAE8AMfwFJn43Yt1hyQ5twkGfPQsI9
         1L6g==
X-Gm-Message-State: AGi0PuaxEyYcbY6nHoWbNoofb3kCXuVHeoyJKlcsKsr2zdF2gkJbGSap
        EjxnxVz7U2W/8fMWEZlNmkAdjnxp
X-Google-Smtp-Source: APiQypI8XJ482MengytcRI5pNyL0eU2mx4M1hF4Tum549Gg17YgQlwBSiiJ+PBAflGVO8NJAEmhbmw==
X-Received: by 2002:a63:6bc3:: with SMTP id g186mr3873785pgc.364.1587536110881;
        Tue, 21 Apr 2020 23:15:10 -0700 (PDT)
Received: from cosmos ([122.181.63.84])
        by smtp.gmail.com with ESMTPSA id v32sm791820pgn.35.2020.04.21.23.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:15:10 -0700 (PDT)
Date:   Wed, 22 Apr 2020 11:45:06 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix memory leaks in trace_events_hist.c
Message-ID: <20200422061503.GA5151@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 kernel/trace/trace_events_hist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f6834a..fcab11c 100644
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
2.7.4

