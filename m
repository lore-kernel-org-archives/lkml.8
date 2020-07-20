Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E96C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B9922482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260329;
	bh=dMpZKAoREPt/Ph4s1EySu309CYTNsehZNf+8JaSdUCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xFZo09xZTYDz3RdsoEFsaLpTCNdAPP1nRDucC86wrFrdKRdzYuMvYk6RLUQ/+JLb2
	 PfB62kyyMbXKz1R+wBYsfEibJSsmXDFjoRM9hwcvl9jgWtTAqh+UHwjoid8Zn7AwBi
	 Nn58AYpQbiGkoseELlR9o2AJhz7W0c3PgVbBrH5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgGTPwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgGTPwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12A32064B;
        Mon, 20 Jul 2020 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260322;
        bh=dMpZKAoREPt/Ph4s1EySu309CYTNsehZNf+8JaSdUCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0SotcvCudK0dcDVXHivGVJLzjKTWRGuh/CHp9TQGMqy3TDRRlJ6QA5A5MppHTDXn
         48OK+yYaeOvYo8hDuVzBNcffA+NH+oujrKAGLO7Npr78a2FlbFWopVAJ/NKcma6o5w
         0jXd+WBwo1MLoOfeLxZUjXXyiFCwvymHKrjbwRPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/133] arm64: dts: meson: add missing gxl rng clock
Date:   Mon, 20 Jul 2020 17:36:47 +0200
Message-Id: <20200720152806.628720493@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
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
index 8f0bb3c44bd6d..5d7724b3a6123 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -266,6 +266,11 @@ clkc: clock-controller {
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



