Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05522087D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJqsCF5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgHaUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgHaUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:23:32 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24791C061236;
        Mon, 31 Aug 2020 13:23:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id q8so4250529lfb.6;
        Mon, 31 Aug 2020 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gUfms9VwMfk9ITu4jVbZVgXv6mmTy3KlTEz8VOyz88=;
        b=NJqsCF5l9/SOErOgl5TDzh418jpBPZse0a1qkyeseil06MU8o3wdPcs1ua9ehJm1fn
         4OpRrE8OVB8JXV+KGCLD5UkT38vFAWxrCA2JlyJPMsrickBQ446ZKf41Wm0dPMzuG8Qq
         JCeCVMT6KEhaWBLskzkldSCcjprRRDr/Vd8BrVfUlVcxIHfLb7V0NiZXtWt/SXInVSx0
         UhUweIpjrZd8u/I970pi2P5Y90dhqjX3THwcvnekxH7Hb3c8Li62WB7Saf/V1pEyawRY
         x9wmt6/yIpSl1JXzHPpAxTYdn8MQWdOfYrA65MxcLZgN9aQ6e71Uq6jhZYsHVCEvdyT4
         SBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gUfms9VwMfk9ITu4jVbZVgXv6mmTy3KlTEz8VOyz88=;
        b=QnUUqqVwrDDnB6zyZQPCLbYe8pDAvR0HVid8WpI+YCKVhHi3aMVD1f4mSy1avkxueO
         do7SmqbMw9LkJiz2aOdTAuCmcHR9VCAoPTSsl3qNxm+EGYjklWbc+BixNleHvgHVqnCs
         /uXV4wC0NSzdXv2WoKMklE77EEAQL8UjPCPLtfY4Ae3BKFV/5iGPHNyAoqwfRWmvCoQD
         V7xswEaDVjT/HhMqyEQz2KTz7i3OfrxwET2RLO4Xz27XAd9c0Zx49lxNkG2ARdwOGrLj
         /xIQ+pLsQ1UuyVlZIgwy6KxwOPB2fcSfWTS6Ep6ZADG1/foN1K8ymKcTMnKsdlCmNTfm
         3lgg==
X-Gm-Message-State: AOAM531buUTc9W57xJK4dYSVrFU++gJ0YeO0iYveTGdU+VdW23fYg+tE
        jKwhlBbQU+5l+Z1S8ccJfYkEC59ufVo=
X-Google-Smtp-Source: ABdhPJzbaQQoKggsHAFVZ3HnVI/ftrhvE0c2GEgHx3HYi2Pdoj5e0a0UhKuZF9JBGW63VOKWsTJgyA==
X-Received: by 2002:a05:6512:20c1:: with SMTP id u1mr1442285lfr.17.1598905409571;
        Mon, 31 Aug 2020 13:23:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1769054ljk.97.2020.08.31.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:23:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/12] i2c: tegra: Don't ignore tegra_i2c_flush_fifos() error
Date:   Mon, 31 Aug 2020 23:22:55 +0300
Message-Id: <20200831202303.15391-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200831202303.15391-1-digetx@gmail.com>
References: <20200831202303.15391-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra_i2c_flush_fifos() may fail and transfer should be aborted in
this case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index efbb20049cf8..a7ef3a93e1b5 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1181,7 +1181,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	bool dma;
 	u16 xfer_time = 100;
 
-	tegra_i2c_flush_fifos(i2c_dev);
+	err = tegra_i2c_flush_fifos(i2c_dev);
+	if (err)
+		return err;
 
 	i2c_dev->msg_buf = msg->buf;
 	i2c_dev->msg_buf_remaining = msg->len;
-- 
2.27.0

