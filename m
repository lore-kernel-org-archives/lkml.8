Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CAC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3D20801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272157;
	bh=A9NrYlbZ6Aa9AtuWy0phP9yGoo3ATEXL5jhHCHQYWBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=is2YWOz/1DEvfjMhwEc4M0ovDzkuF2TXZP/JhGByUJ3EfVcxvc0RiGn+XT4KwQE0n
	 mCVFhsX2Vw56PZJ5kpa588zYOArGB7wwqgn1uU49UQXbLbGAQX1TQkZWt23AGHpHys
	 BU26C8uG6IEkk5jvutJXreNWa4cxidv7rA+6fa6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgBUICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbgBUICd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:02:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7522020801;
        Fri, 21 Feb 2020 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272152;
        bh=A9NrYlbZ6Aa9AtuWy0phP9yGoo3ATEXL5jhHCHQYWBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3WORYOBZH+OImPgHPoaZbeUtDUtK83eYrTW7bL6Wka4MfJKeyUQ1pBtGbWt7Wylh
         PpysKNoM7+6+otDx61u7xNwejUWPVyikinJ2qq7pQ3unnjWI+jIoRdFqy5TRobvt0x
         SPJsPycLVZLYEvjFHlYIyCOqZ68ywZTrAWMRql1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/344] wil6210: fix break that is never reached because of zeroing of a retry counter
Date:   Fri, 21 Feb 2020 08:36:48 +0100
Message-Id: <20200221072350.109609254@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 5b1413f00b5beb9f5fed94e43ea0c497d5db9633 ]

There is a check on the retry counter invalid_buf_id_retry that is always
false because invalid_buf_id_retry is initialized to zero on each iteration
of a while-loop.  Fix this by initializing the retry counter before the
while-loop starts.

Addresses-Coverity: ("Logically dead code")
Fixes: b4a967b7d0f5 ("wil6210: reset buff id in status message after completion")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 04d576deae72c..6cb0d7bcfe765 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -880,6 +880,7 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 	u8 data_offset;
 	struct wil_rx_status_extended *s;
 	u16 sring_idx = sring - wil->srings;
+	int invalid_buff_id_retry;
 
 	BUILD_BUG_ON(sizeof(struct wil_rx_status_extended) > sizeof(skb->cb));
 
@@ -893,9 +894,9 @@ again:
 	/* Extract the buffer ID from the status message */
 	buff_id = le16_to_cpu(wil_rx_status_get_buff_id(msg));
 
+	invalid_buff_id_retry = 0;
 	while (!buff_id) {
 		struct wil_rx_status_extended *s;
-		int invalid_buff_id_retry = 0;
 
 		wil_dbg_txrx(wil,
 			     "buff_id is not updated yet by HW, (swhead 0x%x)\n",
-- 
2.20.1



