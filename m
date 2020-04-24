Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94FC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D82920700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BD1B4CN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pis+VpXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgDXPkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:20 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:53017 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728437AbgDXPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6AA8F10AA;
        Fri, 24 Apr 2020 11:36:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2I5zMakGdefyc
        AHM9J30Y7T2xEqngHoH53dlRgc3XbQ=; b=BD1B4CN8zWU+fPz7IlbsH+rnyrL/K
        GmWvt/35ykWfkbGxhUf3nvgpM/HFzhC6z5mbrPEessL1hEz9R1N36E3rQfYI+jOX
        4NeMvWRfrYLX3CWXu8lALSxcJFtXgnijMRi1t93HqXYAt+/6Su/sJERGgtJYUKLy
        ss86uXwDxtAHwKXgtomXo8lToxz1CUKTyZkf+cKUBkRBtaz/7Gqe0XZlXOGN5Mxu
        LhfAac9FMdLJwAjB6XLz5MpFWNUFjdOqIZAqHwXM99H5iHt1MW5PTN96gc6aRwwc
        PdvRZrDN2H+GwHWfBheSDg2WnL2WJtgs0irTb+HE1jMwJlSAiKzOJ8Exw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2I5zMakGdefycAHM9J30Y7T2xEqngHoH53dlRgc3XbQ=; b=Pis+VpXI
        t0wmLmPGRLm+wsq/DgSmOoRh+9csdgurzenCAT4Ra6SxAyJYtkWgBcp6Mx9j0tRE
        on987iRDzEBBXlS/JnMLPgvTGYLdpSJOBU8mdAjUjy4nS1+nMBJiyxLfNeKgmCot
        UeeN0/zqrttVLPbV92LYnWIWbG0vFw5Wz0kIRejyZs5MnqKWJ+JL9VaUbbNt50/H
        mZnyWAimGdR+ar+ed45xnMdcohtr02DWUnD6oixn+LJwadBsYthTXGp9kNRmKwzT
        kYfVDSDgUHxYjR709uuYs2B4hUdW/JIt4fqM43JK1O7JHh93MAXZt1pFdzmjnRei
        fVCEHGAaADQTiw==
X-ME-Sender: <xms:ZQejXkufTVDwLok66FHM6BLrBJuB_BSbVYKOOazzTbfziom17RDw6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ZQejXo31Oh_FJDumAK97HP0x9cGyjm3g5i4OalhfqmvRBbCD4PkpUw>
    <xmx:ZQejXqFiow9NgvsiJn5lD0t8g-U3c-sZGhwV2nQv7IbJAA9lhLELnA>
    <xmx:ZQejXtPhBRvfTvRQfys8YUwSYQ3cfoYMHaeD8ma69SixaggyksKPvA>
    <xmx:ZgejXppFBIk2U4L8O8z2BDU1N5BMLE3_ww19HQbuONEucwCJCxwu5ZU3b7Y>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6A0E3065D9A;
        Fri, 24 Apr 2020 11:36:05 -0400 (EDT)
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
Subject: [PATCH v2 31/91] dt-bindings: display: vc4: Document BCM2711 VC5
Date:   Fri, 24 Apr 2020 17:34:12 +0200
Message-Id: <1fc211841ff633f59d64c3b074724a23f3606d72.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
