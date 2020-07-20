Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0841C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AEC208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgGTVVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:21:20 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:45952 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTVVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:21:20 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 3C2FDBC17B;
        Mon, 20 Jul 2020 21:21:16 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] dt-bindings: aspeed-lpc: Replace HTTP links with HTTPS ones
Date:   Mon, 20 Jul 2020 23:21:10 +0200
Message-Id: <20200720212110.64214-1-grandmaster@al2klimov.de>
In-Reply-To: <CACPK8Xc_iwvRtUVjY8G8rS8UbZf6-Q6FTGaNweJXk06A=Y459Q@mail.gmail.com>
References: <CACPK8Xc_iwvRtUVjY8G8rS8UbZf6-Q6FTGaNweJXk06A=Y459Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: Left only links to be only HTTPSified.

 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 86446074e206..a92acf1dd491 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -37,7 +37,7 @@ syscon as a means to arbitrate access.
 
 [0] http://www.intel.com/design/chipsets/industry/25128901.pdf
 [1] https://www.renesas.com/en-sg/doc/products/mpumcu/001/rej09b0078_h8s2168.pdf?key=7c88837454702128622bee53acbda8f4
-[2] http://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf
+[2] https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf
 [3] https://en.wikipedia.org/wiki/Super_I/O
 
 Required properties
-- 
2.27.0

