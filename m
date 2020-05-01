Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6B4C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD562166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339795;
	bh=RV4d/t8wCP81nKyW+WJMde16vAm9Qrpdr4u0hkGPIrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUqtVPSvMaI7Xbh1SpARX/m3LhlYLLXWz3ssk4YWZd9b7KPnN1+BYtXyHa1alJIZd
	 EspP9iJQCAAHkiJ1kt6H7worovumkhD+7Z7mPv+fQff+k1ccoZ5BojE2a39cEUmp4n
	 vykpptMEB99GRVKi3iUcosQ1TAzwnAWYTbL6q8mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgEAN3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729823AbgEAN3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:29:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3667D208D6;
        Fri,  1 May 2020 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339785;
        bh=RV4d/t8wCP81nKyW+WJMde16vAm9Qrpdr4u0hkGPIrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8yRMwjvLRibrf/bCGOueCpPg5ap02UF+GlzBFlFMBzV1sE3DknVgASt7S17uuIvN
         ogsAacmjcxMugi0TXCyVKAbuBjereuaIpsbYmUkQRguwUCq7G9piEOBJlWPV+8mOHG
         eA6o5/nXltavuUp5raj5q4+TUW6a8TRoYZ3luK8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Roland Hieber <rhi@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 51/80] ARM: imx: provide v7_cpu_resume() only on ARM_CPU_SUSPEND=y
Date:   Fri,  1 May 2020 15:21:45 +0200
Message-Id: <20200501131529.456441984@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

commit f1baca8896ae18e12c45552a4c4ae2086aa7e02c upstream.

512a928affd5 ("ARM: imx: build v7_cpu_resume() unconditionally")
introduced an unintended linker error for i.MX6 configurations that have
ARM_CPU_SUSPEND=n which can happen if neither CONFIG_PM, CONFIG_CPU_IDLE,
nor ARM_PSCI_FW are selected.

Fix this by having v7_cpu_resume() compiled only when cpu_resume() it
calls is available as well.

The C declaration for the function remains unguarded to avoid future code
inadvertently using a stub and introducing a regression to the bug the
original commit fixed.

Cc: <stable@vger.kernel.org>
Fixes: 512a928affd5 ("ARM: imx: build v7_cpu_resume() unconditionally")
Reported-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Tested-by: Roland Hieber <rhi@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-imx/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -86,8 +86,10 @@ AFLAGS_suspend-imx6.o :=-Wa,-march=armv7
 obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
 endif
+ifeq ($(CONFIG_ARM_CPU_SUSPEND),y)
 AFLAGS_resume-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += resume-imx6.o
+endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
 obj-$(CONFIG_SOC_IMX1) += mach-imx1.o


