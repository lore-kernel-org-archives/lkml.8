Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E832467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699208;
	bh=TBSkjwugAdx71V+ek//0N6epTGZxQcR558IFnm4KTI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DOFsXuIpopl5Wzb84S565WbAg6VxC9h1tauHcrmBHqXjgWr8d9jQEagPrVPfvwGRk
	 eOZD9F+vVwIBD0rP5ovvGxWGo5CNakH9zk3DBTHp0XfUv9WxiSPmwZdVP/u9OPnCsQ
	 JB2GSHG+ApysJxd+/uM7xZOLg7nr9vp5GYajF6VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgAVNUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgAVNUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:20:04 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766D82467A;
        Wed, 22 Jan 2020 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699204;
        bh=TBSkjwugAdx71V+ek//0N6epTGZxQcR558IFnm4KTI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P11AZxl1SdjaycmVYSz+b2K9ujn6Z5HClZt+x/08baSpaCNSWjT3iCVRFBAFqOVW7
         XvBmyJf2GsgHDL7O5kGAWS8ADTvgx8uk+/xovNGrBst6GXsRtK6rbi/9mx7LcYMDLw
         vTxnq0ZV7TvzSyJ5qbUFNdZN1VZCsnySNEHOnZVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sekhar Nori <nsekhar@ti.com>, Olof Johansson <olof@lixom.net>
Subject: [PATCH 5.4 036/222] ARM: davinci: select CONFIG_RESET_CONTROLLER
Date:   Wed, 22 Jan 2020 10:27:02 +0100
Message-Id: <20200122092836.090826916@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 7afec66e2bf5683d8bfc812cc295313d1b8473bc upstream.

Selecting RESET_CONTROLLER is actually required, otherwise we
can get a link failure in the clock driver:

drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
psc.c:(.text+0x9a0): undefined reference to `devm_reset_controller_register'
drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
psc-da850.c:(.text+0x24): undefined reference to `reset_controller_add_lookup'

Link: https://lore.kernel.org/r/20191210195202.622734-1-arnd@arndb.de
Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
Cc: <stable@vger.kernel.org> # v5.4
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-davinci/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_DAVINCI
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
 	select REGMAP_MMIO
+	select RESET_CONTROLLER
 	select HAVE_IDE
 	select PINCTRL_SINGLE
 


