Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02343C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C146520578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="nphvUawd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4+Xotui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgFOImE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:04 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33485 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbgFOImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:42:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D75EF58014B;
        Mon, 15 Jun 2020 04:41:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=5Q64h3nd5fpXR
        ewbNUIi82j+4VyFATnX0AmrGckBfgA=; b=nphvUawdr9fQk8Eoidf4kh/P0MIM+
        ay72WSUni6+nAFO94+uqON8E2w+3hOqEocvaetWdk/mu0HfiIkyE/pDS20IAruHa
        6hHt7A0bBTYPdCATqEaMEtsTYN3r5IiiqTutO03l8DKFcoXK4nDIpOfeaVQ737HN
        Vo/PB9odX0D5GgLBdBdrLowo+QL6BGDYh3uT7FF/mEYGXip9CK1+FSOysnKZHwRi
        5JUTdKu3m31OZhdTdubNtolNe7p5qy9n+dxImIf/pGVVAyUEqLyJ80gvU9n8o9nv
        L7QmI8aF1fXBMg6ge0l79Uc62ynfVwIpn/sTmPzub5e3tisDXMEyiGGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=5Q64h3nd5fpXRewbNUIi82j+4VyFATnX0AmrGckBfgA=; b=e4+Xotui
        /LAdlLtyPh4/EExIiOcb7u+iyNum7h3q1TGc8B1o9JU/GczPM/cxwhdJ6Qp70iYX
        1v5XYjMcl78cYxYLg3Gf1ZSTcuV+BmoqgtGasXwKpbd9qbNzIZPbpikIeFfamKtZ
        9Sg1SuUmsgzgquXXh6IJDwfdbewrQ3aUfS1WjYrJEDUMm4MKFMs2JqITVajoE76a
        hT5C5Fl7XXRNundbu5S0ygrOo/F6G/Xy893YyQUeK/x1tehcoV7t2WmSHOGpNFtI
        QgJDx51KcuIK8skYXEJbsyoWTyom5F59LnWtd2WbnzXKMoOd+oteBaqvIpvkpZLG
        viXO5FUCLHzR4Q==
X-ME-Sender: <xms:VjTnXlugfohHkjZltC4WHkjNyFeaSSzCE8R7Zxk8wHwXVJ0kYheu1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VjTnXuck1uc4dvkhZRVQvzYuDd5uWGngH3oiRDakWpTC9r-ydaD6SQ>
    <xmx:VjTnXoyYqWnm-eX1RL70GN0_7jbOy1O3AY7BQ3d9nJkJT6WIu7FerA>
    <xmx:VjTnXsMnN6qN48iddDVUIV9Zm1V7I-ekCZrYyK8aeFtfDGHhAZJyUQ>
    <xmx:VjTnXka_wecngaQYHKq8ArXktGiM-3M1ExLG_4c3A23Bxah_A94vwA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D5D73280064;
        Mon, 15 Jun 2020 04:41:58 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 24/27] ARM: dts: bcm2711: Add firmware clocks node
Date:   Mon, 15 Jun 2020 10:41:04 +0200
Message-Id: <9a6f113140b3115150bfb18ecb248a48d58562cf.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a clock driver for the clocks exposed by the firmware,
let's add the device tree nodes for it.

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index c7f1d97e69bb..222d7825e1ab 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -69,6 +69,11 @@
 };
 
 &firmware {
+	firmware_clocks: clocks {
+		compatible = "raspberrypi,firmware-clocks";
+		#clock-cells = <1>;
+	};
+
 	expgpio: gpio {
 		compatible = "raspberrypi,firmware-gpio";
 		gpio-controller;
-- 
git-series 0.9.1
