Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A06DC2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D362071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CX6rpgNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgCaNd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:33:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37391 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgCaNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:33:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so26051047wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWqPN/2F35kUoboB7VuE68BOKEz/BXfljK/zGatyCzo=;
        b=CX6rpgNk5Dr3qKnrubMvK4q2UgrMeUkjr0E0F1JgHADGyPC55iYFRLqqwEoNKST6nU
         TpLcGrh+pmaxEVHOtDSD6OuZT/Ndnhg57uaHqlvXy4DomvQNq1AdGLybR7F1F9CJvUxk
         yA9hK1JEZDI/fRjyCLIUziE6uXDS1AYzE17wfcFI7hlEpU94InlVQbrE6W2sXLF1eGUw
         gNjpV8lWh5cdXoz8cPICBXHh+x7omJKnUJC80LxDenNWHvPHmlLlEG026qnejDduZWrG
         oJhe8g2MqDHIUyLNQudXifQmq1vvvFzwdtix95uSlvlOmhJC5tsXDCLfA5GOC+64IRmD
         dejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWqPN/2F35kUoboB7VuE68BOKEz/BXfljK/zGatyCzo=;
        b=HTuqghnhCAapkP0zD5MIciBBhE9qujg6rNnw4QGMVTUvCIF+sYnV9fL+LQK2DyUyFw
         693sNzHhivvXeD1ZsQI6+b/MKMjF7WOSdllH4mdIqyBXYGl3ElTYgUyN3aP6T2f1tKvy
         Er5K8ltt84WhsLAkdlay0mK46yj6Dhc/a5I9ltEIcLG5XvZhnPKJ8WI4qa5iZNF4j9b/
         2+ZU/S3TNZyqsw5BiNLJf4UfdVcfx2W3F+6E1+/CSa01pkazNvxtv/7FU3g7EtzHlqxG
         8E6tTyWUMkCswIFIJEhr0+BCeiTJxWwwjZfNMPiH8U0SvSFxgv4lXXufw3OB0AejWnDv
         BwzA==
X-Gm-Message-State: ANhLgQ2qKapTj4m/b95r768p6mNhZmA4qZOS1d6E9k2wFw4pUg9NR2v9
        em8texTD+hPewd0Y+0NtOjhszw==
X-Google-Smtp-Source: ADFU+vu4XlDHD+eAXmhnbIITSDymKAgWq0Yc108LTSVU+JOlZDZX5TChQouQWuBq86nDsCf9jJIwSg==
X-Received: by 2002:adf:e684:: with SMTP id r4mr20689718wrm.6.1585661635563;
        Tue, 31 Mar 2020 06:33:55 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id 61sm28623081wrn.82.2020.03.31.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:33:54 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v3 0/3] media: ov8856: Add devicetree support
Date:   Tue, 31 Mar 2020 15:33:43 +0200
Message-Id: <20200331133346.372517-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds devicetree support to the ov8856 driver.
In order to to aid debugging and enable future sensor
modes to be supported, module revision detection is also added.

Dongchun Zhu (1):
  media: dt-bindings: ov8856: Document YAML bindings

Robert Foss (2):
  media: ov8856: Add devicetree support
  media: ov8856: Implement sensor module revision identification

 .../devicetree/bindings/media/i2c/ov8856.yaml | 150 ++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/media/i2c/ov8856.c                    | 192 ++++++++++++++++--
 3 files changed, 327 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml

-- 
2.25.1

