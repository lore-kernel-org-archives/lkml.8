Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ACF20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lS195I7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgFWLrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:47:19 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:54209 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbgFWLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:47:16 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05NBkITv013767;
        Tue, 23 Jun 2020 20:46:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05NBkITv013767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592912780;
        bh=CJ7xJNq8YhNLPWOGA/kPm5KL6uoxrz+Qf++mEvOnqZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lS195I7FyGLI05cJtxANmHnbvT/1SFjMOAevI12V/gNPEk7EVcbav9x00Jz7LDm4I
         Zq5uHgDRrxGoXj5HZ/18z0k2W+1gV9TIuOWUVweRuBSg0FLHPWWSQFjkvk/I5y66a4
         ClmZfIti27iSEgtvy5DV3OkRXriIqOLS7smkG4bprkA30C4/I/8b3MmOteRkeim7SN
         bGtyLd0e4WFPmf1QuIm4m/PyiA97p9XZycHypvYUu6XvQBenKze/cCDr0v6R1gyaIE
         gmc5q9EySpapNwKr82iD5jMyacYELqU7tOnFFWpCCfpR8biJYQ53wVxCjaAdVNpHhK
         QPfP67MSyBzug==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: uniphier: rename support card serial node to fix schema warning
Date:   Tue, 23 Jun 2020 20:46:13 +0900
Message-Id: <20200623114614.792648-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623114614.792648-1-yamada.masahiro@socionext.com>
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to
json-schema"), the schema for "ns16550a" is checked.

'make ARCH=arm dtbs_check' emits the following warning:

  uart@b0000: $nodename:0: 'uart@b0000' does not match '^serial(@[0-9a-f,]+)*$'

Rename the node to follow the pattern defined in
Documentation/devicetree/bindings/serial/serial.yaml

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-support-card.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index bf441c2eff79..11e46e7de7c5 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -23,7 +23,7 @@ ethsc: ethernet@0 {
 			reg-io-width = <4>;
 		};
 
-		serialsc: uart@b0000 {
+		serialsc: serial@b0000 {
 			compatible = "ns16550a";
 			reg = <0x000b0000 0x20>;
 			clock-frequency = <12288000>;
-- 
2.25.1

