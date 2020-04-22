Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD47C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4053F2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DyxCrGC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgDVOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:19:29 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:64450 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDVOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:19:28 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 03MEIq6s003059;
        Wed, 22 Apr 2020 23:18:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 03MEIq6s003059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587565133;
        bh=05L0Y4K5hdMLe5DqDt78XEkJuAdMbS03xklsS80D7Zk=;
        h=From:To:Cc:Subject:Date:From;
        b=DyxCrGC9vbJk3WAzDPNWRUm5TW/6TBn/XNszLdLUySG+DlkgrEeyd2p25GpG475X5
         Ns8AYwSr9Xo5JC94ZC/m/GNu5zne4CZl2onlRtCFyr2RiFN6hr3/hOvDgOztOxDhtt
         03UobRstNyV6gNpiLIPx9wr7lV+aZh7JPApv/Xc9AQ/tfKV/7v7a1s50P/Gdrb9r6M
         UrrfceNsdtesIk6C+5GBx2v6z7fJNM7gqa+k/04+yur6u7y9loB0DiGVw/48Zx6n5H
         WNAxrcJiCrDKXSRC4cJflY3CsJ6DGDRvl4rJHHmUoSUnC05jryRdbh+v2CCHG+i1XW
         q3voLqhQl5BHw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: at24: add microchip,24lc[0-9]+ to the compatible pattern
Date:   Wed, 22 Apr 2020 23:18:36 +0900
Message-Id: <20200422141836.1964676-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm/boot/dts/uniphier-ref-daughter.dtsi has

  compatible = "microchip,24lc128", "atmel,24c128";

and 'make ARCH=arm dtbs_check' warns this:

  eeprom@50: compatible: ['microchip,24lc128', 'atmel,24c128'] is not valid under any of the given schemas (Possible causes of the failure)

Microchip 24LC128 is the device used on this board, and I see it in
https://www.microchip.com/wwwproducts/en/24LC128

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/eeprom/at24.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index a15787e504f0..2cd7a04cab7c 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -34,7 +34,7 @@ properties:
           - minItems: 1
             maxItems: 2
             items:
-              - pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|mac)[0-9]+|spd)$"
+              - pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|lc|mac)[0-9]+|spd)$"
               - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
           - oneOf:
               - items:
-- 
2.25.1

