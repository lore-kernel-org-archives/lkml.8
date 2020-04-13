Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35611C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E90620732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="azjtEAgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgDMP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:27:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40258 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgDMP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586791632; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZN4uSv67NQClrE+9U7eVygZv+RQaDv0OlQU6IUvmAW8=;
        b=azjtEAgbWbVW38f/Ggow3q0R8zRqC+FKvLyePUeCVS1fvzQc3GmBYBYqC4n3YL7RPs8kxo
        +mdl9p32rZu48e/KjJITwTubqsgGutBkQGSuh7p56whGHvCLZ1dRnQ74OLEIImxgyper/U
        /fBPexyKxCkipnG+3SYg1niu9eObIF8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 04/13] dt-bindings: usb: ingenic,musb: Add usb-role-switch property
Date:   Mon, 13 Apr 2020 17:26:24 +0200
Message-Id: <20200413152633.198301-4-paul@crapouillou.net>
In-Reply-To: <20200413152633.198301-1-paul@crapouillou.net>
References: <20200413152633.198301-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the common usb-role-switch boolean property to the list of the
supported properties.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/usb/ingenic,musb.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ingenic,musb.yaml b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
index 1d6877875077..292905a8c20b 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
+++ b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
@@ -42,6 +42,9 @@ properties:
   phys:
     description: PHY specifier for the USB PHY
 
+  usb-role-switch:
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.25.1

