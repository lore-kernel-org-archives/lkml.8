Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7095BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CB52087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828715;
	bh=Mwbos0zWY2rX9HbtysjU/n4dNOCI04QklGPwEbcFCp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7y5Xp61mVCBLuzqDFmbL5p9uv3FED0R0Fc09r5jeAaicR7Z+SDoVsq3bno3aFeMC
	 wPfu0NIGnKYvODbTPBgfKE4LPHHcxJRixqkb37A2c6ESixY0LiBNX4AoIV2a3NjAMt
	 m2jq2iOrPdv9tHI3Qj47bYtKEDDmduXeUKE9vLO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgAXBSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbgAXBSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:18:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A409322464;
        Fri, 24 Jan 2020 01:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828685;
        bh=Mwbos0zWY2rX9HbtysjU/n4dNOCI04QklGPwEbcFCp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wG+3tRAwpXoF0/4lmmfmYFyGCIPJ1IFG7R3GM52LDRZEnY2eV/SP9rdP9NymCXxJJ
         R0ykqekTTLNuM1zn+YYIiK9o0QOsuk1zZZlK9/5asbbjkYH+yNjvVDYGq++LC9tIQQ
         BTVWJB8a7RJKq6K5iP87ZbWq0Bs4Xz92UNBIppPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 3/5] ARM: config: aspeed-g5: Enable 8250_DW quirks
Date:   Thu, 23 Jan 2020 20:17:59 -0500
Message-Id: <20200124011801.18712-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011801.18712-1-sashal@kernel.org>
References: <20200124011801.18712-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit a5331a7a87ec81d5228b7421acf831b2d0c0de26 ]

This driver option is used by the AST2600 A0 boards to work around a
hardware issue.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/aspeed_g5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index c0ad7b82086bd..cb23f8ade3e2b 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -110,6 +110,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=6
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_ASPEED_BT_IPMI_BMC=y
 # CONFIG_HW_RANDOM is not set
-- 
2.20.1

