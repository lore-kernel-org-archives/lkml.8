Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCB8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C42120772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xgy+KKMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIDQRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:16:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88775C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:16:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o21so6623689wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPWs6+bNAsvF0rvAc3yDkiD79Fr0V6X4UpT2H9wqL9w=;
        b=xgy+KKMDnP4LzZO277QHztaVVgeFGRl3sKUILKgGRrZjCjl89UcGfnFoy3wn7Vkxzt
         iBVZCpmo6ZUg7glwQWntAZR2d9hPheP2FgEFuydJWgJWH9lYU4bJSjtsDMnKBSkmYqVL
         nfcssm98lx1gOQvthmT/BVWijb5bCkLsUuCsd8VIFF+0ks+0PnMv3lg6hsbQ/BjqdtbK
         eTHl+ylsRdOfekswV62egkDZhUuGm0Isb9FYFfifnk1jbrgjIm48jLu7HxiqMDLxf5I2
         YnBEv9dkScmIlKD+b9OcBbQZKxY6yl5hxhLdz1+Ksh2IJjdksrXT66gcYowGXS7Miwm/
         0WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPWs6+bNAsvF0rvAc3yDkiD79Fr0V6X4UpT2H9wqL9w=;
        b=U1PVX6At2QCDbTO4WAj0tP/v17NGHZpeghjDXHLTm7nUfcvzLNyCMIayFMKXQbmT/w
         Kd7CeLHUTYLjG3TDlWtWz0UPe2Y3I5BV2bXa5ARGtVBntcfF/KKIThVipjKeP7zl3bMv
         +f5VDFvv1GQEqHdMHwUBVb4XbY0v+PjQQqXY0HmZcsacJkcgYt/Pg5fMQvBVsvX7ULP/
         nkIifz55S7krmCIyXqjisCX8cOBnagnK0+3KatkFXNe6IZ4nBn4j8NLpAxT6Z97/61Uk
         1+0gYMzTN7kM5AzgmBUToEaSM3cbZMm214nzcaOUAwn0C8dXWhXT98ocDdtAj7ypSGfL
         /b0A==
X-Gm-Message-State: AOAM531wFJxZ9lN9xhsSCVExqrwxK0xB6cNO+aEVqRUeuBT1KSIXu9sJ
        aVSH22gVojr1WO10Uv+9OJbYszHXfIPDeESY
X-Google-Smtp-Source: ABdhPJxJJhv200sa3/9Yy1JmL6wXEhyHnokhFvwWfgI1eFsruxnXRWfB3rloRZs45tch1S4Vid+8Ng==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr8182405wmg.164.1599236218033;
        Fri, 04 Sep 2020 09:16:58 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d3sm5129543wrr.84.2020.09.04.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:16:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] soc: amlogic: add support for the Meson AXG Power Controller
Date:   Fri,  4 Sep 2020 18:16:52 +0200
Message-Id: <20200904161654.24141-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the bindings and support for the Power Controller found in the
Amlogic AXG SoCs.

The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
but with less VPU memory domains to enable and a supplementary Audio
memory power domain.

Neil Armstrong (2):
  dt-bindings: power: amlogic,meson-ee-pwrc: add Amlogic AXG power
    controller bindings
  soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 23 ++++++++++++++--
 drivers/soc/amlogic/meson-ee-pwrc.c           | 26 +++++++++++++++++++
 include/dt-bindings/power/meson-axg-power.h   | 14 ++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-axg-power.h

-- 
2.22.0

