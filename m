Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCA920738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="fRABIdZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHRMs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgHRMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:48:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9224C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a79so9905631pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PiBfpyPpwYw2gBlkazywYW35vVveYdo+y+uOHyp6ug=;
        b=fRABIdZs6mvbIVr4a0oD+jtpjiKfueaUVYVJ4Y4DTEexjvZFvSUb8oL11xZxBFJ9Fa
         c9GO/WERZtx3ZgE3dLI/jfHh1QnWfQzJxCEqKyrpkAGMSUEJMaaRo7KshBDlAG2o3w8A
         2ANl4fPw3i8g2Cw8YX71+9a3OJ2JdTjJxwJzblEP+ckLna6Dixotdjv9rT1M7w1QwK5k
         I1TarQqbnmiWWac10/vXCYOzOliGu/RgywtiHxW//Pumlc2OAm1bH5aiPjhiJe2L5YIn
         q+bTy6V6OHN8dhxNKf5H8io3xqnlYTbCPAot9ycJbqFkcdqlHnPnA/z5RZ/9d8HPvCbD
         3UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PiBfpyPpwYw2gBlkazywYW35vVveYdo+y+uOHyp6ug=;
        b=C6LgJbg06aqtF1xOtgebN9LIPy+yuO6GQYyuIX+7T1y+OPuVma0OWH0NiSOnehsnmO
         5newdRdQTyXPdqkvLaB5ai0J/qE+z1/pdFxjjnuufHBrfNIBfM5JnWaAMmSpQZSH9I0+
         yriBQd/HUy0MtyIkdTImyFA59YMLWyseoGELsgecSNg/Nz8JGH7eOd5K2xDCAVjauCS+
         jRCbTTVVN9aGEY6ql3viN2eERZZGK53gU32Zxa9zBhTF60thjIWwTDth6XWO2qkvk9xF
         kyTRHE4OuJvejBUKnXRhwmEHznD0rz7YjM/ENuZHrUvwIfW3bk2JFg0W3a8U2BDrxwPq
         viaQ==
X-Gm-Message-State: AOAM533pqLkOTLL/SdPpPC9J+0aq06enGr9dkEijQyATygC27lzTfTa5
        IcEd3ingANeD2mGCVqJt1ClW
X-Google-Smtp-Source: ABdhPJyHTPDSgQc89zx5NWlOlg3j0Fes+5KpAnOZzFGVChpNvEKqXWnQZpY+1TzcvBnUU5G8huGHSQ==
X-Received: by 2002:a63:c30b:: with SMTP id c11mr2180353pgd.252.1597754933173;
        Tue, 18 Aug 2020 05:48:53 -0700 (PDT)
Received: from localhost.localdomain ([116.68.79.111])
        by smtp.gmail.com with ESMTPSA id e4sm24264221pfd.204.2020.08.18.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:48:52 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org
Cc:     Vaishnav M A <vaishnav@beagleboard.org>, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Subject: [RFC PATCH v2 3/3] Add Device Tree Bindings for mikroBUS port
Date:   Tue, 18 Aug 2020 18:18:15 +0530
Message-Id: <20200818124815.11029-4-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818124815.11029-1-vaishnav@beagleboard.org>
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree bindings for the mikroBUS port,
device tree overlays for the mikrobus Port on the BeagleBoard.org
PocketBeagle is available here :
github.com/beagleboard/bb.org-overlays/blob/master/src/arm/PB-MIKROBUS-0.dts

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 .../bindings/misc/linux,mikrobus.txt          | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt

diff --git a/Documentation/devicetree/bindings/misc/linux,mikrobus.txt b/Documentation/devicetree/bindings/misc/linux,mikrobus.txt
new file mode 100644
index 000000000000..99f75caf5f35
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/linux,mikrobus.txt
@@ -0,0 +1,81 @@
+mikroBUS add-on board socket
+
+Required properties:
+- compatible: Must be "linux,mikrobus"
+- i2c-adapter:  phandle to the i2c adapter attached to the mikrobus socket.
+- spi-master: spi bus number of the spi-master attached to the mikrobus socket.
+- spi-cs: spi chip-select numbers corresponding to the chip-selects
+	  on the mikrobus socket(0 -> chip select corresponding to CS pin
+	  1 -> chip select corresponding to RST pin).
+- serdev-controller:  phandle to the uart port attached to the mikrobus socket.
+- pwms: phandle to the pwm-controller corresponding to the mikroBUS PWM pin.
+- mikrobus-gpios: gpios array corresponding to GPIOs on the mikroBUS port,
+		  for targets not supporting the AN pin on the mikroBUS port as
+		  GPIO, the length of the gpios array can be 11, otherwise it
+		  should be 12.
+- pinctrl-names: pinctrl state names to support additional pin usage/deviations
+		 from mikroBUS socket standard usage, must be "default",
+		 "pwm_default", "pwm_gpio", "uart_default", "uart_gpio",
+		 "i2c_default", "i2c_gpio", "spi_default", "spi_gpio", these
+		 pinctrl names should have corresponding pinctrl-N entries which
+		 corresponds to the pinmux state for the pingroup, for example,
+		 i2c_default corresponds to the state where the I2C pin group
+		 (SCL,SDA) are configured in I2C mode and i2c_gpio mode corresponds
+		 to the pinmux state where these pins are configured as GPIO.
+- pinctrl-N : pinctrl-(0-8) corresponds to the pinctrl states for the states described
+	      above.
+
+Example:
+	mikrobus-0 {
+		compatible = "linux,mikrobus";
+		status = "okay";
+		pinctrl-names = "default", "pwm_default", "pwm_gpio",
+				"uart_default", "uart_gpio", "i2c_default",
+				"i2c_gpio", "spi_default", "spi_gpio";
+		pinctrl-0 = <
+			&P2_03_gpio_input_pin
+			&P1_04_gpio_pin
+			&P1_02_gpio_pin
+		>;
+		pinctrl-1 = <&P2_01_pwm_pin>;
+		pinctrl-2 = <&P2_01_gpio_pin>;
+		pinctrl-3 = <
+			&P2_05_uart_pin
+			&P2_07_uart_pin
+		>;
+		pinctrl-4 = <
+			&P2_05_gpio_pin
+			&P2_07_gpio_pin
+		>;
+		pinctrl-5 = <
+			&P2_09_i2c_pin
+			&P2_11_i2c_pin
+		>;
+		pinctrl-6 = <
+			&P2_09_gpio_pin
+			&P2_11_gpio_pin
+		>;
+		pinctrl-7 = <
+			&P1_12_spi_pin
+			&P1_10_spi_pin
+			&P1_08_spi_sclk_pin
+			&P1_06_spi_cs_pin
+		>;
+		pinctrl-8 = <
+			&P1_12_gpio_pin
+			&P1_10_gpio_pin
+			&P1_08_gpio_pin
+			&P1_06_gpio_pin
+		>;
+		i2c-adapter = <&i2c1>;
+		spi-master = <0>;
+		spi-cs = <0 1>;
+		serdev-controller = <&uart4>;
+		pwms = <&ehrpwm1 0 500000 0>;
+		mikrobus-gpios = <&gpio1 18 0> , <&gpio0 23 0>,
+					<&gpio0 30 0> , <&gpio0 31 0>,
+					<&gpio0 15 0> , <&gpio0 14 0>,
+					<&gpio0 4 0> , <&gpio0 3 0>,
+					<&gpio0 2 0> , <&gpio0 5 0>,
+					<&gpio2 25 0>  , <&gpio2 3 0>;
+	};
\ No newline at end of file
-- 
2.25.1

