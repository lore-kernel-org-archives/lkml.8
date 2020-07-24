Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BD02073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmv062P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGXLJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:09:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:09:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q6so9556575ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/KD4aKU1LRGZHLPLJ0VWv8tqMriXUQc32LrDiAo5nQ=;
        b=cmv062P8gVKgR1Bf+VENef/dUn3rWKwpQ9VzCk0ClVmGMWD9SAPor86aqoCEtU9UvR
         T8dgYBGx6kC2Antw9orTdIatEw5aIIBph+495swIXL+RhwEfLPUV/tu2+0xYQdjSyFRL
         D702OOeqkFjs4trf5oC94hweZZj2lBDJUU2aFj39tiW0/kXJ+aoHmIyb6UiSU+o7MiIR
         qpY/f9vamyezqU9kvCsBpEEc/bd0L9Nh+nyyb8KhJNy+kQls0C6GMc2Q9JttFi3Abhfi
         V3tU4/GK8uDvV18fm4OA97urCAnLktxfj5Z5Oz0IAlsNm/0HzDY1rFiEVdyXIAzK9FPc
         tJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/KD4aKU1LRGZHLPLJ0VWv8tqMriXUQc32LrDiAo5nQ=;
        b=dwiF/ftSVDQhcdtXLP4POLjq/l6//YtFicb6M44AsVdWaT/hoSZiiZ66jTcJbuCP+L
         B1ju7dYO16YQo+H6XaejH91jB2HQoHaOIgo+Ow2NJ3/bayh+aKkGJVKtRbgNs6lEnKrx
         hhDmTlMXm7Sjx6CWcSyf0RWJu47w4QrTElyPIQ1A1h63ehl7dWlaghqRWVop267UpsIs
         02nHXoozVmvWAsAC8+DAqU2lHV/b9Nf9d/RheuuXvTNhNikTvacpUzmPR9gzSCr+aYGw
         OgmN/YbllatgsbpqFSHfTlhYkr7rwOvROC1W3pfxTVEBtl8U/GQc1JzztfuYCXTjvLPZ
         /FTQ==
X-Gm-Message-State: AOAM533y+/jZq0U4lDhjHQWE+e8UIg9p+LwqpfFa4mNZ234NvLbJt6yF
        P/HxsATxDPLBZh3xmdnteLIJXg==
X-Google-Smtp-Source: ABdhPJwjIntbFc6Cnszefa8g4lKKgiHzXBlivUuJD/YmGzOA1aKsOwmCBFEzyDfJSkMyEbSYUtzXzg==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr4119214lji.129.1595588980813;
        Fri, 24 Jul 2020 04:09:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id v3sm169165ljj.110.2020.07.24.04.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:09:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.8-rc7
Date:   Fri, 24 Jul 2020 13:09:39 +0200
Message-Id: <20200724110939.8934-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.8-rc7. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc5

for you to fetch changes up to ebd4050c6144b38098d8eed34df461e5e3fa82a9:

  mmc: sdhci-of-aspeed: Fix clock divider calculation (2020-07-13 12:17:34 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-of-aspeed: Fix clock divider calculation

----------------------------------------------------------------
Eddie James (1):
      mmc: sdhci-of-aspeed: Fix clock divider calculation

 drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
