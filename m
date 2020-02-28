Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF99C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2313D2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dM53bfJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgB1O7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:59:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgB1O7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:59:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so3471288wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5EizECLIpIUfC0QN1DsU3CZsuQMZC0Kr0ghGHK94gY=;
        b=dM53bfJArZO9qb5NtLhcf9fc9MxXTPGgqO3tpgopcYReBgUho5eqi1N4rMXS9hsPIO
         bbkpxg0yo51Fvf4BwzAb4CfC2sD63X2WtvYWPLv7cWyQJCSog1KpwF/phVOuKjfH99JJ
         si+flQaseTvCB76w9gaIft838bkEKFINaKQPDPUJqbRvPBdgdGK4dq3u9k7rwTn2eefk
         +8h1z3G9nTC219sIi3SczvSOuhixetoUyuZS3is+6yOodcVIRq0cvQOlyKQkOqHjExts
         cesC9CkNqVWYffLyDEpvK9r+ytutG+WzBm0nWlZm9LOR53/lp5I+OvPt7g2WJhONK3WZ
         i+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5EizECLIpIUfC0QN1DsU3CZsuQMZC0Kr0ghGHK94gY=;
        b=WNgT2pSYy9eJ5+lmkGDQ2/q+eQDfOQlrBo0gmP0khcLGZ0Vd0EwLKlV44KAG2qVG00
         iUOvuTb4ckoz7cLswPYOVBlgafz0v77gTOZekKD6LdZ+Ty6YnjZ4VNyBGSCEa5gPvQKc
         9FRn9TCNiTyRCLCyC+2AjCR3q0cA2GX6/Ht+u/+3c+RLgQYVTFmzBVnHbECdJRJayXpX
         WP0tIdob9J0g6+yD9QmlZYfrROHSmE8dPThTLm83DjjJrrsqMxUOi4n9d+YdcKrSQNg6
         Gs5NoSjmA3f92oyTH+E4qDAzBEkTsVyP6G6y9HTpuQZkWRqtV4H8Ulq7WISqRd3v5LGP
         PByg==
X-Gm-Message-State: APjAAAVGXRwj3CNQTKU10V6iHEethYnGbKbiJiYGQTcrHfKJKkclvaER
        nSYoDe4std74nfUMugNcqW07hNemU1g=
X-Google-Smtp-Source: APXvYqxjbt3ytt/Dr/1YIZdifDKh3nOAVB9e7+Uemwzlc/bYGS1B9wcC4muJfMkxNQXqLI4fVgr6sA==
X-Received: by 2002:a1c:1d06:: with SMTP id d6mr4888765wmd.99.1582901988027;
        Fri, 28 Feb 2020 06:59:48 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id n3sm2659348wmc.27.2020.02.28.06.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Feb 2020 06:59:47 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, georgi.djakov@linaro.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH] interconnect: Mark all dummy functions as static inline
Date:   Fri, 28 Feb 2020 16:59:45 +0200
Message-Id: <20200228145945.13579-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few dummy stub functions that are not marked as static inline
yet. Currently this header file is not included in any other file outside
of drivers/interconnect/, but that might not be the case in the future.
If this file gets included and the framework is disabled, we will be see
warnings. Let's fix this in advance.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 include/linux/interconnect-provider.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 0c494534b4d3..5b64e267bfb3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -117,7 +117,7 @@ static inline struct icc_node *icc_node_create(int id)
 	return ERR_PTR(-ENOTSUPP);
 }
 
-void icc_node_destroy(int id)
+static inline void icc_node_destroy(int id)
 {
 }
 
@@ -126,16 +126,16 @@ static inline int icc_link_create(struct icc_node *node, const int dst_id)
 	return -ENOTSUPP;
 }
 
-int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
+static inline int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
 {
 	return -ENOTSUPP;
 }
 
-void icc_node_add(struct icc_node *node, struct icc_provider *provider)
+static inline void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 {
 }
 
-void icc_node_del(struct icc_node *node)
+static inline void icc_node_del(struct icc_node *node)
 {
 }
 
