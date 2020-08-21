Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C79C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B2A207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="15hPCTEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHUNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgHUNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0841C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so1962418wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agXVF0ms/CfrT8LzQj5/+SUtzz/nXnxAuE96neqmqJI=;
        b=15hPCTEhz90sOk9G1u0Wj0T4eLteE/IpZ0JNTRQxKWU91rHwuaibBg+64666Mf+fta
         KBhpOJLg3IDAHOnH60D+J4dfyIE2xyZJE0FLjqEN0e7MvMOgDbJuKke4pu61JFk5kwu2
         JS51w/BycHBmH+c2nq9zVPq0DXWBC5EEXkBrDvQK5lbo2zNJXeX0luTLQ/gbdMbvvS9y
         e3kew6aQ0D0cZ8XZFBMo7KuDsFxmOxOt98xnMDs4so1V/wRJp7AAZAkomjYURtUNxugw
         UcXK1y4cJVkhVzmLknFH6ysv/yDuWIJ595sEZb0Hab6T0FYoGYAR3BcJMY6ZeAuyS9dJ
         8mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agXVF0ms/CfrT8LzQj5/+SUtzz/nXnxAuE96neqmqJI=;
        b=I5XC/8Btc3bdrYeJqsQPUsvgD9ShPHQ13hqJ24USXzofZpknHAADH2wOZ/WfNM25I3
         jY09WC9iwtPJzf2ftZVVs3W2AT1B0y6od5AFaRKrbkW5ug4sUDyuR2I4UHhZ+nZzf2Xl
         1NsmDaH6hkS9qEVt6T6uLTVzqwxE8QfDI2I1BvpJPFiJo/ERFIVsr6G4DmiZ12LJAwz3
         IzWRly2HpEJPxtsjkD3JWTnJEEURw8HNHudViTYXuZxvkIsvAzpTCSB3yfvO1k3Wsfvc
         0BS7VuZwbBL9adWz719uyZDAfJCUPbgiVL+bUKkFCxHm4PogSTnmUITL46oxoNupl/yV
         vbTQ==
X-Gm-Message-State: AOAM533fIrisBE57tjOUGuriySZc5cGiFPfXCWa4Bb6AX/Op6p586iBt
        g9SqpRC7rgM77RNdK30hEJx3mg==
X-Google-Smtp-Source: ABdhPJz0GIprw7ocZ1X/wsRU33gQ7S9SPzLVWbTTCdWp40pbtOG5+ieJ6iLXeKfeq7y/BFI5xZngkg==
X-Received: by 2002:adf:90d1:: with SMTP id i75mr2696922wri.278.1598017439573;
        Fri, 21 Aug 2020 06:43:59 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 16/18] crypto: sun8i-ce: fix comparison of integer expressions of different signedness
Date:   Fri, 21 Aug 2020 13:43:33 +0000
Message-Id: <1598017415-39059-17-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
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
index 116425e3d2b9..cf320898a4b1 100644
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

