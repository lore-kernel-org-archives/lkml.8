Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABEC433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CC720758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l66bxH3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgGMAZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgGMAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:25:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B8C061794;
        Sun, 12 Jul 2020 17:25:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so8785060qtf.6;
        Sun, 12 Jul 2020 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4yQWsV3hafAnRd1iMkIJnrGo0I7x9nIZbKsXQ6vuOoQ=;
        b=l66bxH3T0hYEOojWemVsG55gvHVVNdfgRx+tePJbX2Cz189Ng79z8UFE/bpG/e+IYN
         7Pny8+xY+hGzQSFkGIsEItZ5NoHfSLYcTFTo2E2M7xFpOw4jhc+QXTgZSVPV6UarHuNu
         MwqG4lLCBzNXJ6busNkOTaafnuBFfyDX1tqcrJx9LyHCR0K3h6yMlLfNpm04E1wClKnj
         DkkAKtd0Sfzc1BHUPI7a0ypnXpH6VzZVjPvmYpAK53Su5yJ82TOgai7NpXKNWIrLVgJC
         VqO4MP3rgqdtKrfJSCYPWU2RXqrvKjNCpqbHNvfqobQC6xygU5fdmI7wrANO3j8+ES7M
         YUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4yQWsV3hafAnRd1iMkIJnrGo0I7x9nIZbKsXQ6vuOoQ=;
        b=A63HALtYZeqAhcVuWq8N8RDDN/nVr5hmksp8oak3z1Q5s4cgAm3eDKmQWDVGb/R810
         WA+hIDyoJyL8UMNnC8o1udFK8lgkvQ3Toqq9jy2TI77R6oMkr/isaWCmJiyflA3Mix5P
         5EF64FGMIPb3JmMTvxInn+QfdMIfMDL1acgLOW4WC0cFJB63tmkLiMCapta26cpmv16z
         KML6Ygi8D7WAIQ+fcT6UAzT9s5EliR/xgYLBjNmauZ3zz+V37v6+2W76q9QCC8jqu/UB
         +rDD8bfWgyCCsIsLVJmfi5z499set5GZsXQ3x7hCfNsQOH7f8nEtMBiaprcPcJ+zhJBH
         uh5A==
X-Gm-Message-State: AOAM533psCU0MN3wyygQJ+jdN6qnu5RFbO735N6SXpOkfjMACJYHJwNw
        bMUoMFuHREYgv1+6uf+VXA4=
X-Google-Smtp-Source: ABdhPJzt3sAiG67OOOhQUVrk7ZtI2DTYmDz5vEAjSTuGwwcAKA2Xhka+ZPwPkwftJadOB+jToYbqmA==
X-Received: by 2002:ac8:36ad:: with SMTP id a42mr84650612qtc.21.1594599917601;
        Sun, 12 Jul 2020 17:25:17 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u5sm17044309qke.32.2020.07.12.17.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 17:25:17 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 1/5] ARM: mach-imx6q: do not select enet PTP clock source on QuadPlus
Date:   Sun, 12 Jul 2020 20:25:08 -0400
Message-Id: <20200713002512.28742-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713002512.28742-1-TheSven73@gmail.com>
References: <20200713002512.28742-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On QuadPlus, the enet PTP clock source is selected via the clocktree.
Therefore it should not be set in the machine layer (mach-imx6q).

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.8-rc4

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org

 arch/arm/mach-imx/mach-imx6q.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 85c084a716ab..fcf211492f6f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -169,6 +169,10 @@ static void __init imx6q_1588_init(void)
 	struct regmap *gpr;
 	u32 clksel;
 
+	/* QuadPlus selects PTP clock source via clocktree */
+	if (of_machine_is_compatible("fsl,imx6qp"))
+		return;
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-fec");
 	if (!np) {
 		pr_warn("%s: failed to find fec node\n", __func__);
-- 
2.17.1

