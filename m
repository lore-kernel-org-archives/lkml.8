Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BB9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DBA20708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864537;
	bh=58Fv9ZIyRMn0SB2Avjo3jAhyEWkuVE0B6ri4MoUMM5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FnAw4vY9vGVPMQP+bEz41dzCOdwmd9Xx2oacRPqyEeSNH6qzsbahcGSyCfFwL7bZ8
	 UJauhHTIngxztbi5aAciMBpiM/InWo5OvpBRS0q6Sr2TvbMAnV86qQNBJvOyqbMqja
	 Rq6p9jths/6VTTxtfdIZq9kYjtvc4vk8BuIJeFto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbgAXLPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390167AbgAXLOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:14:32 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8E620663;
        Fri, 24 Jan 2020 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864472;
        bh=58Fv9ZIyRMn0SB2Avjo3jAhyEWkuVE0B6ri4MoUMM5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+gBF9iN14VDhocGFmQtNOnSEh464h7gGPFiqxFrUoxNFadyARm1U2wHFlTFqew/4
         s+jy9Gb8wEISMFCa/mEB4K7wul0mEOb1xemT75r3Fe8sayy+pnMb9VX45P7aAL0zf4
         j4TBGHHef2kqVAgMizYmmNeqvql3rju7w18gOB7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 275/639] ARM: dts: sun9i: optimus: Fix fixed-regulators
Date:   Fri, 24 Jan 2020 10:27:25 +0100
Message-Id: <20200124093121.242365941@linuxfoundation.org>
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

[ Upstream commit c2a5b554751545023056559121a8ecf86aebe541 ]

Commit 1848f3f44444 ("ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid
warnings") was wrong on the optimus, and instead of droping the
pinctrl-names property, it dropped the regulator-name one.

Obviously, that wasn't what was intended. Reinstate regulator-name and drop
pinctrl-names.

Fixes: 1848f3f44444 ("ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid warnings")
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 58a199b0e4943..d1e58a6a43432 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -82,7 +82,7 @@
 
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
+		regulator-name = "usb1-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
@@ -91,7 +91,7 @@
 
 	reg_usb3_vbus: usb3-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
+		regulator-name = "usb3-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-- 
2.20.1



