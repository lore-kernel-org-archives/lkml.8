Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50A520738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947366;
	bh=mhkQ4yUPLfI0BwkDcba9dv40Zxl1K5J7jGuM1WgniIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GO3P2H1S7kBi+Tm6/4sI95GoCqWWnWkUqZpQJhfZ685RMBXAaRUIB8PnnsmHTS1f4
	 NirRNi3CmuYTSYfzosIJRSshsT8By8iWxvqyHkK9uEFUheYNGWskN40/F+5x7CfVr+
	 mikrOCQrz6ZBUr1GNRxxmkScVxNV+Ge3PhDpsahY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391381AbgFWVWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389792AbgFWUVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:21:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154C32064B;
        Tue, 23 Jun 2020 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943701;
        bh=mhkQ4yUPLfI0BwkDcba9dv40Zxl1K5J7jGuM1WgniIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0NSQcmp4kcXpLavGeSTAdux38K4r3XeJAK64/B+QhAkxdMpDFlaRXuQOQVkXwFXg
         NRVoc/giGyNCKF/qSLdgVrH4mHUfN4a/ggthS1K5TtmvyvuNHmitFNQE6hhaELRCNB
         1i/UhZWVo7vwL0EdRmdLFBcqjv7nYh16i0XdCha4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 017/314] arm64: dts: meson: fixup SCP sram nodes
Date:   Tue, 23 Jun 2020 21:53:32 +0200
Message-Id: <20200623195339.612042709@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 9ecded10b4b6af238da0c86197b0418912e7513e ]

The GX and AXG SCP sram nodes were using invalid compatible and
node names for the sram entries.

Fixup the sram entries node names, and use proper compatible for them.

It notably fixes:
sram@c8000000: 'scp-shmem@0', 'scp-shmem@200' do not match any of the regexes: '^([a-z]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20200326165958.19274-3-narmstrong@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  6 +++---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index bb4a2acb9970a..502c4ac45c29e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1728,18 +1728,18 @@
 		};
 
 		sram: sram@fffc0000 {
-			compatible = "amlogic,meson-axg-sram", "mmio-sram";
+			compatible = "mmio-sram";
 			reg = <0x0 0xfffc0000 0x0 0x20000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xfffc0000 0x20000>;
 
-			cpu_scp_lpri: scp-shmem@13000 {
+			cpu_scp_lpri: scp-sram@13000 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@13400 {
+			cpu_scp_hpri: scp-sram@13400 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 6733050d735fe..ce230d6ac35cd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -345,20 +345,20 @@
 		};
 
 		sram: sram@c8000000 {
-			compatible = "amlogic,meson-gx-sram", "amlogic,meson-gxbb-sram", "mmio-sram";
+			compatible = "mmio-sram";
 			reg = <0x0 0xc8000000 0x0 0x14000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xc8000000 0x14000>;
 
-			cpu_scp_lpri: scp-shmem@0 {
-				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
+			cpu_scp_lpri: scp-sram@0 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@200 {
-				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
+			cpu_scp_hpri: scp-sram@200 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
 		};
-- 
2.25.1



