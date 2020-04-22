Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74EBC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDB12071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551215;
	bh=+e9qoTMeeUTLIN6LPfEmAaCFBw1h2Jg68LOFaxYeyAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jkN/ltjZ31Plp0zwP7Y6rwRu5tkFItavrgfGQxwUVF2TWuTcceD7Xan0tYR3tgXRq
	 BWADXYe5qUXofW9et5TyVmDGFqohLeOi6u7Zl8yMTbh39ZCx0bzv5ouJR8H1mggR9K
	 bmgdETEP25K21sMtG+Ak5hvqiqkprwN3DSsoZrx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgDVK0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbgDVK0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 220272075A;
        Wed, 22 Apr 2020 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551192;
        bh=+e9qoTMeeUTLIN6LPfEmAaCFBw1h2Jg68LOFaxYeyAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHkwqTg7oIHb1jNR+P85ayQhWfnM5fZ1bZDmwePI1cu23e4BAYFS3z6rWyTjh9T1r
         ZoV6sWdrwnEFEhHIZ1LQGSCuQX9sfgSllwDHi1sO8GOl8tV4eSCW65MOmHjaxKBNAt
         s5lxWxyEgu16vOMYxa1YacQFV/jrFouaR+hvdlgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 138/166] thermal: qoriq: Fix a compiling issue
Date:   Wed, 22 Apr 2020 11:57:45 +0200
Message-Id: <20200422095103.413730565@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

[ Upstream commit cbe259fd80b7b02fba0dad79d8fdda8b70a8b963 ]

Qoriq thermal driver is used by both PowerPC and ARM architecture.
When built for PowerPC architecture, it reports error:
undefined reference to `.__devm_regmap_init_mmio_clk'
To fix it, select config REGMAP_MMIO.

Fixes: 4316237bd627 (thermal: qoriq: Convert driver to use regmap API)
Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200303084641.35687-1-andy.tang@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5a05db5438d60..5a0df0e54ce3e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -265,6 +265,7 @@ config QORIQ_THERMAL
 	tristate "QorIQ Thermal Monitoring Unit"
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	help
 	  Support for Thermal Monitoring Unit (TMU) found on QorIQ platforms.
 	  It supports one critical trip point and one passive trip point. The
-- 
2.20.1



