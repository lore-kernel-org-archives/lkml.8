Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05276C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88A62082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409612;
	bh=raZIuq08Y4veqZwuoIeXYqAmRzvHguhjRbatfveDZFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tTkitPqW21j0NzitmpKZaKLIjPDHsSRp0cljp1DEqlEs2/ogg34WQWwrlQlJmQeTA
	 DJ7o7PE6osMMXyLsJ3fmWMYp4MBiJVWwdNQkBXUnLMi6Hl4x/SmKAk3uTW/nXR+ogd
	 oHqe2q0yPe5MWnqzznGuz4kznUSrFZ2A6gOepi3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgA3SkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgA3SkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:40:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B29720CC7;
        Thu, 30 Jan 2020 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409602;
        bh=raZIuq08Y4veqZwuoIeXYqAmRzvHguhjRbatfveDZFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Lt6mephYrn00qEgfPK3FQInsJPLpd2dhaGz1SOcfE4a93CoW+jezxLYktB/1MVql
         PjN+WNkWT5P4mISfpR5PTdZZhn/lbMu76Cq9ZJmJukk0BG2J+Ej3+VFsFbK8VJdkss
         5f6DxV0ls1IZA0i03kknu6+No/ivsDMP8JMQj1iE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.5 16/56] staging: vt6656: Fix false Tx excessive retries reporting.
Date:   Thu, 30 Jan 2020 19:38:33 +0100
Message-Id: <20200130183612.242940902@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
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
@@ -99,9 +99,11 @@ static int vnt_int_report_rate(struct vn
 
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


