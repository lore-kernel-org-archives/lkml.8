Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C0C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C2B2076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="s4aAUBBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCRWZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:25:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51950 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCRWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1584570310; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=k3RbqEFxwxGdQWeiOvBR9+ZN9/CbYEp0FJh36L4I2is=;
        b=s4aAUBBwQwz9ZYATIiyRXRI66x1jxUmqV7pO0eojw5Fs5VGwlcvEX4hXSB43yAge/MMKCv
        VbUSLw6eFN4kRTono2hBdG2iWuvbhXCSvcTgYt8ozwlGqilR/pgVo6ykYQrTEKq/UX243i
        d3JBtejXxrbxYO2iOv5LISnDRTXFPF4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        Jonas Heinrich <onny@project-insanity.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] dt-bindings: arm/samsung: Add compatible string for the Galaxy S2
Date:   Wed, 18 Mar 2020 23:25:03 +0100
Message-Id: <20200318222504.135807-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the Samsung Galaxy S2 (i9100 version), which
is an Exynos 4210 based device.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Notes:
    v2: Move compatible string so that the list is sorted in alphabetical order

 .../devicetree/bindings/arm/samsung/samsung-boards.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 63acd57c4799..eb92f9eefaba 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -52,6 +52,7 @@ properties:
         items:
           - enum:
               - insignal,origen                 # Insignal Origen
+              - samsung,i9100                   # Samsung Galaxy S2 (GT-I9100)
               - samsung,smdkv310                # Samsung SMDKV310 eval
               - samsung,trats                   # Samsung Tizen Reference
               - samsung,universal_c210          # Samsung C210
-- 
2.25.1

