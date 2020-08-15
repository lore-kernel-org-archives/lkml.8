Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D078323B45
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="fI2vCFF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHOVps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgHOVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:45:43 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F1C00459D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oQyOEPHw/uNu9ZLTFXekoz2n57dypFJZ56uvrqcRB/E=; b=fI2vCFF9Nl76oYBwA+j4JZYaZn
        IMfEyaUu2DPjvoDQCqhLpzAKfn6j6Unbv03s33L5zzZCGG6EjmkXNq986BV/USXBfzjAzFlojBUL9
        URJ/AeGPGD2jQ5epjk/tFsayqjaWLQ1f85YmqSEcjkaF01mt+jFI/dGu27DUrsA910l0=;
Received: from p5dcc3368.dip0.t-ipconnect.de ([93.204.51.104] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k71wp-0000Fu-SA; Sat, 15 Aug 2020 21:34:36 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1k71wp-0005dF-GO; Sat, 15 Aug 2020 21:34:35 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        andreas@kemnade.info, Anson.Huang@nxp.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        michael@walle.cc, rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add compatible string for Tolino Shine 2 HD
Date:   Sat, 15 Aug 2020 21:33:35 +0200
Message-Id: <20200815193336.21598-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200815193336.21598-1-andreas@kemnade.info>
References: <20200815193336.21598-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string for the Tolino Shine 2 HD eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e291e38..a3fb61868a16 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -211,6 +211,7 @@ properties:
         items:
           - enum:
               - fsl,imx6sl-evk            # i.MX6 SoloLite EVK Board
+              - kobo,tolino-shine2hd
               - kobo,tolino-shine3
           - const: fsl,imx6sl
 
-- 
2.20.1

