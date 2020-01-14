Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BFDC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717E324686
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996676;
	bh=8W7dvBwMRQLuHVRZsMPvivPXSG58cKKOr57Wv6sdDI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xg4gL2MI4op3Dd5ltoAAJ+XzFIn2UI3sCBFHwNUiQ2xwuDfNYVCxajW1UlRMfyg18
	 HaYFUV3v/sJI1UUcVBMQAhySiAMb77BNp5Bs29qdqOvDiH7iX2uavbwwKwPEkeGRhs
	 yG7dH16KeITsPU2vebZuyQx4XIPyJwD8OVUGRK9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgANKLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbgANKLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C2124687;
        Tue, 14 Jan 2020 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996670;
        bh=8W7dvBwMRQLuHVRZsMPvivPXSG58cKKOr57Wv6sdDI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3rxuf2StITQYBVMOnSQQewZuNoIlyiGEGONXGMbVz6kKYqc8VAkqLjIU/DJWc3Sf
         jvuEDaFVJ05IpxBrAJWWHitT7VYDHDEZsIxcUSbMV8rrExne66+FU3TBwJdtEizlop
         iOF8RpRdAjmlBBgr0MEizXYG+i3Qm7pgHubmVeTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kaitao Cheng <pilgrimtao@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 06/31] kernel/trace: Fix do not unregister tracepoints when register sched_migrate_task fail
Date:   Tue, 14 Jan 2020 11:01:58 +0100
Message-Id: <20200114094340.855869396@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
References: <20200114094334.725604663@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

commit 50f9ad607ea891a9308e67b81f774c71736d1098 upstream.

In the function, if register_trace_sched_migrate_task() returns error,
sched_switch/sched_wakeup_new/sched_wakeup won't unregister. That is
why fail_deprobe_sched_switch was added.

Link: http://lkml.kernel.org/r/20191231133530.2794-1-pilgrimtao@gmail.com

Cc: stable@vger.kernel.org
Fixes: 478142c39c8c2 ("tracing: do not grab lock in wakeup latency function tracing")
Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_sched_wakeup.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -625,7 +625,7 @@ static void start_wakeup_tracer(struct t
 	if (ret) {
 		pr_info("wakeup trace: Couldn't activate tracepoint"
 			" probe to kernel_sched_migrate_task\n");
-		return;
+		goto fail_deprobe_sched_switch;
 	}
 
 	wakeup_reset(tr);
@@ -643,6 +643,8 @@ static void start_wakeup_tracer(struct t
 		printk(KERN_ERR "failed to start wakeup tracer\n");
 
 	return;
+fail_deprobe_sched_switch:
+	unregister_trace_sched_switch(probe_wakeup_sched_switch, NULL);
 fail_deprobe_wake_new:
 	unregister_trace_sched_wakeup_new(probe_wakeup, NULL);
 fail_deprobe:


