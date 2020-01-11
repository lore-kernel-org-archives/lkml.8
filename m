Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31267C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED86420848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738292;
	bh=CuHDXm6CnEmH/l+I+Z4tOhOiGH9ZvYgGUysk2Z+MD98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GwRiF8zS+zwLuLsvItan3ZLYl2dSTodSQkaHDjD45ek3N16mvbH9YBWX+oZCftSu
	 QutLbuH9lcYaIGPgSeujzrAwX89/Neo3Tb/h8nsEiM0k/Hy4RE5RgYm0hCf9ntS8CP
	 5GdlMsC7QUDlRcmFfnL71ttfn+eQoc6Tz3SorepE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgAKKYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731011AbgAKKYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:24:48 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C06C2082E;
        Sat, 11 Jan 2020 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738288;
        bh=CuHDXm6CnEmH/l+I+Z4tOhOiGH9ZvYgGUysk2Z+MD98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KK8jFVH1I9pSoZ7xXaWKU3KvYNh1z7d2ZP5dTFe4m7kuB7mvNLRtdaIqYDUEtJq6L
         BUkVoSjMCCkhH2z9V3LmTHx6eOOo+PSacikN1uAfhx7ar+gRrUhynCS20EYA6tfLUA
         hNgNM+UwFOEtbXKM+lTxRhxHwndfn6tI5JLg9wCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/165] ARM: dts: bcm283x: Fix critical trip point
Date:   Sat, 11 Jan 2020 10:49:30 +0100
Message-Id: <20200111094925.656174796@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 30e647a764d446723a7e0fb08d209e0104f16173 ]

During definition of the CPU thermal zone of BCM283x SoC family there
was a misunderstanding of the meaning "criticial trip point" and the
thermal throttling range of the VideoCore firmware. The latter one takes
effect when the core temperature is at least 85 degree celsius or higher

So the current critical trip point doesn't make sense, because the
thermal shutdown appears before the firmware has a chance to throttle
the ARM core(s).

Fix these unwanted shutdowns by increasing the critical trip point
to a value which shouldn't be reached with working thermal throttling.

Fixes: 0fe4d2181cc4 ("ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 2d191fcbc2cc..90125ce19a1b 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -40,7 +40,7 @@
 
 			trips {
 				cpu-crit {
-					temperature	= <80000>;
+					temperature	= <90000>;
 					hysteresis	= <0>;
 					type		= "critical";
 				};
-- 
2.20.1



