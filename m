Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFEFC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5B21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+FEN8xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgCIPnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:43:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46367 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgCIPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:43:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id v6so8074908lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBQPPc6gkr+d84LVVJkI64k6X5AqrfYE5BRX0YEPsdo=;
        b=D+FEN8xfPVc+PvzK+1vPW80nAPFQhHDVjnc+TbmqVrQ2qh3oiE6sMfprzc9BsTTJsk
         96IGi0iRButqQzwvxdJG9ikk+Mj8nEyA2QwaSt6EDEAGpAqu1SV0wxmtw1mqrc90H7OJ
         4JqiCDWfPPOdHzbNVw1QCF3ggc4gjqsbpDnQPqzGXBKR4Vj5W4+fbIy0pDXFF3WiUHDA
         WyxlLufjesspiaMU181i8pqDhuYJR0AS8AvsyxiDF6V/hoIUOgU1usLkeT6A3PVqPO3a
         Je44seZS8zQLVHJ3GPWZIekfid4FHSkupiPzWmz7Mzi1M5oID+vn4oRqNwn8UUz01omK
         ZumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBQPPc6gkr+d84LVVJkI64k6X5AqrfYE5BRX0YEPsdo=;
        b=sBUAC5g+DfQRrbae7Ys9wj7FN5xpeXGRYCHskn9wyscrOxJfiD6vO8ZHEOBbfQrrxN
         pgoeS93g2G2xeUft1wkWL6Jp9ZepyGhH40hEit5viowWzMY0YT7XWhpW5SmcsGbCAQpf
         pLeSvapJgqzxwyqhGRJZlBFTqyQ6PHpvIQ9D0KQ4j5u+Edd3nAR3TIobpX8p6dSvRisF
         ybXo5OHapNxCBNaeTRTGj6nFi2FBgfFUfneRL2grqSj9Z7mdKgWdPPr6jYH2WirHPTL8
         gieg8B5R+lnU82HQ+r/usQxWBMrSzhTWbvTS3Udw7qALozC5wUAmz9n3PKF68RVG5hUA
         pqpQ==
X-Gm-Message-State: ANhLgQ0YBMrv7wSNP4ibD8dHPLB9VBXBwT7EvV18QlWQVC5sdH7byA4C
        3iEvWCMeoBjLYCcaAKFt8YCvDw==
X-Google-Smtp-Source: ADFU+vsr6lztDniL//P/rxc9yqHeoDa8XafafFDzvarpIb6Vp3idr1AfjM6e06ADJfKtuw35ursNtg==
X-Received: by 2002:ac2:5c44:: with SMTP id s4mr6432083lfp.129.1583768618999;
        Mon, 09 Mar 2020 08:43:38 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a2sm20314056ljn.50.2020.03.09.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:43:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.6-rc6
Date:   Mon,  9 Mar 2020 16:43:36 +0100
Message-Id: <20200309154336.22598-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v5.6-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc1

for you to fetch changes up to 31e43f31890ca6e909b27dcb539252b46aa465da:

  mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x (2020-03-04 15:41:22 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-msm: Silence warning about turning function into static
 - sdhci-pci-gli: Fix support for GL975x by enabling MSI interrupt

----------------------------------------------------------------
Ben Chuang (1):
      mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x

Stephen Boyd (1):
      mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static

 drivers/mmc/host/sdhci-msm.c     |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
