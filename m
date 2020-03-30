Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE58EC2D0E7
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F6B2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DntqLisv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgC3CQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:16:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34391 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgC3CQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:16:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so7875709pfj.1;
        Sun, 29 Mar 2020 19:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myS2Ak0YzAiZAYZxlOLXD6g0s5EoiK6XIgAdluTP7WM=;
        b=DntqLisvfbXCnqjCecKzGWwXKYRS8QYf+7oVLcoDvACb7KlUTL9F8ovnpbx+CbzhKb
         kJ0PwGqphN2dx/hgjjSKOxBaSPyxG5HfSlOMLuurJz/1ltmp/lqtYK/dp8gkVfdYsbbo
         yDqKSn1c5zfZtUhej6XTu2i+uPKBxKKlJ8lDR+tZ6KErtYpHQyGcdDPtZF66JpkLwboS
         BwhVf7hK2mLYw0RDjcZhcAy8qrsbHYbhvE6ZaooZso/Bzs54kokEACdIt+D1xOD3aBBR
         FQbSlTQzHL2Nyee4SxaqEvVs8411/j7vW+Vd9keveGNo1g75ZrWajgjyy+2UCtjhnzMq
         ks+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myS2Ak0YzAiZAYZxlOLXD6g0s5EoiK6XIgAdluTP7WM=;
        b=p7VUTxkyr1bavzN1Z1YT06KmLmU8gQEs9hYAMK4ckS90V9NOvH5EFpGj3RGt3H+29k
         F7C4N8UGPJiZThU+61SzkqM+YeiU3iPqBCMimWPqXsfz78M0HVLE/kBoS9FSUnjQeSW9
         1QeHXf6HihzBJM/ZenyOulQd4QJztd4G4UuRhDiGSFVkLpPEFTHW46Eg7fvOZPVObuxn
         q36Zmv5jvMFxSdRDOCpggxmlwmPRd8YsDFAjDdteoTiQglUeDI3/C1R/sj0uZb/Ici18
         E45sXFjeS2Ro8nkwLWnv+ih463s/EgVBfdpmRbCJqGE1I3VSoS8NJ78pmKO0P7BIb5oO
         aM9Q==
X-Gm-Message-State: ANhLgQ3rezJ9Q/iT6WFRadV54OuePq0kldQpdZ0y3K365yMVa5FumIoo
        j/JNxc2u3d/x2PehOFCBgpc=
X-Google-Smtp-Source: ADFU+vsgwoJcfvEmC5kefiQJ5tmaLvyErZ2hpuh3RtC59p6o1BVBvJIu3lVyPGC7QIh8kMz9LYq8gA==
X-Received: by 2002:a63:a052:: with SMTP id u18mr11071296pgn.210.1585534609627;
        Sun, 29 Mar 2020 19:16:49 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u13sm3674296pgp.49.2020.03.29.19.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:16:48 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] clk: sprd: fix to get a correct ibias of pll
Date:   Mon, 30 Mar 2020 10:16:40 +0800
Message-Id: <20200330021640.14133-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The current driver is getting a wrong ibias index of pll clocks from
number 1. This patch fix that issue, then getting ibias index from 0.

Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/pll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
index 640270f51aa5..15791484388f 100644
--- a/drivers/clk/sprd/pll.c
+++ b/drivers/clk/sprd/pll.c
@@ -87,11 +87,12 @@ static u32 pll_get_ibias(u64 rate, const u64 *table)
 {
 	u32 i, num = table[0];
 
-	for (i = 1; i < num + 1; i++)
-		if (rate <= table[i])
+	/* table[0] indicates the number of items in this table */
+	for (i = 0; i < num; i++)
+		if (rate <= table[i + 1])
 			break;
 
-	return (i == num + 1) ? num : i;
+	return i == num ? num - 1 : i;
 }
 
 static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
-- 
2.20.1

