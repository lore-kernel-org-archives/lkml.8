Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91BB20706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbgFXGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:50:10 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57837 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388262AbgFXGuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:50:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0Zd2IB_1592981406;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0Zd2IB_1592981406)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 14:50:06 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Some improvements for NVMe
Date:   Wed, 24 Jun 2020 14:49:56 +0800
Message-Id: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fisrt patch adds Arbitration Burst support, and another one is
a small improvement. Please help to review. Thanks.

Changes from v1:
 - Add new parameter to decide if use the controller's recommended
 arbitration burst.
 - Add arbitration burst mask in case overflow.
 - Do not export the nvme_set_arbitration_burst().
 - Add reviewed tag from Sagi.
 - Drop patch 2 in v1 patch set.

Baolin Wang (2):
  nvme: Add Arbitration Burst support
  nvme: Use USEC_PER_SEC instead of magic numbers

 drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
1.8.3.1

