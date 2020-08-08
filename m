Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCA82086A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PM77PxTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHHCF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:05:26 -0400
Received: from m12-18.163.com ([220.181.12.18]:40660 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgHHCFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=58O72jhnrDHl5eaGDS
        i3G0TKF4cP/BfnN/97i4BIIUM=; b=PM77PxTVMbqsonZea0PseEBcsU3qAeqLv+
        vLYnrGez8l5WQnhyPX6ajKQOftG7qOx1cb/JF8OwMBBKKv6jFPZ9p5CA9EjGe8F5
        7KU8ZMwI2vWNCwxk+VpXS1EkF7wSdFFG5PYjCgaJsffdli5OoP+0fK9eWQJcJriO
        b40pF2Nz4=
Received: from localhost.localdomain (unknown [58.33.79.182])
        by smtp14 (Coremail) with SMTP id EsCowABnvrJDCC5fRqxLIA--.16258S3;
        Sat, 08 Aug 2020 10:04:58 +0800 (CST)
From:   Grant Feng <von81@163.com>
To:     von81@163.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] leds: Add an optional property named 'sdb-gpios'
Date:   Sat,  8 Aug 2020 10:04:39 +0800
Message-Id: <20200808020439.20606-2-von81@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200808020439.20606-1-von81@163.com>
References: <20200808020439.20606-1-von81@163.com>
X-CM-TRANSID: EsCowABnvrJDCC5fRqxLIA--.16258S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4fCFWfXFW7XFy3XrWfAFb_yoWDtFc_Ja
        s7Cr4IgrZ8uF4vgw1DZr1avr4UCw4xAF1kCw4IqF1kAw1xt3sIgF92q34Yyr1UGana9r43
        Ca97ta4UJ3ZFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0dMaUUUUUU==
X-Originating-IP: [58.33.79.182]
X-CM-SenderInfo: xyrqmii6rwjhhfrp/xtbBiAp6OlaD8FYqmQAAsC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip enters hardware shutdown when the SDB pin is pulled low.
The chip releases hardware shutdown when the SDB pin is pulled high.

Signed-off-by: Grant Feng <von81@163.com>
---
 Documentation/devicetree/bindings/leds/leds-is31fl32xx.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-is31fl32xx.txt b/Documentation/devicetree/bindings/leds/leds-is31fl32xx.txt
index 926c2117942c..94f02827fd83 100644
--- a/Documentation/devicetree/bindings/leds/leds-is31fl32xx.txt
+++ b/Documentation/devicetree/bindings/leds/leds-is31fl32xx.txt
@@ -15,6 +15,8 @@ Required properties:
 - reg: I2C slave address
 - address-cells : must be 1
 - size-cells : must be 0
+- sdb-gpios : (optional)
+  Specifier of the GPIO connected to SDB pin.
 
 LED sub-node properties:
 - reg : LED channel number (1..N)
@@ -31,6 +33,7 @@ is31fl3236: led-controller@3c {
 	reg = <0x3c>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	sdb-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
 
 	led@1 {
 		reg = <1>;
-- 
2.17.1


