Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B1BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4438221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739325;
	bh=jkHktbppRvONf+xJVWmfSCc2eQC8JATnpI2A2T7cDPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Or85bYeeCX78JPuRz0lZNimWN28GXG972N39FXYkV99UtmBYaaVZ2Oic7NCHdqoM1
	 HC9tDs8O6vVOFg6X+lYQJ4hD9M7sBqJOWB64Uyt8KmtcXUutBE7sZqPbXN7Y0jNjE2
	 frS5szCR+NUGLstGI5IviuvREJp1E2RHcskHaa7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgHFSmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbgHFSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7680622CF7;
        Thu,  6 Aug 2020 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738116;
        bh=jkHktbppRvONf+xJVWmfSCc2eQC8JATnpI2A2T7cDPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myqjfk5TqieOfDTqf9vLXeOC0RvfTRnK4oPV3KF2Mi25rXjpnyj89EYEB/pv3E6oD
         hX+zM779/ialBivqyBVc5q9adJbuO7yXflyYpaJyjYiFP0b4Ky4Q9mBCUgof7rc4uz
         lDAEWR85hJEmUil1JhdfzQKn8uqDhADiCt+ymd5c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 04/41] ARM: s3c24xx: iotiming: make functions static
Date:   Thu,  6 Aug 2020 20:20:21 +0200
Message-Id: <20200806182059.2431-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two functions in this file that are never called from
anywhere else, so they should be static to allow the compiler
to optimize it better and not pollute the global namespace.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 9f90aaf70bf3..39081c41958c 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -129,7 +129,7 @@ static unsigned int calc_0124(unsigned int cyc, unsigned long hclk_tns,
 	return 0;
 }
 
-int calc_tacp(unsigned int cyc, unsigned long hclk, unsigned long *v)
+static int calc_tacp(unsigned int cyc, unsigned long hclk, unsigned long *v)
 {
 	/* Currently no support for Tacp calculations. */
 	return 0;
@@ -288,8 +288,8 @@ static unsigned int get_0124(unsigned long hclk_tns,
  * Given the BANKCON setting in @bt and the current frequency settings
  * in @cfg, update the cycle timing information.
  */
-void s3c2410_iotiming_getbank(struct s3c_cpufreq_config *cfg,
-			      struct s3c2410_iobank_timing *bt)
+static void s3c2410_iotiming_getbank(struct s3c_cpufreq_config *cfg,
+				     struct s3c2410_iobank_timing *bt)
 {
 	unsigned long bankcon = bt->bankcon;
 	unsigned long hclk = cfg->freq.hclk_tns;
-- 
2.17.1

