Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E052068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8TZ28rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgFIVZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:25:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A654C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 14:25:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so76261pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9zvvHkYMkDaGTEKW+me8qA60+3Z319xyUwYS20n6J2U=;
        b=K8TZ28rOkHEoo+YZHwY4pe4qjY4oAjrRRdD6PQEKtb45xTUsntY64ayxjN9K/wq8bK
         0z6JQdBKiWMdVql42jgzBuiC5ROZ/RRXySrk8+iR1SzEvmho/xAb7nxJSsx9txFGeqjR
         kw7P11uqO+HceZm7dlVs70XHlp4FUJYmaejC2rAldPifCTVK64l3i+u2aWROh6AaXPCq
         vuMmR9nbaTatc7n2M92UdsVUvVAsqq7qlbJUrbEiZx1IBXl5GDEYuDa3S3yJoTVydElc
         jHDkDTLUh0zu5hUoiO8zDk9pHmoaB6eQGOowEwWjknDNaTY9s95slLAJZB5n/ACTVwIR
         dpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9zvvHkYMkDaGTEKW+me8qA60+3Z319xyUwYS20n6J2U=;
        b=A0FaB3CKe2iouHhmiFslNseINIzrGA820wJjkmzO62vjeonokwJyuaMZW4/mbf2YiF
         zEmaWy0o21jX5m+1CXVsigVQoasTKxW+VlDoTGOLL7sFfPZRVpjtBBOe8oQ3SCjRCr9R
         lNc0uYDBPptIfBC2B/pOrUY7QVYNVWdHP9aJ19UlcjO4vttO4VjaNJunjx8eaNimVMo0
         Py3dmOX2HUuk4DZS1rvIqy7KCkpi9zw2+gaEsZCvCy3/s8Pj5R+3Kyk2neeNiN62sXah
         gUKOV9jgWTFAbi5FZi1Fr1qOcFEirj6cZmi87jPPogsYVO3Cr/eMTP73Mv88inqj2dgN
         2QUA==
X-Gm-Message-State: AOAM532FpGMfJbX5uUqtCfVH3KX+bmPtu1jlPNgezKkfOkIn/2sNVzYA
        WDigqCACARuAlXA7J7fxU5k=
X-Google-Smtp-Source: ABdhPJxv0GaZjaUtYOXZO/mQEyw55j0yqpwPuT2kjRvK0icVlpUc8DeDAAGgQN512pDZBuG2YoB/gA==
X-Received: by 2002:a17:90a:6ace:: with SMTP id b14mr6927592pjm.13.1591737903696;
        Tue, 09 Jun 2020 14:25:03 -0700 (PDT)
Received: from pjh-vbox.hsd1.ca.comcast.net (c-73-71-152-156.hsd1.ca.comcast.net. [73.71.152.156])
        by smtp.gmail.com with ESMTPSA id gg10sm3178897pjb.38.2020.06.09.14.25.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 14:25:03 -0700 (PDT)
From:   Julius Hemanth Pitti <juliushemanth@gmail.com>
To:     gregkh@linuxfoundation.org, jerome.pouiller@silabs.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julius Hemanth Pitti <juliushemanth@gmail.com>
Subject: [PATCH] staging: wfx: make methods 'wfx_get_ps_timeout' and 'wfx_update_pm' static
Date:   Tue,  9 Jun 2020 14:24:14 -0700
Message-Id: <1591737854-11855-1-git-send-email-juliushemanth@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "static" for local methods wfx_get_ps_timeout() and
wfx_update_pm() to address following sparse warnings.

wfx/sta.c:203:5: warning: symbol 'wfx_get_ps_timeout' was not declared. Should it be static?
wfx/sta.c:233:5: warning: symbol 'wfx_update_pm' was not declared. Should it be static?

Signed-off-by: Julius Hemanth Pitti <juliushemanth@gmail.com>
---
 drivers/staging/wfx/sta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 12e8a5b..d855d87 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -200,7 +200,7 @@ void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 	mutex_unlock(&wdev->conf_mutex);
 }
 
-int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
+static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 {
 	struct ieee80211_channel *chan0 = NULL, *chan1 = NULL;
 	struct ieee80211_conf *conf = &wvif->wdev->hw->conf;
@@ -230,7 +230,7 @@ int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 		return -1;
 }
 
-int wfx_update_pm(struct wfx_vif *wvif)
+static int wfx_update_pm(struct wfx_vif *wvif)
 {
 	int ps_timeout;
 	bool ps;
-- 
2.7.4

