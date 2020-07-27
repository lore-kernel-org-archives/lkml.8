Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A0C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1264E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859219;
	bh=XnzV0jukFU97VjRupq8I/WQ0fM6iycBlGRZ6V20MYUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jLWmumlldPz6FvNXqLxlPY94oSR/nwcNxSVNFL9Pm6zztOM4CiSChY+2PDWl9YFwU
	 wihNac86PwgdtFpBzNUZjJGsw2RtG1WaQ6xY5q6IF2lFN9LK9wHNiv+CV5PzB3VroC
	 LpPkEdsV/lsoirSXX2JexJYHfElZI1hZiyUylYnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgG0ONh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbgG0ON3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:13:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E04B2073E;
        Mon, 27 Jul 2020 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859209;
        bh=XnzV0jukFU97VjRupq8I/WQ0fM6iycBlGRZ6V20MYUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u15WDZEgu0WN574ulQwgVa124quKybiz2t3fATbA0wIsPMtGnMOBYvqqa0Xrn5gVl
         4vsLC6papYnejGt4m03tcQ4lwvvip+hfSPTHthFU2XJr3Ndl1JgPsOn30n75X5CBLJ
         YJhN4KfpEWS2VlQlknhV0CL6dhKmF4juodVgJFy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 021/138] ARM: dts: imx6qdl-gw551x: fix audio SSI
Date:   Mon, 27 Jul 2020 16:03:36 +0200
Message-Id: <20200727134926.385574910@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit 4237c625304b212a3f30adf787901082082511ec ]

The audio codec on the GW551x routes to ssi1.  It fixes audio capture on
the device.

Cc: stable@vger.kernel.org
Fixes: 3117e851cef1 ("ARM: dts: imx: Add TDA19971 HDMI Receiver to GW551x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index c38e86eedcc01..8c33510c9519d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -110,7 +110,7 @@
 		simple-audio-card,frame-master = <&sound_codec>;
 
 		sound_cpu: simple-audio-card,cpu {
-			sound-dai = <&ssi2>;
+			sound-dai = <&ssi1>;
 		};
 
 		sound_codec: simple-audio-card,codec {
-- 
2.25.1



