Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E55EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4452087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592397;
	bh=FylbTEiD/DWhvOUoe0WCFuShSIlax8Y8+fievbYrx4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKtbCQckhISocRSETezPwyP1YMiy22TVaVtUUYOdEM31GUdtlrUATh732COhpiQkZ
	 +cDk8vZFfw2gf69hdCvx+67jOPG3YJFBEYi5vpRoEfCpCVfnp1En5RNoHVhuRoD42z
	 oai2VlGhryEcUQbohEBFVKnbGXfDDrW7AilY1X14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbgIHTNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731216AbgIHQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783ED223FB;
        Tue,  8 Sep 2020 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579952;
        bh=FylbTEiD/DWhvOUoe0WCFuShSIlax8Y8+fievbYrx4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sY4H5PXP63ku9hSmDKToYKpgEDyVn1zby9PuV67dxmMniat1Aqb1BQ+ykYs5s06tF
         UGtxVVhCrbV3zzaPQ37B98T4f4OMKzdhBB8XRcPGnmMoxnRNIO2qh+R1Qn9xuD2+Ys
         jY3BuDKAkQhJ7X3NMKVGM30vR89MO+GJog3rKAwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenbin Mei <wenbin.mei@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 099/129] arm64: dts: mt7622: add reset node for mmc device
Date:   Tue,  8 Sep 2020 17:25:40 +0200
Message-Id: <20200908152234.752514916@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenbin Mei <wenbin.mei@mediatek.com>

commit d6f6cbeee4e5ee6976792851e0461c19f1ede864 upstream.

This commit adds reset node for mmc device.

Cc: <stable@vger.kernel.org> # v5.4+
Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Link: https://lore.kernel.org/r/20200814014346.6496-3-wenbin.mei@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -686,6 +686,8 @@
 		clocks = <&pericfg CLK_PERI_MSDC30_0_PD>,
 			 <&topckgen CLK_TOP_MSDC50_0_SEL>;
 		clock-names = "source", "hclk";
+		resets = <&pericfg MT7622_PERI_MSDC0_SW_RST>;
+		reset-names = "hrst";
 		status = "disabled";
 	};
 


