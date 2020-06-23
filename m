Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E4DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E6820724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uwJ2jcIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbgFWLr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:47:27 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:54294 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbgFWLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:47:21 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05NBkITu013767;
        Tue, 23 Jun 2020 20:46:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05NBkITu013767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592912779;
        bh=Vn2EUDBp5gJO41DcoLGASkIVbdjDKOMA+8pe5Lqfplw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwJ2jcIrSN+15RNjiH9k5BHgGkYkVKI/HKhcW/9nb4jKV7PuiYmXRxKVgWrggf5lO
         Qr9Pp2eazKVpQnzw1erVgCCcJL+uIQBO6fLJiN9bK16U8I5hQt7SEtC7t4IRp4xGld
         Llv8TpP+yqsgY3pGAVeEJloBBR7DNPH9s+lIBmsmdNeXvYYMsrbGp7OxK4Jqb7gSCe
         DRtMVgnxMz6/WZv4kqd1mmjALuKXvrnN0oAZIw6+o3a+dMlowMQ+eVJePSbTa+798q
         r3RF3MqO0hCF9Xqltiu2SKWA7eTUNkZYY3Qxo266vhzj7KRrOEoRZsHyar3TIxbfNs
         KbF2zJ54Unpjw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: uniphier: add interrupts to support card serial
Date:   Tue, 23 Jun 2020 20:46:12 +0900
Message-Id: <20200623114614.792648-2-yamada.masahiro@socionext.com>
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

Since then, 'make ARCH=arm64 dtbs_check' is so noisy because the
required property 'interrupts' is missing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 693171f82ff1..d07401fafffa 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -42,6 +42,10 @@ &ethsc {
 	interrupts = <0 8>;
 };
 
+&serialsc {
+	interrupts = <0 8>;
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index eeb976e7892d..709908d5812b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -42,6 +42,10 @@ &ethsc {
 	interrupts = <0 8>;
 };
 
+&serialsc {
+	interrupts = <0 8>;
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 7c30c6b56b57..eca60e02e85a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -43,6 +43,10 @@ &ethsc {
 	interrupts = <4 8>;
 };
 
+&serialsc {
+	interrupts = <4 8>;
+};
+
 &spi0 {
 	status = "okay";
 };
-- 
2.25.1

