Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8CC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6682C20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TtfaEDEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGZC7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:59:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36786 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgGZC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:59:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595732387; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=YJlWfawbaRsS8Sy0QV32pRFsqzlt1zIfjkcHj6ND5zI=; b=TtfaEDEnRdwPRjLkFAYZTQGFVVliYAvdyj8bQgIt5lq6E1BYEc8L5EhlGJK+0Yrb4+cS5+jK
 3yywqPKXigPbGkSNfNXDRFR6Ly9Ot51lRRrzlFVIyEnUdxkhf/XV8L+2jVSIetBb99ra0qzi
 fCAkh1EekF8Hrj2GOFEr8VgqYmI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f1cf1a27ab15087ebec2b95 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 26 Jul 2020 02:59:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13848C433CB; Sun, 26 Jul 2020 02:59:46 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC677C433C9;
        Sun, 26 Jul 2020 02:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC677C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] tracing: export event trace and trace_marker
Date:   Sun, 26 Jul 2020 10:59:25 +0800
Message-Id: <20200726025931.30510-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace has ability to export trace packets to other destionation. Currently,
only function trace can be exported. This series extends the support to
event trace and trace_maker. STM is one possible destination to export ftrace.
Use seperate channel for each CPU to avoid mixing up packets from different
CPUs together.

Change from v1:
All changes are suggested by Steven Rostedt.
User seperate flag to control function trace, event trace and trace mark.
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
 drivers/hwtracing/stm/ftrace.c |   6 +-
 include/linux/trace.h          |   7 +
 kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
 4 files changed, 158 insertions(+), 127 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

