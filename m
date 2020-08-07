Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A398DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6560120866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHGXcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:32:19 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24146 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgHGXcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:32:18 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Aug 2020 16:32:18 -0700
Received: from th-lint-015.qualcomm.com ([10.63.177.64])
  by ironmsg05-sd.qualcomm.com with ESMTP; 07 Aug 2020 16:32:17 -0700
Received: by th-lint-015.qualcomm.com (Postfix, from userid 2383757)
        id 0C4B4174E; Fri,  7 Aug 2020 16:32:16 -0700 (PDT)
From:   Gurbir Arora <gurbaror@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, rishabhb@codeaurora.org,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: [PATCH 0/3] Introduce mini-dump support for remoteproc.
Date:   Fri,  7 Aug 2020 16:31:58 -0700
Message-Id: <1596843121-82576-1-git-send-email-gurbaror@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes firmware sizes can be in ten's of MB's and reading
all the memory during coredump can consume lot of time and
memory.
Introducing support for mini-dumps. Mini-dump contains smallest
amount of useful information, that could help to debug subsystem
crashes.
During bootup memory is allocated in SMEM (Shared memory)
in the form of a table that contains the physical
addresses and sizes of the regions that are supposed to be
collected during coredump. This memory is shared amongst all
processors in a Qualcomm platform, so all remoteprocs
fill in their entry in the global table once they are out
of reset.
This patch series adds support for parsing the global minidump
table and uses the current coredump frameork to expose this memory
to userspace during remoteproc's recovery.

This patch series also integrates the patch:
https://patchwork.kernel.org/patch/11695541/ sent by Siddharth.

Gurbir Arora (2):
  remoteproc: core: Add coredump to remoteproc ops
  remoteproc: qcom: Add capability to collect minidumps

Rishabh Bhatnagar (1):
  remoteproc: qcom: Add minidump id for sm8150 modem remoteproc

 drivers/remoteproc/qcom_minidump.h          |  64 +++++++++
 drivers/remoteproc/qcom_q6v5_pas.c          |  21 ++-
 drivers/remoteproc/remoteproc_core.c        |   7 +-
 drivers/remoteproc/remoteproc_coredump.c    | 211 +++++++++++++++++++++++++++-
 drivers/remoteproc/remoteproc_elf_helpers.h |  27 ++++
 drivers/remoteproc/remoteproc_internal.h    |   2 +
 include/linux/remoteproc.h                  |   3 +
 7 files changed, 331 insertions(+), 4 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_minidump.h

-- 
1.9.1

