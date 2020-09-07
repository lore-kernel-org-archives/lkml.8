Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C469C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513F22080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497381;
	bh=XbwKwVJGhjg2g05fL+HKZshm0QMK9+MQv21YwmNwFIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S8iQV9CEYpASEmSqiHtmv22wyEcD5NnGsbP4zuFvyQJLr1KGBix9nUVBeSEm/1k6y
	 a3rYcweT+1UsZCqAOol7FLQiOt3VU4J9Hobuv+r/EqwaykGtFEOVYLe91K/2lxkaU7
	 d+bGZ/n6c6+DFWnmoFLf7wwyP1Vv55oy/u3e3QJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgIGQtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgIGQfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E4321D7D;
        Mon,  7 Sep 2020 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496506;
        bh=XbwKwVJGhjg2g05fL+HKZshm0QMK9+MQv21YwmNwFIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0hevRz1GO746IlAqS0HG5v0d5TGhh6CTSpyJcCIgz3pUoWmWibtcgNF5v5OrT3jX
         AxUK69ZgX4dChOkiCcrQMkVTST0zr4hBCTaUM2YZnTEWkMq/GwHG1yHEZvs4by35on
         51wu2igVapMNEapH7cIfK57nIwVeqNZgzjQfJmXw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/17] NFC: st95hf: Fix memleak in st95hf_in_send_cmd
Date:   Mon,  7 Sep 2020 12:34:47 -0400
Message-Id: <20200907163500.1281543-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163500.1281543-1-sashal@kernel.org>
References: <20200907163500.1281543-1-sashal@kernel.org>
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

