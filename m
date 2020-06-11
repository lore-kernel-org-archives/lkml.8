Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B355C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EE62074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IFZb6JsG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ssEg4w+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgFKHd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:28 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46625 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbgFKHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:33:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 204FB5800D2;
        Thu, 11 Jun 2020 03:32:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=87eNKXUXLK3tl
        nLtCpRNlpSIF8WfpGhrUkNfAEF99uc=; b=IFZb6JsGyK0+Os7+kTFRv7txRH3XX
        yGLogFr7P8lvUGhJ36u3+JoT/H5mJ1bigee++ilUK9A7ZTtUTChoJSO3/fkzCYd0
        tI2D/PzcjfgcZ7hGYVPTyp3DOXNNi2WH4BMC6/jv2qL6QOi4oh/B4pCdhi/ogaDy
        vwwAAhs2ELQ7MFXQPE37ICBV7z+HeQ78/UzfcVEADe/QhQH7CX+1+D0HqU1+a0N0
        eqg8fpkNgidy2Drygq955EsKfSOU+veyeupXvLHGoic2OBWqcjy7cTmf6Dn4bMHV
        Kt1X+aCZyr9YDWe5aJSc3roQpgUmZrlnF7jlaEZ+xS6yobvMsDPfiKMhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=87eNKXUXLK3tlnLtCpRNlpSIF8WfpGhrUkNfAEF99uc=; b=ssEg4w+A
        lHGNMSnnGn9RyQqMzWyiUjR1kzh29XjKn3oUXcQohPbG5Him68yJn9Yq0fCFjTMY
        FazuQSw/E58z8MFJnpJCx67f/uO9ra94cjN5Zi0TTVkNzIs/Y4lE9+BkKTDZxenF
        coIh6wJGTkQdLSFedJKEIMLDIwCjuoCWUS1fv4dCh8Nj8HDsx/lkm2zpIQXJhsF3
        ss245+qcLJxTGLYfWcW//nfBOhnEIJeEvoJMRsvt9/btgde5BsX22Gvn56FVXAbY
        l1tRLbF2QfS6DpxA97cuDcg+kShJwmQFbYZpNczSzU6NssDCRjt60V9FcIxocHFE
        KZdjHMgniZYZoQ==
X-ME-Sender: <xms:Kt7hXkXzm8do_fD0UKZCBjXODeYiaeCiqNsuq__rRzCWkWP1YG70Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvtd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:K97hXomuiHtV4EStS_8H1RaJopXsc7uzUYe8TxIVUgEtOumIU3M-bA>
    <xmx:K97hXoa-rRHeIkYgw4F4ERhRgwoADU-w1AaA60zRQuZ8S6Bbzijwuw>
    <xmx:K97hXjXvkbzsXo4IfIHqYIc9Le5VZgR2HolqQYP-blhyoD7oZcWbaA>
    <xmx:K97hXo5UAaVqa1IGdD343OGBT-aurH-giRiO9KiZOvgH-8Vz2L_l9g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B30ED3280059;
        Thu, 11 Jun 2020 03:32:58 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 24/27] ARM: dts: bcm2711: Add firmware clocks node
Date:   Thu, 11 Jun 2020 09:32:13 +0200
Message-Id: <262190e38d34c4b009f417f2f4de1c73d5e4993f.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a clock driver for the clocks exposed by the firmware,
let's add the device tree nodes for it.

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
