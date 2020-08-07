Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59659C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3548A22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHGGZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:25:04 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:62166 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgHGGZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:25:02 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 Aug 2020 23:25:01 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Aug 2020 23:25:00 -0700
Received: from c-mansur-linux.qualcomm.com ([10.204.90.208])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Aug 2020 11:54:45 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id F308321C70; Fri,  7 Aug 2020 11:54:44 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: [RESEND  0/3] Venus - Handle race conditions in concurrency 
Date:   Fri,  7 Aug 2020 11:54:35 +0530
Message-Id: <1596781478-12216-1-git-send-email-mansur@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of this patchset is to handle race
conditions during concurrency usecases like
Multiple YouTube browser tabs(approx 50 plus tabs),
graphics_Stress, WiFi ON/OFF, Bluetooth ON/OF,
and reboot in parallel.

---
Resending the fixes by describing more about the issue
and correcting typo errors.

Mansur Alisha Shaik (3):
  venus: core: handle race condititon for core ops
  venus: core: cancel pending work items in workqueue
  venus: handle use after free for iommu_map/iommu_unmap

 drivers/media/platform/qcom/venus/core.c     |  6 +++++-
 drivers/media/platform/qcom/venus/firmware.c | 17 +++++++++++++----
 drivers/media/platform/qcom/venus/hfi.c      |  5 ++++-
 3 files changed, 22 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

