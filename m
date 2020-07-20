Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD46D206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261365;
	bh=3teWVEPaloupJTd7mQW+Y7NsazRnxCyO/FYsPNSXKDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cMLbrdnk8lzUtL+kS2Fmm+sXdeBqWNYU870LE8Y9kqLGF1yb2ywGe/zpn33tzsPHZ
	 kk8kfpP6uDKyu8mSzs12o03HHlZdN4cuixVNUOG5PeseID7E4/rMFf6Od1QaeBxMit
	 zGKqMSre6UhPa1ipNsxfhS4KOKddc5NsfCD9gclw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgGTQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbgGTQJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:09:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D422064B;
        Mon, 20 Jul 2020 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261356;
        bh=3teWVEPaloupJTd7mQW+Y7NsazRnxCyO/FYsPNSXKDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFiWe8b0OuNFkjDWxzX65xmpNLQdoS/Y8dVUoVlHE69CoZOSTm4Zh37m/UfzUCrRE
         Ib4fLrVqRIDKSugfRXyYI3reQKX0HVyJxC8adbYshlXs9yhvAgc9oGWdGG1g7bPa3H
         vSunCpLhC6TGUQhEoaEgYWLoTHyU7FIqhqScUvqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 087/244] arm64: dts: meson: add missing gxl rng clock
Date:   Mon, 20 Jul 2020 17:35:58 +0200
Message-Id: <20200720152829.979762656@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 95ca6f06dd4827ff63be5154120c7a8511cd9a41 ]

The peripheral clock of the RNG is missing for gxl while it is present
for gxbb.

Fixes: 1b3f6d148692 ("ARM64: dts: meson-gx: add clock CLKID_RNG0 to hwrng node")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200617125346.1163527-1-jbrunet@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 259d863993905..887c43119e632 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -298,6 +298,11 @@ clkc: clock-controller {
 	};
 };
 
+&hwrng {
+	clocks = <&clkc CLKID_RNG0>;
+	clock-names = "core";
+};
+
 &i2c_A {
 	clocks = <&clkc CLKID_I2C>;
 };
-- 
2.25.1



