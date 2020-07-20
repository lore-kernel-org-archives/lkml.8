Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EACBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8C022B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giKWfMOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgGTLYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgGTLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:24:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60BC061794;
        Mon, 20 Jul 2020 04:24:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so17497861wrs.0;
        Mon, 20 Jul 2020 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0MpeHu7Qw2UNCkTfTVDcI6OwbuQEk4/Ke+DjLHLk6U=;
        b=giKWfMOz19JffrLV3eRuSk3MKIhq6qgF9GyrL8dCuNUA1GCR9tTOJOUenZ+YPwqDR5
         IoGsYUyO/8gXe0eplNsnZ+8guo/FVo7zVgkI/e7ZEsIZ8S5cGN23F65Ff++1Zzyx+XYn
         11jTfm4byKyawSEw2mgJVRrtUHGEKYdgkfYVZRllOAwlqS2QslhxS1lQicxOir05ypv4
         Cu/AN0LEBeeictpebJ5+N6oCy1g6jAzIq9n4DZUp/W4nHhRCvbXw9IJMuEeI9UgZqhXs
         iTy71l4UwsBxPwIoeq5Mr3YxB1JQTxiJ4uIGgCseNX28Vw43YZy898VKB3tdeJ3oqF9K
         DYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0MpeHu7Qw2UNCkTfTVDcI6OwbuQEk4/Ke+DjLHLk6U=;
        b=KQ1biI6TkdeTh84wyChnDQWECadJkwqAFVixAF592twSdDoG6Qd58gTulilc3cG1hr
         LRp1/N4UT9fld+82jfaBFvozIGD4a+D68VPwTCYlfSeV4VwReigSQ5Tok72/Ay+x972v
         to+Z5PyExMt29iQzODxmFTHQCLLqR5mDibCKTNQH1/p1mvwfMPrIH4VQOq/9973wP1FI
         ML80PANgaGjFCWsdPMGZTz1hUqOISaDUffylKKkETE7PrO7V0Sp1F8UexOqU8c4AO41X
         fOw6eCMmiRzx9SG0AKhcb/HjpomzzMY251rX2sWII9ppHs6hcDkHyFBhsKrmYtKrvBtm
         RYHQ==
X-Gm-Message-State: AOAM531GKGFf+fbN2urZuovSvvH9Racu7WHDkADJV5e8DYtwomb7UmhA
        Cmre9bpHFn0tGCYmtMoZbfw=
X-Google-Smtp-Source: ABdhPJyx6KTL+INmrZ51MClTIJqi7ESS3U/5hPBpiOQNB3YRei+BK9LcYlxgNLvcARTeMfWOa8AaEg==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr21933315wrj.264.1595244283566;
        Mon, 20 Jul 2020 04:24:43 -0700 (PDT)
Received: from localhost.localdomain ([148.63.172.143])
        by smtp.gmail.com with ESMTPSA id t4sm33452942wmf.4.2020.07.20.04.24.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 04:24:43 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     baruch@tkos.co.il, linux@armlinux.org.uk,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] rtc: pcf8523: Make DSM for battery switch-over configurable from DT
Date:   Mon, 20 Jul 2020 12:24:00 +0100
Message-Id: <20200720112401.4620-3-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

The pcf8523 has two configurable modes for the battery switch-over
functionality: (i) the default mode and (ii) the direct switching mode -
the driver atm only supports (i). For the default mode to work a filtering
circuit consisting of a series resistor of 1 kOhm and a capacitor of 3.3
microF must be added to the VDD pin input to guarantee a voltage drop of
less 0.7V/ms for the oscillator operation reliability (see pp.54 of the
datasheet). Some boards (e.g. the cubox-i) do not include such circuitry
and are designed to work only in direct switching mode. According to the
datasheet, this is the recommended mode for hw designs where VDD is always
expected to be higher than VBAT. After a power cycle, if the voltage drop
exceeds the said value, the REG_SECONDS_OS bit will be set (oscillator has
stopped or been interrupted) causing userspace applications such as
timedatectl and hwclock to fail (RTC_RD_TIME: Invalid argument).
Hence, This enables DSM as a device-tree configurable property so that
specific boards can make use of it. Note that, if the RTC comes from an
inconsistent state (REG_SECONDS_OS defined), the software reset will
override any power management options set during the probe phase.
Thus, pm is also enforced in pcf8523_start_rtc.

Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
---
Changes in v2:
- Added extended commit message for git history
- Separate dt bindings documentation into a single patch

 drivers/rtc/rtc-pcf8523.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

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

