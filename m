Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1269C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BFC206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHSKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:13:25 -0400
Received: from mail.v3.sk ([167.172.186.51]:51742 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727813AbgHSKMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 75DD5DFA44;
        Wed, 19 Aug 2020 10:11:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HHJNB9nMykzM; Wed, 19 Aug 2020 10:11:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 32538DEE69;
        Wed, 19 Aug 2020 10:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vACbqImGK-dy; Wed, 19 Aug 2020 10:11:23 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id EA9A8DFA71;
        Wed, 19 Aug 2020 10:11:22 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] dt-bindings: display: simple: add Innolux LS075AT011
Date:   Wed, 19 Aug 2020 12:12:05 +0200
Message-Id: <20200819101206.633253-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819101206.633253-1-lkundrak@v3.sk>
References: <20200819101206.633253-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Innolux LS075AT011 7.5" (1200x900) color/reflective LCD panel to
the panel-simple compatible list. This panel is used in the OLPC laptops.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 6deeeed59e59f..cad63a639e258 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -153,6 +153,8 @@ properties:
       - innolux,g121i1-l01
         # Innolux Corporation 12.1" G121X1-L03 XGA (1024x768) TFT LCD pa=
nel
       - innolux,g121x1-l03
+        # Innolux LS075AT011 7.5" (1200x900) color/reflective LCD panel
+      - innolux,ls075at011
         # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
       - innolux,n116bge
         # InnoLux 15.6" WXGA TFT LCD panel
--=20
2.26.2

