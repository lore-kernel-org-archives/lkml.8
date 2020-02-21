Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B327EC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8841F20679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jegHlrmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBUJPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:15:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40893 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgBUJPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:15:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so1105906wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8yINZRO45/buDujM3HQWN+HE7/zrh3qil8LER65I0o=;
        b=jegHlrmtmgw87Ca60vU0+DYn4GCrVvFjA+xO7x6L2ft9I51PJufmlfsA6GBWoidzwP
         6sIii+nww8wDFcwhHxTIWTNAF2UhJylwBc8oQw57UuH7G1G699lN1HMizu6F/1nHzSnc
         7+A8Cc5XJXo3skcFg41rPNd7C2qkMRES8HGRCWC4wU4D4BOPiqSXruHy1Vmk8FAg4j1n
         WmC04Hzz6DQvJbz0Grfyy03eQuUWdE91ZmHylDyfnSDR8ATZAFzrt0m+tUvmtByucCGK
         lV7/PhKNMZA1YAgqpOL8V/DZJBhyeYSX8873/n1PZ8LOf2HWmMvIFDjkf4r0bkiIjqnB
         fhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8yINZRO45/buDujM3HQWN+HE7/zrh3qil8LER65I0o=;
        b=Uy2D/QLh4IBN8g6D/8ZpsEb1opmUx7AR/6SSlBW+2emUrS2Ke2LpRWD9BLSbkVo8ob
         HnO/vyrRONCuR812t4yaiz0U0Dv1j5POM2j3n+aaiFo/mZfsaoNOsyLVwlrN9zefH2dP
         w0532OJCkZGHADd+VUizoa3sTroQKxW6Xb9YoDwxlNc5qANsWAXqZiSZtrGCxENYgW5u
         XduvMxyxB3Zhdq7sIg3kln4KTnUpSyHUbXwn9FAvXF2jWbbatuY1KTEEcVGnAx1PG30s
         Ldv8HITN+HzyKYG9W2a4EIl0oi6MrQJUeu+RW2Hd4TbqPzFjacUUYgJ1WBzJR6wg6ghf
         upoQ==
X-Gm-Message-State: APjAAAUpumBzkQHIqocmT1+ibDfvu89tLo5kWi4mUml30YO1uNgcRIYx
        VFmlA3PlXDM7VsixOYI2KNYOQA==
X-Google-Smtp-Source: APXvYqzOLrvYke8JxLusQTYxWMJgWVJI5YZHIN1lAn+HFD0jVXgsy4eUze9XGMGeCS4PcOmFh9h0Ug==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr50072068wru.220.1582276540323;
        Fri, 21 Feb 2020 01:15:40 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:4ca8:b25b:98e4:858])
        by smtp.gmail.com with ESMTPSA id o15sm3257837wra.83.2020.02.21.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 01:15:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>, Tim <elatllat@gmail.com>
Subject: [PATCH v4 2/3] usb: dwc3: core: add support for disabling SS instances in park mode
Date:   Fri, 21 Feb 2020 10:15:31 +0100
Message-Id: <20200221091532.8142-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200221091532.8142-1-narmstrong@baylibre.com>
References: <20200221091532.8142-1-narmstrong@baylibre.com>
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

Synopsys explains:
The GUCTL1.PARKMODE_DISABLE_SS is only available in
dwc_usb3 controller running in host mode.
This should not be set for other IPs.
This can be disabled by default based on IP, but I recommend to have a
property to enable this feature for devices that need this.

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

