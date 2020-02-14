Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C2C3B196
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D152187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f3T6NdVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgBNG0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:26:52 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35760 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBNG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:26:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so3507462pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCrhZ74+BntL1ASmsZknwx81NOpQkF74lLsvD9sBub0=;
        b=f3T6NdVHZxNDFtYQX+iekyEp0Bj2gxg4PzjB4yrO524wQr2gUIHTtFAGcvT0x+wfxY
         xgHw8Oc7tgN48emrBRNtwlfgTheC5sPIifAvxhb1VHFp42qc5buBVrLVuqMTscO3BeVg
         gMN5M9wfjGBaooPpixSwRakGOYGWDa2gtcbaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCrhZ74+BntL1ASmsZknwx81NOpQkF74lLsvD9sBub0=;
        b=bRZrMr7hbOm6B8mnWbXQZINiQjU9TPzNwAFy14mBs+SPdSBdDKG6iS+CA0xfErAMSA
         A9o2jWA8XISzX/rHX2WwHY9NZYSDCm+uhi59wtDsIr3D1NnM5ihg/CHMc9/DXHY4qjGq
         KbA9BXX1v1xvYMIsf90ApQWSD5fqUyMcGR2aRKbLHlhda+Xy3klrFVxl3yLkzWoOOe9R
         f3UV0XQQRBJQ5stNEKPjelOZdZjCzCfzG8MDvv3XjmYUuvlE3cFyxuiHuV36p2BMlHdX
         +ur2L9hs8tkniR+WARTB+zx+2t8K3C1kN0FszYjKuIoKI07xTlrxM/4f8WGOdapeq7WG
         TehQ==
X-Gm-Message-State: APjAAAVlQfMESryDRMWjsUCfn9mhhJLuH3vLpQVW7ienxxSokLi8Jjdm
        VydmqpMqJG9/bfqVmFGCrGQDEPpsqEdGFw==
X-Google-Smtp-Source: APXvYqyn5ehjzmo5Eos0aPWzc2ZSt6d7nE5vtqIbR/GyaAShL8VPgieCBvCjTwVgiNarWUm9OnDtxg==
X-Received: by 2002:a17:90a:9dc3:: with SMTP id x3mr1620345pjv.45.1581661609563;
        Thu, 13 Feb 2020 22:26:49 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id o73sm4636778pje.7.2020.02.13.22.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 22:26:48 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jwerner@chromium.org, Evan Benn <evanbenn@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 0/2] Add a watchdog driver that uses ARM Secure Monitor Calls.
Date:   Fri, 14 Feb 2020 17:26:35 +1100
Message-Id: <20200214062637.216209-1-evanbenn@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is currently supported in firmware deployed on oak, hana and elm mt8173
chromebook devices. The kernel driver is written to be a generic SMC
watchdog driver.

Arm Trusted Firmware upstreaming review:
    https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405

Patch to add oak, hana, elm device tree:
    https://lore.kernel.org/linux-arm-kernel/20200110073730.213789-1-hsinyi@chromium.org/
I would like to add the device tree support after the above patch is
accepted.


Evan Benn (1):
  dt-bindings: watchdog: Add arm,smc-wdt watchdog arm,smc-wdt compatible

Julius Werner (1):
  watchdog: Add new arm_smc_wdt watchdog driver

 .../bindings/watchdog/arm,smc-wdt.yaml        |  30 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/watchdog/Kconfig                      |  12 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/arm_smc_wdt.c                | 191 ++++++++++++++++++
 6 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,smc-wdt.yaml
 create mode 100644 drivers/watchdog/arm_smc_wdt.c

-- 
2.25.0.265.gbab2e86ba0-goog

