Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A20206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NJv/6e13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgEBS3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:29:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18131 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728365AbgEBS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:29:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588444154; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7Uz3vEjyENB89+BOuUVvQkgCH/gNoz40d28guITUw3E=; b=NJv/6e139+86UsD5yF5RMR+GkiH7PHC3pHtcg6jnNIIaSr/4DAmbqEoRwVdIh3d9HXMmMYFj
 Mfz6C/hPvweT9yrvNSgD0Lxnib9gSP3BSPR9hW9u+xzTXTUvgLhgHlPPaVbSIMnm+6cgnilg
 XtA9wMVplLMU7HR/uKBDR6UUVWk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eadbbf4.7f8a5efab260-smtp-out-n04;
 Sat, 02 May 2020 18:29:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2457C433D2; Sat,  2 May 2020 18:29:07 +0000 (UTC)
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD3E1C433CB;
        Sat,  2 May 2020 18:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD3E1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: [PATCH v3 0/2] timer: make deferrable cpu unbound timers really not bound to a cpu
Date:   Sat,  2 May 2020 11:28:55 -0700
Message-Id: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are introducing support for global deferrable timers
and this feature is very useful for the mobile chipsets. All comments
in initial discussion [1] are addressed. Here is the latest discussion - [2]
as these  patches are in downstream kernel for quite a long time.

[1]- https://lore.kernel.org/patchwork/patch/500541/
[2]- https://lkml.org/lkml/2020/3/16/147

Changelog:
v2 -> v3:
 - Fixed 'kbuild test robot' warnings.

v1 -> v2:
 - Fixed tglx comments about warning.
 - Thanks Pavan for your suggestion.

Joonwoo Park (1):
  timer: make deferrable cpu unbound timers really not bound to a cpu

Prasad Sodagudi (1):
  sched: Add a check for cpu unbound deferrable timers

 include/linux/timer.h    |  3 +++
 kernel/time/tick-sched.c |  8 +++++-
 kernel/time/timer.c      | 69 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 74 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
