Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDEC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DEB2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5Zqjzao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD0R2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgD0R2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:28:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B29C03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:28:14 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so14534396lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dq6UXDEp+CfhWskvNuEfUSYYLoNA4rRIzRZcrwo0+MY=;
        b=x5Zqjzao8L+ufNxFV7ltgeMVwwgp9ywdXPktv0A4tuA/TaySL6cN2ioBLum7Civlu1
         mOWqG0GZaqxC6XmB2whqvkJ6yZkI0+6/1DldT4Rf69iCuuSf0fzdh+rzwK4wQWJ9NFAQ
         CToGTup9Wx28bgq1lK6Xy7mcBOZeXGt8wmg6wXw9RU/LEIAuwNm1SLphUKyKPYjRtniM
         CCzKJii7PGY4MRFaNyBL2QrXRc2B2UjrogvGv7J8dalEq2ezNIRUz+aHLTni/Xm5x/ve
         ThCVeWwgJaPSJBVccziQTvoX+uAfGA06P2WGFUEW+jeOhpkofx1dzeVWKGFdcZrbc/Vy
         9+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dq6UXDEp+CfhWskvNuEfUSYYLoNA4rRIzRZcrwo0+MY=;
        b=uBJBM06DbUrJGRgeZe5G3MhAkZTHLevNWehPe2YEbcqMHZyD+o3E5qrzK9Fx1aw1bP
         Df9ZbFeLHhOSnQB5aR5ujDqWLkkJ8vnd3ohFbYHNWKyK/h4Ee+XUptR8SvbfDAqb4ji6
         6HjF/XjwKdNDgib43ekuwrn/o21ct9MM7nd0MG8qxM3hJhLYtF4RJOoNbue45C5rGNy2
         Q5h5ni6Ry8PGZYI2Wf0xEhExXOeU3ZhvaamvK8Y6jTdt7TcV2lCy65vddjzMPgPhfFii
         3PPiJaj3gOUlX5FyIkPOk7/+UTnLtA/w4Il+qyIdiwn+iQ2uH+TUGBuZfv6vFENMK81/
         MzPg==
X-Gm-Message-State: AGi0PubhrPrU4JmRtSN3Gwp0CMFloBV7Ba9++BxNsDtg6RddVCYOnv4m
        9xLmFNDMg5CQUIX5TOM8wbMjAA==
X-Google-Smtp-Source: APiQypJWv8O+pTWo8o5RVwex9KReKqhYTkJvhJxn5WYJuBnoQNeHME9vZsTS6HDD1lhOtGRpi+iE4w==
X-Received: by 2002:a19:5f4e:: with SMTP id a14mr16402967lfj.57.1588008492538;
        Mon, 27 Apr 2020 10:28:12 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id c19sm8058077lfj.18.2020.04.27.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:28:11 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] memory: tegra: mark PM functions as __maybe_unused
Date:   Mon, 27 Apr 2020 19:28:02 +0200
Message-Id: <20200427172802.17569-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, we get a couple of warnings when CONFIG_PM_SLEEP is
disabled.

../drivers/memory/tegra/tegra186.c:1578:12: warning: ‘tegra186_mc_resume’ defined but not used [-Wunused-function]
 1578 | static int tegra186_mc_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~
../drivers/memory/tegra/tegra186.c:1573:12: warning: ‘tegra186_mc_suspend’ defined but not used [-Wunused-function]
 1573 | static int tegra186_mc_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~

Fixes: 177602b00641 ("memory: tegra: Add system sleep support")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/memory/tegra/tegra186.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 5d53f11ca7b6..e25c954dde2e 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -1570,12 +1570,12 @@ static const struct of_device_id tegra186_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra186_mc_of_match);
 
-static int tegra186_mc_suspend(struct device *dev)
+static int __maybe_unused tegra186_mc_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int tegra186_mc_resume(struct device *dev)
+static int __maybe_unused tegra186_mc_resume(struct device *dev)
 {
 	struct tegra186_mc *mc = dev_get_drvdata(dev);
 
-- 
2.20.1

