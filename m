Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C591D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlAfy2qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEOJku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727898AbgEOJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:40:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E7C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:40:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so684109pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rKmZCcVKTIVgCO+z+GlkssBEJpYMxklWqKhfYU/OBVw=;
        b=ZlAfy2qQSjg+yhOrlIGiA3r33pwsHJXBZMFY9e1KDLMutt0i9qo/LPRiXgBSJ05d3w
         PHya8TF0no0u/FdQAiTrM7w4dNQ0MOKkdwPVc4GHANK3hUiclzAyq289ERuk3o9a20hd
         MDb1bCT7DYdwlVX8H/9xkmwPkNsveya+KVBm9UWN1mOzGaiJZXAwHQcH0sQModNr8Oj0
         pHt7tD7Z1/sLD6zRihXl2lrGAG6lk9RgvcYL+rcAk82XFy5J1JJFHb6Rxh1G748MSTP1
         nfrplRHTdK7PwBPxIhsZwHUHTRmgsHnE+wRUDhQ2nMzzXvmF6tkhy7Xp1RemztOCmwJ2
         F0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rKmZCcVKTIVgCO+z+GlkssBEJpYMxklWqKhfYU/OBVw=;
        b=RTrX3Bqt8W2syb8fUfJ7V6xpmDc0KAbP002xlT5qvoK6ZcadGNepMT6pKrzBpFIOJd
         8VUHDRGaYaMhV9uod6ky2OR7r6NPZRTjiWFuRs3uWhL48fvEZHTnquqApdVLA6FQeeXT
         oYRLwaR4Y2eEwX9t1Svz/VB38BQQR2itBPtuFkUaEOqVK767BEOYNRjpWLsy3YAR1Rsc
         OZNpt53kySrTmhiGX/osTZH0uA9xG9qihxosNJYNwFfZKEXocrIIfj+A1Wcoh4K0Bcay
         2ZMv48Iph6PDD49g+5W8b29vgaYDh1g2xXyiheneSkr3rZVcwfMjJdHMjPmdiXPJaTHR
         PXCA==
X-Gm-Message-State: AOAM533qZlE4m4Ob7VWKwD14iC6hEvnfHvwze/B709qimgY4leMGIHwI
        vSn5y0od0XhXQVYNcgME3EE=
X-Google-Smtp-Source: ABdhPJx0VC3lwdcXvsKRqbN7D+s7an/8aOByh9MDHsLGMbJTkmK+wfEFQ3gqWOMy1tW+kDu2YuIJwg==
X-Received: by 2002:a17:902:599b:: with SMTP id p27mr2586551pli.75.1589535649041;
        Fri, 15 May 2020 02:40:49 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id z13sm257789pfj.153.2020.05.15.02.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 02:40:48 -0700 (PDT)
From:   heshuai1 <hexiaoshuaishuai@gmail.com>
X-Google-Original-From: heshuai1 <heshuai1@xiaomi.com>
To:     gregkh@linuxfoundation.org, vkor@vkten.in, nishkadg.linux@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        heshuai1 <heshuai1@xiaomi.com>
Subject: [PATCH] rtl8723bs: core: fix a coding style error
Date:   Fri, 15 May 2020 17:40:44 +0800
Message-Id: <1589535644-6820-1-git-send-email-heshuai1@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this coding style error reported by checkpatch.pl:
  ERROR: do not use assignment in if condition
  #1120: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:1120::
  +	 if ((addr = of_get_property(np, "local-mac-address", &len)) &&

Signed-off-by: heshuai1 <heshuai1@xiaomi.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index ca98274..06be1d4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1117,8 +1117,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
-		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
-		    len == ETH_ALEN) {
+		addr = of_get_property(np, "local-mac-address", &len);
+		if (addr && len == ETH_ALEN) {
 			ether_addr_copy(mac_addr, addr);
 		} else {
 			eth_random_addr(mac_addr);
-- 
2.7.4

