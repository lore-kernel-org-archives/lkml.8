Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E150C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D993C21D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048558;
	bh=rXkh2aRrbIIG14idHHtgzlWycyi8V8ynYJ10c0RNDbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Lcq9nvqEI6znX1O6JYCAdkoCTU73tJSn9zGO2SZ5pXCh9io/Z5eZ0KbkdZCyQAIH
	 Idu3Dw1ahHLpzINs9KN6dIx8ZkmzRhoGsJ2MipP2qO3gZMYVk4Pq8O1uCzOMRVfXz3
	 YMxpDR3NuvUKgJH2/vXBRhogVgl9L/YoEWihjB8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394791AbgDPOtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409396AbgDPN6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B174221927;
        Thu, 16 Apr 2020 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045525;
        bh=rXkh2aRrbIIG14idHHtgzlWycyi8V8ynYJ10c0RNDbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfWiQtbhwJgJdQiPUo05hKmJBWcQtlsJofCswyXaNeD+xmV8v4gsbm7lhwlMzl54R
         lbar+qxDbNkEXseyoM3zdmsFoW3suC4c6k3FFn6XYLfqgptTQQQrbdKPLpgX55htGe
         ZvyrSB4rqWnHey/UVuTRfg/2+q9exM/DdkHo/p9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.6 169/254] arm64: dts: allwinner: h6: Fix PMU compatible
Date:   Thu, 16 Apr 2020 15:24:18 +0200
Message-Id: <20200416131347.657042268@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
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
@@ -70,8 +70,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a53-pmu",
-			     "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,


