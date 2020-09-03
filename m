Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FD9206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BZ06Qo+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAlrKZWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgICIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:36 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:48021 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgICICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 12BDECA6;
        Thu,  3 Sep 2020 04:02:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=aBB5SQ24pyqVM
        W/fyj8ngOXqAKkOS41AE2GxM0LTpXw=; b=BZ06Qo+MMIB1pOXwh1RZCprG/LQ6Q
        MPXOVRPemMsfXqUyoEYGNQ/lh56MnAbFkmaLA3EfMsvLBC6SwFXoEfqfBRDOhxnu
        T4+ZimwNWnAnmCkHS/MS+PD1h1nk26j22w50p5Ytwu36OruGiMrtz3N5qMCpAQD8
        JT+6kThNqO2nNDqYZ9OvPwQcVXBAPezYOq4VzkuA+SolKNZ8OQ4rQsrAu+tEcPOa
        DqnXVzwPByY7um/3HPW8iq5nzFYBDZsS4x2CNx5lr5wTtKhJrkZKzQcBBLT04lTt
        BPaJVZdzq1gUSiU7D0nLnnBhRhtrD4pZ7UYrNg3D4okeMw4XGSFWglJUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=aBB5SQ24pyqVMW/fyj8ngOXqAKkOS41AE2GxM0LTpXw=; b=SAlrKZWn
        xgLGQCS8BHm2r3LDY6Kr24xEXw51A/1hUNbnd2L4z+Sbcc+id502RZf2KOHvIZpm
        UuTRZAHDAtgCj9XXFZdsmlzC4sYkIP1rHCTOPgjGnI5uQVtGk9Bw3wyIBbEyuBui
        6lUl2PUy13w3Re3Yd6vLCI7L25ffB+UBljQJRJHid78IfW1G5HjFVc/6Vyb+LwO7
        ZTQCXzXzAJd/Qx2MdTHtv/u5fpm4U5WR2JrGGusO6+PS5x8IaTjp2DCdbWAXrGHU
        FkBMH2yjRJuH1b28h3m8fwMxBaatqRA8n4HpaRQd87UCnrf5qjido6b3ObzUijKi
        j1BCrevFncebtg==
X-ME-Sender: <xms:JKNQX-6mZ1vJvCZCrvrlzU7USpMJPQ9Q2iohgAcdB8K0Ly0_Yu0w5Q>
    <xme:JKNQX34DepqkTmLtz2JblZK-sNqXqE_HM8Pd_DEJhnK2tgLRS9k-OzBDYTSA4GafT
    TvTr8oI4j4AwpGQ42o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefvd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JKNQX9cIn9hthLsOJqhjOlMDV1mOsJGcuRISkt6Y4F2mvBH1hZCFRg>
    <xmx:JKNQX7JZv_ogNx8sSLnJdg6RQeoBDCCcIWxs3Cx39-IX5hhyyOf29w>
    <xmx:JKNQXyLhavY6smsuiYmVnfuZf-6p5MR4glvqO0Af3PzQIDnV9B_Fuw>
    <xmx:JKNQX0AUmlClnAazqGVHE1q4QkoCP7wHncFAFV3XzY_6ZqNOMmPfKXRR00Y>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D785F3280060;
        Thu,  3 Sep 2020 04:02:43 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 36/80] dt-bindings: display: vc4: pv: Add BCM2711 pixel valves
Date:   Thu,  3 Sep 2020 10:01:08 +0200
Message-Id: <3a21824460d96245984d730e446863a4853f2ae5.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 comes with other pixelvalves that have different requirements
and capabilities. Let's document their compatible.

Reviewed-by: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
index e60791db1fa1..4e1ba03f6477 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
@@ -15,6 +15,11 @@ properties:
       - brcm,bcm2835-pixelvalve0
       - brcm,bcm2835-pixelvalve1
       - brcm,bcm2835-pixelvalve2
+      - brcm,bcm2711-pixelvalve0
+      - brcm,bcm2711-pixelvalve1
+      - brcm,bcm2711-pixelvalve2
+      - brcm,bcm2711-pixelvalve3
+      - brcm,bcm2711-pixelvalve4
 
   reg:
     maxItems: 1
-- 
git-series 0.9.1
