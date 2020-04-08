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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E32C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF6720730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTRNh18A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDHCAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:00:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46114 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDHCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:00:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so2600633pgc.13;
        Tue, 07 Apr 2020 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43YEEm544JLvl88YSTAStWDg2Ul956CWKc/PiTEpGVI=;
        b=TTRNh18APZ7kwJsD6yO1dJJ4bzXp2l0P2/sY2u+gdWCtl9q8EqZ0ljb+tguI3oC7Sv
         zIDtuY4TQSaSrIrIl7Kpjewx2iFRXNOtDs9VsmDRjvpfut+ItC+c0hberuM2a4596tNJ
         FgNIJ7xDhnwj6WeITB3sw7JTL8opIsEAPlzEwqS7XD6wekMgM/3+4TqF51OSVfWhiHk8
         QDeDbrKJ/S7nx7rVu0+6lwX3PCVv18tDQoUh0Dua8FOjJTHxLE1zkyTRs+GbstBitZGu
         NhTZADSqfgvwdyrNoLvVt8EPbW0gbzOfWyAL9EBBZGyHXpNIAbWtTQ2T6d7SrmXMqVV+
         ipzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43YEEm544JLvl88YSTAStWDg2Ul956CWKc/PiTEpGVI=;
        b=sIkSnCa7rNWjIPL+RvkjrBHHH+pH7Y5dFEdumIPBsTqMyGZFLBjsU/Uif5KriO6dih
         s/55/UqH0WSB3BSTytfR6P/SxZKyPBqptIuG0TAGBEsXIqlMYxi29CVBhyOu5fYsXmuP
         cp6k9ubiyu3JQeew3kt1RT+bRaKlqKjaMY6EU2QErUfXhjS+llv+cYbwmXeeMUxQSab8
         lZVAB1AYi33DSiLBtgvSrQ/S4hmvhf9BnTxK3wgDscVqnAXSmnLjEQ/SWwPxL3Z896CH
         XdIruqXH+jlawtzpaN1gZ0Rovp9Eob8Q79z/gICO0ysTaQuRzfa6/gT+A7sh2JNJnqyj
         QyiQ==
X-Gm-Message-State: AGi0PuZUJxMECkg4bchV+o0YLOidyN2SaDOSOR2bA9y/s6F6IGKg1cRC
        b/n4PAtUr95r/m+cGO/9ATI=
X-Google-Smtp-Source: APiQypLCeXhvzEj+hIJCgRGaz/Q1qEPnTyoQ7uiHBwZSbiOtF7MkvcBFXsAi/VunoA3EY0c+PsxK5w==
X-Received: by 2002:a62:8247:: with SMTP id w68mr5455549pfd.146.1586311208938;
        Tue, 07 Apr 2020 19:00:08 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g4sm15248070pfb.169.2020.04.07.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 19:00:08 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] clk: sprd: don't gate uart console clock
Date:   Wed,  8 Apr 2020 10:00:01 +0800
Message-Id: <20200408020001.31631-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330021640.14133-1-zhang.lyra@gmail.com>
References: <20200330021640.14133-1-zhang.lyra@gmail.com>
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

