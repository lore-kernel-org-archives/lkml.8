Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2162C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABF9206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdx0bfqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgFOOar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgFOOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:30:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10319C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:30:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so7220226pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N4MV/2ssU6mwZxWqGE2MgU42SIyU17mHNixbYYrV7Qw=;
        b=qdx0bfqHe72klnA3i1cIFjVOxwx6PH9FuWRHKid0/vbSSxsQeDeiJIHzS1MBg/hllc
         92q8cEuOLPSmlkWS76hqxWXvlqy7P2YSKYZgh0cbCllqLLhmPSinykBPXjNMsCo1GSI/
         mOhheS1KfGwxpDOS8EzF3xly8ZqZAHKdq4tkGKe9+Y91Ri0dqWjxWTi7f6ZbYUDo5TV0
         PJLL6m/jh3W6b92pTrMk6i/yYFz10Quz1/+0iT2ymfUbOnoPkBRUpKkehQW3uUIjAsoa
         5F2rhrJuVLNJPtTA+ifhytVjBAWtYTRTQxfPGWD6e/9GttbMr6W34WmsAiEE9fsgoUy9
         LCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N4MV/2ssU6mwZxWqGE2MgU42SIyU17mHNixbYYrV7Qw=;
        b=aUptomwBhfI0hJWlXp7vhI2G98zZdAxFunQv+VZ24aMNCVsAJ0bd4E9H/Kwdv+e4S4
         80VzHURD2u2fU5sCsobPXZXJJTvPQAzvA8teHUjbL2+QhDdRZlo8U5f7r/BqRXGE/f/A
         2vbVJ5Ubu8L/Ughxm72F+H9ESXKcRdZzBmrku46RFC2KPJCMgvZZaotSSXGRuYhKvups
         QgJ93s8bJrdr7HIXpNWEN+JjAQgIxLkILcA4GyVkfsEaTZJmGh1pNJhXk5vo1KKUglWE
         AKzpzNAA5UAXpNQwvdM9GKFBOBVKLcoFoKzaAtdE3SmV8D+AHK6qgXrlWo59j++CmCQg
         ebXQ==
X-Gm-Message-State: AOAM531Px4T12JHPvzUrd/WtDqpajd9MSgZjZHrz+nEfVZO79cpbcfGA
        XdA7D4He3EeJW4/QhRUDhHh/V4dt
X-Google-Smtp-Source: ABdhPJxf+43CsHURjdWg1312Ch0xPd28xmc7zfjwZ4Kk2lsWRiHUHwV1l96GnsJBCShOX9mhlDwlbA==
X-Received: by 2002:a17:902:fe95:: with SMTP id x21mr22918316plm.17.1592231442590;
        Mon, 15 Jun 2020 07:30:42 -0700 (PDT)
Received: from cosmos ([122.171.238.207])
        by smtp.gmail.com with ESMTPSA id hv15sm12793715pjb.17.2020.06.15.07.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:30:42 -0700 (PDT)
Date:   Mon, 15 Jun 2020 20:00:38 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/probe: fix memleak in fetch_op_data operations
Message-ID: <20200615143034.GA1734@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak report:
    [<57dcc2ca>] __kmalloc_track_caller+0x139/0x2b0
    [<f1c45d0f>] kstrndup+0x37/0x80
    [<f9761eb0>] parse_probe_arg.isra.7+0x3cc/0x630
    [<055bf2ba>] traceprobe_parse_probe_arg+0x2f5/0x810
    [<655a7766>] trace_kprobe_create+0x2ca/0x950
    [<4fc6a02a>] create_or_delete_trace_kprobe+0xf/0x30
    [<6d1c8a52>] trace_run_command+0x67/0x80
    [<be812cc0>] trace_parse_run_command+0xa7/0x140
    [<aecfe401>] probes_write+0x10/0x20
    [<2027641c>] __vfs_write+0x30/0x1e0
    [<6a4aeee1>] vfs_write+0x96/0x1b0
    [<3517fb7d>] ksys_write+0x53/0xc0
    [<dad91db7>] __ia32_sys_write+0x15/0x20
    [<da347f64>] do_syscall_32_irqs_on+0x3d/0x260
    [<fd0b7e7d>] do_fast_syscall_32+0x39/0xb0
    [<ea5ae810>] entry_SYSENTER_32+0xaf/0x102

Post parse_probe_arg(), the FETCH_OP_DATA operation type is overwritten
to FETCH_OP_ST_STRING, as a result memory is never freed since
traceprobe_free_probe_arg() iterates only over SYMBOL and DATA op types

Setup fetch string operation correctly after fetch_op_data operation.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 kernel/trace/trace_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b8a928e..d2867cc 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -639,8 +639,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			ret = -EINVAL;
 			goto fail;
 		}
-		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM) ||
-		     parg->count) {
+		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
+		     code->op == FETCH_OP_DATA) || parg->count) {
 			/*
 			 * IMM, DATA and COMM is pointing actual address, those
 			 * must be kept, and if parg->count != 0, this is an
-- 
2.7.4

