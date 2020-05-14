Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45064C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F3120810
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482590;
	bh=P3vnlNl2kfwRlE3gX2+SClcTGmFVrHC5ebGzq7c4wOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nrz2wAhGQ1hYFO8PXb7qs88kI6Xax7fZVo6/OWagDiuV0VFRQXHGJvzbvpfg91RNT
	 X8Lbne7vhXwRgr7pj8oqUg4BhMMBZTYfQIxzmCZhE57eRI2/GVwkfMzAta8bt5v7My
	 QbBQsdOZx7HuR7K53W6o3ek6bK8OlEQdEk2FdQEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgENS43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgENS4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206B6207D0;
        Thu, 14 May 2020 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482571;
        bh=P3vnlNl2kfwRlE3gX2+SClcTGmFVrHC5ebGzq7c4wOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFrtfd62IkgDicdzLZSM8a+GgQ2Bg+X2URn87P+kDqXjT9W9hzXWklD+QYaPJyMSx
         nHNW1bL2xThQHJvZpvyDflywozoS8PgZySJbmOrT9U3/8WgeUwZkIVY1rEix6U674Y
         Cro068i/skthwezWugr5ncn8l45sNn/kD6kHR7Sw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Elder <elder@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 17/27] net: ipa: fix a bug in ipa_endpoint_stop()
Date:   Thu, 14 May 2020 14:55:40 -0400
Message-Id: <20200514185550.21462-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185550.21462-1-sashal@kernel.org>
References: <20200514185550.21462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>

[ Upstream commit 713b6ebb4c376b3fb65fdceb3b59e401c93248f9 ]

In ipa_endpoint_stop(), for TX endpoints we set the number of retries
to 0.  When we break out of the loop, retries being 0 means we return
EIO rather than the value of ret (which should be 0).

Fix this by using a non-zero retry count for both RX and TX
channels, and just break out of the loop after calling
gsi_channel_stop() for TX channels.  This way only RX channels
will retry, and the retry count will be non-zero at the end
for TX channels (so the proper value gets returned).

Signed-off-by: Alex Elder <elder@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_endpoint.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 915b4cd05dd29..78ed431e6eb86 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1284,7 +1284,7 @@ static int ipa_endpoint_stop_rx_dma(struct ipa *ipa)
  */
 int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 {
-	u32 retries = endpoint->toward_ipa ? 0 : IPA_ENDPOINT_STOP_RX_RETRIES;
+	u32 retries = IPA_ENDPOINT_STOP_RX_RETRIES;
 	int ret;
 
 	do {
@@ -1292,12 +1292,9 @@ int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 		struct gsi *gsi = &ipa->gsi;
 
 		ret = gsi_channel_stop(gsi, endpoint->channel_id);
-		if (ret != -EAGAIN)
+		if (ret != -EAGAIN || endpoint->toward_ipa)
 			break;
 
-		if (endpoint->toward_ipa)
-			continue;
-
 		/* For IPA v3.5.1, send a DMA read task and check again */
 		if (ipa->version == IPA_VERSION_3_5_1) {
 			ret = ipa_endpoint_stop_rx_dma(ipa);
-- 
2.20.1

