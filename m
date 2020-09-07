Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20BC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2802080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497677;
	bh=wOb0MOvzDb/ZrwrJ3pg48ni2ycaY2oXkvvjZPPz+c+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFg/GfoHlL7IN98SlCYiJkUSU9xf87AU3yBDddwx9hYYTCtviSWMdh5iJQdoUV4CB
	 jFShgP5W4JijpbcjS7F3+xLrFfLb094Twx9RLFh0FqYI88lHOApPlLHh6ODgc8NuuJ
	 mYEw033c9TCC1LyLI59wW3fZX0zJdSEsNgbIYBWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgIGQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbgIGQcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C1E207DE;
        Mon,  7 Sep 2020 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496351;
        bh=wOb0MOvzDb/ZrwrJ3pg48ni2ycaY2oXkvvjZPPz+c+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/XDQhQdTpl4VVJ3vhgHR9D0GwHMRfNkKm5ziRoVlBrW44uiYhxJmvb//PM8a81vJ
         rnYPfvGAD8oALyzx00qw92DhSBdXu5sjMZo+2nrfmwoUiZCe8kztmft1St7COqCFpK
         F5t+SoB3LmBwzHlORspZy2BU8YqNBjbpsJnOYf4Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 08/53] NFC: st95hf: Fix memleak in st95hf_in_send_cmd
Date:   Mon,  7 Sep 2020 12:31:34 -0400
Message-Id: <20200907163220.1280412-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
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
index 9642971e89cea..4578547659839 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -966,7 +966,7 @@ static int st95hf_in_send_cmd(struct nfc_digital_dev *ddev,
 	rc = down_killable(&stcontext->exchange_lock);
 	if (rc) {
 		WARN(1, "Semaphore is not found up in st95hf_in_send_cmd\n");
-		return rc;
+		goto free_skb_resp;
 	}
 
 	rc = st95hf_spi_send(&stcontext->spicontext, skb->data,
-- 
2.25.1

