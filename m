Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84738C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FCB2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="waWdG4Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBSOSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:18:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35276 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBSOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:18:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so770638wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9xo7c5xIj503yHqM6KupvIMlSgtFtTi88b83o6eSpE=;
        b=waWdG4XrW/EyuOUHVJ+iPuGlQzQRPMVeiFZmuqt63qawGzIZe7kly2VTbx7nkdw5+r
         BtzQToiQTyOB4geMLMJMtnUgjMMBgxA7gdQphqDzKy59R1qpzB68bZTi2kbcTK7CJhxO
         hh4NiDeWbL7WqbqrTlyUZY9G2NZPn6x9mT7nWjCwdOxmqywcONXSVOBgC3H21Bv04sml
         DxiB+DcCg+O5h61UzJQmuDFJTkj1aDglNEE9cJ+NxPmxBCtPfTTnNIN8mZTlrDd6owxi
         55mJiuEAJa+VINDupWca2I8xX0ZZbMc19EdkVX0g41M638AoQy95qSPtsG5H7rIDL3Iz
         /Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9xo7c5xIj503yHqM6KupvIMlSgtFtTi88b83o6eSpE=;
        b=t7FXdpPt11hQ1CJ0c5uFXS22S+XRg0fdkO0cg+M4VgNWpBdK4DYbhseKLkXxOVIhAQ
         a4ThIvKOnWOfW3nFwVBU0ilYOivpuqJCgHTiZjc1hHJh3UGTHx7s+YDeZQKY868mRrdB
         IrfO2JffWJMgN+YVlPr/zANddjwypeH15p8tfB5Y4ZccGyxFSvpmlxCPJbGqg6HKCX95
         HkvMk03zmPCmBtYHtK/PU9DF7Z5FqmncajtiOObmVrt1eegOp2a+aEEJ26bXz9Bm8Qnx
         +jQ/ymMGl4SIfdUKVcfuT49cZ0Ycfu/NGycrtkGPs7Tar3CcMVVVrMPh3fIF0Q5axxTp
         sR6g==
X-Gm-Message-State: APjAAAXv8ofTz/aRJRTN2mbFb7rPS1s2ImQDJ+Pr0EnCWchJRitfcQGx
        Da4+VhZCscrIG0/xsM9vbqmLiw==
X-Google-Smtp-Source: APXvYqxLVGf28xLvfSGn9RNQlEUC9o5LfiGwH9Hro/B8+KLSDPU477rsdTxeZIEGkdiMgYuB0154Ag==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr36121815wru.294.1582121903188;
        Wed, 19 Feb 2020 06:18:23 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:510e:e29a:93ab:74c3])
        by smtp.gmail.com with ESMTPSA id b11sm3337772wrx.89.2020.02.19.06.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:18:22 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>, Tim <elatllat@gmail.com>
Subject: [PATCH v3 2/3] usb: dwc3: gadget: Add support for disabling SS instances in park mode
Date:   Wed, 19 Feb 2020 15:18:16 +0100
Message-Id: <20200219141817.24521-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200219141817.24521-1-narmstrong@baylibre.com>
References: <20200219141817.24521-1-narmstrong@baylibre.com>
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

Synopsys explains in [1]:
The GUCTL1.PARKMODE_DISABLE_SS is only available in
dwc_usb3 controller running in host mode.
This should not be set for other IPs.
This can be disabled by default based on IP, but I recommend to have a
property to enable this feature for devices that need this.

[1] https://lore.kernel.org/linux-usb/45212db9-e366-2669-5c0a-3c5bd06287f6@synopsys.com

CC: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/core.c | 5 +++++
 drivers/usb/dwc3/core.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1d85c42b9c67..43bd5b1ea9e2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1029,6 +1029,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
 			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
+		if (dwc->parkmode_disable_ss_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -1342,6 +1345,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-ss-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 77c4a9abe365..3ecc69c5b150 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -249,6 +249,7 @@
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
 
 /* Global User Control 1 Register */
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
@@ -1024,6 +1025,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
+ *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -1215,6 +1218,7 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		parkmode_disable_ss_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-- 
2.22.0

