Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED696C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93EA2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+nK1UHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgFJRRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgFJRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438EC03E96B;
        Wed, 10 Jun 2020 10:16:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so3173397wrt.5;
        Wed, 10 Jun 2020 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufahVb650w9qsCrH1Cbf/slHCvCwJwLo7tVzV2USitA=;
        b=l+nK1UHjzB69FNVE+oP3RRR5YWelnjeKlAXrIBKOzhCz5TUvwa3LtqFS8o2zuiufw/
         0mYvXmy7lYL8YCoqmDMZA3OberG5ISZzusL1aIVgz2y3qX493weN/bds88e7DcsuQ56c
         Effdw3cpOAzU/PApjE2DyMlSmIcUaWlZRccwok3cX9xuclJQmo99xJngBphqBL+YZHOi
         EikWk2YO4hKeu3SFbfYWz69HCqd8eIhKRCZfnZIohmBapa+h7ZD6Vjw1O5xIHxIFgtpH
         lwgQ1ESCpkn+6wgtwr/S1kw/IaC5HOEpzzzMFmInSSUz92YGPRXQrRWfJbX1pgT4ucKQ
         lNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufahVb650w9qsCrH1Cbf/slHCvCwJwLo7tVzV2USitA=;
        b=iGy/wXW0/QGiZXnKExZwvZwN7Xw/pYbibyvRkCgQyJqmJr0M4LtMmrV+l604mVATu6
         Rmf6Kzgcfhp5uMEZG/HlnK5NIJIP56pNDoiVmP7RUAFFXnKXyDnZdspahUQg9OYK6i6g
         vL1VCHdT9NAJm7+6nSwQPPo9UvyHRhUmrfFkUx030kUE6MlxpTCZyCYkW4N00nZkhcKj
         PA79gw6IZjlAMWURTFgTsQmg+OksuYsu4sbhKl6+rjc1P17jJsgfKpiAdEgcuZQsSIP6
         6q7xySvM9gkJ5B1JJvfzoy7VoVhxVFNKeCzM4P6NAAaKzHMXkafYC0BW1DJQjh6uWnj6
         XoBg==
X-Gm-Message-State: AOAM53102yUoRhAgTgRQM87NqVROVlxE5I2hXZ5iBOMBFP/OGM2Y93TJ
        KGFFDzMABMPLa1rC0VAhJ8o=
X-Google-Smtp-Source: ABdhPJwEtna7aixJMCKiZdjMiIc1fb6fCfZ/dWM+7OhcJR8NgfA97VJUrOJm8XvzFU8v2Gb2X30fwA==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr4802365wrq.310.1591809399858;
        Wed, 10 Jun 2020 10:16:39 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id f11sm589048wrm.13.2020.06.10.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:16:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 7/9] mips: bmips: dts: add BCM6328 power domain support
Date:   Wed, 10 Jun 2020 19:16:28 +0200
Message-Id: <20200610171630.465579-8-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610171630.465579-1-noltari@gmail.com>
References: <20200610163301.461160-1-noltari@gmail.com>
 <20200610171630.465579-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6328 SoCs have a power domain controller to enable/disable certain
components in order to save power.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v3: Separate dt-bindings definitions from power domain .dtsi support.
 v2: Add dt-bindings header files.

 arch/mips/boot/dts/brcm/bcm6328.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index af860d06def6..1f9edd710392 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -110,6 +110,12 @@ leds0: led-controller@10000800 {
 			status = "disabled";
 		};
 
+		periph_pwr: power-controller@10001848 {
+			compatible = "brcm,bcm6328-power-controller";
+			reg = <0x10001848 0x4>;
+			#power-domain-cells = <1>;
+		};
+
 		ehci: usb@10002500 {
 			compatible = "brcm,bcm6328-ehci", "generic-ehci";
 			reg = <0x10002500 0x100>;
-- 
2.26.2

