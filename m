Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A25C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296BC222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyBOpb18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgANPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:19:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgANPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so6549898pgk.0;
        Tue, 14 Jan 2020 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2K6rRI7pCn9t5RYAWusq+FmSFOJ0/oBKMxxQl0gpYQY=;
        b=GyBOpb18t5KUIO1lKiMJ+TY48O4y0uaee+qso1Wsun2HKScGCc2Cj0zq3voSwbeufW
         edkQTmZ3t5V9bNfanTGFKzp4yOSewQoLShea7EPxSrXe9AHa6vXseo7coz33toBgeIUF
         MLJXqv6BKVeFn8GXxHtrYdxGB25Xyo/+PD9WuTlEEcuJNejNB2bQVfO88lX+c+j1rPY+
         Mc3XWfDAbX7G7/L/qTdtedPY5vpF1MnaaiTpYJvvy1XOUF4k2C1bPC5Op3a/+vtXM7t5
         5cf1rKRYXShhbHWuEAoBhFYIvRH2PHv/jSLjyEGf/X5mfTsopEB+a4tU93WeycZuyqBd
         5BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2K6rRI7pCn9t5RYAWusq+FmSFOJ0/oBKMxxQl0gpYQY=;
        b=Ibc4ApiVMwJa3MYT3yWqHD1YQ21keWEoLUa0bG0YVD4Jb+AorJWfX/aLlhzT1bTPRn
         FzyfOJXaC+nuib5Ye+w9+bFkN058QoN8cFR+/O631WnASctSD4O/XzsZinN4w3iBzbXs
         +7chwJSOBUV1Nqngfom/mtakwDkMcIfjwQSi6kz261qmWt7bNAL8NBxQh0gId6NCeKrC
         4KrX+d4vyEUMSf9Cg42BRjPvkv/eHat9ScdvUDJ33gbPZWkhyhejsbvDOy6lfXkXhORj
         j6N1US5K8d3tNemjMonir7EJ1y9Koe96jW3lggyvLnGhVZaoGX83B6FD92RpGnZGZjo2
         uLoA==
X-Gm-Message-State: APjAAAXQ2sFqiY5gp1SAWDI/mwnwBhT+iedjCBgCWjOafZiN/Cy3blVy
        B7HSx9rF0KL+dx2Mnyt3ArM=
X-Google-Smtp-Source: APXvYqwP7gCn/MA7btxDogcApJqTsBrFCttsL+REBZoBUwJzmmo+HFp2fLQRj0phrrY0C9TTdnCAZA==
X-Received: by 2002:a62:e908:: with SMTP id j8mr25632066pfh.55.1579015171060;
        Tue, 14 Jan 2020 07:19:31 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 207sm18834425pfu.88.2020.01.14.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:19:30 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: vf610-zii-dev: Add voltage monitor DT node
Date:   Tue, 14 Jan 2020 07:19:05 -0800
Message-Id: <20200114151906.25491-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200114151906.25491-1-andrew.smirnov@gmail.com>
References: <20200114151906.25491-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for various voltage supply rails connected to SoC's ADC
for voltage monitoring purposes.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index a1b4ccee2a10..95d0060fb56c 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -84,6 +84,14 @@
 		regulator-boot-on;
 		gpio = <&gpio0 6 0>;
 	};
+
+	supply-voltage-monitor {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 8>, /* VCC_1V5 */
+			      <&adc0 9>, /* VCC_1V8 */
+			      <&adc1 8>, /* VCC_1V0 */
+			      <&adc1 9>; /* VCC_1V2 */
+	};
 };
 
 &adc0 {
-- 
2.21.0

