Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E17C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA98920639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BJtKaDY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgHYIXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:23:38 -0400
Received: from m12-18.163.com ([220.181.12.18]:46358 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgHYIXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=I+iIic8fam574pYtic
        8pIXKP8q5gxngdUz2v8fQklcE=; b=BJtKaDY6oun/P0l/EP/VlOMdvjUG4CmN7j
        QmtH6RxK4By7oJu8L8MbNVm87vd0noPyApbkKFkIELh45zpU9AmUS8x1h/4f3wrE
        MuS7V1TCIU4KRY7qLB1MqDwNNoXXerL1nnKMWVfYDIEVPTYCQc8TW5zB4v7lfMF7
        oltYV4Jwo=
Received: from localhost.localdomain (unknown [58.33.102.45])
        by smtp14 (Coremail) with SMTP id EsCowADn7pY5ykRf0ZtgKw--.56943S3;
        Tue, 25 Aug 2020 16:22:25 +0800 (CST)
From:   Grant Feng <von81@163.com>
To:     von81@163.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] DT: leds: Add an optional property named 'shutdown-gpios'
Date:   Tue, 25 Aug 2020 16:22:06 +0800
Message-Id: <20200825082206.26575-2-von81@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825082206.26575-1-von81@163.com>
References: <20200825082206.26575-1-von81@163.com>
X-CM-TRANSID: EsCowADn7pY5ykRf0ZtgKw--.56943S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw4fCFWfXFW7XFy3XrWfAFb_yoW8Jr43pr
        ZrCF10y3sIqFW7K3y8ta4UJ348XF4kAF17KFs7JFyxGF1Dur9aqaySkwn8X3WUJrWIvayF
        vFs5KFW8t347Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSwZ7UUUUU=
X-Originating-IP: [58.33.102.45]
X-CM-SenderInfo: xyrqmii6rwjhhfrp/1tbiRAGLOlSIgmZ4dQAAsB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip enters hardware shutdown when the SDB pin is pulled low.
The chip releases hardware shutdown when the SDB pin is pulled high.

Signed-off-by: Grant Feng <von81@163.com>
---
 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-is31fl319x.txt b/Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
index fc2603484544..676d43ec8169 100644
--- a/Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
@@ -16,6 +16,7 @@ Optional properties:
 - audio-gain-db : audio gain selection for external analog modulation input.
 	Valid values: 0 - 21, step by 3 (rounded down)
 	Default: 0
+- shutdown-gpios : Specifier of the GPIO connected to SDB pin of the chip.
 
 Each led is represented as a sub-node of the issi,is31fl319x device.
 There can be less leds subnodes than the chip can support but not more.
@@ -44,6 +45,7 @@ fancy_leds: leds@65 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	reg = <0x65>;
+	shutdown-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
 
 	red_aux: led@1 {
 		label = "red:aux";
-- 
2.17.1


