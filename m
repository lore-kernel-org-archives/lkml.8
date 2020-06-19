Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF11BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA679206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584851;
	bh=QVcW8dTwS5z7Olepp+XqsyVQMXHXIDd8TyyxJ/ZDWoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L5LVto1zEUcAYpIUyHf+MAADnFOnUffz1sIOgdBUUwwfpk/gbtEOnRmzSx5+7bNUQ
	 GfsWBGHciDUDnEB+4U0bLI/DxE7tNmxnSbHyewPPk+/iu/FeCnvBjHkdWG7cZlfUpA
	 DSxDhArX0LX/Pxcm8T+flUH9sLrdlF32tavb8mQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395461AbgFSQku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbgFSOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388FD2083B;
        Fri, 19 Jun 2020 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577922;
        bh=QVcW8dTwS5z7Olepp+XqsyVQMXHXIDd8TyyxJ/ZDWoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldXQPvD26f6Ujl2CL6oSLKk8m2kN4ink5S+CyaOfIKmne2ikYlE1W549IX+/lNK+C
         uHWaVGCyGaPl46iF0Ew8Rn0ireZWWcxim0WX5oersN0YkRKw5UwhGpVhIyGpgb7lDl
         1CDEUHDgd0H5Q1C5p3r5agT6I+sO7SYhjBhSEWC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis <pro.denis@protonmail.com>,
        Masashi Honma <masashi.honma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 015/190] ath9k_htc: Silence undersized packet warnings
Date:   Fri, 19 Jun 2020 16:31:00 +0200
Message-Id: <20200619141634.229358027@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

[ Upstream commit 450edd2805982d14ed79733a82927d2857b27cac ]

Some devices like TP-Link TL-WN722N produces this kind of messages
frequently.

kernel: ath: phy0: Short RX data len, dropping (dlen: 4)

This warning is useful for developers to recognize that the device
(Wi-Fi dongle or USB hub etc) is noisy but not for general users. So
this patch make this warning to debug message.

Reported-By: Denis <pro.denis@protonmail.com>
Ref: https://bugzilla.kernel.org/show_bug.cgi?id=207539
Fixes: cd486e627e67 ("ath9k_htc: Discard undersized packets")
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200504214443.4485-1-masashi.honma@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 4748f557c753..11d06021b5e4 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -999,9 +999,9 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 	 * which are not PHY_ERROR (short radar pulses have a length of 3)
 	 */
 	if (unlikely(!rs_datalen || (rs_datalen < 10 && !is_phyerr))) {
-		ath_warn(common,
-			 "Short RX data len, dropping (dlen: %d)\n",
-			 rs_datalen);
+		ath_dbg(common, ANY,
+			"Short RX data len, dropping (dlen: %d)\n",
+			rs_datalen);
 		goto rx_next;
 	}
 
-- 
2.25.1



