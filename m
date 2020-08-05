Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1841D2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DC8aYJFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHEQq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgHEQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EADFC061A31;
        Wed,  5 Aug 2020 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J08654X7H3kbc58/m2gL+bfcL2jyb0HzXVeKBQozN18=; b=DC8aYJFt9cO5OYGZXYZ4pk5oxV
        +8JcsbVbK3VPyo8Rqa1zrayMTV25RJIgCiEFVYdntVbNcbl/W/L8yxfEDBIZxqO7ExarM07ZZLIXF
        /DfydtCqSvavDLR0MTVFO/RKveDDydmsL67zqd02pXJf1i6lK0XPCNARjPP5QG1lVKPo/nOZgIiXH
        kKto+7OnkDAbfE6fGtfntJiJslatSVyIfBpqIqW0R6ofjAhlbBppIAqr/Xu5JC9b/3WP3jyY21ACY
        DFd0XOgngt31L6mWcqKubsxBwHcyGopOuxQzNlWx02B8ygbE/ejNAP/7nr3ygleS1IJbek2tw+PiA
        OYbmVQSg==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Hcc-0007nH-4c; Wed, 05 Aug 2020 11:30:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1k3Hcb-00BavU-NB; Wed, 05 Aug 2020 12:30:13 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm: dts: remove stray /dts-v1/ from mt7623a.dtsi
Date:   Wed,  5 Aug 2020 12:30:11 +0100
Message-Id: <20200805113013.2763510-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <8ef96e4d02ef82e171409945ee6cc0348c4fe594.camel@infradead.org>
References: <8ef96e4d02ef82e171409945ee6cc0348c4fe594.camel@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

This isn't needed in dtsi files.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/boot/dts/mt7623a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index 0735a1fb8ad9..a96075206cce 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -5,7 +5,6 @@
  *
  */
 
-/dts-v1/;
 #include <dt-bindings/power/mt7623a-power.h>
 #include "mt7623.dtsi"
 
-- 
2.26.2

