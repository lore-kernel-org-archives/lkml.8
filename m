Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA8C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0397206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kpS0ODIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgGUTHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgGUTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so3854938wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IClHRVpfuk7pyuQdBbEm+ADLfyWf25fRbOn1BdIIJx4=;
        b=kpS0ODIMjq+Rex/AWKOaWVHiTIYVRyqA1p81k5RhhxTrsSUm7oxY721P7m25ai52mn
         eGD8THFhFyBroaNH9gyg+kYiZ9oGqSKMVpbk53qlf6NwbxbOhFms34PilOy8uPXuUuel
         f9PB5MJXN+GBiDm4pvJxEmHJhFGprO45X0Q472aewv9nmxqZyCULD6DE/Z3Bd6abmVtg
         WstaO+kbfW3SBQiNKlHaRuy8vPEuwSbX8QUKa9+vTDc5hYcwXDbwcdv80x3kNCq2K83m
         R9WY6i/ZHcgXp2l3a84yuAKXcywUtpUG9V9MYieWweqaEbnv2H/5pHYn4hHd50oVXCOP
         1Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IClHRVpfuk7pyuQdBbEm+ADLfyWf25fRbOn1BdIIJx4=;
        b=ey8nJf9/lJiYxZT3HXycReDBPbZoZQcLtmuldxk01HS9J8hmoN8mtrb4AaGywATu+e
         I2cN94pNlMEAkUbWlLZPnHCNgayUAFXy2cdGUpvp1mr4HFhLFwwjfnzkLGQTPJMk/Sgn
         F4IykXvIIsYOAEmvvp9JVgt5IfTD85P02AZnw287whipuQU6x/WsJ4BDB5tOlfvy92J2
         a0EMPw3c00s1bCZJyQw6h34pubkGOJgW/ndvl+7yrVfmfm/LgFhPVl0HWnori0FvIuwN
         JyVMowCzjp4Km2m+j4+o5jPIGiEnwltTLOFoP16c026SuLtdRKBKiSXOsxwp41xzncJ8
         7DlA==
X-Gm-Message-State: AOAM531NFpY9vpiC1QU8ldSjK32Sodd8geT4sTxW5WbBADH9sTy0Cp3/
        q+0cH4MtpdNBydw3DxmiRGwBkQ==
X-Google-Smtp-Source: ABdhPJxkKsBBqSYMLl2ItrQoeHhFa7/eJVIPmedqJIvSOSX/Y34StYaam6LPLJv4WsxLjn/RcUwp0g==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr5348230wmg.56.1595358416326;
        Tue, 21 Jul 2020 12:06:56 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 16/17] crypto: sun8i-ce: fix comparison of integer expressions of different signedness
Date:   Tue, 21 Jul 2020 19:06:30 +0000
Message-Id: <1595358391-34525-17-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning:
warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 3901e3401c6b..7b2a142c9b8d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -566,7 +566,7 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 static int sun8i_ce_dbgfs_read(struct seq_file *seq, void *v)
 {
 	struct sun8i_ce_dev *ce = seq->private;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAXFLOW; i++)
 		seq_printf(seq, "Channel %d: nreq %lu\n", i, ce->chanlist[i].stat_req);
@@ -778,7 +778,8 @@ static int sun8i_ce_get_clks(struct sun8i_ce_dev *ce)
 
 static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 {
-	int ce_method, err, id, i;
+	int ce_method, err, id;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ce_algs); i++) {
 		ce_algs[i].ce = ce;
@@ -858,7 +859,7 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 
 static void sun8i_ce_unregister_algs(struct sun8i_ce_dev *ce)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ce_algs); i++) {
 		if (!ce_algs[i].ce)
-- 
2.26.2

