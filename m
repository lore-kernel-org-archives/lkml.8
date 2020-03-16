Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B73C10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7EA206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YldQoyfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgCPCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:39:38 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30765 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729849AbgCPCje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:39:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584326373; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XAYV3Mbi2e454rSxwWhOjN2+9LBMzJs0h881zYPA/3g=; b=YldQoyfP7wIxMuigbNpHS2EPfVBgkLquuIzK+Nyn3LsQbD0N4CFuZRwH1lyfr4Kf2CKBW9sz
 rfVNTk2M8K79Cn2ZBGRgl2TSwUaQls8ewYw887wSRNJ97cLZghe/sV7lOPnV/1cZN5Ol9fGC
 dNuEXgUzwYK7609PoH4TLhiG/1Y=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6ee6da.7f0a81007148-smtp-out-n04;
 Mon, 16 Mar 2020 02:39:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65E64C44BFA; Mon, 16 Mar 2020 02:39:21 +0000 (UTC)
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68B2DC00452;
        Mon, 16 Mar 2020 02:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68B2DC00452
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        tsoni@codeaurora.org, tj@kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 0/2] timer: make deferrable cpu unbound timers really not bound to a cpu
Date:   Sun, 15 Mar 2020 19:39:08 -0700
Message-Id: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These patches introduce support for global deferrable timers and this feature is very useful
for the mobile chipsets. There was a discussion on global deferrable timer discussion - [1]
and thomas raised cacheline bouncing problem. I am thinking that, that problem is addressed
on later patches problem as much as possible. Global deferrable timers runs on the
tick_do_timer_cpu to avoid cacheline bouncing problem during the execution of timers.  

[1]- https://lore.kernel.org/patchwork/patch/500541/


Joonwoo Park (1):
  timer: make deferrable cpu unbound timers really not bound to a cpu

Prasad Sodagudi (1):
  sched: Add a check for cpu unbound deferrable timers

 include/linux/timer.h    |  3 +++
 kernel/time/tick-sched.c |  6 +++++
 kernel/time/timer.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 67 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
