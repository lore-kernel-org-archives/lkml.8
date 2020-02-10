Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4FC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E239F2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581343473;
	bh=7fRbMVB8UtpzAcwDa2C7GH4fqkKZBT/U7iNhVYXR1BE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ftgHnvLUoHXIp2arke6MIGr1NWbT7WYCeVx+wF9x6yvXu/fRnf2M0gboGBiqgPbxQ
	 Do2SOQxHXjHvZnJONBiidEGionknAwBlQlPlAwWpeTt3QTePKuXbSGVtJsMuO49dYB
	 2vDMsiTsB7j3JMDOFgfaiJdkRgAWtm/NcKK6b/Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgBJOEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgBJOEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:04:33 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31925206D6;
        Mon, 10 Feb 2020 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581343472;
        bh=7fRbMVB8UtpzAcwDa2C7GH4fqkKZBT/U7iNhVYXR1BE=;
        h=From:To:Cc:Subject:Date:From;
        b=tdLgfvi+MwEhD3EQ+OniSWgk5rxOMfpVefeowW9T4nkdFrXEhdP6oXDnqCoBEBuYx
         ObgGrQX7aD137yvFDvLp/DvlFnPPR41dotnWtS4p66QYZc61/ci3ujJXjRHqXebhvT
         PYQIRQ1cI6OMpIXLdo/ewczjp9CCuYx9d6Oj11n8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH] dt-bindings: usb: exynos-usb: Document clock names for DWC3 bindings
Date:   Mon, 10 Feb 2020 15:04:16 +0100
Message-Id: <1581343456-18900-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos DWC3 driver expects certain clock names, depending on used
compatible.  Document this explicitly in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 66c394f9e11f..6aae1544f240 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -78,7 +78,14 @@ Required properties:
  - ranges: allows valid 1:1 translation between child's address space and
 	   parent's address space
  - clocks: Clock IDs array as required by the controller.
- - clock-names: names of clocks correseponding to IDs in the clock property
+ - clock-names: Names of clocks corresponding to IDs in the clock property.
+                Following clock names shall be provided for different
+                compatibles:
+                 - samsung,exynos5250-dwusb3: "usbdrd30",
+                 - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
+                                              "phyclk",
+                 - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
+                                           "usbdrd30_axius_clk"
  - vdd10-supply: 1.0V powr supply
  - vdd33-supply: 3.0V/3.3V power supply
 
-- 
2.7.4

