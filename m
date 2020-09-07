Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9FCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2259A207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497650;
	bh=XbwKwVJGhjg2g05fL+HKZshm0QMK9+MQv21YwmNwFIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZhyD3EBlDwHkm+DK9OOTrzg4/NheHSrqUzGg9Ib/ZeinLcbed139UDGf4IpdwYbzc
	 phpUburzG2jL9+RBDoNsNlBxZPRaon9doITbS99vCJUb/5PSwtwgI0+PNDyKWUen7p
	 RUF8z7OkIAd4Out2MMzmYIoZOj/6uV6P3vZjX7B4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbgIGQyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730756AbgIGQed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77CD821D81;
        Mon,  7 Sep 2020 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496473;
        bh=XbwKwVJGhjg2g05fL+HKZshm0QMK9+MQv21YwmNwFIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfI8xHgdftKD5UtviSI+MzC65Qzg28i1x8MSlMoOuRDtPtDOFw9BfW873oFC7qkI9
         8r5nbkahtBefzSjS+ED21dv909J7cpmRdUsprVyDe4idPOLuryPT6ujqGu1TtPysjE
         F+MH9EXBhiurRhPlMhXJMFBT/TekqbcKbDeYGXiU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/26] NFC: st95hf: Fix memleak in st95hf_in_send_cmd
Date:   Mon,  7 Sep 2020 12:34:05 -0400
Message-Id: <20200907163426.1281284-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163426.1281284-1-sashal@kernel.org>
References: <20200907163426.1281284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit f97c04c316d8fea16dca449fdfbe101fbdfee6a2 ]

When down_killable() fails, skb_resp should be freed
just like when st95hf_spi_send() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/st95hf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 01acb6e533655..c4b6e29c07192 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -981,7 +981,7 @@ static int st95hf_in_send_cmd(struct nfc_digital_dev *ddev,
 	rc = down_killable(&stcontext->exchange_lock);
 	if (rc) {
 		WARN(1, "Semaphore is not found up in st95hf_in_send_cmd\n");
-		return rc;
+		goto free_skb_resp;
 	}
 
 	rc = st95hf_spi_send(&stcontext->spicontext, skb->data,
-- 
2.25.1

