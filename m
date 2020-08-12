Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36105C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073DF20771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249832;
	bh=MQR05X2smn64mi3esQ9qgy+sb0U5n0XiH+PjMJuVSKg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yED4ysL592xYL/7uCVFMbB/CvH24qBN84GXpuOCyyKgq1V/TXNvbIOInI3kv0Ty6+
	 qTVCfsaMFpT0S3ZSrXeYz5xMSQZBIpZxYiRAPUgaZ81LPKK9k9YSVbtmBbMxfMcnek
	 rQrJC+Bt0K2ZUa7qM3O40jUKcw3IcAg84Qr+BSUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHLQaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgHLQa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ABC20771;
        Wed, 12 Aug 2020 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249827;
        bh=MQR05X2smn64mi3esQ9qgy+sb0U5n0XiH+PjMJuVSKg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TecpCjzSsK1L1wUlUM8irEC4MvbLmUIc0ew/sEDkey7UrPqBnx5+JC0/G+IN8niDz
         nAr3ivNfgoepmLesLHhU4gqxdBANPtw2XEhFQOFkDD4GknHOakp2qzXZQ9YVK4R2yL
         bMXmQFnjZg1qY9XjoMZhfSuZxC5vQbvVqRphet4M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 11/11] MAINTAINERS: Add entry for NXP PTN5150A CC driver
Date:   Wed, 12 Aug 2020 18:29:58 +0200
Message-Id: <20200812162958.6180-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Krzysztof Kozlowski as maintainer of NXP PTN5150A CC/extcon driver
to provide review, feedback and testing.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2eb17cd3953..48cb5162a94a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12431,6 +12431,13 @@ F:	drivers/iio/gyro/fxas21002c_core.c
 F:	drivers/iio/gyro/fxas21002c_i2c.c
 F:	drivers/iio/gyro/fxas21002c_spi.c
 
+NXP PTN5150A CC LOGIC AND EXTCON DRIVER
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+F:	drivers/extcon/extcon-ptn5150.c
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.17.1

