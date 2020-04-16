Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC6C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9773321BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043617;
	bh=VOfh+h2MtQqoZ+YNlZDh/acRHYS0plv1SE5C2r/svls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mzs2hgAwGbDXhrgKLAUhTlpj9bavvdtmw53aBB+ej8H8xIoBFCm6TnRrb9uNZSx/L
	 l11+EHhyDJhKDWJtgnzEO6QnCMKSRe2zp25162B2iTGnu3r2KU6Z5ZRR8V4kRJs4qq
	 iR+n+dUD2+1Drr1YtwaolJlQY44CEhFJzd3c3XYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895319AbgDPN0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895174AbgDPN0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7C0206E9;
        Thu, 16 Apr 2020 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043564;
        bh=VOfh+h2MtQqoZ+YNlZDh/acRHYS0plv1SE5C2r/svls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMEyqVIPZLeMERCeVhNU51iU64K2M72HPKvKzh4RnKbuZ8/6dgIEIP2Npzi63Qxi8
         sEBnZ0HSclGK9VoZz18IMmiaNww/QdfZRyXRe+abkws/b1/Q578IJsfBJcRGFLpF4u
         6y9wTnNIvmnfFmLe8GxREVklXHZA75LGjpgiGLGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/146] ARM: dts: sun8i-a83t-tbs-a711: HM5065 doesnt like such a high voltage
Date:   Thu, 16 Apr 2020 15:22:22 +0200
Message-Id: <20200416131242.573777598@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit a40550952c000667b20082d58077bc647da6c890 ]

Lowering the voltage solves the quick image degradation over time
(minutes), that was probably caused by overheating.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 49547a43cc90a..54cbdaf7ffdcc 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -318,8 +318,8 @@
 };
 
 &reg_dldo3 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
 	regulator-name = "vdd-csi";
 };
 
-- 
2.20.1



