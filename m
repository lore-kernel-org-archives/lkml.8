Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C91E20786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686818;
	bh=SuA5w6ezMb0ojAPZt/AGc+QJN57Z38+WSNy/llYyw8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i3aR8KQ7IH3npB49yf2GPYKcWLHnxTVCdxIDQ1rG5dSG8hgiXlFOHOrEk4CsQfzVw
	 2BBverpYtY2jDp0iGtr28hwk5hZGDf3LIF9eTngJw++TgUR6e8EuK8ShDk9fZ2o6W7
	 6/dJ2ED8feQq3KZVHgug7AqXfBQ6MxSeXtIInIWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgHQRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387597AbgHQQLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:11:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279E020658;
        Mon, 17 Aug 2020 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680700;
        bh=SuA5w6ezMb0ojAPZt/AGc+QJN57Z38+WSNy/llYyw8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmeSvwS3bcGkgCaGVTVhrbIfgFknXZB9a8Ibt6mRie13wPSaVBCJtuVPDExjxnH+n
         +hfB8W13DAbzHebvaCiEcK0ghnh6bqNtALj1Pb2SeorbhaKHMVBY1hsHtlMzN591rD
         TYtMYDxc9pIK470joJkDtrmsrf12R+kAGfKEnEGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/168] ARM: dts: gose: Fix ports node name for adv7612
Date:   Mon, 17 Aug 2020 17:15:52 +0200
Message-Id: <20200817143734.780787471@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 59692ac5a7bb8c97ff440fc8917828083fbc38d6 ]

When adding the adv7612 device node the ports node was misspelled as
port, fix this.

Fixes: bc63cd87f3ce924f ("ARM: dts: gose: add HDMI input")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20200713111016.523189-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 9235be8f0f007..7802ce842a736 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -399,7 +399,7 @@ hdmi-in@4c {
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			default-input = <0>;
 
-			port {
+			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-- 
2.25.1



