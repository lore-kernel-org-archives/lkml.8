Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A4BC8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A127F206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hm28sbPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgD1UKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:10:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13198 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbgD1UKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:10:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588104606; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bojKP1ZrkM2Eg3huzfDNTd3FMiLWtmgMlTVULwps5RM=; b=hm28sbPD2Wi40cCA4siIKH/lAsH5FmTL6FPbfzewgS00j4rVgxtG06V6USpK7c8U7eJzakHN
 ipGT2hoiKY0+/cRedc3fmCSRoyYh8QAszmCsB3lxVhU0c7f4tJX4IQv1oboaYsCmIo3oCG1J
 BeYqZC9aWw3XOQs9dBoyFx8yQo4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea88d8d.7f0d1931eed8-smtp-out-n03;
 Tue, 28 Apr 2020 20:09:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27A39C433D2; Tue, 28 Apr 2020 20:09:47 +0000 (UTC)
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43BC0C433CB;
        Tue, 28 Apr 2020 20:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43BC0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: [PATCH v2 0/2] timer: make deferrable cpu unbound timers really not bound to a cpu
Date:   Tue, 28 Apr 2020 13:09:37 -0700
Message-Id: <1588104579-8712-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches introduce support for global deferrable timers and this feature is very useful
for the mobile chipsets and initial discussion link -[1]. Lastest discussion was with - [2]
as these patches are in downstream kernel for quite a long time.

[1]- https://lore.kernel.org/patchwork/patch/500541/
[2]- https://lkml.org/lkml/2020/3/16/147

Changelog:
v1 -> v2:
 - Fixed tglx comments about warning.
 - Thanks Pavan for your suggestion.

Joonwoo Park (1):
  timer: make deferrable cpu unbound timers really not bound to a cpu

Prasad Sodagudi (1):
  sched: Add a check for cpu unbound deferrable timers

 include/linux/timer.h    |  3 +++
 kernel/time/tick-sched.c |  8 +++++-
 kernel/time/timer.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 68 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
