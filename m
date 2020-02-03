Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A5FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2162D2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748173;
	bh=QsjbUwwT6G2tcMfHQDcUEaZfQFcpR3qcXYmk4I4shpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gh8GUzwOpscj2IFF/t1S0Ev8UT2pVaQIXfaaAu+FjR8XkS+XfsKoA82Xw5F6hY6QL
	 vEJLPCA1q9rRUm0KR0oFTuV9H3KFgD9kkKiLzJygEEfnEy5gHHkOmc5qlf9ckTlTAK
	 YBpZWnLmTRyu31h2Mbth0I5RnZsU3QlGaV1mSHeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgBCQmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbgBCQdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:45 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA50B21741;
        Mon,  3 Feb 2020 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747625;
        bh=QsjbUwwT6G2tcMfHQDcUEaZfQFcpR3qcXYmk4I4shpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9bvl4no5v6UeCQMOS2bGGZpSyR/01S7L9tMvFVtYqzepa3p+w09VQUD0cBGm/6Au
         ptcuB73Kzbt68ZSqvaJO2a8+ju5kZ4W62fK1wIlv+KXzejBWc7iCc9cE/ZeXpXgZGf
         ANdhH0d6rru1TRG9Po8IParbhmzZkqCqxhOkugeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/70] ARM: dts: am335x-boneblack-common: fix memory size
Date:   Mon,  3 Feb 2020 16:20:05 +0000
Message-Id: <20200203161920.022371354@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matwey V. Kornilov <matwey@sai.msu.ru>

[ Upstream commit 5abd45ea0fc3060f7805e131753fdcbafd6c6618 ]

BeagleBone Black series is equipped with 512MB RAM
whereas only 256MB is included from am335x-bone-common.dtsi

This leads to an issue with unusual setups when devicetree
is loaded by GRUB2 directly.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-boneblack-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
index 21bc1173fa6b9..cb4267edde63d 100644
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -131,6 +131,11 @@
 };
 
 / {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+
 	clk_mcasp0_fixed: clk_mcasp0_fixed {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-- 
2.20.1



