Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B868C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5A420791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMMzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:55:00 -0400
Received: from smtp.h3c.com ([60.191.123.50]:26134 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMMzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:55:00 -0400
X-Greylist: delayed 4762 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 08:54:59 EDT
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 07DBZXOS027013
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:35:33 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 07DBYhDN026643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 19:34:43 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 19:34:46 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] tracing: use __this_cpu_read() in trace_buffered_event_enable()
Date:   Thu, 13 Aug 2020 19:28:03 +0800
Message-ID: <20200813112803.12256-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 07DBYhDN026643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is executed with preemption disabled, so it's
safe to use __this_cpu_read().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb6226972..7d0d71ce9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2514,7 +2514,7 @@ void trace_buffered_event_enable(void)
 
 		preempt_disable();
 		if (cpu == smp_processor_id() &&
-		    this_cpu_read(trace_buffered_event) !=
+		    __this_cpu_read(trace_buffered_event) !=
 		    per_cpu(trace_buffered_event, cpu))
 			WARN_ON_ONCE(1);
 		preempt_enable();
-- 
2.17.1

