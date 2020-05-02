Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EBAC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CB020731
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kiho-fi.20150623.gappssmtp.com header.i=@kiho-fi.20150623.gappssmtp.com header.b="bvb/ukky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgEBRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728373AbgEBRWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 13:22:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C86C061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 10:22:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so5555856ljd.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kiho-fi.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SQVKZYyDlpOHs6iMr+1/4kxXWmP2kmVeVd0xRrV7hng=;
        b=bvb/ukky9X41WtzQFHp9/Dyrs2Z6532E5++DYK8Y+jD9I8JPSyR3d70TLFH/0qJDBD
         YR367kJ9DuheeOwxFSmH7QJYsMNfs+eBr63gsKfXg7c4Rv8ewhk1hRlB5SkjQAFsT81+
         Zy9uYnfo1bHBojpK8wDxPhxVtMkgMFQmAPRRlHydoN8//ntvaHF5ARx1eZ2NjIGuujF/
         4RytCj/632AyHiYLyTBHIwb/uJwuop6vdCC2eipNbSTwj7eQ7m8W+GtJuyVU5LjMMduh
         ZN0UBGcqkOj3VoxFtIayIIM4Fej+BExaU+AhHQPS9eBMHllf0SjyLqJI+JMtdM8uomta
         aj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SQVKZYyDlpOHs6iMr+1/4kxXWmP2kmVeVd0xRrV7hng=;
        b=WF8QfPn9micVfoBSnwNAKOPlEGVOlqTqEZlfqgCMakMLZtDJDx+uuHLD41MqOmaw3S
         dj6fP60Pqo36nKi/W7w0aDOf+w505CFFu595vu8gGalqp24F20ZGGjj23Yf93wKqbO3P
         7reQ1H003zPxN4g4XKfLVIi4ato+hCjK3gAKeYLccCskHNfzYTwVjay3Q/og9BS9uMvH
         ZxDvKpdQ3z0Er/Lw7rQkxAJm+5DINmJh1Q0Em+MCDqB7fRkunXBD49xAJU9ZikHMgwnP
         YzutNGZT5dCt0LF7P4V/h9Zu9urO7UYug4a7qhEpCC1fLm+PpwwxvGP9BlfBioDguDGq
         DL/w==
X-Gm-Message-State: AGi0PubqwCVCi/2uQfJzBFr9djVONCBky6L3fEOOkIw6HF7SLfEeZB0a
        eTo4fLlvOkkTJVPeTEjQGoO3LfTe99aqvg==
X-Google-Smtp-Source: APiQypL6anjjjWSN6V+XYxJy+PFkZKLOCHjH2Gs85AOPKUSIbrkf713J120ogeIEH7Bp6v0YgaCNNw==
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr5539992ljg.269.1588440161810;
        Sat, 02 May 2020 10:22:41 -0700 (PDT)
Received: from [192.168.100.210] (dsl-kpobng12-58c361-73.dhcp.inet.fi. [88.195.97.73])
        by smtp.gmail.com with ESMTPSA id c20sm4328925ljk.59.2020.05.02.10.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 10:22:41 -0700 (PDT)
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Petteri Jokinen <petteri@kiho.fi>
Subject: [PATCH] gpio-f7188x: Add GPIO support for F81865
Message-ID: <4340a212-89f5-8c62-db61-f061e494d6b1@kiho.fi>
Date:   Sat, 2 May 2020 20:22:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO support for Fintek F81865 chip.

Datasheet: http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf

Signed-off-by: Petteri Jokinen <petteri@kiho.fi>
---
 drivers/gpio/gpio-f7188x.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index cadd02993539..18a3147f5a42 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -36,9 +36,19 @@
 #define SIO_F71889A_ID		0x1005	/* F71889A chipset ID */
 #define SIO_F81866_ID		0x1010	/* F81866 chipset ID */
 #define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
-
-
-enum chips { f71869, f71869a, f71882fg, f71889a, f71889f, f81866, f81804 };
+#define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
+
+
+enum chips {
+	f71869,
+	f71869a,
+	f71882fg,
+	f71889a,
+	f71889f,
+	f81866,
+	f81804,
+	f81865,
+};

 static const char * const f7188x_names[] = {
 	"f71869",
@@ -48,6 +58,7 @@ static const char * const f7188x_names[] = {
 	"f71889f",
 	"f81866",
 	"f81804",
+	"f81865",
 };

 struct f7188x_sio {
@@ -233,6 +244,15 @@ static struct f7188x_gpio_bank f81804_gpio_bank[] = {
 	F7188X_GPIO_BANK(90, 8, 0x98),
 };

+static struct f7188x_gpio_bank f81865_gpio_bank[] = {
+	F7188X_GPIO_BANK(0, 8, 0xF0),
+	F7188X_GPIO_BANK(10, 8, 0xE0),
+	F7188X_GPIO_BANK(20, 8, 0xD0),
+	F7188X_GPIO_BANK(30, 8, 0xC0),
+	F7188X_GPIO_BANK(40, 8, 0xB0),
+	F7188X_GPIO_BANK(50, 8, 0xA0),
+	F7188X_GPIO_BANK(60, 5, 0x90),
+};

 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
@@ -425,6 +445,10 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 		data->nr_bank = ARRAY_SIZE(f81804_gpio_bank);
 		data->bank = f81804_gpio_bank;
 		break;
+	case f81865:
+		data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
+		data->bank = f81865_gpio_bank;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -490,6 +514,9 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	case SIO_F81804_ID:
 		sio->type = f81804;
 		break;
+	case SIO_F81865_ID:
+		sio->type = f81865;
+		break;
 	default:
 		pr_info(DRVNAME ": Unsupported Fintek device 0x%04x\n", devid);
 		goto err;
--
2.26.2

