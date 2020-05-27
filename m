Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BDBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6005020776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="GDPfI1e5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smWN56+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgE0P5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:11 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60367 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390106AbgE0Pte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D3E3D582005;
        Wed, 27 May 2020 11:49:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2I5zMakGdefyc
        AHM9J30Y7T2xEqngHoH53dlRgc3XbQ=; b=GDPfI1e5KUvbj23n5X227mloVFY/3
        t4ZnnUqAy/V3vYC+s/+6lMhmuG6BtTkgtEbtVzCK94xHj2Q4HA8PR2ZpDuq56By3
        DxgK6hq6FzzbDnvoNjb4XRc5cufhUaM+mYmQ2bBT1FiFV7zIgfKSk3S8q1WcfZGa
        /GjPj0dKNEsd1PXwsfFGN30JySBg37GWLtTjEMlJwyaOnXSm44KQKaVkXVSjdKk1
        mYQCIh0Qza9H5KMKa4z7Lb/1N6lX94AWMlOG9mR+Xh81E7Xu2uxQlqZHeWUFHLjz
        A7Zw9upBF1pbzNOxoXQALpubQutmyZnP2fb5UBvRNgTfhutbsA8XRlN7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2I5zMakGdefycAHM9J30Y7T2xEqngHoH53dlRgc3XbQ=; b=smWN56+f
        1pwLp2iGMWQSidpEwae8QUOnqW840OQijmct90Dz6zXB6VOYcQmO9RjZfXY/rJSa
        l/Ei/x2nOpNOwmEVtD0n3drmA0ayxudShPW9ezpeP+Uhdm4qPe1U/Ri0p5ygMGLz
        fKkOgxQn+peJ3Xy6PVAB/hdJ3lFPuObAWwb9pFPzQwKITqgzB0eQrZaniug2ryk8
        2CnqmlBdCdcXRqlcYfP62H+qgaVBkw13tlkHnNnBQQ/ETBGkHWDQW6lgb7kT10im
        KmmPdnkGp9HRgD8gbUGNsiEETxL5w5pSc8Um3e8daSFqAJbcLxkJEo6NHHeeYdYC
        g/h/65WiMaQrNw==
X-ME-Sender: <xms:DIzOXnXWO_lISxlUCitH0rnMi4dKb6xYO7PsRyUpc23fbq_uej2VXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DIzOXvmJ-VLAYX7qZ8v_tQ4_-ZFCAXRL07JbpEF6cARKfTiu9UKe-Q>
    <xmx:DIzOXjbNIZ1MgebVYfsSEM9A8JT1D2v51Vpk3OC615B3pUrb3zZLkA>
    <xmx:DIzOXiVQbowtYBPCONx9JBbLeqp_fX-AKEne-jAcExujoqViiPQBOg>
    <xmx:DIzOXijEe9LvUU_f5KZSujyNyDIGd8kLTiMlvpBXyrygEKgS4FDRQQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 78ABA3280060;
        Wed, 27 May 2020 11:49:32 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 010/105] dt-bindings: display: vc4: Document BCM2711 VC5
Date:   Wed, 27 May 2020 17:47:40 +0200
Message-Id: <c92be0086d086cd763160bec08c81dd8b8fd32e6.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 comes with a new VideoCore. Add a compatible for it.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh+dt@kernel.org>
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
