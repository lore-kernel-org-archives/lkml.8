Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6CC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B7620578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272448;
	bh=g6VPhW3eBB5C1uecuVo6rBMiGuCBDUnq8qjhxoIngKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K4TJZg24H41j59pKf9JTb+9VdzVWJBJkUJwpfkE+YdhHPaQmr0AA3zs6Yoc0gs3KD
	 S1MR2HFjZWoAaD8OAnLL0lsGB7W7MqlEDnhddzT3Ar7iFMhH3Lv1HP4bKwGqvAYA+i
	 P0P/OQuPDUE52BTjw1IQWZQ9J8jbId3EBYf+voFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbgBUIH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731841AbgBUIHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:07:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AC720722;
        Fri, 21 Feb 2020 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272444;
        bh=g6VPhW3eBB5C1uecuVo6rBMiGuCBDUnq8qjhxoIngKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liI+vjaMg0GSIUYRfGkB0sqWQOEAYpGary7MJye/l1M8hwTP817Ph3ioeCtWohz58
         nb/UgtTh21D5TY4woNQxGTgihOha4nGQ2ohTZfJfoPQPvTZUKZ5o2cYSl7HM5HVPvg
         UCfsiA7ArdR2wmu0J/0hix1J3K3XwQXORkf4wctM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Paolo Pisati <p.pisati@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 111/344] arm64: dts: qcom: msm8996: Disable USB2 PHY suspend by core
Date:   Fri, 21 Feb 2020 08:38:30 +0100
Message-Id: <20200221072358.990526257@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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
index 87f4d9c1b0d4c..fbb8ce78f95be 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1598,6 +1598,8 @@
 				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy2>;
 				phy-names = "usb2-phy";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
 			};
 		};
 
@@ -1628,6 +1630,8 @@
 				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
 			};
 		};
 
-- 
2.20.1



