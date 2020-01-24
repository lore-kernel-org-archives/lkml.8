Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3FAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296712071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876722;
	bh=+I5ykO5NXtCEJfLJit9LMgzYwZuR+pnoXVd6Iosr3M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vXLd79SsGbzpX+VpLMaZogWTj61QGQUuKEb6GvF+cmpaen7tByMlCgN2MbbMgUqGp
	 +tpXHopr7z30nquAVXmVS6S9afKmgCP6HmNQJIie7LLDyqxtEpS9ocDYt/wYo4l6YK
	 Tpk/FTHWvlS2F46/H59lDFiKwcCXZkcNDVfrGanw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbgAXOSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390893AbgAXOSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6216020838;
        Fri, 24 Jan 2020 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875516;
        bh=+I5ykO5NXtCEJfLJit9LMgzYwZuR+pnoXVd6Iosr3M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAMCnbuVP71YhDIlg6xokDhb/rsL+0IMjUuLucYeCCxRqIhu5M+PLrpiK7E2RpoLM
         i6IabTPT3hrj+1gXEmLNGV64RVS/6SFAma5x/iP4bKnfD/0WxS0knPqgnFq/NJgldL
         ZwNsOM3FSamqK4bYwjdzFUylkjIk7t+Yz9f6J/Wc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 016/107] ARM: dts: imx7ulp: fix reg of cpu node
Date:   Fri, 24 Jan 2020 09:16:46 -0500
Message-Id: <20200124141817.28793-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit b8ab62ff7199fac8ce27fa4a149929034fabe7f8 ]

According to arm cpus binding doc,
"
      On 32-bit ARM v7 or later systems this property is
        required and matches the CPU MPIDR[23:0] register
        bits.

        Bits [23:0] in the reg cell must be set to
        bits [23:0] in MPIDR.

        All other bits in the reg cell must be set to 0.
"

In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
Otherwise there will be warning:
"DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"

Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 6859a3a83750c..3dac6898cdc57 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -37,10 +37,10 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: cpu@0 {
+		cpu0: cpu@f00 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0xf00>;
 		};
 	};
 
-- 
2.20.1

