Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4535C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCE120897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RmogQZqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kg4HJyMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgICIHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:07:39 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44757 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbgICIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 83CD0C29;
        Thu,  3 Sep 2020 04:03:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+3b/zq/nS3RmW
        eMoQfDhOObDiP0bYzhAeWlwMkvfu4Q=; b=RmogQZqCV+jBIpU9QM+sD8s78ZPJj
        JD4CUEx7IhnVFPX9or0Fjq9GS/Y86o/8JTkXfPBJ4AKEsFyH2p7C6nrkBtF6e2SH
        AoBFKQH4PFdTyjJpIoSKQf7BIC2JUWHf4KerShXDFQQoZEFw498GzUn1rYXxS/Zt
        0LVNNOb6YvSveIJs6ktexzcBW0IOT0TzaQWeMuW1x4SQ7bRAvsSUyYqFrD4pF3+k
        jikgyuDg3V0yr7RxJc9rXdj3/so98CB2MleEEmfP4X72D6y8/Fo5RKPT93Ob/Cer
        RkJeAcHzdxlpxECne8yc7D94lFW3YWQeXMzawO2FeZafOL/GmMlHSTxTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+3b/zq/nS3RmWeMoQfDhOObDiP0bYzhAeWlwMkvfu4Q=; b=Kg4HJyMz
        jkSLY4M9XB6twxzgsFwVSx1foRKcxzwXvmxboaPbF/7gn7wOIgmQ/Df6B0lM4NDI
        uGwYjglUohDAksAMxc1E1De/2AefwIeLHnB13fIZtMKAJIsJWgXdo2WeaYrcH2w9
        sEmnB+PbZHsjnyeq0kPu2FOQli5ykqBmFa+x8NWRudyYaMa2HoNT6kfESU8EgD5T
        w7xYfr7TQ2vysbwTzmBLU+G+Q5jrAZNEpIDOzhWQtKgei4qwNgfDO2MKGEfsthZn
        xO71/k+7M0swYyES4SdP2950K3VXgrCjYO3zgLyJqBqBiUZKJW99rWOWSXvCSlRB
        Zp5is37L8kOyKw==
X-ME-Sender: <xms:YKNQX4oZ6QQcFNyH6NaytuUCt35M5vHKNgquev4OwAQk_YQsyEvmiw>
    <xme:YKNQX-r3XwOpJ9F2yv7FNgEcxrKkq0zQYzaiYRXhbhKRRnMGQxQVDQ_qpXlK85kBN
    DPFli-llyN42_Xk9bc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejtd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:YKNQX9MisRfjvofGxU1wqE6_E8rSQu14hniM4RNAhH2Zi3g5oV05Lg>
    <xmx:YKNQX_7RHJVKZ9qpnPuXRIawwKwwnszI_bFWiVk0N0t-H1lbxphKhQ>
    <xmx:YKNQX35hW3jc4RmZmtJ5BsgIocZ1uCSJs4nEVGG9I3LbboPbcOpIVA>
    <xmx:YKNQX_w4fWfd64vEqsgGvJJyL3Q-n6TOE6GoK06ksZCu1Z9gYWkh7Xt96dI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3F22328005A;
        Thu,  3 Sep 2020 04:03:43 -0400 (EDT)
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
Subject: [PATCH v5 78/80] dt-bindings: display: vc4: Document BCM2711 VC5
Date:   Thu,  3 Sep 2020 10:01:50 +0200
Message-Id: <1075091c50b378505a9a89f760af11f0e1e26e5b.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 comes with a new VideoCore. Add a compatible for it.

Reviewed-by: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
index 0dcf0c397375..49a5e041aa49 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
@@ -17,6 +17,7 @@ description: >
 properties:
   compatible:
     enum:
+      - brcm,bcm2711-vc5
       - brcm,bcm2835-vc4
       - brcm,cygnus-vc4
 
-- 
git-series 0.9.1
