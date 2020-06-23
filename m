Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F6320707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948109;
	bh=qfDGp8y2Sgz/L41SXVjn+sgKFR3izMpAf5AaFrTPn+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKLXHmlSGurJHPe26vrFxItJ1USad0CPYwjMoZuGGz6JpS9mzNZKFHTxOGPygPQOw
	 mcYOM4NVzJoqw+mPGQPBCgYBl1Z/4xYml0okZY5EpoRfpKB/YwKiRGO3lkbmfyt021
	 tOIkKglJxHSCQ3o0Cia5eYxzShnpHEMGqbhHv4GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393687AbgFWVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387829AbgFWUKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:10:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E4020707;
        Tue, 23 Jun 2020 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943040;
        bh=qfDGp8y2Sgz/L41SXVjn+sgKFR3izMpAf5AaFrTPn+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bU9r0xn/SwF19LlsU5J02SU4aUwZJNP/bTOU4hORXPpTj2DsVaJacMkNc2auY16uz
         LCsKurod/nJS2YphzO7y9POdzDdzbRDRhO1lZ+bqHcliDpyQO0BRI9MuzbVqZdv9VH
         oYq348HEI+bdfKKcEySwXq4bgEkPl/86PFnfvFvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 205/477] staging: wfx: fix value of scan timeout
Date:   Tue, 23 Jun 2020 21:53:22 +0200
Message-Id: <20200623195417.271609796@linuxfoundation.org>
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
index 77bca43aca428..20b3045d76674 100644
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



