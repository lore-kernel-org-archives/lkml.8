Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7CFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6B20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691406;
	bh=jUQYFr/zNcIZpn8MHrRMQ4VbgAFjyryo9kcyksEqlsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXVaanHrBpnNht9IXQ5G7YLOOLGY5aC4bBdzkC145Hjb+45ovMNURj2VGXhNlR5kT
	 haXuEDt3ESo9SkkLVKI3jCdRchJSvGkQPJLQkaUbdvPkv28TAKgwEhPpgYfY//Havk
	 kCFhojciRtwzxBuP6LIu2ew3xqAP0szNicAUCFWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392087AbgHQTKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbgHQPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:41:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A8520760;
        Mon, 17 Aug 2020 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678913;
        bh=jUQYFr/zNcIZpn8MHrRMQ4VbgAFjyryo9kcyksEqlsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx3HAkA9QWBMrkcr+3VgxK/1SzrEZcG+Pz+b4Eh7f+lnLsVD3V4NjInE6AiLS3k/j
         AvdRQ1c5TzoblaDdQq4DBKU0fWrqdTQG6crW6LeAI2f4W14TJ3rW0asAlz8VYmXony
         /8Qcri0pgicpQ3dq3nS8TDH7dAVWx0Gi4T4Tqp50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 033/393] ARM: dts: gose: Fix ports node name for adv7180
Date:   Mon, 17 Aug 2020 17:11:23 +0200
Message-Id: <20200817143821.215410804@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit d344234abde938ae1062edb6c05852b0bafb4a03 ]

When adding the adv7180 device node the ports node was misspelled as
port, fix this.

Fixes: 8cae359049a88b75 ("ARM: dts: gose: add composite video input")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20200704155856.3037010-2-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 79baf06019f5a..a378b54867bb4 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -336,7 +336,7 @@ composite-in@20 {
 			reg = <0x20>;
 			remote = <&vin1>;
 
-			port {
+			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-- 
2.25.1



