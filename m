Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E3C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEB920731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941801;
	bh=D8sLH2taGBH1jwEvqLtqvnEN3ghJ4DGfw4UH7oD9zHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OGy+E7Nt+cvHkiFQibiWdVz9J5+T1MZnqTXoHZ5/0PZE5uHW+MGhZaQTDKpmk80GM
	 pRGY8Yl0nwtut8S0v7t8AUkkXG6g3zlnU2KG5XA+hzDp9g3gSaxHsZWmtGxOQR0EHB
	 2RNQs4ZTrSPGlNqEpyuNkY1FVkSXARyWS+ZrW6Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgEHMnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbgEHMnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91ED820731;
        Fri,  8 May 2020 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941793;
        bh=D8sLH2taGBH1jwEvqLtqvnEN3ghJ4DGfw4UH7oD9zHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n50cmSzH/hl11arDxOaP0RmSCRH3NXcEtbH4kIaCsiBs5F3J25cBdIJMjT+q3MTjq
         pmtAXaB1skP3OgL7FHmXWPpEAqWVHNcQll7Sv0AfyKJuSsxv2nlpO2eFeVA9lvUmVm
         /37oDNiHHQN1runGMj0B9P7037F3tjPc0WaCKTfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 173/312] ath9k_htc: check for underflow in ath9k_htc_rx_msg()
Date:   Fri,  8 May 2020 14:32:44 +0200
Message-Id: <20200508123136.666797570@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 3a318426e09a9c9266fe6440842e11238f640a20 upstream.

We check for overflow here, but we don't check for underflow so it
causes a static checker warning.

Fixes: fb9987d0f748 ('ath9k_htc: Support for AR9271 chipset.')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/htc_hst.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -414,7 +414,7 @@ void ath9k_htc_rx_msg(struct htc_target
 		return;
 	}
 
-	if (epid >= ENDPOINT_MAX) {
+	if (epid < 0 || epid >= ENDPOINT_MAX) {
 		if (pipe_id != USB_REG_IN_PIPE)
 			dev_kfree_skb_any(skb);
 		else


