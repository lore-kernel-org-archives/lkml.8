Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99858C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7218C20673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607472;
	bh=1RannAdkteMyghRDc+f5aLCgkJsdUpnGkmQK0GISlnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODGE1isuC+s+ELzi6s7R3G46wbEFoYnTJjEyzr8G+qiOO6zwaKLsBV12n8uL+ukHw
	 AwC6Ox8fL4G3G63HxQ5AXj5LHO3j4WstVfGC99NSD7PxIbFLSH+CEzhCz8XI//jMCk
	 O806lG3AuYaMbmdbAAwp6LpQIokhE3SO2GJoZgOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgDKMRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgDKMRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:17:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127D320673;
        Sat, 11 Apr 2020 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607462;
        bh=1RannAdkteMyghRDc+f5aLCgkJsdUpnGkmQK0GISlnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+xwNScp11hAsPljVu3qEr1is74YQExTOlFfctEErizpD8/z4UQbD21jVtMUs9OtC
         7uxuEipAlxHccug4D1IQ9dXdMeUH9W8UubLS3bR1/50v0aG+ocdU3S74wjTxDsjXPi
         dsRcaRu9/y1UN2GnxJphFjWfRgTW7Ycvj5jRCWhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH 5.4 29/41] ARM: imx: only select ARM_ERRATA_814220 for ARMv7-A
Date:   Sat, 11 Apr 2020 14:09:38 +0200
Message-Id: <20200411115506.165923487@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit c74067a0f776c1d695a713a4388c3b6a094ee40a upstream.

i.MX7D is supported for either the v7-A or the v7-M cores,
but the latter causes a warning:

WARNING: unmet direct dependencies detected for ARM_ERRATA_814220
  Depends on [n]: CPU_V7 [=n]
  Selected by [y]:
  - SOC_IMX7D [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])

Make the select statement conditional.

Fixes: 4562fa4c86c9 ("ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Cc: Christian Eggers <ceggers@arri.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-imx/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -557,7 +557,7 @@ config SOC_IMX7D
 	select PINCTRL_IMX7D
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
-	select ARM_ERRATA_814220
+	select ARM_ERRATA_814220 if ARCH_MULTI_V7
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 


