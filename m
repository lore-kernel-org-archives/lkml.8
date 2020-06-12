Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FD4207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFLGuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:50:06 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29074 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgFLGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:50:03 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Jun 2020 23:50:03 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 11 Jun 2020 23:49:59 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 611052187A; Fri, 12 Jun 2020 12:19:55 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        peter.ujfalusi@ti.com, sivaprak@codeaurora.org,
        boris.brezillon@collabora.com, architt@codeaurora.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] Fix issues related to register access in IPQ NAND
Date:   Fri, 12 Jun 2020 12:19:47 +0530
Message-Id: <1591944589-14357-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1: avoids register write to unavailable SFLASHC_BURST_CFG register
Patch 2: set BAM mode only if not set by bootloader

[V3]
 * Addressed review comments from Miquel
[V2]
 * As per review comments from Miquèl split the original patch into two
   addressing independent issues.  

Sivaprakash Murugesan (2):
  mtd: rawnand: qcom: remove write to unavailable register
  mtd: rawnand: qcom: set BAM mode only if not set already

 drivers/mtd/nand/raw/qcom_nandc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.7.4

