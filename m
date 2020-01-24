Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81EF20663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864474;
	bh=LulBTmAi/2rxwJpwT9kpq/dyMu0maR6zY2C7ZSGsSbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kRFZ1rOjFz2N93fJY7lGYi4DudnDQTde+dhPMw0x0o3GrdDUcOF/F0w5D2AazP/6p
	 MuRbFZp6iQpK6wJDMX3zTckk+1TzXuQzOXxiteX6xq0w8zOAtoywJ2chCVoJIZKWMe
	 sHXELAJ/smFtmBqE8bpfKdjCzKX4P4qyMEEjqL10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgAXLOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390138AbgAXLO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:14:26 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477EE2467F;
        Fri, 24 Jan 2020 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864466;
        bh=LulBTmAi/2rxwJpwT9kpq/dyMu0maR6zY2C7ZSGsSbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCBXMytqdigdHstd7PM4Bvcc2U2UxuTbGHYOurJ8q4lt0kkV12JFZnEJCxflhWfCC
         pLsI4Mkyv0hTp87W/joLrr+fdmcWtHzO78iapmf9hqD95HMX7qhdlhtX03JD1sekbJ
         Ks1A4tOIuoMLsoeKb8vFR5OBSjQlPy7QmQ+HlPWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 273/639] ARM: dts: sun8i: a33: Reintroduce default pinctrl muxing
Date:   Fri, 24 Jan 2020 10:27:23 +0100
Message-Id: <20200124093120.930243702@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit fa44328f4eb0b762a1fcb148809068e9646e7156 ]

Commit d02752149759 ("ARM: dts: sun8i-a23-a33: Move NAND controller device
node to sort by address") moved the NAND controller node around, but
dropped the default muxing in the process.

Reintroduce it.

Fixes: d02752149759 ("ARM: dts: sun8i-a23-a33: Move NAND controller device node to sort by address")
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a272a69519a26..1efad1a6bcfd9 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -163,6 +163,8 @@
 			clock-names = "ahb", "mod";
 			resets = <&ccu RST_BUS_NAND>;
 			reset-names = "ahb";
+			pinctrl-names = "default";
+			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.20.1



