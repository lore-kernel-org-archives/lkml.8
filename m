Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67889C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E902076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046386;
	bh=OCDPV2zz/YIKZU9qI9+BSym+ivqyXOy7+eJgm5P65Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIAp3IWvSZP1aTQfUWcxK875InjhT48BpOwzYfWrm6gzjxCvEPh9cPEHescvMln/S
	 iFVUK/ORg6dhsUfk27Ey7bMknRTZHLcPPlWzQalmiS1I2r7jFdYnG1y0G6oKvNGcOP
	 d7hY2VZt2a9PHlRn02MG6g9PqOW0/03YpaxTzpm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440535AbgDPONE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636303AbgDPNso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:48:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2162223C;
        Thu, 16 Apr 2020 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044923;
        bh=OCDPV2zz/YIKZU9qI9+BSym+ivqyXOy7+eJgm5P65Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQ1RayoUV5vzz6C/vI6D7Hoxkum2Y7IO0AFzwuAhi/SjaY3reqjBjkRKsHt9v2APs
         4M+8VKWOiUwIuXbz102fO+poY4TcuqQM2MMR/bTw9c4hXdOpNi5MifXHMX6SU1N7qq
         pkm59e+THMCMvaMN44jPcnyshE9LQ+YjgOtj2wws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.4 157/232] arm64: dts: allwinner: h6: Fix PMU compatible
Date:   Thu, 16 Apr 2020 15:24:11 +0200
Message-Id: <20200416131334.655008703@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

commit 4c7eeb9af3e41ae7d840977119c58f3bbb3f4f59 upstream.

The commit 7aa9b9eb7d6a ("arm64: dts: allwinner: H6: Add PMU mode")
introduced support for the PMU found on the Allwinner H6. However, the
binding only allows for a single compatible, while the patch was adding
two.

Make sure we follow the binding.

Fixes: 7aa9b9eb7d6a ("arm64: dts: allwinner: H6: Add PMU mode")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -71,8 +71,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a53-pmu",
-			     "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,


