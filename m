Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B2AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EEB20768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LmYSOZz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgGWMkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgGWMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:40:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF019C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:40:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so3038356pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78DNKewgvGuO7JtiEp9n0GA7+N0YVp1BKe8RGOkUB1k=;
        b=LmYSOZz8qGvkJMQRHPG7LEJeh47WCjGLbF91lOecvk8FRiv7selasyl6PIWrtrWSpZ
         cQpHU570FvQHZ2Q0L7ukehQRmac7dwZc0jwqKrqURBUd2OM6h9oMirl50ABJCkxTFDPm
         iYEMyyQHEkn0YigFUJ8Qbm9Lpk2QHiOUTjMZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78DNKewgvGuO7JtiEp9n0GA7+N0YVp1BKe8RGOkUB1k=;
        b=nM02fr1dnnKA0hAGJXoVDtaMhJxKcRbnM9ERAEVDI7EHRzERqSq87f3KpySidVXMOd
         L5aCU6hP2c7OWxEFSjlLTNmdLiiU2Dfhtzn/JlsFmIHiHk2NpDNdXiy6JDfKSZkai7Ms
         T4NT8xhF+/s9ZkOASn4FUGlx/Efpkl7aESpsoviWNr91T+XhBP3e83EhaDcRLNkq2H8v
         uWVIU1bFZagvzWCPs9ax1EAK/SwNTUDokRm+9feG2qCnHk6t3k0OL7tuErUCxZpMiwFb
         VsRxH2dUQP4UeQPb5PF7Ft1JkBIxAwBuu1YMhX+kMfGT/XmONVQPqpdB38jIMtHx7+EA
         qXxA==
X-Gm-Message-State: AOAM531EEhEkF5KKdzhnKoALkNvkxrwXoTtdFlortSII5XssXWvPwj4h
        w+xyAQvKeY+tuM98SE8qo2hSfw==
X-Google-Smtp-Source: ABdhPJzKQ8HIN0n3HwHsMov5IRd+jA9fucy3Zbi4FubPg+ZV8L0hq/Q4PpwulFt6FCsbldStufZUQA==
X-Received: by 2002:a63:e24d:: with SMTP id y13mr4089941pgj.248.1595508010141;
        Thu, 23 Jul 2020 05:40:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:cbf:ea0:8a30:a3af])
        by smtp.gmail.com with ESMTPSA id m26sm3051270pff.84.2020.07.23.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:40:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
Date:   Thu, 23 Jul 2020 18:09:44 +0530
Message-Id: <20200723123951.149497-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
    
PX30.Core needs to mount on top of Engicam baseboards for creating
complete platform boards.
    
Possible baseboards are,
- EDIMM2.2 Starter Kit
- C.TOUCH 2.0 10.1" Open Frame

Note: These baseboards can be used for i.MX8 SOM's as well. So having
baseboard on respective SoC seems to be easy rather than making it
common across all.

Any inputs?
Jagan.

Jagan Teki (7):
  dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
  arm64: dts: rockchip: Add Engicam PX30.Core SOM
  arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
  arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0 10.1" OF
  arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF

 .../devicetree/bindings/arm/rockchip.yaml     |  12 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/px30-engicam-common.dtsi     |  31 +++
 .../rockchip/px30-engicam-ctouch2-of10.dtsi   |   7 +
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
 .../rockchip/px30-px30-core-ctouch2-of10.dts  |  21 ++
 .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
 .../boot/dts/rockchip/px30-px30-core.dtsi     | 250 ++++++++++++++++++
 8 files changed, 351 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2-of10.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2-of10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

-- 
2.25.1

