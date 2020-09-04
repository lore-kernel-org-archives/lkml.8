Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA76C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1320684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CJ4sNtaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIDTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIDTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:18:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7643C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:18:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so5108030pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQ3Za1ulBYpN6P3MWzPM8LHHd18bcHtpU18gBebPUd8=;
        b=CJ4sNtaVT/wZNtZnBVnxz7DODlBAmOVNmIGMPjv6QcCUBziyn96kTlpdgR76NVKTQD
         kikQUpeq5K2YSKosNrj/D/vyT/Nv14u8Xrci14GTIppj2owJuAZ8i+6xoyQgGX79vDIP
         a+h4rbgnL/5/aKwRBzcPda/hRo9OSnIkF89Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQ3Za1ulBYpN6P3MWzPM8LHHd18bcHtpU18gBebPUd8=;
        b=Idq7zqLMcwnrTF1VLSCh7IGo05/k9q87jlPU3+tTbTXlAWPeecbdIalgDZ4V0Jl9rk
         ZRAiLCKq0fLv/0g087ypbxwCbbfwFAnehUWhTMAWha/FWXCbVw3Y/+CFbYAhEEuS0vLb
         BDrBGU+RddxeR+6ZU6MpqvryGXhGObxAX5TYaSFlRiFO4na/ivnWmzKUjXSH2Cu0b9ah
         CyXXWft52q+7ASs4GwMj4///ypRHGVQ+2ej3D00bCK4tL5UJAbWGXlv40Xuw7FcHij7F
         C2Xfx58rJ1QSgvODhzoxMy7+gdBu8n1q+rU6dPgnKq+cQC8CTWHPoVOrPZjy246s9sGX
         lItw==
X-Gm-Message-State: AOAM532FPi4LlaRTpluTPMbGo8nYp+HAEdr7sgx6fsvCl4yi4tgKQwZb
        xBED215l3qO8xFcwgpHiw2ISew==
X-Google-Smtp-Source: ABdhPJxL1HrEmjVqHII42Qjc4LuSWAD0dWbQkB6r3vNPeYT1NHHcj1jRE7Uwi0GsLh3NqWV7jmmcNw==
X-Received: by 2002:a62:5e45:: with SMTP id s66mr9893108pfb.230.1599247129115;
        Fri, 04 Sep 2020 12:18:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b9ea:24bf:6b2b:1eee])
        by smtp.gmail.com with ESMTPSA id t4sm5986001pje.56.2020.09.04.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 12:18:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Tom Cubie <tom@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/3] extcon: Add Type-C Virtual PD
Date:   Sat,  5 Sep 2020 00:48:27 +0530
Message-Id: <20200904191830.387296-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Type-C protocol supports various modes of operations
includes PD, USB3, and Altmode. If the platform design
supports a Type-C connector then configuring these modes
can be done via enumeration.

However, there are some platforms that design these modes
of operations as separate protocol connectors like design
Display Port from on-chip USB3 controller. So accessing
Type-C Altmode Display Port via onboard Display Port 
connector instead of a Type-C connector.
 
These kinds of platforms require an explicit extcon driver
in order to handle Power Delivery and Port Detection.

This series support this Type-C Virtual PD and enable the
same in ROCK Pi 4C SBC.

Any inputs?
Jagan.

Jagan Teki (3):
  dt-bindings: extcon: Document Type-C Virtual PD driver
  extcon: Add Type-C Virtual PD driver
  arm64: dts: rk3399-rock-pi-4c: Enable Display Port

 .../extcon/extcon-usbc-virtual-pd.yaml        |  66 ++++
 MAINTAINERS                                   |   6 +
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts   |  16 +
 drivers/extcon/Kconfig                        |  10 +
 drivers/extcon/Makefile                       |   1 +
 drivers/extcon/extcon-usbc-virtual-pd.c       | 285 ++++++++++++++++++
 6 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-virtual-pd.yaml
 create mode 100644 drivers/extcon/extcon-usbc-virtual-pd.c

-- 
2.25.1

