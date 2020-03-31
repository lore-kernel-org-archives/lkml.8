Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8ECC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292EA20781
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/uFeqjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgCaKpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:45:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgCaKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:45:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so7968975plq.13;
        Tue, 31 Mar 2020 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxLEB1TjwZBGmBB/ZQJRbk9MhV3+/5MVrEoEIkaFWEg=;
        b=l/uFeqjg0Q+0nCWWSVLir1llB/cFAJYfpZ3Zfu9Ci8p5zGEUjrRzWEnsoTaUqcZuZ1
         fMjYD/uYZQsNy0HLUAO9JATrWl9oFdwsN+4wLi9j7g+wUxBAwdEqB5dI9yiYuz8jJEHr
         MuDjcS4S0AK6CnWxnS5Kba+w0bmBjfUcom5w+C9gCAk35if4WDTgIeXAuyyJTIE5KFkL
         cdy3DpXcH/AHshPQtKZDg8Y6N4Ep47NiE/zBOx8XKfEt8lGu9fe26BZxWi4XdSOK/vFX
         hhySvozVLUQ9dK6RM+i/IGwzIRcE1b1RVi6rDeTbLKFmHZK4eyF8DqnmwLeB4QvMMvWI
         RBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxLEB1TjwZBGmBB/ZQJRbk9MhV3+/5MVrEoEIkaFWEg=;
        b=UuG4Fz9KNSU4XcOXKH/vIuGcoHJM5ubG/7tV+MZTC3v2eD+mLxWSL1jYkv5w7Xq631
         9q6oowOgizRfM5EauFb/8ZPFT/MGDLefw3NbCXxgKijmZyVVQxRLC+iNPZqnhIOlovts
         aWUJ0krxzb6XhkqD29qUqgkEl7rOun7mf91jGk4PxO+AEZkf9Q+8UDxnKPILrPxhWXVv
         Ki8vETqABbrsO6kMhPEzacFbzz1CioZNe/5P9FeVB2fppI+CjYGOQeRX31A8j4Wt2hRD
         Egjcp4gnUgzkUHa0t231CWmJKt9o4bd6+aeKeOC7CUEkE+RM/CH3OBrxQPs72NZPlelL
         RXQg==
X-Gm-Message-State: AGi0PuaUQdJgD81Rq3Zq54RpJu3pKXZa6XSdGmHhkaRq/2l2q8p11UQ6
        1cKaZBQdkAE+mG2FBfsBRcg=
X-Google-Smtp-Source: APiQypK8so6BAq7FULz+XoJNXwOxMoGi2MmMOD07bP1gBNmL+vOeEB4AXL8DdPxsGWzACbpZvKAugw==
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr3175902pjy.157.1585651547915;
        Tue, 31 Mar 2020 03:45:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t1sm11432236pgh.88.2020.03.31.03.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:45:47 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
X-Google-Original-From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] clk: sprd: don't gate uart console clock
Date:   Tue, 31 Mar 2020 18:45:32 +0800
Message-Id: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't gate uart1_eb which provides console clock, gating that clock would
make serial stop working if serial driver didn't enable that explicitly.

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

