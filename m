Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C48206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2Uo01NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCMN05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:26:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36173 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCMN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:26:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so12135722wrg.3;
        Fri, 13 Mar 2020 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hGTtD4LLU6z8nLYoqJKtaVgPwNbnoGTn8gZTvLe4N9c=;
        b=U2Uo01NM91NeBSJVW7uzYrj/clfD2+uDJn2m4bO9PQGnqG9CONH5kjfrKGbB9kawLl
         UosbWPOXW/QVxzhxAX5JADqAQcJnZkZFXWyT8hJN7kZRM3hAivHdpHaYS5dwB013jV9a
         nhFTaA+p6bTYIcgeLrgYQEfK5iHcY9GXnAvWveEnRMlxrJPzD4GAFqPT0wdBipKkxWSF
         8PUAG1CpXxlydZs0yZlAwx8gG6zdOtjmL688rc+4Iqhx+Sp5g0TAmvGJmHemf2t4DPXK
         TlOy5e89BbW+pwPRdA7DhYiZ07Z2DCTZhbuetN9ETxY8CuUqAYwTKz+LA4/G9tTKIH3I
         YNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hGTtD4LLU6z8nLYoqJKtaVgPwNbnoGTn8gZTvLe4N9c=;
        b=JCjvwRuf5oUFHqHGONU227wnHt7q8naKvC/STYGCVbqaFLrMdCzJUIFQXoZWW64VIu
         HiRc+3Tj/AQUkJmF8QMQ6vXj0ZXSgFsw21MKAyyE8/7bXwP8/u/DTkXUEX51kNIuDY87
         vDVdZ748vCreXEJjOOrD3kK9Hu1dktVCnJQz/Z+IXnB3a+twIEEVvceSK918DRCHW8oW
         UKfLCnqBn0ZOP0kY7e6kwrNfgOhFtmD8lu1iHDAjsyAYGTJDXbIuKO48BZ6G3JYc+Ziq
         AxMQHO0vFLuB+JakQaVhOlGAJbcnnMRXDD30lSYRLq4uuoda9tJ+R/cKye1vBMPyDava
         OOQA==
X-Gm-Message-State: ANhLgQ12BwB4MmXIe8tDoS7pCwT+Hed48oaJkk3dFWM3yOzQzV3MPVO9
        ppcyW80hF1ka0gBCqRvsKqE=
X-Google-Smtp-Source: ADFU+vv9CSAECvZnYj48mBzZNjuL7qHzUdi9abc7khFeX05zaTMSUwv7MmoseyxxldsKLgNVD8282g==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr17438260wrw.161.1584106013666;
        Fri, 13 Mar 2020 06:26:53 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w67sm12994428wmb.41.2020.03.13.06.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 06:26:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: remove clock-frequency from saradc node rv1108
Date:   Fri, 13 Mar 2020 14:26:46 +0100
Message-Id: <20200313132646.10317-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental test with the command below gives these errors:

arch/arm/boot/dts/rv1108-elgin-r1.dt.yaml: adc@1038c000:
'clock-frequency'
does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/rv1108-evb.dt.yaml: adc@1038c000:
'clock-frequency'
does not match any of the regexes: 'pinctrl-[0-9]+'

'clock-frequency' is not a valid property for a saradc node,
so remove it.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/
rockchip-saradc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 153868c62..f9cfe2c80 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -366,7 +366,6 @@
 		reg = <0x1038c000 0x100>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#io-channel-cells = <1>;
-		clock-frequency = <1000000>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
 		status = "disabled";
-- 
2.11.0

