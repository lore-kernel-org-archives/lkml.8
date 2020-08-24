Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E42C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B9206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289278;
	bh=8lkaNw81xwCmX/agOJnoRWP0Dl+zRRFo5+k9DLpTbJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlDdXLqwcxbK90wYvJsy8z0sG+Bw9WVl0ZrNjP9QePlLEbMR0NoEWA0C72Gra9e2D
	 AeA+9MKB/8teKnK4l3Krm2y7pFcEIjVfj2GQxdJEL9hDNJy4S2D/EdHq8d+w1GBTtc
	 na61geEANA1RMc8Wzr4jvZgBFpRbOG6aJruxv7fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgHXROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgHXQhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:37:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D2F22E03;
        Mon, 24 Aug 2020 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287010;
        bh=8lkaNw81xwCmX/agOJnoRWP0Dl+zRRFo5+k9DLpTbJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwiyn04NJt2WxmQ0vrSyEUx+JTbGUI5BHZdoQisaE11CxDncYlRjHD/A7ZcUpyBPj
         P3FSo6lRFsTWVA2ZXpuCovmj2q6E2azzd1lkkfCb6CDkEMGZJl6EI5seE4YgZ46Inm
         cOs95QrMdzVc0dabh2hhzqNK0P5ULkz2GmMzF7Bk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Alain Volmat <alain.volmat@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 12/54] spi: stm32h7: fix race condition at end of transfer
Date:   Mon, 24 Aug 2020 12:35:51 -0400
Message-Id: <20200824163634.606093-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

[ Upstream commit 135dd873d3c76d812ae64c668adef3f2c59ed27f ]

The caller of stm32_spi_transfer_one(), spi_transfer_one_message(),
is waiting for us to call spi_finalize_current_transfer() and will
eventually schedule a new transfer, if available.
We should guarantee that the spi controller is really available
before calling spi_finalize_current_transfer().

Move the call to spi_finalize_current_transfer() _after_ the call
to stm32_spi_disable().

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
Link: https://lore.kernel.org/r/1597043558-29668-2-git-send-email-alain.volmat@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ef3be03574e80..04ee21defbc0b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -969,8 +969,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	if (end) {
-		spi_finalize_current_transfer(master);
 		stm32h7_spi_disable(spi);
+		spi_finalize_current_transfer(master);
 	}
 
 	return IRQ_HANDLED;
-- 
2.25.1

