Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D540C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96CE206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U4ucAUEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBSOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:18:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36413 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBSOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:18:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so762147wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n73JnDmg0VzOPRicTQwaM/KnoVwGL/4pXuBOrYc7ef4=;
        b=U4ucAUEAepCuTndLcLzujqnjNO5Vw7hsLHtU27Dk3BiCHkZTHeSfe4LRR7YCwX9+Yt
         Q1GvFaJiQsdwMyFrYNSrKr9u7wYs2uLspG1a5fo31YVDsaaTOdff4HDdkNnZ1Rod84LB
         NWvZOTy15qlcYLWMcU0PlihDccGWQQVYlzMbeVaaiYGYrQuK+64m00E0CdG9ZDtNAip8
         xFBBmfhEE32XXk/uctEVJemKHTXIH+BRQmPVWwttpax63y0HMK6D0H2WUooPXyvk88oq
         UGjAYwi2CbuFuQ2B5PZ8m1kCYNtO9glDPcsdGKbyVKN7dsySr1skOJaMpDZ/ZowcxiGc
         uyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n73JnDmg0VzOPRicTQwaM/KnoVwGL/4pXuBOrYc7ef4=;
        b=j6php1tzs93CSEHwRdSLJWjbDon1VxudiMxndxMllNkulHXlGEucMRR3AkLNEKP2UK
         yQxRXAnN7Bas09GU5Lbn86Hc1iWIbWZPQCEM+CvJp3k5o4FCjnJnuqTlqU6ITgbGB1oc
         ZvJmDu7OIhlUiYm+8a8FVws8iTR26UuETTFx0oPkiodo4ThUo1x6033Z86JKeEdzOr2/
         916EGRW+KglWYU5xbO6Xky3CqSFftVtBDD3GIFOHsXAYhZOP64pQriF6DOuRPMISo6lb
         5PzVbYaIaiRdB8TxLW/Ay1Yt4RgL5PADtOnDNuCD2gkphCnnF0KM3lCCo7U7QMj71USa
         e5qA==
X-Gm-Message-State: APjAAAV1GgViOiq+Bf6ReZvOD+KXECPh3yfaxtTqggiIwc1KipM0SrN3
        QoL7GzfMxDIUa8IYBe3C/xgwcg==
X-Google-Smtp-Source: APXvYqz4yAg1bD+S0svdzIoD9J0ZoAZj9d9nIR9o555HoYP0tBNnux95dFcBJ/pcGkZq9I0WWoDm0Q==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr35628480wrs.309.1582121900311;
        Wed, 19 Feb 2020 06:18:20 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:510e:e29a:93ab:74c3])
        by smtp.gmail.com with ESMTPSA id b11sm3337772wrx.89.2020.02.19.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:18:19 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] usb: dwc3: parkmode_disable_ss_quirk on DWC3 controller
Date:   Wed, 19 Feb 2020 15:18:14 +0100
Message-Id: <20200219141817.24521-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain circumstances, the XHCI SuperSpeed instance in park mode
can fail to recover, thus on Amlogic G12A/G12B/SM1 SoCs when there is high
load on the single XHCI SuperSpeed instance, the controller can crash like:
xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
usb 2-1.1-port1: cannot reset (err = -22)

Setting the PARKMODE_DISABLE_SS bit in the DWC3_USB3_GUCTL1 mitigates
the issue. The bit is described as :
"When this bit is set to '1' all SS bus instances in park mode are disabled"

The bug has been reproduced by Jun Li <lijun.kernel@gmail.com> and confirmed
by Thinh Nguyen <Thinh.Nguyen@synopsys.com> with the explanation:
> The GUCTL1.PARKMODE_DISABLE_SS is only available in dwc_usb3 controller 
> running in host mode. This should not be set for other IPs.
> This can be disabled by default based on IP, but I recommend to have a 
> property to enable this feature for devices that need this.

Changes since v2 at [2]:
- rebased on v5.6-rc2

Changes since v1 at [1]:
- added rob review tag
- added Thinh Nguyen in commit log

[1] https://lore.kernel.org/linux-amlogic/20191014141718.22603-1-narmstrong@baylibre.com
[1] https://lore.kernel.org/linux-amlogic/20200109101535.26812-1-narmstrong@baylibre.com

Neil Armstrong (3):
  doc: dt: bindings: usb: dwc3: Update entries for disabling SS
    instances in park mode
  usb: dwc3: gadget: Add support for disabling SS instances in park mode
  arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3
    controller

 Documentation/devicetree/bindings/usb/dwc3.txt    | 2 ++
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 drivers/usb/dwc3/core.c                           | 5 +++++
 drivers/usb/dwc3/core.h                           | 4 ++++
 4 files changed, 12 insertions(+)

-- 
2.22.0

