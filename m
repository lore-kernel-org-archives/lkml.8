Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10720CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257656;
	bh=b0T7XcKyF7fdfoO4CCzBX1iv4p+VefjFERsskt64TYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aa0u5XsXJkr3rrRGZUo9FKoDF4LwtdP306M8V0k9cPw/pKFA3I9s3jaZT3OJ9Oj1h
	 qlXE2oD/tbQdKbmTiy2q6xigiX0qZV0e+xA9b/ZzB8h1K2C1P7JAK9EwHfdGPTA7Yu
	 boIRB7Azt/nlR+T7sTcLV5V2TATxaa/VibSoSWIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgCCRrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbgCCRrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:47:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3083208C3;
        Tue,  3 Mar 2020 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257651;
        bh=b0T7XcKyF7fdfoO4CCzBX1iv4p+VefjFERsskt64TYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAtXCf+ae5BTUK1uTy+TpYQfTgaTNZ0IdjoxCvADbzenxVDoPWEbtlcby0KpF42Gt
         1Fn9SdLUUYkJCJqNr6iZaZXBEvi3TAGM3GvCBL/as8J3p/10rYbQMjvJZbweFjdTvu
         gsOJg4/adv0T7bbsj73kXykRrSvpOLZb15T0D0+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 044/176] ARM: dts: sti: fixup sound frame-inversion for stihxxx-b2120.dtsi
Date:   Tue,  3 Mar 2020 18:41:48 +0100
Message-Id: <20200303174309.625791372@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit f24667779b5348279e5e4328312a141a730a1fc7 ]

frame-inversion is "flag" not "uint32".
This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 60e11045ad762..d051f080e52ec 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -46,7 +46,7 @@
 			/* DAC */
 			format = "i2s";
 			mclk-fs = <256>;
-			frame-inversion = <1>;
+			frame-inversion;
 			cpu {
 				sound-dai = <&sti_uni_player2>;
 			};
-- 
2.20.1



