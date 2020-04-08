Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02705C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95DF206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHL4MXPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgDHNKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:10:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40773 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgDHNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:10:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so5367656wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYXlDfYBhiWgPgJU0Q/nJhdlPceCvlDUE/4GyWKcH6g=;
        b=QHL4MXPEljvtIQGjunB5zOVtcdXGVKmlw4SZOnXhxkT1G/idNJYDWnJFfBVSZA6ur3
         XLz9bz/BqDPWhdQatlMyK6MmtNW8HxbZeVjK0G1uqi7z9jMag7KM2wUrQWsgkoABLzNs
         oYhqehOttVSx8OlDnxRpDf36Pjdevb/n571RX6/ccykz1GdjpgOarVQkS4Bm9+QTsEy0
         UbUITpFmgxApWyw5xc28x/GA0O2u/y+CJhdZhLfIxQwoqqqjCYFGVNm594e3V6ypu9Lr
         UWvi+6+0ZKt423SaS92K/1Xh7qfhb+YaYr0a0RE4bUjQ2SNqU3UJArWVOsEbiLCXMGU4
         CArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYXlDfYBhiWgPgJU0Q/nJhdlPceCvlDUE/4GyWKcH6g=;
        b=VQDK9He3FLLyBB3z5ZNjplhWWa2PSnIclaSIJbgjc5ZtBSnCqfH5ik9YgriV1GlZvG
         Pgrkj70K/sO5MEa64iaHvlLHOkybbGrtA0S8+g6Xu0kbTTbOVhFwcp5CIjONgk5omqdH
         YNTqJEexUrGUFmnzWIHILpRwcimRZsgnWP0XCpSGQLtPibkLQqyFr9k92QeGfHZFTQ1w
         KxLtqw4yf2jPHlEnXhiR55g+ayT+uN2ssQkctHKzepGwbeuxVKjyPg6C4fEbDjBJgjjv
         vIryBXsl5IiLRA9u/sWO1BD8m5JglqKDY3O1xuA5dlvp03osTQV3kitb/q3VxSZHmrnL
         h4yw==
X-Gm-Message-State: AGi0PuZnbTmn74cDqE0vyshHtK00JXPDalXwtRRTKjCqfJigXb8VUydG
        XdkbflXSXlb0n6kQBiLwaJ0SYQ==
X-Google-Smtp-Source: APiQypJze0ARzAXgLTH/rmOlQ2KeFXFto1u/pWx1vCgzC7LIu7QenfXc92GJkM+v/zzhBPo68YSeJA==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr4663487wms.18.1586351445367;
        Wed, 08 Apr 2020 06:10:45 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id f4sm18428044wrp.80.2020.04.08.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:10:44 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, Anson.Huang@nxp.com, olof@lixom.net,
        leonard.crestez@nxp.com, geert+renesas@glider.be,
        marcin.juszkiewicz@linaro.org, valentin.schneider@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 0/6] Qualcomm CCI & Camera for db410c & db845c
Date:   Wed,  8 Apr 2020 15:09:53 +0200
Message-Id: <20200408130959.2717409-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series depends on the Qualcom CCI I2C driver series:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=267371

And the ov8856 device tree series:
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=268013

This series enables basic camera functionality on the Qualcomm db410c and
db845c (RB3) platforms.

This includes building drivers as modules, adding devicetree nodes
for camera controllers, clocks, regulators and sensor nodes.


Loic Poulain (2):
  arm64: dts: msm8916: Add i2c-qcom-cci node
  arm64: dts: apq8016-sbc: Add CCI/Sensor nodes

Robert Foss (4):
  arm64: dts: sdm845: Add i2c-qcom-cci node
  arm64: dts: sdm845-db845c: Add pm_8998 gpio names
  arm64: dts: sdm845-db845c: Add ov8856 & ov7251 camera nodes
  arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |  76 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |  27 +++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 204 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       |  92 ++++++++++
 arch/arm64/configs/defconfig               |   3 +
 5 files changed, 402 insertions(+)

-- 
2.25.1

