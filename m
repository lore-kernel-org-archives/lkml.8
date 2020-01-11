Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84548C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2112077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737655;
	bh=zDPSuGbcNkmbbtTnk9w1Bx3wZxsTbV4rpqmXHikbpRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1DZYG4RCLpyLyzeuF4LVoefMcx5y/VO1WHuo4ONOfhv9yE9CpY0k3ayE1Thw+RO1
	 AyZHm9SXo1Hg9GZaOmvfzWPFhrFeh+9bR1w6mH2j+3ptFZmyojQGMDP61yI+6FaJe1
	 DSECaeLSf/RU+u1J1lv/GMMkNTLm7YuFvUOMaaWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgAKKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbgAKKOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:14:09 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D23D2146E;
        Sat, 11 Jan 2020 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737649;
        bh=zDPSuGbcNkmbbtTnk9w1Bx3wZxsTbV4rpqmXHikbpRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCRDlmQ3u7YnEaYO/RCgyTFqJp0e2Y2itprpTuc0NE0lOxuQ5oxkXW76X10/m7CEj
         6QAZLEgrd0ciFmW8qZa02twT7YfZRhnfvCFC3vfsGiRJzzGIFkOPMIaBE5mIjYvtiv
         fWQ1yClgZ2oFAjXN1Sx5fw7vHIhIHkVGOYRA9nAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/84] ARM: dts: imx6ul: imx6ul-14x14-evk.dtsi: Fix SPI NOR probing
Date:   Sat, 11 Jan 2020 10:49:52 +0100
Message-Id: <20200111094850.519762766@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Roese <sr@denx.de>

[ Upstream commit 0aeb1f2b74f3402e9cdb7c0b8e2c369c9767301e ]

Without this "jedec,spi-nor" compatible property, probing of the SPI NOR
does not work on the NXP i.MX6ULL EVK. Fix this by adding this
compatible property to the DT.

Fixes: 7d77b8505aa9 ("ARM: dts: imx6ull: fix the imx6ull-14x14-evk configuration")
Signed-off-by: Stefan Roese <sr@denx.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 818021126559..695303435003 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -175,7 +175,7 @@
 	flash0: n25q256a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "micron,n25q256a";
+		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
 		reg = <0>;
 	};
-- 
2.20.1



