Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAAA2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948732;
	bh=8S3YEdXpkcnmfREyCAK8cGhMQ1RhxM689r8xymK6pB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2zGNfyePldhbUnIAotJ8aVcv3t83cA6+xCjE1lemSz11T5aMW5yPKRdsrKasvGZk
	 WFzfZLav8muLcWi4XnkuH/G0kuEY9+wxfd8r/mG1tZSDpCPEiUGAg7t6imF7hk58xf
	 fmvbZnxCsTuxblJNHCsm3Y6SMOqhuBIbpYw/JTPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgFWUBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbgFWUBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:01:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E174206C3;
        Tue, 23 Jun 2020 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942468;
        bh=8S3YEdXpkcnmfREyCAK8cGhMQ1RhxM689r8xymK6pB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSrQ6y4E4eLbL56uXgNbLpedu/P/uBuYPj4ARCbKl2hXnTLGfLQItWNF8vtoiP80S
         NzVcB0I4hFsrn4CwJgOzXuAyG6YsugyAdkeVcVUdUbkjGBQuc2XOQovd0xKQpcMKMK
         6vZomRUCqVaLh41VhRBlwqFpmBhKYNAxc+rTcysk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 011/477] staging: wfx: check ssidlen and prevent an array overflow
Date:   Tue, 23 Jun 2020 21:50:08 +0200
Message-Id: <20200623195408.128626482@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 87f86cddda65cab8a7e3df8a00e16abeccaa0730 ]

We need to cap "ssidlen" to prevent a memcpy() overflow.

Fixes: 40115bbc40e2 ("staging: wfx: implement the rest of mac80211 API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200424104235.GA416402@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/sta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 9d430346a58bb..969d7a4a7fbd9 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -520,7 +520,9 @@ static void wfx_do_join(struct wfx_vif *wvif)
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 	if (ssidie) {
 		ssidlen = ssidie[1];
-		memcpy(ssid, &ssidie[2], ssidie[1]);
+		if (ssidlen > IEEE80211_MAX_SSID_LEN)
+			ssidlen = IEEE80211_MAX_SSID_LEN;
+		memcpy(ssid, &ssidie[2], ssidlen);
 	}
 	rcu_read_unlock();
 
-- 
2.25.1



