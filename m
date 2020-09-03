Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB3C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A4520758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AEr3y3IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgICASU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:18:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33955 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727842AbgICASP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:18:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599092295; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=DWvh/xe4da4kqEIchXLMEtV/mjQkWQ1/j/n7f+uAWvc=; b=AEr3y3IQngtojQD/9sKeDblRfRCDqcEZlaIyUGT0yCirQWTscMT4S/Qx18ZLz2dQumTnFU6M
 NSiEBzfXWbI/hdUpdBpYnYc9qwRpedHR+vMXIRbP6pQgxLkNVlQF+0UM2Z2vAaNwEjJL6nWj
 eyveaPbuPhlUhcGVApKh/gmgvkU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f50361aba408b30ce88aad4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 00:17:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB160C433A1; Thu,  3 Sep 2020 00:17:28 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 45B37C433C6;
        Thu,  3 Sep 2020 00:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45B37C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/6] tracing: export event trace and trace_marker
Date:   Thu,  3 Sep 2020 08:17:00 +0800
Message-Id: <20200903001706.28147-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace has ability to export trace packets to other destination.
Currently, only function trace can be exported. This series extends the
support to event trace and trace_maker. STM is one possible destination to
export ftrace. Use separate channel for each CPU to avoid mixing up packets
from different CPUs together.

Change from v2:
Change flag definition to BIT(). (Steven)
Add comment in stm_ftrace_write() to clarify it's safe to use 
smp_processor_id() here since preempt is disabled. (Steven) 

Change from v1:
All changes are suggested by Steven Rostedt.
User separate flag to control function trace, event trace and trace mark.
Allocate channels according to num_possible_cpu() dynamically.
Move ftrace_exports routines up so all ftrace can use them.

Tingwei Zhang (6):
  stm class: ftrace: change dependency to TRACING
  tracing: add flag to control different traces
  tracing: add trace_export support for event trace
  tracing: add trace_export support for trace_marker
  stm class: ftrace: enable supported trace export flag
  stm class: ftrace: use different channel accroding to CPU

 drivers/hwtracing/stm/Kconfig  |   2 +-
 drivers/hwtracing/stm/ftrace.c |   7 +-
 include/linux/trace.h          |   7 +
 kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
 4 files changed, 159 insertions(+), 127 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

