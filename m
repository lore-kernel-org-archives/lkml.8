Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD3CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F2420801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgFLJ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:29:01 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38300 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgFLJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:28:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U.LF6m9_1591954131;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.LF6m9_1591954131)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 17:28:51 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/4] tracing: not necessary re-define DEFINE_EVENT_PRINT
Date:   Fri, 12 Jun 2020 17:28:42 +0800
Message-Id: <20200612092844.56107-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
References: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of DEFINE_EVENT_PRINT is not changed after previous one,
so not necessary to re-define is as the same form.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
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
2.20.1 (Apple Git-117)

