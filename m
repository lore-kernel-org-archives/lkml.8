Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CAAC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55FC206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="d6zxk4TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgGZDAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 23:00:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15445 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgGZDAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:00:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595732415; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vXcY9i3D0OSTVBONPBeITnkbLfbZQF6WM4MtJSAOd6A=; b=d6zxk4TPAcjensLJa0yvrU7GxNRowg5iOfBDB1Xd6Bygeh0tLluqZ8Z6E6Ma8/KipvI0LF/I
 OUqCuz0LEKB4G3o3wiYTNlzPaRvMtztMIt4Wfm6oEfg7FwofV7dcjGGexqAsn3HuBJEkjNeD
 /ERHuzDO69ckaf71l0zr07x7Jcs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f1cf1b1aa44a6db0510c71c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 26 Jul 2020 03:00:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75621C433CB; Sun, 26 Jul 2020 03:00:01 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C523C433C6;
        Sun, 26 Jul 2020 02:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C523C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] stm class: ftrace: enable supported trace export flag
Date:   Sun, 26 Jul 2020 10:59:30 +0800
Message-Id: <20200726025931.30510-6-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200726025931.30510-1-tingwei@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set flags for trace_export. Export function trace, event trace
and trace marker to stm.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/stm/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index ce868e095410..c694a6e692d1 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -46,6 +46,8 @@ static int stm_ftrace_link(struct stm_source_data *data)
 	struct stm_ftrace *sf = container_of(data, struct stm_ftrace, data);
 
 	sf->ftrace.write = stm_ftrace_write;
+	sf->ftrace.flags = TRACE_EXPORT_FUNCTION | TRACE_EXPORT_EVENT
+			| TRACE_EXPORT_MARKER;
 
 	return register_ftrace_export(&sf->ftrace);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

