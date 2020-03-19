Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC7EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6181A2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624297;
	bh=vopcAl7ELoZ/KGoCV6RwpYp8fny946zl81L8jceB6OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nirh/qq7AhMEMlkiedet/Cw455LfK1ZjF1roUpgLVDGj03j2FSbY5cjWrQwLUVCLV
	 3TAkaCm1pIyx4yGf0KLScpvgbAPXGehIXn0DVcBppL30p+LlaP6FnIvTSw8x5p38+H
	 Yu3TcweOLewWtDX/DrVJTUerkccimTwRB63i7v+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgCSNY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbgCSNYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:24:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B4D208C3;
        Thu, 19 Mar 2020 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624293;
        bh=vopcAl7ELoZ/KGoCV6RwpYp8fny946zl81L8jceB6OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGcf09iw65oBpOARM752zzomfNZw0Y33dQd1IAvQCrTR65egNKwlrHDN7F0xvwZZA
         wMdzQqIOrKfgP3fH5XT6AHm+f4W/s/RHtqiBNcQYMPXjGPExwuvc5061uxe8AVn7yf
         UraibOKxQU7OINmhij4Bfp1CKgQBj3wnGwtote20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 04/65] mmc: core: Allow host controllers to require R1B for CMD6
Date:   Thu, 19 Mar 2020 14:03:46 +0100
Message-Id: <20200319123927.741036912@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 1292e3efb149ee21d8d33d725eeed4e6b1ade963 ]

It has turned out that some host controllers can't use R1B for CMD6 and
other commands that have R1B associated with them. Therefore invent a new
host cap, MMC_CAP_NEED_RSP_BUSY to let them specify this.

In __mmc_switch(), let's check the flag and use it to prevent R1B responses
from being converted into R1. Note that, this also means that the host are
on its own, when it comes to manage the busy timeout.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Tested-By: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc_ops.c | 6 ++++--
 include/linux/mmc/host.h   | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index cfb2ce979baf1..5a4eddef8067b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -540,9 +540,11 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * If the max_busy_timeout of the host is specified, make sure it's
 	 * enough to fit the used timeout_ms. In case it's not, let's instruct
 	 * the host to avoid HW busy detection, by converting to a R1 response
-	 * instead of a R1B.
+	 * instead of a R1B. Note, some hosts requires R1B, which also means
+	 * they are on their own when it comes to deal with the busy timeout.
 	 */
-	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
+	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
+	    (timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
 
 	cmd.opcode = MMC_SWITCH;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0c..4c5eb3aa8e723 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -333,6 +333,7 @@ struct mmc_host {
 				 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | \
 				 MMC_CAP_UHS_DDR50)
 #define MMC_CAP_SYNC_RUNTIME_PM	(1 << 21)	/* Synced runtime PM suspends. */
+#define MMC_CAP_NEED_RSP_BUSY	(1 << 22)	/* Commands with R1B can't use R1. */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
2.20.1



