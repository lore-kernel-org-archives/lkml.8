Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C421920578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TEk+NipW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgHUNqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgHUNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0734C061795
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so1981051wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RREMgoQ10AgEzpG5x2JxpJp9Y6xrNHTkcUblYPCMXMg=;
        b=TEk+NipWY9MDQ+vFrqSZQFe5XomXoCSXFWyfn5e2rmcBRQlGd1EGRfRYxZbDbl0Oxe
         aSwUsjFqp/SdChXATY5+9SCncxMp5bVLPKppFtmxDs8k9kZ7CVKSUxujASVnAp9jUoMQ
         ZuFoCqn7fFfnEUxYMaLPAySY9NCa0ogJzorb3N5w6mZfJ9tvT+uQ+Bto+ZGw6vGkVfgX
         FfzIGzR+Mj+1UcgWlURx9byVuJz9kIYcm2fXd3zFL9AFwwKVueGZiQe8PPdWryKpmHyi
         zWYfJuvCjVP5c5mtjrbdp8Wsv+vjBidRwGXKOm/WJAJDO4NSXyJn0DDmhptpS+Kc7g2G
         6xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RREMgoQ10AgEzpG5x2JxpJp9Y6xrNHTkcUblYPCMXMg=;
        b=YsJTPCCMAwgY1MGHNUGESbBRRv+6zMcaV9V7gj7gW/p4JdHFJ6TbjWcHv/zVrvuyub
         dwvraKxiNAuJrzFBaRw3rdIUQ2pPrQmB+sRWAeAe18iZSmIRTAMk5QuG8EwF86aPePZZ
         sVMeqO+H1Q40gU8y0JhSaCFHXt5TYpyaBSQl005gr7gTpi/SrS7ck8PMidT6KL8VKP37
         4zhWYa/MKpkvZM3sgbnmE8UoIlSDTjioAL2kZjFXese2MC+pjAxM7A6djDHAXUbdD6VU
         HX32XvXUGcfEjZy74B4J+9D6Mf+RaFtjWdkQFQeJlTkbaoTmMgRXJ4OCwo74/DFUG2Qq
         7guw==
X-Gm-Message-State: AOAM530h2mu/Y68iMoQCDXCB20QU+izaz62XDtbff2h23InWaSDtAyUb
        rntnMgHeY/uWunOAxWUA4wv32g==
X-Google-Smtp-Source: ABdhPJxNSKa69Xq37AHiVkE86BxigAIHhSSUTpLFuineyUb7ERAD88HYd3tG4d32P4MzeH5ESs5jmQ==
X-Received: by 2002:adf:f149:: with SMTP id y9mr2705908wro.93.1598017440423;
        Fri, 21 Aug 2020 06:44:00 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 17/18] crypto: sun8i-ss: fix comparison of integer expressions of different signedness
Date:   Fri, 21 Aug 2020 13:43:34 +0000
Message-Id: <1598017415-39059-18-git-send-email-clabbe@baylibre.com>
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
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 739874596c72..c9cfe20b383d 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -414,7 +414,7 @@ static struct sun8i_ss_alg_template ss_algs[] = {
 static int sun8i_ss_dbgfs_read(struct seq_file *seq, void *v)
 {
 	struct sun8i_ss_dev *ss = seq->private;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAXFLOW; i++)
 		seq_printf(seq, "Channel %d: nreq %lu\n", i, ss->flows[i].stat_req);
@@ -571,7 +571,8 @@ static void sun8i_ss_pm_exit(struct sun8i_ss_dev *ss)
 
 static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 {
-	int ss_method, err, id, i;
+	int ss_method, err, id;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ss_algs); i++) {
 		ss_algs[i].ss = ss;
@@ -642,7 +643,7 @@ static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 
 static void sun8i_ss_unregister_algs(struct sun8i_ss_dev *ss)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ss_algs); i++) {
 		if (!ss_algs[i].ss)
-- 
2.26.2

