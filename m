Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857B020733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U4dAz5Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgC3Xpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:45:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54984 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgC3Xpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:45:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so629518wmd.4;
        Mon, 30 Mar 2020 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uzSi9/VYcTraEBB9HY7h/rXS2xZdLMR03bizri5gj4=;
        b=U4dAz5JvC5Fm0PIcTcWwiVNghqf0QdYuFyDYQm3OPsDtjHrCfMpE46Qo7orMdSK05Y
         P5DXJy38lM1lC7YIgMPBGH16GG5xBtNDRcaO6VhqWdmxtggajwky/+qcHKKF6NYHg00G
         W9dFPn3vX5HJ5BC7X8j9SbXwS6bz5LpzRR4vsM7CdR1Yyyr61PXhKsAsfJFGgRFavQaF
         EZ9CIwME/Ja3sdR3Y3OZLi5gA0KPfwcKI1DMz0CqjqajGHI5/TQsHPOpEJQX0P7FH1xD
         51fdQHUq+OFjP3ufeY+q8KJZYGaed/SA62fyiiORqKhq8vCQbVrEpKBxkAZ4+oEyOazH
         ZXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uzSi9/VYcTraEBB9HY7h/rXS2xZdLMR03bizri5gj4=;
        b=WxaEkxFQCTKSdfaJCXGIdjxg1OqNswcnvlTjAsAxmRLvHDc8QiYfx4IV1f8TS0PMly
         at9uXGcLepjUtouOiRudcQkj7cR76x7DyjlfLQ+ABRNeQcIm5FrKWp86AamHy730hJjA
         V+xmpS1A5NRKT6tISUbsRzK7wCC1JZQxa/wUyfhZVDA/a/Po2XNyOVZEMD+GaV6OvD2z
         iqZdIoGzFY2/yoq7dEO79Apgtqu4PadA1ImWz20XM1a5vGBlYEzgpNgH9e6lKXBPI7P/
         mK7KYPsmFGzkS/n7MDSstI/8yOsU+2FUZJfXZgrlpLrcFdwAdI166GVyN6fuwca2EHjS
         iwqg==
X-Gm-Message-State: ANhLgQ1FVaA9sqAZfQkaRtX7HPl7NPsqaIPmrvyy24x8Z7aUuc2o0EDv
        SGJxbLesKAp9Is5PefTb6G4=
X-Google-Smtp-Source: ADFU+vvtXm6WQtlMFz5iqFRMXzrlv57Bxn7PrxUOdXCnqT1tXpKTo5A1T4R+dQC9PFDeLc8AG/pT8Q==
X-Received: by 2002:a1c:2484:: with SMTP id k126mr575356wmk.52.1585611949773;
        Mon, 30 Mar 2020 16:45:49 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v186sm1392953wme.24.2020.03.30.16.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:45:49 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] clk: meson: meson8b: make the hdmi_sys clock tree mutable
Date:   Tue, 31 Mar 2020 01:45:35 +0200
Message-Id: <20200330234535.3327513-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
References: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI TX controller requires the hdmi_sys clock to be enabled. Allow
changing the whole clock tree now that we know that one of our drivers
requires this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 34a70c4b4899..7c55c695cbae 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1725,7 +1725,7 @@ static struct clk_regmap meson8b_hdmi_sys_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_sys_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		/* FIXME: all other parents are unknown */
 		.parent_data = &(const struct clk_parent_data) {
 			.fw_name = "xtal",
@@ -1745,7 +1745,7 @@ static struct clk_regmap meson8b_hdmi_sys_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_sys_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_hdmi_sys_sel.hw
 		},
@@ -1761,7 +1761,7 @@ static struct clk_regmap meson8b_hdmi_sys = {
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "hdmi_sys",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_hdmi_sys_div.hw
 		},
-- 
2.26.0

