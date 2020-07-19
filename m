Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BAAC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A35921775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZK9wg1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgGSOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:50:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C8C0619D2;
        Sun, 19 Jul 2020 07:50:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so15378638wrw.12;
        Sun, 19 Jul 2020 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kjfuse7dtGFuujC8xKQQtWkMq6uG/2iBu5hcp0AydUM=;
        b=AZK9wg1DXgX28pBbajcPDYLcnk43Qj2AOevWnTVuCv3yXTq/YELz1G0Ul7+v0eCTvi
         MB8sd7FdbuqGAmqXoixLVNffTzI1ihdrw0vfzSnsjg7D9YE3AikleRFunF4FC2sWR812
         LnTu6JOitsoEo8RC226fRp1XmpzbZUSt5bZ/Twu8kr1Obc4g31r8afDCKhtLhx9qtVSE
         mCaeN/WLr2jN5zHwxkEjDR2wN/di4pYhQVImsgculyOyCowVaAEqltifGl9/mHLUZEeB
         KzzouGzgZl0OMEriHNc8zH1igfzHQOtCrYQXuLBOWkauFYI7txqSpkjWQo9IxKl7FEHE
         apHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kjfuse7dtGFuujC8xKQQtWkMq6uG/2iBu5hcp0AydUM=;
        b=X9OKYMhe8bRLYhTPX0x8yPazt9hNIabrJzpWKPxDje2pLelyeS6dWoG0fsWVdyuCZF
         Q7ZM4+0VSnkSOglIduCDElMAg4I/bo4IRF/4VjYnONp3ndP1ZiVVMIBc5S4+fWY4Kuej
         t+ZfSzpVPK9nIymARqAJ4mxkemZjqdfXH5pdIK0jzffsQvJZ0Vpof/39KDfeYEA+BvUg
         TkSE84bT5jTIrIZcZ7YEbkEKP6/SGHf6P7/7+PQ2+xXwXhFf+d7nzQS6ry0uXoMuVTQ4
         nEcgRVMXMXI/Qa5msdwqhalLGTCqiQT2j5eoPRt9a84Byc+T61CLTdtwqeewioPQOA9p
         0//w==
X-Gm-Message-State: AOAM530ahQT2GkRWNIiEqmtkW2Orz9tpotXL768ELG0BOKGTgB2jt+LK
        6GNL+qwcg1FCkqSW+n4+Rmw=
X-Google-Smtp-Source: ABdhPJwslrlNgQRc5S4GUrNpBrqbecXCN9mawT9Cuuc1xNWEODhN9GtBzhV866bI9hjUba3kyC3HCg==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr2439713wro.239.1595170243004;
        Sun, 19 Jul 2020 07:50:43 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-179-3.netvisao.pt. [84.90.179.3])
        by smtp.gmail.com with ESMTPSA id d13sm26422755wrq.89.2020.07.19.07.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 07:50:42 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     linux@armlinux.org.uk, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: pcf8523: Make DSM for battery switch-over configurable from DT
Date:   Sun, 19 Jul 2020 15:50:27 +0100
Message-Id: <20200719145028.3370-2-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200719145028.3370-1-miguelborgesdefreitas@gmail.com>
References: <20200719145028.3370-1-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt |  7 ++++++-
 Documentation/devicetree/bindings/rtc/rtc.yaml        |  7 +++++++
 drivers/rtc/rtc-pcf8523.c                             | 13 ++++++++++---
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
index 0b1080c..f715a8f 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
@@ -4,10 +4,14 @@ Required properties:
 - compatible: Should contain "nxp,pcf8523".
 - reg: I2C address for chip.
 
-Optional property:
+Optional properties:
 - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
   expressed in femto Farad (fF). Valid values are 7000 and 12500.
   Default value (if no value is specified) is 12500fF.
+- pm-enable-dsm: battery switch-over function is enabled in direct
+  switching mode. The power failure condition happens when VDD < VBAT,
+  without requiring VDD to drop below Vth(sw)bat.
+  Default value (if not provided) is the standard mode.
 
 Example:
 
@@ -15,4 +19,5 @@ pcf8523: rtc@68 {
 	compatible = "nxp,pcf8523";
 	reg = <0x68>;
 	quartz-load-femtofarads = <7000>;
+	pm-enable-dsm;
 };
diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index ee237b2..a0048f4 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -47,4 +47,11 @@ properties:
     description:
       Enables wake up of host system on alarm.
 
+  pm-enable-dsm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables the battery switch-over function in direct switching
+      mode. Should be set in systems where VDD is higher than VBAT
+      at all times.
+
 ...
diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 47e0f41..0c08f91 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -122,7 +122,7 @@ static int pcf8523_load_capacitance(struct i2c_client *client)
 	return err;
 }
 
-static int pcf8523_set_pm(struct i2c_client *client, u8 pm)
+static int pcf8523_set_pm(struct i2c_client *client)
 {
 	u8 value;
 	int err;
@@ -131,7 +131,10 @@ static int pcf8523_set_pm(struct i2c_client *client, u8 pm)
 	if (err < 0)
 		return err;
 
-	value = (value & ~REG_CONTROL3_PM_MASK) | pm;
+	if (of_property_read_bool(client->dev.of_node, "pm-enable-dsm"))
+		value = (value & ~REG_CONTROL3_PM_MASK) | REG_CONTROL3_PM_DSM;
+	else
+		value = (value & ~REG_CONTROL3_PM_MASK) | 0;
 
 	err = pcf8523_write(client, REG_CONTROL3, value);
 	if (err < 0)
@@ -173,6 +176,10 @@ static int pcf8523_start_rtc(struct i2c_client *client)
 	if (err < 0)
 		return err;
 
+	err = pcf8523_set_pm(client);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -352,7 +359,7 @@ static int pcf8523_probe(struct i2c_client *client,
 		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
 			 err);
 
-	err = pcf8523_set_pm(client, 0);
+	err = pcf8523_set_pm(client);
 	if (err < 0)
 		return err;
 
-- 
1.8.3.1

