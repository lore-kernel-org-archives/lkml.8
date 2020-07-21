Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41152C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7682065E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgGUQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:47:06 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45826 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbgGUQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:47:04 -0400
Received: from [78.134.114.177] (port=54080 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jxvPx-0009Zq-I8; Tue, 21 Jul 2020 18:47:01 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: clk: versaclock5: fix 'idt' prefix typos
Date:   Tue, 21 Jul 2020 18:46:52 +0200
Message-Id: <20200721164655.422-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'idt' is misspelled 'itd' in a few places, fix it.

Fixes: 34662f6e3084 ("dt: Add additional option bindings for IDT VersaClock")
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v3: add Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/idt,versaclock5.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
index 6165b6ddb1a9..9656d4cf221c 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
@@ -35,7 +35,7 @@ For all output ports, a corresponding, optional child node named OUT1,
 OUT2, etc. can represent a each output, and the node can be used to
 specify the following:
 
-- itd,mode: can be one of the following:
+- idt,mode: can be one of the following:
                  - VC5_LVPECL
                  - VC5_CMOS
                  - VC5_HCSL33
@@ -106,7 +106,7 @@ i2c-master-node {
 		clock-names = "xin";
 
 		OUT1 {
-			itd,mode = <VC5_CMOS>;
+			idt,mode = <VC5_CMOS>;
 			idt,voltage-microvolts = <1800000>;
 			idt,slew-percent = <80>;
 		};
-- 
2.27.0

