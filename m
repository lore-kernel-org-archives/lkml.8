Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB9C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A068B2072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736390;
	bh=b+oDzQHYFWqh4GhFlqP1FBy9gLqfo2Twtg7XrUABY7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V3Oa4e+LsgqnLZLzFotYL+saR+Gbu3RpGVNh3MlZRvA/GpjohYKkZuvaMO8q6x48J
	 IgSXKJFW1qfIXh56O71GXp6z8GtVmBvP4tORJxv96XF/KqyPxwBTomFdagkX+0kg9I
	 s580MExR3O0yWYw1J1k+UqvDuRlO3oVqp1LB8ytM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgAKJxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgAKJxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:53:09 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113A62072E;
        Sat, 11 Jan 2020 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736388;
        bh=b+oDzQHYFWqh4GhFlqP1FBy9gLqfo2Twtg7XrUABY7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKabw3SLXg+dedYcPZ4FRNOAtkLX3ZZVrxbbvjZktWrrjs1qTNRyrCyOahegWQZPU
         NX5l0S+BOZPKCjSDjZCkLOC3nO3mJh8oKWxnvP5FUuIJ8o+H2eCm1ronoJ+pipDGIR
         2zxxQf1UBeKypySIsKR5IdgWdQ+bXjOcTH3vTLWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masashi Honma <masashi.honma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 28/59] ath9k_htc: Modify byte order for an error message
Date:   Sat, 11 Jan 2020 10:49:37 +0100
Message-Id: <20200111094844.185354781@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

[ Upstream commit e01fddc19d215f6ad397894ec2a851d99bf154e2 ]

rs_datalen is be16 so we need to convert it before printing.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index cc9648f844ae..54e96c661a9c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -985,7 +985,7 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 	    (skb->len - HTC_RX_FRAME_HEADER_SIZE) != 0) {
 		ath_err(common,
 			"Corrupted RX data len, dropping (dlen: %d, skblen: %d)\n",
-			rxstatus->rs_datalen, skb->len);
+			be16_to_cpu(rxstatus->rs_datalen), skb->len);
 		goto rx_next;
 	}
 
-- 
2.20.1



