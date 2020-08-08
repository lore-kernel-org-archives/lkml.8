Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58009C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2939F20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930405;
	bh=uiIpGsEYTqwL6nQJ02O5kTo3YTu+/mkyN/E6AG/P8pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jwIpPeNb4LzbcLNGAzqALLjUnFoNEqYbK8QXrYrtBMxtLzlKmRLvNYHRCzgIGzW5W
	 1sZWkcfmCDOz6fJqBkTjSahga2a2XdJ7HQl69Q9ZGR6zO14hafBWHfzZe5Kb2OqWRs
	 IuDcUnbjBD6OAUODvubDCHPykfzY7GR8Ci14/5Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgHHXiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgHHXiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE6620825;
        Sat,  8 Aug 2020 23:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929889;
        bh=uiIpGsEYTqwL6nQJ02O5kTo3YTu+/mkyN/E6AG/P8pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKR4SJcgVH/eQUvyrcz/7PrDSefmfGKcgclf8POE9tyg/xO5qcWf0/9rLIGBpZ3XK
         RqTPy556940JES6jgsEV0U+VAi3D049U0mpn9a8LFLACquMgnhGO0YlC9W6I4UA8V7
         gtHOjWE5uoLCQJkltU4fPoUvUiTdcN7nT2F4LRpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 31/58] ARM: dts: gose: Fix ports node name for adv7612
Date:   Sat,  8 Aug 2020 19:36:57 -0400
Message-Id: <20200808233724.3618168-31-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index a378b54867bb4..10c3536b8e3d9 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -394,7 +394,7 @@ hdmi-in@4c {
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			default-input = <0>;
 
-			port {
+			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-- 
2.25.1

