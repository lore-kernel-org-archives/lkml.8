Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67189C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258C214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758136;
	bh=36a9lD/veDQq5Kk24uPgKZn3yWb8Gm7VdB8+weBsoQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ubZvYi8uFdHjEmwvyho/vC8YjwfxrUB8wPYXiPEDo4Rl0F3Xm1c8n9BYeusT4XJA7
	 7cTG/49HQME06kNyP4kWcP4ZEjp65bnNNQocgo2e1Bciodp+Wnng9AIubiOQxSFy8b
	 bPBX9adtvgl69/KNVtG4yjeMXN/q8nBJIH6aqxr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgDAQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387452AbgDAQWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:22:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A151720857;
        Wed,  1 Apr 2020 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758131;
        bh=36a9lD/veDQq5Kk24uPgKZn3yWb8Gm7VdB8+weBsoQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9oc3XuP3p0N8dnUGfnnZ+o1IaNM3O5AF5JnuyAAIMbLcvigWHMsOQi5aZLuf+MoW
         xoKbQPbxj7e+yu6VpiDqybj+dbgNpXxwqx1SeGGyu1FgpulMl14r/I+FzW0BP6yYNH
         XOAIBbhPIfTLH6enY3uoqXqhU4FV8GYZpG6GNOnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sungbo Eo <mans0n@gorani.run>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5.4 21/27] ARM: dts: oxnas: Fix clear-mask property
Date:   Wed,  1 Apr 2020 18:17:49 +0200
Message-Id: <20200401161431.755855599@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.352722470@linuxfoundation.org>
References: <20200401161414.352722470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sungbo Eo <mans0n@gorani.run>

commit deeabb4c1341a12bf8b599e6a2f4cfa4fd74738c upstream.

Disable all rps-irq interrupts during driver initialization to prevent
an accidental interrupt on GIC.

Fixes: 84316f4ef141 ("ARM: boot: dts: Add Oxford Semiconductor OX810SE dtsi")
Fixes: 38d4a53733f5 ("ARM: dts: Add support for OX820 and Pogoplug V3")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/ox810se.dtsi |    4 ++--
 arch/arm/boot/dts/ox820.dtsi   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -323,8 +323,8 @@
 					interrupt-controller;
 					reg = <0 0x200>;
 					#interrupt-cells = <1>;
-					valid-mask = <0xFFFFFFFF>;
-					clear-mask = <0>;
+					valid-mask = <0xffffffff>;
+					clear-mask = <0xffffffff>;
 				};
 
 				timer0: timer@200 {
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -240,8 +240,8 @@
 					reg = <0 0x200>;
 					interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 					#interrupt-cells = <1>;
-					valid-mask = <0xFFFFFFFF>;
-					clear-mask = <0>;
+					valid-mask = <0xffffffff>;
+					clear-mask = <0xffffffff>;
 				};
 
 				timer0: timer@200 {


