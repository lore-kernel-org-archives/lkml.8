Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F4C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A1420771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf6Ht3J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgGVQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:18:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370DC0619DC;
        Wed, 22 Jul 2020 09:18:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f12so2823431eja.9;
        Wed, 22 Jul 2020 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TBVZPJ7eiK7Rj07MgbjTYAxf0mSfdzYtCLBYEc1p9SI=;
        b=nf6Ht3J/nNK0uiHU7avSENiPKKiDP/9q10mv1APHwAEK3FlMOrIOTbTnLxoIochtKC
         froOopOJ2DtLCC07mtzokdvMF4DC8xJyd0i6rRlSFRu66m15Sg18Qmu0wyfRa7szIee7
         gABM6RiXv5mnoHF01D0qM8IB4BcQ1rHjQs2dUop2radeLAgt9Opi54a6QY4mN6YBjWo3
         Mmd7KGIrlh9bc5VTSfm45ifND/LgZXuIX6Pg1y/+dW2bxv/GBz2xBjhytSHz1l2hXJ2b
         AhYx1+4h09LpOX2Qa4hKgPcs62C+BVNEFFf7mQKfTFRspl4p6iFsW5Zvx/1NvdBSfMqP
         LZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TBVZPJ7eiK7Rj07MgbjTYAxf0mSfdzYtCLBYEc1p9SI=;
        b=B6VGStQ681hx8Md6jpf5gkMLzFguWQEt/AGzY8GT+aIZ186JTniP9CPM8ghtluSuJx
         wz8M/eHvrLEY/cggxhbXZUHID/RMozZwBwa2UoMuO0HriBSay4GsX0CFD9vu8fn8B9fd
         CaGOJm9gXsTZqpVp0ZE5no0Dxxy7t+tLQ6hSa18nyzcB304Mcv0C9JwqPsf4JmNwFj/S
         R3J0E0T9ScmOLnMkKfODPw6QYyxApCjGtc5PutWmC+8O/Cl4QSht8io1nl3e7FyqmQ+R
         aSIt8dBrduBvuRPofw7maB9dhy2aybcaX0heKFTyrrg6viqWKtwDgJdvEk0jiU40/RhM
         r87A==
X-Gm-Message-State: AOAM530sHHRIM5SfXxNn2A6JzZ19T23g2SR2TYZf/TjalJZLescpt7A+
        i59jIwL14tAz4rRi0C2KD5Rb4NcasQ==
X-Google-Smtp-Source: ABdhPJx6hR1jLeKhYCIi6mOgl2ZnQOXoHE/znZ1XOOsjmKUpaiW/2XlZUT6RaGGJveS3J4HKymIypg==
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr339791ejx.20.1595434704723;
        Wed, 22 Jul 2020 09:18:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id v25sm190334edr.74.2020.07.22.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 09:18:24 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: rockchip: add sclk_mac_lbtest to rk3188_critical_clocks
Date:   Wed, 22 Jul 2020 18:18:20 +0200
Message-Id: <20200722161820.5316-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the loopbacktest clock is not exported and is not touched in the
driver, it has to be added to rk3188_critical_clocks to be protected from
being disabled and in order to get the emac working.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

Changes in v2:
- add sclk_mac_lbtest to rk3188_critical_clocks instead of adding the
  CLOCK_IGNORE_UNUSED flag

 drivers/clk/rockchip/clk-rk3188.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 77aebfb1d6d5..730020fcc7fe 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -751,6 +751,7 @@ static const char *const rk3188_critical_clocks[] __initconst = {
 	"pclk_peri",
 	"hclk_cpubus",
 	"hclk_vio_bus",
+	"sclk_mac_lbtest",
 };
 
 static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device_node *np)
-- 
2.17.1

