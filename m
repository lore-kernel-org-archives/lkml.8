Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8744D2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942761;
	bh=zwhRJ+OuXl7qZ0G5brL2deN/W22Eb6hT5+ciEo1woDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1l4dTXxxFTZdcrBdFDVsGDljrYb8L6/yO/D9tFUOqDBLBLC9tLxuq4ghGtIlbFhc
	 JeUnkDU+E0/EG/ZSaicLRD098SiLRnbBaA2wOUuZr0UqeVD2MTNpRGqwa1wQbUbZCs
	 6qMKMoXd/yHragZ3CmOI36rKaD9Lc89VYjr6OWx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbgFWUGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388394AbgFWUFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:05:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B4E2064B;
        Tue, 23 Jun 2020 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942751;
        bh=zwhRJ+OuXl7qZ0G5brL2deN/W22Eb6hT5+ciEo1woDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8pI7/npFccq1ra4B8rWmcB8jDLV/tFAdTKQ1g3gkEsEbzhZUoz7Nifhb5RMxyaJY
         udka71Fp+E7jiwHlHpns9UhyqMTxwt33KwwoUMD04NLGsCytLHK5syq/vRaYmp8KSn
         7qxhRvTohN7UF84ZY84S+g9MuJstvJUU8oHww+LI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 121/477] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: Fix led polarity
Date:   Tue, 23 Jun 2020 21:51:58 +0200
Message-Id: <20200623195413.326888080@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Stehlé <vincent.stehle@laposte.net>

[ Upstream commit 34b6826df7462c541752cf8b1de2691b26d78ae0 ]

The PWR-LED on the bananapi m2 zero board is on when gpio PL10 is low.
This has been verified on a board and in the schematics [1].

[1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#Documents

Fixes: 8b8061fcbfae ("ARM: dts: sun8i: h2+: add support for Banana Pi M2 Zero board")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index d277d043031b2..4c6704e4c57ec 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -31,7 +31,7 @@
 
 		pwr_led {
 			label = "bananapi-m2-zero:red:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_LOW>; /* PL10 */
 			default-state = "on";
 		};
 	};
-- 
2.25.1



