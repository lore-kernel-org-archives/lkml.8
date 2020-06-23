Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EE4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C149F207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VM7M9iGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgFWSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:24:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51670 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1592936684; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITvD9mmuKfY68Q7XYzYsHbbyiuTuUxzWr+ANwSKk9sI=;
        b=VM7M9iGfJTdYAjzAFEyiROauyPDgXKDUjgQ00jl6PWF04mnygkemoVIktVTwvoHKWVi3/J
        izdx6L8JRIEVjb9XuuMYQAN+E2oh0Mo/udQZ2C9uIWi98Qnu5Mwaa3VvTY1Xply2v1Taws
        t+M6srN62+LIjEcnb4taCSBZ2vEueGI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/7] dt-bindings: MIPS: Add entry for the YLM RetroMini
Date:   Tue, 23 Jun 2020 20:24:27 +0200
Message-Id: <20200623182432.187843-2-paul@crapouillou.net>
In-Reply-To: <20200623182432.187843-1-paul@crapouillou.net>
References: <20200623182432.187843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry to ingenic/devices.yaml for the JZ4725B-based
YLM "RetroMini" RS-90.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/mips/ingenic/devices.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/ingenic/devices.yaml b/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
index d1175030781a..07d8550a9b49 100644
--- a/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
+++ b/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
@@ -22,6 +22,11 @@ properties:
           - const: qi,lb60
           - const: ingenic,jz4740
 
+      - description: YLM RetroMini RS-90
+        items:
+          - const: ylm,rs90
+          - const: ingenic,jz4725b
+
       - description: Game Consoles Worldwide GCW Zero
         items:
           - const: gcw,zero
-- 
2.27.0

