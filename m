Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3373DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E482A20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926857;
	bh=ENiqpdrP0F6yjrEXZFstOmJSl0BgjFvhgs+/PdwbxjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAwzobVDvqJqkZowQes6ZyKf3iH+d7xONuyiRRoZwOLuSB4npGvPEfhZf2K57qzhX
	 H9W9PAfJGgX5sUAxS9u/gDWXF0Va4NLEyxHMRRHPbIGhw/Jtsxd4ttNXqtWcrsoMnI
	 x7f8UkSO+1jGSEJvq0eIcDvX5YGYqwxXeDfdYW+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgHTMeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbgHTJsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:48:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC6422D6E;
        Thu, 20 Aug 2020 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916932;
        bh=ENiqpdrP0F6yjrEXZFstOmJSl0BgjFvhgs+/PdwbxjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzQY3NvwjYdmVlTppPwVJNqmArc2LbQM4RfAmXW/U5D5ksnSJVRHWGyzC4lNz/ZvP
         7RBq0U6SsXCn514lasaRfN5ULDSNs4dG6jNQwE3dfD+F2t9gPqACZK3MWj+mS8vrem
         dy4uWTwk65V1GdNDF1obTWCyGVR8PxHvThZ0n/lE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/152] mmc: renesas_sdhi_internal_dmac: clean up the code for dma complete
Date:   Thu, 20 Aug 2020 11:21:03 +0200
Message-Id: <20200820091558.676450266@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 2b26e34e9af3fa24fa1266e9ea2d66a1f7d62dc0 ]

To add end() operation in the future, clean the code of
renesas_sdhi_internal_dmac_complete_tasklet_fn(). No behavior change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1590044466-28372-3-git-send-email-yoshihiro.shimoda.uh@renesas.com
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index a66f8d6d61d1b..cb89f0578d425 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -229,15 +229,12 @@ static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
 					    DTRAN_CTRL_DM_START);
 }
 
-static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
+static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
 	enum dma_data_direction dir;
 
-	spin_lock_irq(&host->lock);
-
 	if (!host->data)
-		goto out;
+		return false;
 
 	if (host->data->flags & MMC_DATA_READ)
 		dir = DMA_FROM_DEVICE;
@@ -250,6 +247,17 @@ static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
 	if (dir == DMA_FROM_DEVICE)
 		clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
 
+	return true;
+}
+
+static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+
+	spin_lock_irq(&host->lock);
+	if (!renesas_sdhi_internal_dmac_complete(host))
+		goto out;
+
 	tmio_mmc_do_data_irq(host);
 out:
 	spin_unlock_irq(&host->lock);
-- 
2.25.1



