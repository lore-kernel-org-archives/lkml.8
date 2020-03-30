Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82047C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582B620774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dR/P67Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgC3JW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:22:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:64554 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgC3JW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:22:59 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 02U9MRYO004012;
        Mon, 30 Mar 2020 18:22:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 02U9MRYO004012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585560147;
        bh=jub3TGqtGTkZnD38uTgdfqYya/SwA1lK8vt+6CKyAds=;
        h=From:To:Cc:Subject:Date:From;
        b=dR/P67Xq4lgIqq9JQjyY8WPrAMVXn0rwdrH9bH+/l6CHnhY/bS9VG1dwiApdpqrDF
         ILRWFya0YyQsh9xf7mOowuFBMobI0Fz+O1Ixb7CYsh5yCjZxf+gANrjSdHBLX9tAIK
         Mv5lli9eyUI9otBTv0hyKnK9ntewQSvjhHDB77PhVD/e1cvrnrOMt3FZnEQ3PrJbxx
         caEEeYrXDWC+XsHAEfYxowuuhbWCyEEnM4iwS6WTGuw6cxPtuM1FBygPpkcN2uhwG9
         DPdEn02ZeDbzhM0m9wltfzKXyLk94tS2ja1vGq2zWpxNwp3C7Msmam9a6bL6AR5wZB
         59SMie8IQBEYQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: uniphier-system-bus: fix warning in the example
Date:   Mon, 30 Mar 2020 18:22:18 +0900
Message-Id: <20200330092218.28967-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning from 'make dt_binding_check'.

Warning (unit_address_vs_reg): /example-0/system-bus: node has a reg or ranges property, but no unit name

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/bus/socionext,uniphier-system-bus.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
index ff9600d6de3b..c4c9119e4a20 100644
--- a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
@@ -72,7 +72,7 @@ examples:
     // - the UART device is connected at the offset 0x00200000 of CS5 and
     //   mapped to 0x46200000 of the parent bus.
 
-    system-bus {
+    system-bus@58c00000 {
         compatible = "socionext,uniphier-system-bus";
         reg = <0x58c00000 0x400>;
         #address-cells = <2>;
-- 
2.17.1

