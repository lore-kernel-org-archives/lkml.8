Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3556EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D23421D81
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGBV7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665D0214DB;
        Thu,  2 Jul 2020 21:58:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E0-004Bfx-Ef; Thu, 02 Jul 2020 17:58:32 -0400
Message-ID: <20200702215832.339413645@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-next][PATCH 06/18] tracing: not necessary re-define DEFINE_EVENT_PRINT
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

The definition of DEFINE_EVENT_PRINT is not changed after previous one,
so not necessary to re-define is as the same form.

Link: http://lkml.kernel.org/r/20200612092844.56107-3-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index a4994761bdaf..5219f81b9d74 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -520,10 +520,6 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
-#undef DEFINE_EVENT_PRINT
-#define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
-
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 /*
-- 
2.26.2


