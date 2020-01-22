Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB221C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E9924688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686058;
	bh=ZyUSN2qZMc0ogUqJVTOVCyj/0ZWfWJuftQJyqUcfcJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hbqe3Y0+U5URbOr9Tp+marGuyX6rMC/gAYz2h9lvzRPjIUJvOi+XHaZHm6/ENQmkU
	 UdTJAkkC5oC+fciFiS1PHz3MEgajpC0DPOLj26BbLMXykUkDq4td71BGhA4jEonbKk
	 O1a27pkJADw6d2ts/cRGJDKW0oViZo2jWiDCjoTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgAVJk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbgAVJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3982467B;
        Wed, 22 Jan 2020 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686043;
        bh=ZyUSN2qZMc0ogUqJVTOVCyj/0ZWfWJuftQJyqUcfcJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci7VPS+PYoTxhsWK4REC2ts8Ix5l8xvqRnYIWOVCeOA9sWdbLN0axrmfKn3DQt7zh
         PBwk6fZ0pDW2rP92ifVl1nu50suAyB2W+0PHWJ/H7RFUyioytGO4fW4buUnjHjpm3u
         oQUHW0X2pjon3K7ht/mR2fSlcvWDV2daKqsco034=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.19 004/103] ARM: dts: imx6q-dhcom: fix rtc compatible
Date:   Wed, 22 Jan 2020 10:28:20 +0100
Message-Id: <20200122092804.306053667@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 7d7778b1396bc9e2a3875009af522beb4ea9355a upstream.

The only correct and documented compatible string for the rv3029 is
microcrystal,rv3029. Fix it up.

Fixes: 52c7a088badd ("ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and PDK2")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
@@ -205,7 +205,7 @@
 	};
 
 	rtc@56 {
-		compatible = "rv3029c2";
+		compatible = "microcrystal,rv3029";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc_hw300>;
 		reg = <0x56>;


