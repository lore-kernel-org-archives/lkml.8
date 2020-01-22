Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE19C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01B92467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686124;
	bh=Dbo3v6EsEkfvHSpCRZHRDxdBfN5Pfp/DqXmhD8DDa1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=assimvpwFxWDJf5FqYM1d06OeQTgEo47rOMjTnxWsDrx8+it6D5xuVEDuUuOE/m9c
	 ZDM7LG9xybU3tSfLW5+wlzSB021xJw5WOMjtVe8/8C4ppLuvCD6COO9lHDPL0myBsd
	 UehNxlN64Z8ivEVm5pdXXIGq/OuvkN6DFrrv+hxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgAVJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbgAVJly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2362467B;
        Wed, 22 Jan 2020 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686114;
        bh=Dbo3v6EsEkfvHSpCRZHRDxdBfN5Pfp/DqXmhD8DDa1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZNjcDQc5CJMKJFfindnnkg+vYkyZDoiAt2vzcVHLhMM2RLufLUZITBoxtsdsfNfL
         GG9Ts0fJgTxSnWbxA4ZwjTLHrb13U9sD0VsCBoFrLSrArDkkuws8/IREksy+oaISg+
         6wyiSJYPQWogoRbGEQuvRE3ZV5/LvnMMLp4Fp2eI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ludwig Zenz <lzenz@dh-electronics.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.19 022/103] ARM: dts: imx6q-dhcom: Fix SGTL5000 VDDIO regulator connection
Date:   Wed, 22 Jan 2020 10:28:38 +0100
Message-Id: <20200122092807.087052160@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

commit fe6a6689d1815b63528796886853890d8ee7f021 upstream.

The SGTL5000 VDDIO is connected to the PMIC SW2 output, not to
a fixed 3V3 rail. Describe this correctly in the DT.

Fixes: 52c7a088badd ("ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and PDK2")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Ludwig Zenz <lzenz@dh-electronics.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
To: linux-arm-kernel@lists.infradead.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
+++ b/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
@@ -55,7 +55,7 @@
 		#sound-dai-cells = <0>;
 		clocks = <&clk_ext_audio_codec>;
 		VDDA-supply = <&reg_3p3v>;
-		VDDIO-supply = <&reg_3p3v>;
+		VDDIO-supply = <&sw2_reg>;
 	};
 };
 


