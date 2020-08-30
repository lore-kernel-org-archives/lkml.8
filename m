Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086FFC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CA22087D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796713;
	bh=bZKjaF7zU21mhUOf60pHRJSVa3D+wHQ9mx0XEEaNPk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jcwKQU0uCDHePMbG7XQjr8PVCfTW6+4a8gOSU/2gEo8JfXsXaRpLwRJCtBA9hCWQu
	 zXP26DV5aCPlycSy4dtP4bdyXu5TkW+/2Pl6iAmdccaxM1SO/HK4pUJsZu165g+ALm
	 xdnght/pH3eDJsvQbs9cxiZxUxfMQbZ3zeDuOwKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH3OLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbgH3Nyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B49120EDD;
        Sun, 30 Aug 2020 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795670;
        bh=bZKjaF7zU21mhUOf60pHRJSVa3D+wHQ9mx0XEEaNPk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whhUpAaz8uHIu+rbNB7NYpNJWDdOeIf9ZV9Z16GtnFgM9VnU7hba/qfZFT57TMII0
         ZqlMi/ySrpVsMzz+Zy5fv4mQPkrGEM1EFNVKToeCO3BEirqVw+1p/mNLBLOSa6Xv6g
         85oXVDg+C4LQH04kCX46+MqQ3c2S8PUXpXH0kwiw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Denis GNUtoo Carikli" <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 12/33] ARM: dts: exynos: Remove empty camera pinctrl configuration in Universal C210
Date:   Sun, 30 Aug 2020 15:51:39 +0200
Message-Id: <20200830135200.24304-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera's pinctrl configuration is simply empty and not effective.
Remove it to fix dtbs_check warning:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: camera: pinctrl-0: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 9479e41bdc2a..7c83ce019b44 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -190,9 +190,6 @@
 
 &camera {
 	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 };
 
 &cpu0 {
-- 
2.17.1

