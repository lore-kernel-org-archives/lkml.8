Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E12C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30DB20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+WQLrfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGPBbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGPBbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:31:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21410C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SaIela0nfLz3LKk+U57tKKaDRzVz/77dBDxuE2GipTg=; b=q+WQLrfHeFWMQyxjWBeRN+muIJ
        1uSN7FZq56exQ4CP2HWGPJUT2Mb6gWxFM8nVb7VUnjUPPkTVWFz1P1jwYv58nJslWjVFkrdYKB15U
        0o2JtczErRR/nREFKssMHjSwKr/VcWTAbxUxlW0wzetKmoDTxTfK5AMZjvQzOZcFI391Y0KtqsDP9
        cEc8B+9mYmeEaPtmj4jLWzDtyc4faD3BAYbPq3RHAOR/B4qNiSSppL2geNB9jUBak1XVyv0AAlGfU
        /f0JPlXyZae+jXeX5AH5ASm1wPA+sZfQ3EwwMPXJr23QsD+m7kRrKB8h4koF3gUK+dooiganT/a36
        PxtrXJiA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvskQ-0000d8-B7; Thu, 16 Jul 2020 01:31:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] trace/events/sched.h: fix duplicated word
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Message-ID: <25305c1d-4ee8-e091-d20f-e700ddad49fd@infradead.org>
Date:   Wed, 15 Jul 2020 18:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change "It it" to "It is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/trace/events/sched.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/trace/events/sched.h
+++ linux-next-20200714/include/trace/events/sched.h
@@ -91,7 +91,7 @@ DEFINE_EVENT(sched_wakeup_template, sche
 
 /*
  * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
- * It it not always called from the waking context.
+ * It is not always called from the waking context.
  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup,
 	     TP_PROTO(struct task_struct *p),


