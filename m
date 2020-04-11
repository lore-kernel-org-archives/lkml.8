Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72282C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4206A214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607600;
	bh=RBwdeau2UXjuzCvH96Qfxh/rR+Du1Zjk34A0ZOmqfvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKWOtYxqunUjXGKpNR4xwl1zCYLYOOD5J/C5xlSNIhka8DfES8uSlS3lVp2KYHCNb
	 wn94o1+2CGBuzVTONip7y0O9xHKQTvtMEfDZIcKFypSX5ngVupwPn+HykR6yUeciYx
	 n47Ai5ZfbfAgvbYZCNtWwhob3u8YqOqJvqsrzpxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgDKMT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgDKMTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:19:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D282084D;
        Sat, 11 Apr 2020 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607595;
        bh=RBwdeau2UXjuzCvH96Qfxh/rR+Du1Zjk34A0ZOmqfvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UDnRc0q2SObP9ncGW2G3zUeFWcjERk+Xlppk2xHXAU4HVlGDEz0w5xYZJLaxw4Uz
         QqlJ2qeDUjQukte6o0cyx/lXD22Z9qinQCUvUeSCWM/RFcV2ynyUr78NN2eGVE6Krp
         8DNRYe2N63dIkOpk5JJ7tijKHiOI6LkrldsbkM60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH 5.5 41/44] ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D
Date:   Sat, 11 Apr 2020 14:10:01 +0200
Message-Id: <20200411115500.892167067@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115456.934174282@linuxfoundation.org>
References: <20200411115456.934174282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

commit 4562fa4c86c92a2df635fe0697c9e06379738741 upstream.

ARM_ERRATA_814220 has below description:

The v7 ARM states that all cache and branch predictor maintenance
operations that do not specify an address execute, relative to
each other, in program order.
However, because of this erratum, an L2 set/way cache maintenance
operation can overtake an L1 set/way cache maintenance operation.
This ERRATA only affected the Cortex-A7 and present in r0p2, r0p3,
r0p4, r0p5.

i.MX6UL and i.MX7D have Cortex-A7 r0p5 inside, need to enable
ARM_ERRATA_814220 for proper workaround.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Cc: Christian Eggers <ceggers@arri.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -520,6 +520,7 @@ config SOC_IMX6UL
 	bool "i.MX6 UltraLite support"
 	select PINCTRL_IMX6UL
 	select SOC_IMX6
+	select ARM_ERRATA_814220
 
 	help
 	  This enables support for Freescale i.MX6 UltraLite processor.
@@ -556,6 +557,7 @@ config SOC_IMX7D
 	select PINCTRL_IMX7D
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
+	select ARM_ERRATA_814220
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 


