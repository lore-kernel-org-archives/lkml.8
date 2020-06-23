Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C15F20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oRMFmqO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgFWG3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:29:36 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:38260 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbgFWG3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:29:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05N6SID1008028;
        Tue, 23 Jun 2020 15:28:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05N6SID1008028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592893698;
        bh=uTXPjrpCh4fD/aE1Dd8b26sBzP/nRgftIkj2Y3t4u6E=;
        h=From:To:Cc:Subject:Date:From;
        b=oRMFmqO+anwp5IKFFMuw2tKuP+TF8VvvV75yUpel96GyZ+BUSKrqnKVFe1TYw18Da
         W2vUUBO7GnLCYLPu+Kv5pD9EI9AhnbsYsrvbAbLCfTDf3pFH0EwwBIN7vQnxqcsjdL
         WZO9SCL00p+YjCGEb94LO+AkFumx49KjBNh+7h1nquErcuJIL+bDKL2PHrfWZona0P
         exQiZSMXD2356Wh4cIfZFZPav3Y3jSxnwSzUJXbX8sjgW3mImavJOp2hRD3uURS1cy
         7/fuBv7ANLJqTXEsOoeGsDiCoAfLjasPNhkOYWciFgrqgkFPpqw+XQjgaf525sb8dh
         UsM5W0pVbfIRw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bus: uniphier-system-bus: fix warning in example
Date:   Tue, 23 Jun 2020 15:28:11 +0900
Message-Id: <20200623062812.705264-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to
json-schema"), the schema for "ns16550a" is checked.

'make dt_binding_check' emits the following warning:

  uart@5,00200000: $nodename:0: 'uart@5,00200000' does not match '^serial(@[0-9a-f,]+)*$'

Rename the node to follow the pattern defined in
Documentation/devicetree/bindings/serial/serial.yaml

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/bus/socionext,uniphier-system-bus.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
index c4c9119e4a20..9fa4f891fa00 100644
--- a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
@@ -87,7 +87,7 @@ examples:
             phy-mode = "mii";
         };
 
-        uart@5,00200000 {
+        serial@5,00200000 {
             compatible = "ns16550a";
             reg = <5 0x00200000 0x20>;
             interrupts = <0 49 4>;
-- 
2.25.1

