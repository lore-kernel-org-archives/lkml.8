Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A1C208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922147;
	bh=ZYzY6ErG/NfSQMyGO+ymxwRPG0Hb5eEKj9Iv+PmCo5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKkDS5hkxFbKAihMysirAPKqGP1kWFXyTSoh48fh6gqUQ11vh0yWUGq13fQ2k237S
	 Zo2SHextQ/fKhBSnIg63EQtSeSt/Sm3qAbJsIn0FIHWqj17hFJw0rwiYmuA938vKoz
	 o137FbndF168u3JGwXPX8A1YLpLmOdJgo7JgRNow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgHTLP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgHTKI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:08:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9992420738;
        Thu, 20 Aug 2020 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918136;
        bh=ZYzY6ErG/NfSQMyGO+ymxwRPG0Hb5eEKj9Iv+PmCo5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6gxt6+WIUmhwHPLzUXBP8HcUq+jLPlRtFsGtnInebTZb5EPhkFO7Hmlrrr+zBeLc
         dfYygt6w9ykxgoowOb/dqZWznE2ajxhKUn2dXu7M+rom/80JxhoYJFyMmXc1nv1jRf
         C8wAQoaQRAJTAjDBLbL1WkFdx4qCXTbLT+C78v9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wei Xu <xuwei5@hisilicon.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/228] arm64: dts: hisilicon: hikey: fixes to comply with adi, adv7533 DT binding
Date:   Thu, 20 Aug 2020 11:20:41 +0200
Message-Id: <20200820091610.908828095@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

[ Upstream commit bbe28fc3cbabbef781bcdf847615d52ce2e26e42 ]

hi3660-hikey960.dts:
  Define a 'ports' node for 'adv7533: adv7533@39' and the
  'adi,dsi-lanes' property to make it compliant with the adi,adv7533 DT
  binding.

  This fills the requirements to meet the binding requirements,
  remote endpoints are not defined.

hi6220-hikey.dts:
  Change property name s/pd-gpio/pd-gpios, gpio properties should be
  plural. This is just a cosmetic change.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 11 +++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index e9f87cb61ade7..8587912e1eb00 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -210,6 +210,17 @@ adv7533: adv7533@39 {
 		status = "ok";
 		compatible = "adi,adv7533";
 		reg = <0x39>;
+		adi,dsi-lanes = <4>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+			};
+			port@1 {
+				reg = <1>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 6887cc1a743d4..f78e6468b02fc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -513,7 +513,7 @@ adv7533: adv7533@39 {
 		reg = <0x39>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <1 2>;
-		pd-gpio = <&gpio0 4 0>;
+		pd-gpios = <&gpio0 4 0>;
 		adi,dsi-lanes = <4>;
 		#sound-dai-cells = <0>;
 
-- 
2.25.1



