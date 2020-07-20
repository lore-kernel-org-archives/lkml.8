Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2434EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66742250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dJ4rXGQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGTCVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:21:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43015 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgGTCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:21:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595211691; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=OGtn5y+5u6/tNGv1oaw5tRw65wC3jFL4Nm1dcyL638w=; b=dJ4rXGQCNpsqHw5QGobSBqO5omJ8x/GstLrLCcspcsLx7SxpOSql9lzr5MEkHkVCObJB1foP
 JB13g6BmrENRa3ikI4H3lMSP8reWX7EsXr81LIoY3GWzwRCiz1nsInZjdmIcIKAsUS1msw/N
 255Ky2aqH1s9EGNrLmfiPO9QdHE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f14ffabee6926bb4f7af1e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 02:21:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA4D7C433C9; Mon, 20 Jul 2020 02:21:30 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA653C433C6;
        Mon, 20 Jul 2020 02:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA653C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing: export event trace and trace_marker
Date:   Mon, 20 Jul 2020 10:21:13 +0800
Message-Id: <20200720022117.9375-1-tingwei@codeaurora.org>
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

Tingwei Zhang (4):
  stm class: ftrace: change dependency to TRACING
  tracing: add trace_export support for event trace
  tracing: add trace_export support for trace_marker
  stm class: ftrace: use different channel accroding to CPU

 drivers/hwtracing/stm/Kconfig  |  2 +-
 drivers/hwtracing/stm/ftrace.c |  5 +++--
 kernel/trace/trace.c           | 26 +++++++++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

