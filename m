Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF3DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDFB20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="txSs6WoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgFWLeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:34:21 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:26468 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbgFWLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:33:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 05NBWiUg029531;
        Tue, 23 Jun 2020 20:32:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 05NBWiUg029531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592911965;
        bh=UBNMDPzFnN1cnIVkGWvbjH9Uo3Pe4tVb9X7LiojohOs=;
        h=From:To:Cc:Subject:Date:From;
        b=txSs6WoDHTo3B6ahAwu2aWrCBUKUSI5HzVJ3K7QcCNLC7UraMms6L/+/XkE3RR+OT
         exD/ZJcHkJ2H2QbT8vT6glOP0yDkdOnikRN0rsjr0lX52xOs9A4+eTwdl+MAf7RGJl
         SvKtMiLSZznzz41mss95xot9NEjHdBptoYc2azxajQh/ZQR3TBe4rDcc8rEtAGCrxk
         BLXkDqWeK+gFi3BFFsrHh+IfZr+P3zMiihFOB2JMtc92XEMxNjJhG3AxuEIy7e8BAN
         5bQUQ1mVhqAvM1/IiOLjiLVgt9LIn5VA/cSIYvnr3MjyUgYJF+5TsZFEfqmR5uKhVE
         aDPhIhOyJ0vvw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: bus: uniphier-system-bus: fix warning in example
Date:   Tue, 23 Jun 2020 20:32:42 +0900
Message-Id: <20200623113242.779241-1-yamada.masahiro@socionext.com>
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

While I was here, I removed leading zeros from unit names.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - change unit names too

 .../bindings/bus/socionext,uniphier-system-bus.yaml           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
index c4c9119e4a20..a0c6c5d2b70f 100644
--- a/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
@@ -80,14 +80,14 @@ examples:
         ranges = <1 0x00000000 0x42000000 0x02000000>,
                  <5 0x00000000 0x46000000 0x01000000>;
 
-        ethernet@1,01f00000 {
+        ethernet@1,1f00000 {
             compatible = "smsc,lan9115";
             reg = <1 0x01f00000 0x1000>;
             interrupts = <0 48 4>;
             phy-mode = "mii";
         };
 
-        uart@5,00200000 {
+        serial@5,200000 {
             compatible = "ns16550a";
             reg = <5 0x00200000 0x20>;
             interrupts = <0 49 4>;
-- 
2.25.1

