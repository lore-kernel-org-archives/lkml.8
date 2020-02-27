Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D74C52D2A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4623E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811828;
	bh=POQBEBmj9YQfomHR0dXXKcpPqERbDd5yZUvqqBkcoNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMqUSqd90ijWWQfGsQYOQqvVQxex5OKrD8V6moAChlKYqwEPwth2kiiwHrxaUW2jE
	 xSdRrZ2FEyFRprxmM2cBcPyqRVs8jDnbc1l1KIT1vAi+anUZpcldgb0pZOLJU6+mX1
	 USysLr2uXckr7DDeSgyNeMqOiJOCIkLd0enS8etY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgB0N5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbgB0N5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95D120801;
        Thu, 27 Feb 2020 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811822;
        bh=POQBEBmj9YQfomHR0dXXKcpPqERbDd5yZUvqqBkcoNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm0aMRC2Ucf3YOZLw4Fz54Dgoi3Jw3PylZ315ndrelTVbciEWzbfgckG/uY7IDCwZ
         /3itAk4b0uMxiwcKhCsD3EbQ2beG6X+kAqF94aXT1nFUArm4pFGI0eGyD+SNUu6jQT
         52kVH0pggnVA/A8GUl+Qcj1G5K6RiE9PK1198LKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Paolo Pisati <p.pisati@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/237] arm64: dts: qcom: msm8996: Disable USB2 PHY suspend by core
Date:   Thu, 27 Feb 2020 14:34:50 +0100
Message-Id: <20200227132302.721710336@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Gautam <mgautam@codeaurora.org>

[ Upstream commit d026c96b25b7ce5df89526aad2df988d553edb4d ]

QUSB2 PHY on msm8996 doesn't work well when autosuspend by
dwc3 core using USB2PHYCFG register is enabled. One of the
issue seen is that PHY driver reports PLL lock failure and
fails phy_init() if dwc3 core has USB2 PHY suspend enabled.
Fix this by using quirks to disable USB2 PHY LPM/suspend and
dwc3 core already takes care of explicitly suspending PHY
during suspend if quirks are specified.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Link: https://lore.kernel.org/r/20191209151501.26993-1-p.pisati@gmail.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6f372ec055dd3..da2949586c7a3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -788,6 +788,8 @@
 				interrupts = <0 138 0>;
 				phys = <&hsusb_phy2>;
 				phy-names = "usb2-phy";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
 			};
 		};
 
@@ -817,6 +819,8 @@
 				interrupts = <0 131 0>;
 				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
 			};
 		};
 	};
-- 
2.20.1



