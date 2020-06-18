Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEEFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7221924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H3jKplbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgFRKIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgFRKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:08:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C49C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:08:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so2236619plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1VqP9EIERD+hagFVC72DAlEZ/VXVNsM2Fw1XLYSvTI=;
        b=H3jKplbfvME7fGxdX1WtYsdu4TmOA3VQ+7/NZMWf2u8wLO0HxmPsJa8PytQ7dZf9JW
         lUToFtWYpt9pEKmHUpw6Vs5GViXY6wsEzN3mACl0EEt0ZTGmJ5t3ZUYi1Tw4ulybGMco
         pYEiOxUiYIZleW1T4UibRgcAJWHxvG6L6HvpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1VqP9EIERD+hagFVC72DAlEZ/VXVNsM2Fw1XLYSvTI=;
        b=aSilwRlsrWSwQYh67j3XrN9vcFU3fLgLSjjhyi3+8ogNwjrWnDiYRNdAQi6C7wHLF1
         FmuqWTYenoXuRjji96Nli1KaCnjVF1u9I7qWLwCFzY5Y/0sqLSKO4240KUE/rX0646I7
         +Z5u5BmMhkBVFP7+kPd0Yuy5SKW4tPlM2OQUboCRPw0g49Wwq7zfEHqQWzwmsA8lAbDL
         2M8FOFs0GZPawJukYTLEaq4WZ2IiDIO/razhUadoKtJ16B2s/BFclHeeLnI2CzRIIxUU
         B/wjvV+XCsVO8lqI5k47qa87YN5z9CqUx9qJ5Cxc1PhTbWhPy0aXoBU3oE1ZK+EI8jjW
         16Aw==
X-Gm-Message-State: AOAM533n2W1gEGq1h+Tevvyk3BEwJejoW8EzDqzQc5wjiD/35vM4WwNy
        WP403XvIGloBIVNc+DJ7Htpxhg==
X-Google-Smtp-Source: ABdhPJyHy7LJRn/VtSjB/Zvs5KMCzyZvT4A08M95yw8GvYTIy2Cx+yvqQMNC3B+pEj0gQ7MYz9hMxw==
X-Received: by 2002:a17:90b:1246:: with SMTP id gx6mr3453815pjb.146.1592474928918;
        Thu, 18 Jun 2020 03:08:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b0c7:f192:869b:df87])
        by smtp.gmail.com with ESMTPSA id o16sm2190793pgg.57.2020.06.18.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:08:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/4] ARM: dts: rockchip: Radxa Rock Pi N8 initial support
Date:   Thu, 18 Jun 2020 15:38:28 +0530
Message-Id: <20200618100832.94202-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N8 is a Rockchip RK3288 based SBC, which has
- VMARC RK3288 SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VMARC RK3288 SOM need to mount on top of dalang carrier 
board for making Rock PI N8 SBC.

Any inputs?
Jagan.

Jagan Teki (4):
  ARM: dts: rockchip: radxa-dalang: Update sdmmc properties
  dt-bindings: arm: rockchip: Add Rock Pi N8 binding
  ARM: dts: rockchip: Add VMARC RK3288 SOM initial support
  ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3288-rock-pi-n8.dts       |  17 +
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       | 298 ++++++++++++++++++
 .../dts/rockchip-radxa-dalang-carrier.dtsi    |   2 -
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |   5 +
 6 files changed, 327 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-rock-pi-n8.dts
 create mode 100644 arch/arm/boot/dts/rk3288-vmarc-som.dtsi

-- 
2.25.1

