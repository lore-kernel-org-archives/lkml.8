Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29326C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5C2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBSHek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:40 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35166 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbgBSHeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E367FE0046;
        Wed, 19 Feb 2020 07:34:21 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tRQ7l11uIYi5; Wed, 19 Feb 2020 07:34:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 336AFE0074;
        Wed, 19 Feb 2020 07:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ciOnyxmKWg_h; Wed, 19 Feb 2020 07:34:15 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E433CE0046;
        Wed, 19 Feb 2020 07:34:14 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 06/10] dt-bindings: clock: Add MMP3 compatible string
Date:   Wed, 19 Feb 2020 08:33:49 +0100
Message-Id: <20200219073353.184336-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219073353.184336-1-lkundrak@v3.sk>
References: <20200219073353.184336-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding describes the PMUs that are found on MMP3 as well. Add the
compatible strings and adjust the description.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/clock/marvell,mmp2-clock.yaml  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.y=
aml b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
index c5fc2ad0236dd..e2b6ac96bbcb0 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/clock/marvell,mmp2-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Marvell MMP2 Clock Controller
+title: Marvell MMP2 and MMP3 Clock Controller
=20
 maintainers:
   - Lubomir Rintel <lkundrak@v3.sk>
=20
 description: |
-  The MMP2 clock subsystem generates and supplies clock to various
-  controllers within the MMP2 SoC.
+  The clock subsystem on MMP2 or MMP3 generates and supplies clock to va=
rious
+  controllers within the SoC.
=20
   Each clock is assigned an identifier and client nodes use this identif=
ier
   to specify the clock which they consume.
@@ -20,7 +20,9 @@ description: |
=20
 properties:
   compatible:
-    const: marvell,mmp2-clock # controller compatible with MMP2 SoC
+    enum:
+      - marvell,mmp2-clock # controller compatible with MMP2 SoC
+      - marvell,mmp3-clock # controller compatible with MMP3 SoC
=20
   reg:
     items:
--=20
2.24.1

