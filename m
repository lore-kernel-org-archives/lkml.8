Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73383C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB082075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONRt9F1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgESDAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgESDAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:00:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C6C061A0C;
        Mon, 18 May 2020 20:00:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so3245833ply.11;
        Mon, 18 May 2020 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eozjto79cDaaYBRhhL0JqfzI0jgkFXP1vwEZQbjMQKU=;
        b=ONRt9F1E+eDwlkaAvdGC2p2pUX2Ert93Yot8UDXGJkjbURtIhWH/qiAAYF5xhBREQn
         bVA/B059BU/o/w+AQBqFCK+RysA49IMCsiiWexwlF80xLUDD4/SASijPnXIvFpB2U7zT
         Lz9gtXDthPvH7ol5HqdDaPi12+7HM4GJiBd+YEuWVglKynijbCap8gaGzKj2DLgT4yB2
         kbzOPQZZhybuLXYolQ+vm1gWAcO5u4Op/nOYSjGQQv9553SVkU2a8ms7EFtishNvDQCn
         rkTsVCUCcqpzcg9BWrm32xW1QnCgDngyUvb15NyOtRpCJejmLbjAj0vAekRUVZaQXQBE
         biSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eozjto79cDaaYBRhhL0JqfzI0jgkFXP1vwEZQbjMQKU=;
        b=sgATCaPxrnIrCtPn3qKTE3GIPdj4T7ZL8WWjRX7CW6DxPwfSr2pcfEjkxhwDG6Ksh0
         F50Urp+Bg+S5CXHkLpDae/19BqHBAOJBipBxi0SZnE0Sn+kvM0cyLjmTpBfAXeufwsZA
         /WWh2ckOHEJKAm8SBmQWHfBlBD/8su9JmvN0j0zwcS4nKC1SeQDdNYToydnmAdKL+zhF
         Ql9FJrmNqQu+LH6NWT2Y/a2OBTwT4oFmpjVf5CXre4mkMXMdr4AMp8KETxnL8mv41fzx
         /eiAC49DmZuVf8LH3ngMw4eVF0Nivf2ekTHAAc2+0V2ZHaaMTTD5xtIGBBu/jblShhGU
         k/2g==
X-Gm-Message-State: AOAM532AQJVJOSwKtc0URZVqigx1kDdiDPnLp5ZI9u1fKQE+ylG0YILS
        BCLtCRAVrJB+zy8lT07gM+s=
X-Google-Smtp-Source: ABdhPJz8QN5RT4ze2AENM1VjOY7uZWHZOObN8Ab2QuFZV98/1OxTfYA9AzMYQYq3wGEB4JkCnJhraA==
X-Received: by 2002:a17:90a:141:: with SMTP id z1mr2613706pje.33.1589857247615;
        Mon, 18 May 2020 20:00:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k24sm9809494pfk.134.2020.05.18.20.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 20:00:46 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/2] clk: sprd: return correct type of value for _sprd_pll_recalc_rate
Date:   Tue, 19 May 2020 11:00:36 +0800
Message-Id: <20200519030036.1785-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519030036.1785-1-zhang.lyra@gmail.com>
References: <20200519030036.1785-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The function _sprd_pll_recalc_rate() defines return value to unsigned
long, but it would return a negative value when malloc fail, changing
to return its parent_rate makes more sense, since if the callback
.recalc_rate() is not set, the framework returns the parent_rate as
well.

Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
index 15791484388f..13a322b2535a 100644
--- a/drivers/clk/sprd/pll.c
+++ b/drivers/clk/sprd/pll.c
@@ -106,7 +106,7 @@ static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
 
 	cfg = kcalloc(regs_num, sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
-		return -ENOMEM;
+		return parent_rate;
 
 	for (i = 0; i < regs_num; i++)
 		cfg[i] = sprd_pll_read(pll, i);
-- 
2.20.1

