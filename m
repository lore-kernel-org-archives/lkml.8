Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45886C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C56F20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqSUplEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgETNRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:17:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F2C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:17:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r3so1210497wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fGa0ePTwdv/m0NymAGWNyChyMUYoL+GdKZwi/SDOG4c=;
        b=bqSUplEYwA/RCSBYWLBLBoRMrka5UKxu4JdsV3O3IKD6mugXebHI7Krk9e1OSWC46v
         viEzj/QNYk1/r/+YPaVUrfYRSrnWs9VcV+1Dhun9FknfeVrZmm3hxp8NZB6wM6BwSQLP
         s0cDMD2qMfy3kAbguJwE2bimcSkCxVv3am3+EHmOSnfdjh3ON1x5vCtSRhJZg00F9KKB
         H7XivkiDy+Gnj8hatIdczUhBIeEFrMbyFWjdCFoCkMOwwgNnCHiftDKVlwxC+PQWQqrY
         xCveS2aJhwakv3/5ssvo7Hav7uroKAfiEHBZNXWh7nwUwfXCoV9af8Q/iWIfKNReSOsz
         p7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fGa0ePTwdv/m0NymAGWNyChyMUYoL+GdKZwi/SDOG4c=;
        b=rJswID6bfx25/O7Kt3vUaktqu6ZOF+93cJmG0SSWOixIcZRe09XgcgoXRz743cXoWZ
         xRz97ciuZe5CfyzxIgjNDY7SitLG4xhDzvDTkdeTJOgTov2w6KtUuR/f5uH3XC2e38AD
         rROh3QSp0RW27327iXwWu5SaUb3f00k0cCpSkCL8e4I4r0mLIBVk9HLcQ/Ll/DRoG/1g
         FoOnamnGaPh7PTMaaqXzt7BCNvBBcai+M34H123a1pvGletbx2tcevXlX1VexK3cD3HB
         pFwo27kryjMGu9dP8A/+1cCjlbjz0UBV0hKeb5+SRdx6IMdTnU2Qb1mJbY2XhHN8hrbR
         nXSQ==
X-Gm-Message-State: AOAM531I2WJwATT04B2PCN11BE1QQ6REGkjBFwDapa8BtZ/Yat7p2ykb
        +AhAxmEDEG+Eikxz0+6OjiY=
X-Google-Smtp-Source: ABdhPJxIRPdON3yN2mBj3oXYJ+y8eYNn3OzvKwNF0rMj51OaEur6eDbRF2Ts96mPK6kz8aaj9qMvCw==
X-Received: by 2002:adf:fdc5:: with SMTP id i5mr4001007wrs.176.1589980642822;
        Wed, 20 May 2020 06:17:22 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:4423:7d1b:b637:c183? ([2a00:23c6:9e09:2900:4423:7d1b:b637:c183])
        by smtp.gmail.com with ESMTPSA id 32sm3017267wrr.38.2020.05.20.06.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 06:17:22 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wojciech Kudla <wk.kernel@gmail.com>
From:   Wojciech Kudla <wk.kernel@gmail.com>
Subject: [PATCH] smp: generic ipi_raise tracepoint
Message-ID: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
Date:   Wed, 20 May 2020 14:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preliminary discussion: https://lkml.org/lkml/2020/5/13/1327
This patch avoids introducing arch-specific trace points by leveraging
existing definition for ipi_raise.

Issues to address in potential future work:
- make ipi reason available on generic smp code level (possible?)
- addition of ipi_entry/ipi_exit tracepoints in generic smp code

Signed-off-by: Wojciech Kudla <wk.kernel@gmail.com>
---
 kernel/smp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..df6982a1d3f2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -23,6 +23,11 @@
 
 #include "smpboot.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/ipi.h>
+
+static const char *ipi_reason_missing __tracepoint_string = "";
+
 enum {
 	CSD_FLAG_LOCK		= 0x01,
 	CSD_FLAG_SYNCHRONOUS	= 0x02,
@@ -34,6 +39,7 @@ struct call_function_data {
 	cpumask_var_t		cpumask_ipi;
 };
 
+
 static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
@@ -176,8 +182,12 @@ static int generic_exec_single(int cpu, call_single_data_t *csd,
 	 * locking and barrier primitives. Generic code isn't really
 	 * equipped to do the right thing...
 	 */
-	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
+		if (trace_ipi_raise_enabled())
+			trace_ipi_raise(cpumask_of(cpu), ipi_reason_missing);
+
 		arch_send_call_function_single_ipi(cpu);
+	}
 
 	return 0;
 }
@@ -474,6 +484,8 @@ void smp_call_function_many(const struct cpumask *mask,
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
 
+	trace_ipi_raise(cfd->cpumask_ipi, ipi_reason_missing);
+
 	/* Send a message to all CPUs in the map */
 	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
 
-- 
2.17.1
