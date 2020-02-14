Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D90C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C984C24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701453;
	bh=LtILxJ9C95kXAEwVvle1sN+WabbIIbi0e8O6PJc8BpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FyQP/JMbHx38LtS68Bp/ca2LjSTdqPFfHGWrlKcYS5DmROBQxEBLGSk4D/E5gMA3T
	 MdEmyLH3+WwLJnfkTc92SFJ2ehZmOYDAFrgMPOmEOqu17GR/VDCOdMKX/zyoV/fmok
	 3hwxDlX8X4qf0IkuFRolwadx6y6AaLbKpCPLsyiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390636AbgBNQHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390450AbgBNQGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:06:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BB722314;
        Fri, 14 Feb 2020 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696393;
        bh=LtILxJ9C95kXAEwVvle1sN+WabbIIbi0e8O6PJc8BpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4W7WCqqBpEG+cj3D6C3FNIJrZtcrggHXh/8FNvL1fITLE14T1Ebq37Y/ZBQzV49M
         aiR6TrF/rNjzKjc31K7vQ7HZ9d2Nwv3dGyxbUSWvUyCp4u4R66j0UuitxEskPJS8lb
         MsmHQ5TGt9YoxnJiOikyvCApJnxLfZ89zc3xVmkw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 218/459] arm64: dts: qcom: db845c: Enable ath10k 8bit host-cap quirk
Date:   Fri, 14 Feb 2020 10:57:48 -0500
Message-Id: <20200214160149.11681-218-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 2e198c395a084ff3015d71896e35de049c40e3a4 ]

The WiFi firmware used on db845c implements the 8bit host-capability
message, so enable the quirk for this.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20191113232245.4039932-1-bjorn.andersson@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f5a85caff1a39..751651a6cd819 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -517,6 +517,8 @@
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	qcom,snoc-host-cap-8bit-quirk;
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
-- 
2.20.1

