Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A330121974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448045;
	bh=M1hVbQ7i/J2XTsiWDNvRlGMXFXUI4kXywYgjYJSwY5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXgyvjmL8oNqnhZI8LpCTSWJm65/ILr+cPK2WvTx3t37fS0tXmJ6nLIzkzbiHdxoJ
	 005Rq6Rtr/I7JmJQNUT4C+Obnz+KbqyQNmBAUm69nhZR4zH0YJk38g+1/mKq0h3wGF
	 DQZlejARSZypDYBPPwnF0f/UFsRX60sbs4Cv2QlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgFRCkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgFRBMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA23821D7E;
        Thu, 18 Jun 2020 01:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442757;
        bh=M1hVbQ7i/J2XTsiWDNvRlGMXFXUI4kXywYgjYJSwY5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lv4lH28CQmy4SodXHP66Pu5LCbnA72EFUEq3G6xqo2N8+M8BwwQBnyxefr0JDD7J8
         11KZSDZehuB6kPOSAl9duhMz3zOZPgwjRj0geNF446PYGNAPlu9ORH7vVUTavSs5sy
         e5tkTn5rkv7duyj4e7aImoYl4aT5TYCrt0dV+PUg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 208/388] staging: wfx: fix value of scan timeout
Date:   Wed, 17 Jun 2020 21:05:05 -0400
Message-Id: <20200618010805.600873-208-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

[ Upstream commit 6598b12d6635e8e3060863b84c04e472546ee126 ]

Before to start the scan request, the firmware signals (with a null
frame) to the AP it won't be able to receive data. This frame can be
long to send: up to 512TU. The current calculus of the scan timeout does
not take into account this delay.

Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200515083325.378539-5-Jerome.Pouiller@silabs.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/hif_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
index 77bca43aca42..20b3045d7667 100644
--- a/drivers/staging/wfx/hif_tx.c
+++ b/drivers/staging/wfx/hif_tx.c
@@ -268,7 +268,7 @@ int hif_scan(struct wfx_vif *wvif, struct cfg80211_scan_request *req,
 	tmo_chan_bg = le32_to_cpu(body->max_channel_time) * USEC_PER_TU;
 	tmo_chan_fg = 512 * USEC_PER_TU + body->probe_delay;
 	tmo_chan_fg *= body->num_of_probe_requests;
-	tmo = chan_num * max(tmo_chan_bg, tmo_chan_fg);
+	tmo = chan_num * max(tmo_chan_bg, tmo_chan_fg) + 512 * USEC_PER_TU;
 
 	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_START_SCAN, buf_len);
 	ret = wfx_cmd_send(wvif->wdev, hif, NULL, 0, false);
-- 
2.25.1

