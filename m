Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D80FC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19691205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340848;
	bh=ldTvqhRkqM+nR/J0XJ6ZzNqIValUnJ/esBZKHmivZsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9DHVEYfomrdWb61/R98lrM1DCo7dlJX1jZO0ShspvFfk7F5/ZfUEtpHsl89b70/w
	 YTopt8vL7s4LMXGdBQpYlpEcPjM2d7FzAj30qNI3d+Uf0mrU000MisYrzCxbRjlly6
	 wyEVKd9SxZ/z17sPIMIiz8EsMj+zvLaBxNTKCh40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgEANni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731642AbgEANnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:43:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C28205C9;
        Fri,  1 May 2020 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340612;
        bh=ldTvqhRkqM+nR/J0XJ6ZzNqIValUnJ/esBZKHmivZsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KElBVFIsr/Bpt82AIKrS7nGvckoaXOZ+f4seCCi0AFsYdtjvSCQKWSocQ1yBs7hiS
         1PnhtGnmM9O525NDKOIf4egoYsB66hlYwHmXif3LhomsWcYHBs/AzAeDt6sOLedvgn
         KAgOQHsLnmGJFWi4yEZnzYwraA2QWXFMqntwqexc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.6 057/106] blk-iocost: Fix error on iocost_ioc_vrate_adj
Date:   Fri,  1 May 2020 15:23:30 +0200
Message-Id: <20200501131550.471056449@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

commit d6c8e949a35d6906d6c03a50e9a9cdf4e494528a upstream.

Systemtap 4.2 is unable to correctly interpret the "u32 (*missed_ppm)[2]"
argument of the iocost_ioc_vrate_adj trace entry defined in
include/trace/events/iocost.h leading to the following error:

  /tmp/stapAcz0G0/stap_c89c58b83cea1724e26395efa9ed4939_6321_aux_6.c:78:8:
  error: expected ‘;’, ‘,’ or ‘)’ before ‘*’ token
   , u32[]* __tracepoint_arg_missed_ppm

That argument type is indeed rather complex and hard to read. Looking
at block/blk-iocost.c. It is just a 2-entry u32 array. By simplifying
the argument to a simple "u32 *missed_ppm" and adjusting the trace
entry accordingly, the compilation error was gone.

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-iocost.c            |    4 ++--
 include/trace/events/iocost.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1594,7 +1594,7 @@ skip_surplus_transfers:
 				      vrate_min, vrate_max);
 		}
 
-		trace_iocost_ioc_vrate_adj(ioc, vrate, &missed_ppm, rq_wait_pct,
+		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
 					   nr_lagging, nr_shortages,
 					   nr_surpluses);
 
@@ -1603,7 +1603,7 @@ skip_surplus_transfers:
 			ioc->period_us * vrate * INUSE_MARGIN_PCT, 100);
 	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
-					   &missed_ppm, rq_wait_pct, nr_lagging,
+					   missed_ppm, rq_wait_pct, nr_lagging,
 					   nr_shortages, nr_surpluses);
 	}
 
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -130,7 +130,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_i
 
 TRACE_EVENT(iocost_ioc_vrate_adj,
 
-	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 (*missed_ppm)[2],
+	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 *missed_ppm,
 		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
 		int nr_surpluses),
 
@@ -155,8 +155,8 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
-		__entry->read_missed_ppm = (*missed_ppm)[READ];
-		__entry->write_missed_ppm = (*missed_ppm)[WRITE];
+		__entry->read_missed_ppm = missed_ppm[READ];
+		__entry->write_missed_ppm = missed_ppm[WRITE];
 		__entry->rq_wait_pct = rq_wait_pct;
 		__entry->nr_lagging = nr_lagging;
 		__entry->nr_shortages = nr_shortages;


