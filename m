Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463B6C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F80B20809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="maGB7XEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgG1Beo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:34:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26549 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgG1Bel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:34:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595900081; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9EpaubBxqFUSacMHuSIGmCuRKTELLz5Ei4tZOzpBcNk=; b=maGB7XEQGtMHzszQ1KSDfUo/jvRUkar4+3FgZhVMX2F7rEkQqNwYAcQmsryPkSs3ExeDJX5W
 3BV/g7iKLgkLR/SjCbumKNIDsRWi+0GJGbbxKWzIBv54QWblevTsl/rzMb+JkESZJGA5QhAb
 EZNzewNhe+FNopEzwQMOLo/vVJQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f1f80afca55a5604c738fe3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 01:34:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4824C433CB; Tue, 28 Jul 2020 01:34:38 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDF74C433C9;
        Tue, 28 Jul 2020 01:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDF74C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] stm class: ftrace: use different channel accroding to CPU
Date:   Tue, 28 Jul 2020 09:33:59 +0800
Message-Id: <20200728013359.2326-7-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200728013359.2326-1-tingwei@codeaurora.org>
References: <20200728013359.2326-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid mixup of packets from differnt ftrace packets simultaneously,
use different channel for packets from different CPU.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/hwtracing/stm/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index c694a6e692d1..ebf29489919c 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -37,8 +37,10 @@ static void notrace
 stm_ftrace_write(struct trace_export *export, const void *buf, unsigned int len)
 {
 	struct stm_ftrace *stm = container_of(export, struct stm_ftrace, ftrace);
+	/* This is called from trace system with preemption disabled */
+	unsigned int cpu = smp_processor_id();
 
-	stm_source_write(&stm->data, STM_FTRACE_CHAN, buf, len);
+	stm_source_write(&stm->data, STM_FTRACE_CHAN + cpu, buf, len);
 }
 
 static int stm_ftrace_link(struct stm_source_data *data)
@@ -63,6 +65,7 @@ static int __init stm_ftrace_init(void)
 {
 	int ret;
 
+	stm_ftrace.data.nr_chans = num_possible_cpus();
 	ret = stm_source_register_device(NULL, &stm_ftrace.data);
 	if (ret)
 		pr_err("Failed to register stm_source - ftrace.\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

