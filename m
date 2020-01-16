Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99621C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635D32072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216819;
	bh=yiFbhYZs4OakPil0W1cRjf0MHa+WDnry7VTabF4Vsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2iID3x5NbLCCif5EfFMeEpUXzDMyxkoXU3hpIRchv0u2q3FKX3rR0TysXltdaJtq+
	 KlgQSYqEX9QpO+82o2X67B2Fvr8DoMKYGKay990dmsSCt78+d6YcSSnjMmxGsI3zeX
	 xk/KNTptdaY8Nix1Rj+c16GHth+5qdy/wa49/7uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbgAPXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390565AbgAPXUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32052072B;
        Thu, 16 Jan 2020 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216807;
        bh=yiFbhYZs4OakPil0W1cRjf0MHa+WDnry7VTabF4Vsrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13xuKyqR4JSLz5EUokm/4Ke6SmbMmWvd2vVooiwopuNPGRrAMN20Y3wFR9ZXUzJtW
         r0QnCpkgUuZDBSxO7Zoy4O4rLp56c5SsE21D9j187Msxs3w2EKZ7x3gyW9o5VWhoVR
         7B5CZ/JgE3NmwjllLqxI2eWg8z7/d1KIbrfw7gQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5.4 027/203] PM / devfreq: tegra: Add COMMON_CLK dependency
Date:   Fri, 17 Jan 2020 00:15:44 +0100
Message-Id: <20200116231746.779254239@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 5fdb0684b5b0f41402161f068d3d84bf6ed1c3f4 upstream.

Compile-testing this driver fails if CONFIG_COMMON_CLK is not set:

drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_target':
tegra30-devfreq.c:(.text+0x164): undefined reference to `clk_set_min_rate'

Fixes: 35f8dbc72721 ("PM / devfreq: tegra: Enable COMPILE_TEST for the driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -99,6 +99,7 @@ config ARM_TEGRA_DEVFREQ
 		ARCH_TEGRA_210_SOC || \
 		COMPILE_TEST
 	select PM_OPP
+	depends on COMMON_CLK
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
 	  It reads ACTMON counters of memory controllers and adjusts the


