Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421AC20746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615509;
	bh=azMOu8EjMGDrE0P+u3NYrkPUjjB/EnRM97c2/Lsix7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pO0uaQEX/64OwJizrNs+AjLgHNTwjLr62us1WaSNQlCrFmb5oKjadHXICTBtD1D7y
	 wPpHOFHYey6oDZrFoYax8vh6/1QwYB+VeZYPy/7F5MN25mJt71pWhuAjcqXPYAGTiV
	 lWD0V+fXFsUKiY1Q4b+skFzsrlJRYHk+Z0AISXoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgEDSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbgEDSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:04:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37FA207DD;
        Mon,  4 May 2020 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615496;
        bh=azMOu8EjMGDrE0P+u3NYrkPUjjB/EnRM97c2/Lsix7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1si1RGvy0/sNE68cnE/5l6ENpRP5w5XhasKB5hgJ9xlkA7d/IS2ZRv5RvVh6yHy6
         DolYo0VQ47szhaqbPZJs4/GWKvbXRKhAHY7hr3+V6P6vKqWlDdTznJKhNsX9nuv/Ki
         eef8D2+O/g7J/kbKiVmrGuY6hP45cBne1jjGaS5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
Subject: [PATCH 5.4 33/57] ARM: dts: imx6qdl-sr-som-ti: indicate powering off wifi is safe
Date:   Mon,  4 May 2020 19:57:37 +0200
Message-Id: <20200504165459.203658645@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

commit b7dc7205b2ae6b6c9d9cfc3e47d6f08da8647b10 upstream.

We need to indicate that powering off the TI WiFi is safe, to avoid:

wl18xx_driver wl18xx.2.auto: Unbalanced pm_runtime_enable!
wl1271_sdio mmc0:0001:2: wl12xx_sdio_power_on: failed to get_sync(-13)

which prevents the WiFi being functional.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Cc: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi
@@ -153,6 +153,7 @@
 	bus-width = <4>;
 	keep-power-in-suspend;
 	mmc-pwrseq = <&pwrseq_ti_wifi>;
+	cap-power-off-card;
 	non-removable;
 	vmmc-supply = <&vcc_3v3>;
 	/* vqmmc-supply = <&nvcc_sd1>; - MMC layer doesn't like it! */


