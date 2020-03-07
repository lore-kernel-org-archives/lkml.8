Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F50C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 19:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C572073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 19:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCGTIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:08:09 -0500
Received: from [167.172.186.51] ([167.172.186.51]:41944 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgCGTIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:08:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D9BA8E00D3;
        Sat,  7 Mar 2020 19:08:25 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XwkNf2ZU1kmz; Sat,  7 Mar 2020 19:08:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B6FACE0161;
        Sat,  7 Mar 2020 19:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YrblnvZ3IINr; Sat,  7 Mar 2020 19:08:23 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E2D02E00D1;
        Sat,  7 Mar 2020 19:08:22 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2 1/3] dt-bindings: Add vendor prefix for Chrontel, Inc.
Date:   Sat,  7 Mar 2020 20:07:58 +0100
Message-Id: <20200307190800.142658-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200307190800.142658-1-lkundrak@v3.sk>
References: <20200307190800.142658-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chrontel makes encoders for video displays and perhaps other stuff.
Their web site is http://www.chrontel.com/.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Collect Rob's ack

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
index a2da166df1bc7..0ab86d876f4d2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -185,6 +185,8 @@ patternProperties:
     description: ChipOne
   "^chipspark,.*":
     description: ChipSPARK
+  "^chrontel,.*":
+    description: Chrontel, Inc.
   "^chrp,.*":
     description: Common Hardware Reference Platform
   "^chunghwa,.*":
--=20
2.24.1

