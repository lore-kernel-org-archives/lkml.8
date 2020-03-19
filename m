Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C724C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F340B206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHuJKeA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgCSUMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:12:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35518 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:12:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so2747872lfp.2;
        Thu, 19 Mar 2020 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rWnveVVUhV0jZP6qk2JekF9mt/8mR18XOrixvtwDns=;
        b=MHuJKeA/kZXo70Js7a1TtN19e8hJGw2o6tgp5HbLKe0ifRtReSjepyflK0E44eItgL
         V2NeNarC+m60rA8i2OBWS+EB6+Lat0Yz5X5/yMAj8avWI0E6tB2PAujmdIjRvJzHcbJG
         MzkZd9RXwnGn3Y/6OCE38pkpuIl6oQhChMczStjw1ylz7OqFwnF5xnV1u/mXellR71AL
         LMPIRLYKnV+TiMYrlP8vmqI9hbA1O5aor9XQ62p+OzPRfkN18b9gPX8WO1sih6s6kSgv
         q3u5qwF1TgS+22vNUVUeBbyKfW1RRdvdxKs6mKbk0ndIsi6GvBGZVwq3R6Y9ovC95If8
         B7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rWnveVVUhV0jZP6qk2JekF9mt/8mR18XOrixvtwDns=;
        b=fgwVlIurcpd31V4xVY5OOpUL69IdE4hNeoS08kbZCHkGd0iAnNKk0KSM7SDurIfJo1
         lxzt0flj+DJehiQKp7mUDwS0Jt8ROk1etJ2KTpaL6XKxm1h5bRODzxUe8BsQKrbCw39I
         sEYw5o3DdpaR6TXQmn2AASTP+rpaFiF7y2OXi0pMWU/0GyqU0LAAMAy7eRSth86/ChEY
         X27KuZWI0k3NO8hPFrvFEOxpVuqJibHtfDE3p0DJOd4U5YHUzR/4YwFTsv88lKkenid7
         zIaawcRdP3xSH2MiPRdSvlNObFhK7J7U2nKia7h+3vnSmyTV7/kV+TX1epnL4MALMRUq
         VoEg==
X-Gm-Message-State: ANhLgQ07DAWSEOJZ1bIaVMdw7RVLhkcAW2vRccFuaKP729DoYcekhFrp
        a3uT2V36WUeyWZzJJX2kVb8=
X-Google-Smtp-Source: ADFU+vtSQAmtsDiVKncNEieuoVMXJL3wofav79o9W9WxOvss1hAc05X546TLUW07at33Bn8DfcG8OQ==
X-Received: by 2002:a19:7907:: with SMTP id u7mr3123765lfc.18.1584648757441;
        Thu, 19 Mar 2020 13:12:37 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id z21sm2059317ljz.49.2020.03.19.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 13:12:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] i2c: tegra: Synchronize DMA before termination
Date:   Thu, 19 Mar 2020 23:11:40 +0300
Message-Id: <20200319201140.17451-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319201140.17451-1-digetx@gmail.com>
References: <20200319201140.17451-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA transfer could be completed, but CPU (which handles DMA interrupt)
may get too busy and can't handle the interrupt in a timely manner,
despite of DMA IRQ being raised. In this case the DMA state needs to
synchronized before terminating DMA transfer in order not to miss the
DMA transfer completion.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index dabb9223990c..b69a10497cd5 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1224,6 +1224,15 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		time_left = tegra_i2c_wait_completion_timeout(
 				i2c_dev, &i2c_dev->dma_complete, xfer_time);
 
+		/*
+		 * Synchronize DMA first, since dmaengine_terminate_sync()
+		 * performs synchronization after the transfer's termination
+		 * and we want to get a completion if transfer succeeded.
+		 */
+		dmaengine_synchronize(i2c_dev->msg_read ?
+				      i2c_dev->rx_dma_chan :
+				      i2c_dev->tx_dma_chan);
+
 		dmaengine_terminate_sync(i2c_dev->msg_read ?
 					 i2c_dev->rx_dma_chan :
 					 i2c_dev->tx_dma_chan);
-- 
2.25.1

