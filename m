Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B02072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QT3H37b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCEWAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:00:23 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37261 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEWAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:00:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id o2so168846pjp.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfm6ayNE4wy/7YaGXfXadlkUakLeQg3UKTG0DwefcsQ=;
        b=QT3H37b0qfM0BSUCS6IVtLykGWqqs12NwaHzXe65aJ8KVqh/60M8DBrM7FyJRW0rql
         5pDuv+cDrRc3rD9aD8KJyov/+VKdOcCaDMvQeQ+w6uHcUlAKuD7E7x5ppqr09Yw2d1Gk
         ry6t6WkWT+3SNi7DuM8iFPhhMXfHwnIzulZsDbDDH9u5KFTarbPtzVrVmXjWSyFJj6ms
         R3r/uZuKIYaK5jP4tbWDXSvpE/HPjLxABNicOKeRduk2VdaZ6+qhSTSus+VtQsQn5Y+9
         DD/4UAs11DixjZsek6XOoxt004QwGw/aB3UcCUa3tw0cuXYBL35jqqrU4BjL/egARrW2
         yUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfm6ayNE4wy/7YaGXfXadlkUakLeQg3UKTG0DwefcsQ=;
        b=WWXnILGfvc5w4cHlfhqnYTA/UW4/7PZi1LbN2iD4QijerzadVlR9YMqMwuC+aoKHE3
         CWwNgRyx/PoHK4pGsP0Q+XigXG4mhQu9f4LAwZCX8YoB4xcpQdHbPu2wqwiuLL/o+zpg
         2yrTTQR7hzP5n4JFFtID0LOJZ6z8MvnoKUu+QnJhCQmFkrcqeO81q5OYMNvxALVLQ8NK
         ZTEihMNvx0B3qv8cp9AYYPQoKSvUJ/0Z2gi9QAfwK3JKtnROXPMSmaYSWgt9xnmCW/dF
         U1XRLJnc2gVEHDqu71/LmtIzX6ZT6LQzO2YWylxxDklnbA0U3E7ymZLE6xTJ4N9jRtKt
         TMmg==
X-Gm-Message-State: ANhLgQ2v/Bk1s9fFtuc0r9DjjCfKrQxBHsf8nEVLMBFWJnynF96A2Bz0
        cIoNwKyS4x2Ag/70FpmlE5BYfvBV6OQ=
X-Google-Smtp-Source: ADFU+vvFvGjwJ+dMpKZfLYrMZG2DVMlcV+NyLhGza5CGl9eZZCxGMx+E5rgekeNVYP8w9F+M+8bqaA==
X-Received: by 2002:a17:90a:c218:: with SMTP id e24mr233300pjt.64.1583445620935;
        Thu, 05 Mar 2020 14:00:20 -0800 (PST)
Received: from localhost ([103.195.202.232])
        by smtp.gmail.com with ESMTPSA id d1sm32233596pgj.79.2020.03.05.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:00:19 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 0/4] make dtbs_check fixes for cpu compatible
Date:   Fri,  6 Mar 2020 03:30:11 +0530
Message-Id: <cover.1583445235.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix them up.

Amit Kucheria (4):
  dt: psci: Fix cpu compatible property in psci binding example
  dt-bindings: arm: cpus: Add kryo280 compatible
  arm64: dts: qcom: msm8998: Fix cpu compatible
  arm64: dts: marvell: Fix cpu compatible for AP807-quad

 Documentation/devicetree/bindings/arm/cpus.yaml  |  1 +
 Documentation/devicetree/bindings/arm/psci.yaml  |  4 ++--
 .../boot/dts/marvell/armada-ap807-quad.dtsi      |  8 ++++----
 arch/arm64/boot/dts/qcom/msm8998.dtsi            | 16 ++++++++--------
 4 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.20.1

