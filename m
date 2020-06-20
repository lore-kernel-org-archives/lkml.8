Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B305C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514F323EF1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UH5336yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgFTQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgFTQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:37:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F96C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so2261526ejq.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TahxZALJaLCxgLMRboEQz5AGrY5Y2MzITJGz48oy1vw=;
        b=UH5336yAihXpFlkaEJC0dTEyZT1X7gcIiuPL59QjIZbud6sSevhkZmAz4bLSCjj7eg
         KReF9sbxXno8m/FJlmfAcBi75MsdGkDRBzvPSJVm7iba4+Bbb37rOlqxkrX/d3VTntgM
         6U97hcKOC/sTO5HcD23Y553Be53z8r3Ed2FPebpONe+NCIv+KlhUn3/4MDYmeK1ugxl5
         m8jhTUKs9Rz6t7b+om8YymoapMbjPBZNkiICG8Z7TgZ+Jp09F87WTR+2/H/iypz0ycVj
         NbZY9rLg9OLN8EvZat+E42wTx0FZhv/bA2N6jHl9j+6BGY4omPOu2E5e2RhuP0WbVr/9
         RYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TahxZALJaLCxgLMRboEQz5AGrY5Y2MzITJGz48oy1vw=;
        b=m4bdJO497M2PlfJSUvIJEXgc3lq1T5i46R1MNmhitI0fM+EvHu4RzfI3xAdKmNXRYl
         CO3kgRaF0EEkAh0WTcyK73FP/fpk9AZTaqjQ42XDssqb25OG2H2nX+7GlmXrarFxkenW
         KRmCV9/U8FZIM89ujELVx7ivYMl1/SmonHNi9jWrHNXQJs7RCm7di0FjFEPeZulLhEmQ
         gG/M/CjCPnvSmddTlI/IOpa3/uuRef0gBSdDdo6sm2YTwkrOxuMVt29Yu5g9DkB129fW
         yhXpdDu1S/NPYmPSEWQjGN+ziSPyMpo6U8Berw/nwp/16/9u686pK/iDtI5/etrqF7fp
         Iw+w==
X-Gm-Message-State: AOAM531HHfI69tiloHyowEZe64VrXmwz24WVBDw0uGOftKMM3+MSxxwp
        mQ0XjkW4ClvhmT8WQr6bWaY=
X-Google-Smtp-Source: ABdhPJx0Dr2mn9vLEyJDZKufVycnesKdKOX9+R36cGvaO02+1LnNq2V8x4wzWWxYO8jTTr6PFT+5/Q==
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr8642098ejc.66.1592671024588;
        Sat, 20 Jun 2020 09:37:04 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o90sm7839442edb.60.2020.06.20.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:37:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8b: ec100: enable the SDHC controller
Date:   Sat, 20 Jun 2020 18:36:53 +0200
Message-Id: <20200620163654.37207-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
References: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC-100 has built-in eMMC flash which is hard-wired to 3.3V VCC (which
means it's limited to high-speed MMC modes). Enable the SDHC controller
to access the contents of the eMMC flash.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 163a200d5a7b..ed06102a4014 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -27,6 +27,11 @@ memory {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -299,6 +304,26 @@ &saradc {
 	vref-supply = <&vcc_1v8>;
 };
 
+&sdhc {
+	status = "okay";
+
+	pinctrl-0 = <&sdxc_c_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	max-frequency = <50000000>;
+
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	no-sdio;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_3v3>;
+};
+
 &sdio {
 	status = "okay";
 
-- 
2.27.0

