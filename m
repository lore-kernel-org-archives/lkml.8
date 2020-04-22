Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372A8C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8EB20775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551008;
	bh=xnctP96IABKORGoIgvVEM+OiiZ2hWkTGMixUA2d1amo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNfAeNEl+DCDTmupWqJeh26aCYsF0PhJGSTk0fzNGCGKx2Us9w+PHa4r6zObRUZF2
	 0Od61CdDx1yJx7isTCHtpbE1TCRdTZtVw6uw6UEyZZw4p8N4mHECwor3vLYm8m+c8L
	 B1/2JzfqQbfMBhQI4/1h0O12mtB38h2oxCVoApzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgDVKX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgDVKXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA5B2076E;
        Wed, 22 Apr 2020 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550987;
        bh=xnctP96IABKORGoIgvVEM+OiiZ2hWkTGMixUA2d1amo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEuDxhOTvSAeGsGsjCWQs9au5nkYzqiNY9bMIuLqCr06TF+kW8F8VhLyaB1k90FiN
         eEo6cmkHf01KugduOcbO27/L0lK6prAc49vWiqK6AMGHzkJH98L6W8DNeLtZ4DVrio
         HUOtumm6e6y6fNMQzthWQdGdQ8C/ZvI8Jxjn7CEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yixin Zhang <yixin.zhang@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 054/166] dmaengine: idxd: reflect shadow copy of traffic class programming
Date:   Wed, 22 Apr 2020 11:56:21 +0200
Message-Id: <20200422095054.762310621@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit a1fcaf07ec718bb1f11e29e952c9a4cb733d57a5 ]

The traffic class are set to -1 at initialization until the user programs
them. If the user choose not to, the driver will program appropriate
defaults. The driver also needs to update the shadowed copies of the values
after doing the programming.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Reported-by: Yixin Zhang <yixin.zhang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/158386263076.10898.4586509576813094559.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index ada69e722f84a..f6f49f0f6fae2 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -584,11 +584,11 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 		struct idxd_group *group = &idxd->groups[i];
 
 		if (group->tc_a == -1)
-			group->grpcfg.flags.tc_a = 0;
+			group->tc_a = group->grpcfg.flags.tc_a = 0;
 		else
 			group->grpcfg.flags.tc_a = group->tc_a;
 		if (group->tc_b == -1)
-			group->grpcfg.flags.tc_b = 1;
+			group->tc_b = group->grpcfg.flags.tc_b = 1;
 		else
 			group->grpcfg.flags.tc_b = group->tc_b;
 		group->grpcfg.flags.use_token_limit = group->use_token_limit;
-- 
2.20.1



