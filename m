Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB256C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94632080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747006;
	bh=RHf68d8sLCJyDm2CxGjh9FMDudsP8X7q9NG15UwWiCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0P+6jh2mm8URQPRY1QfRG2wWbkSf4KDFMsgVZyftJ0HgW2HG4TeEUsKo4Uv9H1dSw
	 QNIgFYU3ltpe2L9dC8tJglAZdXKtR3RYyAKqgJE7OFfmGw/QeRCVvj1TYdULMn9y32
	 TNPwMsJ5GNhy731dPCMn9g6fgl6L/t1CM6N713fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgBCQUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgBCQT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:19:58 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488E52086A;
        Mon,  3 Feb 2020 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746797;
        bh=RHf68d8sLCJyDm2CxGjh9FMDudsP8X7q9NG15UwWiCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjUAx9WX1ioV4g9/xqIL7Gaol9spQzJ6HfeslqDnp7uFy9MSZAkNUW3ABnuTxQ1JW
         ieI5iypwuJOsuck/sMoixGUZm9bRdhOUuFa9ZLh9MoAKP50mk0PfE47mGNL3l98J54
         zKIow/Y5wMshOWjWTqjv/0azF/esIPWr3JyTjykY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.4 11/53] staging: vt6656: Fix false Tx excessive retries reporting.
Date:   Mon,  3 Feb 2020 16:19:03 +0000
Message-Id: <20200203161905.159106215@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 9dd631fa99dc0a0dfbd191173bf355ba30ea786a upstream.

The driver reporting  IEEE80211_TX_STAT_ACK is not being handled
correctly. The driver should only report on TSR_TMO flag is not
set indicating no transmission errors and when not IEEE80211_TX_CTL_NO_ACK
is being requested.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/340f1f7f-c310-dca5-476f-abc059b9cd97@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/int.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/staging/vt6656/int.c
+++ b/drivers/staging/vt6656/int.c
@@ -111,9 +111,11 @@ static int vnt_int_report_rate(struct vn
 
 	info->status.rates[0].count = tx_retry;
 
-	if (!(tsr & (TSR_TMO | TSR_RETRYTMO))) {
+	if (!(tsr & TSR_TMO)) {
 		info->status.rates[0].idx = idx;
-		info->flags |= IEEE80211_TX_STAT_ACK;
+
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
+			info->flags |= IEEE80211_TX_STAT_ACK;
 	}
 
 	ieee80211_tx_status_irqsafe(priv->hw, context->skb);


