Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E975220748
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9N8Wf/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDHCCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:02:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35757 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDHCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:02:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id a13so1691929pfa.2;
        Tue, 07 Apr 2020 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43YEEm544JLvl88YSTAStWDg2Ul956CWKc/PiTEpGVI=;
        b=i9N8Wf/LJH+2amaHGUiKYbQG0OzdWkX+FHFhPwtQbnDCAGscXjkCIUSZ/bvLwLZUM7
         Y09QKB2U7xK+46L6iNOflb1NnRHy+TLKU6U1EWKckDow9FpWmQLr9nqlNQtNwr2WaDpV
         DbD2KFqMUc0MY2NJk2GSmWtiNFrXNXCT0nJmKQsrbkdG1weGQ42zj2Tbw+m5jHwI7rfE
         5Gsc3CzqOLAYuaxMySb5zPOQiwEXskkJ18mv6mtlgQztdpOgpZhLUDweerlIAf99sdh6
         cIQV/mjzBMe7ikw9bVlfZ+I94AkRw/NVJ0FjaiwBEIgUZ15dzT5FisHDN9wa+dbFrSWT
         CHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43YEEm544JLvl88YSTAStWDg2Ul956CWKc/PiTEpGVI=;
        b=PN26A1vvLhDUT8ZkxjJ3DWIO3Mq0IJC80G3+RPg+N2aMR8C10cn81g60xX10k4eypD
         tfciPq6hL2cH2z7S+U9jdhIEAEadGYnUrujDsdgdrzi3JuyFG+S9CgWD6ZKyX3SQLPUy
         6PklqlMDgcNoPpuu/rGhR0bSaa4QQIkDCCBcNZYdZoS0ZbvAio8i0zzVbXX+Uufijay1
         8yZOxXbpz+6QgaeKxplpF3IlX9bvFTgK8L8vRlgujk5jPrbU/f4epMKJT2nsp3rQ8Ird
         j8LgEDKqzeWK7PljC3/FIHd0x8TWQ1SO/za37+ND4ItVbwIUWGr3rTnyOyI6S5OBFU35
         VgJg==
X-Gm-Message-State: AGi0PuYq1wDPuA8ykH0r/JTFUed80LKiO+i0BzWmiRfF8yFijHlGot66
        y83CYj24e0pMd077ngA7gzQ=
X-Google-Smtp-Source: APiQypIcZc9Lpo17buZl6AcMBw+5coHXSfyBhG5ebLrCzeKCH7p0zTmAUWlhbLB6thuzxcU2Fjt6Tw==
X-Received: by 2002:a63:cc03:: with SMTP id x3mr4933088pgf.28.1586311361541;
        Tue, 07 Apr 2020 19:02:41 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r14sm3007912pjj.48.2020.04.07.19.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 19:02:40 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] clk: sprd: don't gate uart console clock
Date:   Wed,  8 Apr 2020 10:02:34 +0800
Message-Id: <20200408020234.31764-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Don't gate uart1_eb which provides console clock, gating that clock would
make serial stop working if serial driver didn't enable that explicitly.

Fixes: 0e4b8a2349f3 ("clk: sprd: add clocks support for SC9863A")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/sc9863a-clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
index 24f064262814..6c6ac158ef61 100644
--- a/drivers/clk/sprd/sc9863a-clk.c
+++ b/drivers/clk/sprd/sc9863a-clk.c
@@ -1671,8 +1671,9 @@ static SPRD_SC_GATE_CLK_FW_NAME(i2c4_eb,	"i2c4-eb",	"ext-26m", 0x0,
 				0x1000, BIT(12), 0, 0);
 static SPRD_SC_GATE_CLK_FW_NAME(uart0_eb,	"uart0-eb",	"ext-26m", 0x0,
 				0x1000, BIT(13), 0, 0);
+/* uart1_eb is for console, don't gate even if unused */
 static SPRD_SC_GATE_CLK_FW_NAME(uart1_eb,	"uart1-eb",	"ext-26m", 0x0,
-				0x1000, BIT(14), 0, 0);
+				0x1000, BIT(14), CLK_IGNORE_UNUSED, 0);
 static SPRD_SC_GATE_CLK_FW_NAME(uart2_eb,	"uart2-eb",	"ext-26m", 0x0,
 				0x1000, BIT(15), 0, 0);
 static SPRD_SC_GATE_CLK_FW_NAME(uart3_eb,	"uart3-eb",	"ext-26m", 0x0,
-- 
2.20.1

