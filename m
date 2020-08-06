Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40008C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3693206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgHFSKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:10:48 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15555 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgHFSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:10:47 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Aug 2020 06:17:55 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Aug 2020 06:17:53 -0700
Received: from c-mansur-linux.qualcomm.com ([10.204.90.208])
  by ironmsg01-blr.qualcomm.com with ESMTP; 06 Aug 2020 18:47:39 +0530
Received: by c-mansur-linux.qualcomm.com (Postfix, from userid 461723)
        id 0952521C62; Thu,  6 Aug 2020 18:47:37 +0530 (IST)
From:   Mansur Alisha Shaik <mansur@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: [PATCH 0/3] Venus - Handle race conditions in concurrency
Date:   Thu,  6 Aug 2020 18:47:32 +0530
Message-Id: <1596719855-1725-1-git-send-email-mansur@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intenstion of this patchset is to handle race
conditions during concurrency usecase.

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

