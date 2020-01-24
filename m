Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC5C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79AE2468A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828708;
	bh=ny9PYva32ScPOAXGjxJcNlDJIh1SjBwEbovcV72cTa0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QJwPLbZDui3okIgvIF+ASV1LTNi0uhQ+OAumRg1dpeP8XoUykca/Ba7vR4DsoAFBT
	 /xUD6m36d5xrFe9WOu4bQkmV/741LCkkySGdE5pi9mQ5K24D2UGr9nmZ/NPFMkm/0m
	 3R8Mn8TgQ0Ic8R4h4nrjMG29/I37L4ra55TwMUTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgAXBS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbgAXBSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:18:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909CC2087E;
        Fri, 24 Jan 2020 01:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828690;
        bh=ny9PYva32ScPOAXGjxJcNlDJIh1SjBwEbovcV72cTa0=;
        h=From:To:Cc:Subject:Date:From;
        b=OUFpA+2RzxPXdvOaBhcavl1bUxi7eaTo/Yk9BY/Dh2a7d5qEA/2ZKFWT42tghfAms
         T/96pTpN9/f5SAwcpYqqkXSlS1uQKL96jbIyBYbN5/azrR9Et4/n6q5kuG5aZf5/R6
         fS0ZPZMqlHVbGTc10EI16y7dGmowM/h1YJnS2RrE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 1/2] ARM: config: aspeed-g5: Enable 8250_DW quirks
Date:   Thu, 23 Jan 2020 20:18:07 -0500
Message-Id: <20200124011808.18801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
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
index 4f366b0370e93..3fb6bcba79942 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -53,6 +53,7 @@ CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_USB_SUPPORT is not set
-- 
2.20.1

