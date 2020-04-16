Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B3C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCC9206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048958;
	bh=sRsf7xacDSWIjD5VxmR6mRyFX8pNfQp0G4me/WzHu8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jI9GGK0/CnblIv4fCw9fNqawucZSjp2L24bhgaBnUgTg/vTVzIr0hKkQUlF4xmN8L
	 vHns3swOd5yS9MzTLOCvgThwpZSn1ruckh/udhumbVOaxPh4FoGJAqijZFfSkMTVU1
	 GNtJbaG1iz6isSZJtB5Z2FytXXeQ8AxwPay+Dexg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392397AbgDPOz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408929AbgDPN4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E597A217D8;
        Thu, 16 Apr 2020 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045376;
        bh=sRsf7xacDSWIjD5VxmR6mRyFX8pNfQp0G4me/WzHu8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8yZmHTGNUAkj6urCO1vMtMkN4zjKw31Ek9ogjWnicWXDdbQi2X6rLjXRMa3GqbY9
         M62V7lUm9I+VRYdm7+mr19yqk1Fk++F0v+59eSJt80fzHvI/N1wCqMvok+he1X7soG
         JP6GxQSXjOET1sa/qDfeWug9yM5h0IgS73VCWNcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.6 110/254] mmc: mmci_sdmmc: Fix clear busyd0end irq flag
Date:   Thu, 16 Apr 2020 15:23:19 +0200
Message-Id: <20200416131339.930120460@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

commit d4a384cb563e555ce00255f5f496b503e6cc6358 upstream.

The busyd0 line transition can be very fast. The busy request may be
completed by busy_d0end, without waiting for the busy_d0 steps. Therefore,
clear the busyd0end irq flag, even if no busy_status.

Fixes: 0e68de6aa7b1 ("mmc: mmci: sdmmc: add busy_complete callback")
Cc: stable@vger.kernel.org
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Link: https://lore.kernel.org/r/20200325143409.13005-2-ludovic.barre@st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/mmci_stm32_sdmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -315,11 +315,11 @@ complete:
 	if (host->busy_status) {
 		writel_relaxed(mask & ~host->variant->busy_detect_mask,
 			       base + MMCIMASK0);
-		writel_relaxed(host->variant->busy_detect_mask,
-			       base + MMCICLEAR);
 		host->busy_status = 0;
 	}
 
+	writel_relaxed(host->variant->busy_detect_mask, base + MMCICLEAR);
+
 	return true;
 }
 


