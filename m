Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E3F2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MWcvAepi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgIIQxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgIIQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:04:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464BBC061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:04:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so2814233wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqHDfmvrn1k16mVJQ5+b/SIXRz53SpIEt2htZWi6LBw=;
        b=MWcvAepihDTzFeQEhYY4dmVrfX1hYZrzB4rWEGRs4dmjdbtUj+2Qif01qedSuWuIzF
         pTWkOigok9A72v58KpF1HrnrSkw/q3gV/pNBzM6lsDcPtpzwJCjXF0KuVhlOMqmAibM4
         BNvWlMPLHGrYmjmq9cFMO84V6elPjUgSJ8rXi+n8phF5NJ/1ifTr68u4FfK+28F7B30F
         KG+s1lHKyfT1hW3fITFNV+T1cPG6rE7Dz2jvtP+F4NxMMDki7qWh6xf8J/yJzRRk5j0J
         5siS673YwqOMAvBMZZELYYn9H1wEUUvN4WMzsE2eYMOtKM74f29o/BQN8TPAj51/dUHU
         ikTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqHDfmvrn1k16mVJQ5+b/SIXRz53SpIEt2htZWi6LBw=;
        b=tyMNabTa/Aipu5x3ArdQuSEAQGK5w9wWsaXCg9+ciks2A81oYieKIrxQeH4hSr3E5i
         54jfw86VCi12vpW49s5ofvH05bOPiWMQ/QCws+nzzbVw6nTUGGmEeCg/siVjlooh6bdE
         0f261uY4Q4qKlBzwvq/5bap/EFKEc6VrFSTFLS+d5uk6I12qNDuTeVvkMMm5P2uIzpS8
         TBCU1VvLnUJiFUCxpt+EE3yK6YLVIhGsBWOeH4dZ6/lBOvD+QBzcEcNEBOnzZ44nh/21
         Vy+Vj63z3x92JXEB1gx5LVaxiqAG3tUigrIhIMKZ7wE1iDSylatATP25XdEjEwHtqFyE
         f6PA==
X-Gm-Message-State: AOAM533utq38+mStEB0XJxrWb9tRcFdoJyM9GJcRkNo8oPQT7aQCZX4c
        LmlrkmLEjHDqvNrwzjOj8iCUNA==
X-Google-Smtp-Source: ABdhPJwPM+/b2ZDI+b2lSlT6ZtTWsjPKk0PA8OlwP8p9CqXazyikXgs/36KZ9HFCJYOviAo2mF99NQ==
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr4178443wmd.124.1599667455779;
        Wed, 09 Sep 2020 09:04:15 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id y6sm4850700wrn.41.2020.09.09.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:04:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, kishon@ti.com, balbi@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/5] usb: dwc-meson-g12a: Add support for USB on S400 board
Date:   Wed,  9 Sep 2020 18:04:04 +0200
Message-Id: <20200909160409.8678-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG is close from the GXL Glue but with a single OTG PHY.

It needs the same init sequence as GXL & GXM, but it seems it doesn't need
the host disconnect bit.

The Glue driver reuses the already implemented GXL & GXM work.

The USB2 PHY driver needs a slight tweak to keep the OTG detection working.

Neil Armstrong (5):
  phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
  dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG
    Families USB Glue Bindings
  usb: dwc-meson-g12a: Add support for USB on AXG SoCs
  arm64: dts: meson-axg: add USB nodes
  arm64: dts: meson-axg-s400: enable USB OTG

 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 +++++++-
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 51 +++++++++++++++++++
 drivers/phy/amlogic/phy-meson-gxl-usb2.c      |  3 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 17 +++++++
 5 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.22.0

