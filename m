Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5BCC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A780C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrMUz80P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgGMOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgGMOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EEEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so16858128wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvpgFvNf+4M0KT7vkEQvPhnEsrG9RGiG3boyv4KDsto=;
        b=vrMUz80PGSbZwbmV+F7PV6yfcb4vbzA1BBwlGt7IOvaW2FLCyErAgUbgh3NA5AFTZT
         rg3rxyp5lxg+M2A/pXuyCzTDM3TWNfmw0x+5eph50aQQIqiP44NLYEPZwhNtkqrXaN+n
         EBxjJwdd3KlXlVgXOULY8K+XRuA45z14kJsz2+GoJaD2bwX6l1UPH0l0FesqMXKQO5qy
         gRs5C5COfiGZqTR7lsqJHfO8L0wnv0kfJw65ZLZ5Rro4d6AhtvU+udBUrlxwgynjyKH0
         cVH1XUiAqpYNFua+pzHpcO5Dl/yZC8SC7cpvPSId9A4hOyJnKWA/htNJMI3HFuLIH4C9
         DqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvpgFvNf+4M0KT7vkEQvPhnEsrG9RGiG3boyv4KDsto=;
        b=KQ+n0774c8/QCdXLNfmBIYTEyL0WpcUMOzRq9z4jKSu5CIh4jQPfFu/gFqAdaFE/E1
         73bLwKjoftceHT8tHiyQB3j3Tv3TR1BAjB2uM/MW4g7QEZZTzpmPRKOLynVgC/8iTTO9
         tna3NU8Vm4s72hOODubgEHn/LyJdjduy+nBeurKToTMmrHHD0d9FuVx5Me9BL2VnwIqQ
         /nOOSnYSLLyMfkH36rAp88B5xT0XZJwwiFX8bfI+adlvslXUO2x82FDBjNvW145S9anF
         scPsQ6rFJIakyPmQkN7jXIHoHQAXa+XDHJmMADXzpztPIXaOgA0Jsplcj2Zx3VI/9s70
         aoAg==
X-Gm-Message-State: AOAM531cnpaaNrW623cKRWivgpPgEHisCA7ZxjfovF6s67kdNo/sdab0
        6ZrUuYCFzeRAHM1JDk5rQ9E3bQ==
X-Google-Smtp-Source: ABdhPJxU7YOLp/XuHhUGNd2gC1eVG/AmN1zoITJziRxn5KRKhhZfe4M9AxA1e308qH/mPnzjiVsCOA==
X-Received: by 2002:adf:9524:: with SMTP id 33mr79455557wrs.156.1594651792520;
        Mon, 13 Jul 2020 07:49:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 18/25] pinctrl: pinctrl-bm1880: Rename ill documented struct attribute entries
Date:   Mon, 13 Jul 2020 15:49:23 +0100
Message-Id: <20200713144930.1034632-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinctrl-bm1880.c:40: warning: Function parameter or member 'pctrldev' not described in 'bm1880_pinctrl'
 drivers/pinctrl/pinctrl-bm1880.c:40: warning: Function parameter or member 'pinconf' not described in 'bm1880_pinctrl'

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-bm1880.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-bm1880.c b/drivers/pinctrl/pinctrl-bm1880.c
index d1a7d98367870..a8e267237435f 100644
--- a/drivers/pinctrl/pinctrl-bm1880.c
+++ b/drivers/pinctrl/pinctrl-bm1880.c
@@ -22,12 +22,12 @@
 /**
  * struct bm1880_pinctrl - driver data
  * @base:	Pinctrl base address
- * @pctrl:	Pinctrl device
+ * @pctrldev:	Pinctrl device
  * @groups:	Pingroups
  * @ngroups:	Number of @groups
  * @funcs:	Pinmux functions
  * @nfuncs:	Number of @funcs
- * @pconf:	Pinconf data
+ * @pinconf:	Pinconf data
  */
 struct bm1880_pinctrl {
 	void __iomem *base;
-- 
2.25.1

