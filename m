Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE6EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D7922D2C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHvft9pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgFTCWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbgFTCWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:22:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9608C0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so4749257pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILpDZ3g9RyhdCAmxH0qmTrsO+2Jv0SpzLTozx8GBn9c=;
        b=OHvft9pwOa/GYAdCFYxEz/NDExYtwokXsA2ThVXvvC3L2llsk0L4ygM7PglBrxfIlE
         riFeZNNFAFupw6qQDwIIFWO6oPyZGY/dkGSLo3f4KkqWwjn+WiMhqJ/jiUH/CDtHPtdW
         n4IKkbw8AENTUmfEVOtroQunniMAyN5lsqy9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILpDZ3g9RyhdCAmxH0qmTrsO+2Jv0SpzLTozx8GBn9c=;
        b=cQL46CACF22C+10Ikt2eQnzDUUk1kvBml3O8OojNCmgHwZZb87MH47ZPK+toQI2wJh
         4TJnPWPOi7TqLFvAJE1kL+20pre3whf4Eh4ltxby2qNzKOa0J3zSjt5og9TaWubCV1a/
         w0jGf74srLmp+PVcSANwGPu/xM0D5l3D2BUWE2e8Sr2xGCHoSeSjwK5hYsYP7huXU1Mn
         F8hAOzskw2rNR62xQ2MFWfjxcLPWr3dgP3SRfOJ75HOAjTx6uEl7d31HOoTvm5ZMNM1G
         7CznQzsPxacV/EYI6N9HofFMWB/tmRlhQwnXL/xiqYRUhoJDVYUhlGJOGJo8ZRlRZhRl
         zefw==
X-Gm-Message-State: AOAM5311hXsYR9ZDP14txdji0XhBFWeMV6B+TD6tbIUha0WG4KlliCYC
        saBspv12OXIKLW7QW9YWrFGYJQ==
X-Google-Smtp-Source: ABdhPJya2OjomlPpqTqbnSJht2OJvzEboztD2rUElEBmRBsqZobnQJMGxhW2DXb5CZF39tXbToWriw==
X-Received: by 2002:a17:90a:c717:: with SMTP id o23mr6365885pjt.195.1592619755094;
        Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m14sm6241911pjv.12.2020.06.19.19.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 19:22:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v1 0/2] Some small spi geni cleanups
Date:   Fri, 19 Jun 2020 19:22:31 -0700
Message-Id: <20200620022233.64716-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow onto Doug's latest spi geni series[1] this simplifies and
reduces the code a little more.

[1] https://lore.kernel.org/r/20200618150626.237027-1-dianders@chromium.org

Stephen Boyd (2):
  spi: spi-geni-qcom: Simplify setup_fifo_xfer()
  spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily

 drivers/spi/spi-geni-qcom.c | 55 +++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 30 deletions(-)


base-commit: 7ba9bdcb91f694b0eaf486a825afd9c2d99532b7
-- 
Sent by a computer, using git, on the internet

