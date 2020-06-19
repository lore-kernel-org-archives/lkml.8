Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A63C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4809F2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579822;
	bh=PGlP+JP7FvYzxdcy4SX9/FZl2RROoPdsSLINcj/iE2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oT3uF1JMhogJTkXq0cw/FVr8DaxjKeazVQjwglDihMH8QJpNhrLx3ted6Y6/0bxDF
	 3935PhAJruh3y2IoS7kL4dCx7OFNjZQnvfElTPKhBeGwW41mlLLVtZ1o0z1RI61QSQ
	 5mlZgaIgvWb3qfI24qlPjVBlSn8a8nyszJeIFQS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbgFSPQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404105AbgFSPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:16:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB7A2080C;
        Fri, 19 Jun 2020 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579812;
        bh=PGlP+JP7FvYzxdcy4SX9/FZl2RROoPdsSLINcj/iE2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keiQoDcWKTAPUf1F7+ZUAWpj1HL8brGk5GXtIMaurmBI6NeRBQy1sLyqk7oJhuuK4
         nZiU2l/y0j9ZISlmAJ1x2ObvF5I8cyv69L2ImVgiXh+vh/8Nae1oh3dJrCT6hI+B35
         HvBGGysaFmK4UZFPI8RPvp4Tuah0HQwMldDoUw4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 003/376] ath10k: Fix the race condition in firmware dump work queue
Date:   Fri, 19 Jun 2020 16:28:41 +0200
Message-Id: <20200619141710.521631401@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maharaja Kennadyrajan <mkenna@codeaurora.org>

[ Upstream commit 3d1c60460fb2823a19ead9e6ec8f184dd7271aa7 ]

There is a race condition, when the user writes 'hw-restart' and
'hard' in the simulate_fw_crash debugfs file without any delay.
In the above scenario, the firmware dump work queue(scheduled by
'hard') should be handled gracefully, while the target is in the
'hw-restart'.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00044

Co-developed-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/1585213077-28439-1-git-send-email-mkenna@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index ded7a220a4aa..cd1c5d60261f 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2074,6 +2074,7 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
 	ath10k_pci_irq_sync(ar);
 	napi_synchronize(&ar->napi);
 	napi_disable(&ar->napi);
+	cancel_work_sync(&ar_pci->dump_work);
 
 	/* Most likely the device has HTT Rx ring configured. The only way to
 	 * prevent the device from accessing (and possible corrupting) host
-- 
2.25.1



