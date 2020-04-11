Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453BAC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0767120709
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648062;
	bh=rQ+FMFDbzRJVIClmJqZrm30Jm4qhTCvvooV36aXECIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ek5Ioi7nUO50SkZNmm3iJzVFqm/mEwInUfFgAfBhqDVvPae3tuliQCawGqptgYmMm
	 CWR0BfcoQ2tQQA38OFZCUVtLv2hrS23rVUpeoopssmsYfewpMfdl9a0edA/xt/8jJC
	 Lpn5efM0E5kvZUK9BbNOSDWYy3KTYbd+9j7DuVGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgDKXeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgDKXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBA720708;
        Sat, 11 Apr 2020 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646563;
        bh=rQ+FMFDbzRJVIClmJqZrm30Jm4qhTCvvooV36aXECIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNm7SFIM03zhfOnbAyN6fP3cFVKryAkv7pzx7wslurpTYI7Ye4HqIugtEkZn7f1Qz
         KXvkf2IOtvVkAw+wu4ZWEHpbYjXef0poldt4NnSUX7Ch5PdJXTSGDVdx8H9UxWvIMA
         Nr3MQv+0nvBCSjf2BvjioFIZPoG6/3zqvcsLQkfA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, Tim <elatllat@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Dongjin Kim <tobetter@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 111/121] arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3 controller
Date:   Sat, 11 Apr 2020 19:06:56 -0400
Message-Id: <20200411230706.23855-111-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit a81bcfb6ac20cdd2e8dec3da14c8bbe1d18f6321 ]

When high load on the DWC3 SuperSpeed port, the controller crashes with:
[  221.141621] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.157631] xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
[  221.157635] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
[  221.159901] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.159961] hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
[  221.160076] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
[  221.165946] usb 2-1.1-port1: cannot reset (err = -22)

Setting the parkmode_disable_ss_quirk quirk fixes the issue.

Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
CC: Dongjin Kim <tobetter@gmail.com>
Link: https://lore.kernel.org/r/20200221091532.8142-4-narmstrong@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 7fabc8d9654a5..46eea2bdbeabd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2197,6 +2197,7 @@
 				dr_mode = "host";
 				snps,dis_u2_susphy_quirk;
 				snps,quirk-frame-length-adjustment;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
-- 
2.20.1

